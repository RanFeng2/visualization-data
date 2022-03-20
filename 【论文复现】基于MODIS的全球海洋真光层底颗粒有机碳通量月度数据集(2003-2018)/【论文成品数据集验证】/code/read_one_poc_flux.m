clear;clc;clf;
fileName = "poc.flux.201801.hdf";
fileDiscription=hdfinfo(fileName);
data1 = hdfread(fileName,'poc_flux');
latitude = linspace(90,-90,2160);%%注意北是90，南是-90
longitude = linspace(-180,180,4320);
[xlon,xlat] = meshgrid(longitude,latitude);%增加维度,网格化
%%筛除无效数据
t1=find(data1==-9999);
data1(t1)=nan;

%%找经纬度
pos=find(xlat>=31&xlat<=43&xlon>=120&xlon<=144);%[31,43][120,144]
lat=xlat(pos);
lon=xlon(pos);
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
title('POC【读取】','fontsize',15)
xlabel('longitude');
ylabel('latitude')

colorbar();%色表
caxis([0 250]);%配色范围