clear;clc;clf;
fileName = "poc.flux.201801.hdf";
fileDiscription=hdfinfo(fileName);
data1 = hdfread(fileName,'poc_flux');
data2 = hdfread(fileName,'pe_ratio');
latitude = linspace(-90,90,2160).';%转置
latitude = repmat(latitude,[1,4320]);%重复2160次
longitude = linspace(-180,180,4320);
longitude = repmat(longitude,[2160,1]);%重复4320次,相当于meshgrid(lat,lon)
%%筛除无效数据
t1=find(data1==-9999);
data1(t1)=nan;
t2=find(data2==-9999);
data2(t2)=nan;

%%找经纬度
pos=find(latitude>=31&latitude<=43&longitude>=120&longitude<=144);%[31,43][120,144]
lat=latitude(pos);
lon=longitude(pos);
poc_flux=data1(pos);
%%找到之后是线性序列，要恢复一下1:2比例的形状
lat=reshape(lat,[144,288]);
lon=reshape(lon,[144,288]);
poc_flux=reshape(poc_flux,[144,288]);


%% 作图
m_proj('Equidistant','lat',[31,43],'lon',[120,144]);
m_pcolor(lon,lat,poc_flux);
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
caxis([0 250]);%配色范围