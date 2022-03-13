clc;clear;clf;
%% 读sst
fileName1='AQUA_MODIS.20180101_20180131.L3m.MO.SST.sst.9km.nc';
% ncdisp(fileName1);
sst = ncread(fileName1,'sst');% 'degree_C'
latitude = ncread(fileName1,'lat');
longitude = ncread(fileName1,'lon');
[lat1,lon1] = meshgrid(latitude,longitude);
%% 读zeu
fileName2='A20180012018031.L3m_MO_ZLEE_Zeu_lee_9km.nc';
% ncdisp(fileName2);
zeu = ncread(fileName2,'Zeu_lee');% 'm'
%% 读chlor_a
fileName3='A20180012018031.L3m_MO_CHL_chlor_a_9km.nc';
% ncdisp(fileName3);
chl = ncread(fileName3,'chlor_a');% 'mg m^-3'

e_ratio = -0.0081.*sst+0.0668.*log(chl./zeu)+0.426;%%[边界暂时没写]
t1 = find(~isnan(e_ratio) & e_ratio>0.72);
e_ratio(t1) = nan;
t2 = find(~isnan(e_ratio) & e_ratio<0.04);
e_ratio(t2) = nan;

%%找经纬度
pos=find(lat1>=31&lat1<=43&lon1>=120&lon1<=144);%[31,43][120,144]
lat2=lat1(pos);
lon2=lon1(pos);
e_ratio2=e_ratio(pos);
%%找到之后是线性序列，要恢复一下1:2比例的形状【9km的不需要缩小】
lat2=reshape(lat2,[288,144]);
lon2=reshape(lon2,[288,144]);
e_ratio2=reshape(e_ratio2,[288,144]);

%% 作图
m_proj('Equidistant','lat',[31,43],'lon',[120,144]);
m_pcolor(lon2,lat2,e_ratio2);
shading flat;%着色模式
colormap(jet);%配色方案
hold on;

m_coast('patch',[1 1 1]);%画出海岸线
m_grid('linestyle','none','box','fancy','xtick',10,'ytick',8,...
'tickdir','in','yaxislocation','left','fontsize',10);
title('东海部分海域','fontsize',15)
xlabel('longitude');
ylabel('latitude')

colorbar();%色表
caxis([0.05 0.2]);%配色范围
