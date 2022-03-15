clear;clc;clf;
fileName = "poc.flux.201801.hdf";
fileDiscription=hdfinfo(fileName);
data2 = hdfread(fileName,'pe_ratio');
latitude = linspace(-90,90,2160);
longitude = linspace(-180,180,4320);
[xlon,xlat] = meshgrid(longitude,latitude);%增加维度,网格化
%%筛除无效数据
t2=find(data2==-9999);
data2(t2)=nan;

%%找经纬度
pos=find(xlat>=31&xlat<=43&xlon>=120&xlon<=144);%[31,43][120,144]
lat=xlat(pos);
lon=xlon(pos);
e_ratio=data2(pos);
%%找到之后是线性序列，要恢复一下1:2比例的形状
lat=reshape(lat,[144,288]);
lon=reshape(lon,[144,288]);
e_ratio=reshape(e_ratio,[144,288]);


%% 作图
m_proj('Equidistant','lat',[31,43],'lon',[120,144]);
m_pcolor(lon,lat,e_ratio);
shading flat;%着色模式
colormap(jet);%配色方案
hold on;

m_coast('patch',[1 1 1]);%画出海岸线
m_grid('linestyle','none','box','fancy','xtick',10,'ytick',8,...
'tickdir','in','yaxislocation','left','fontsize',10);
title('东海部分海域e-ratio[2018年1月]','fontsize',15)
xlabel('longitude');
ylabel('latitude');

colorbar();%色表
caxis([0.05 0.2]);%配色范围[0.05 0.2]