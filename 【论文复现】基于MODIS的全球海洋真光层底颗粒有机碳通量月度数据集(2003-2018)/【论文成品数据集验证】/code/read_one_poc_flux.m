clear;clc;clf;
fileName = "poc.flux.201801.hdf";
fileDiscription=hdfinfo(fileName);
data1 = hdfread(fileName,'poc_flux');
latitude = linspace(90,-90,2160);%%ע�ⱱ��90������-90
longitude = linspace(-180,180,4320);
[xlon,xlat] = meshgrid(longitude,latitude);%����ά��,����
%%ɸ����Ч����
t1=find(data1==-9999);
data1(t1)=nan;

%%�Ҿ�γ��
pos=find(xlat>=31&xlat<=43&xlon>=120&xlon<=144);%[31,43][120,144]
lat=xlat(pos);
lon=xlon(pos);
poc_flux=data1(pos);
%%�ҵ�֮�����������У�Ҫ�ָ�һ��1:2��������״
lat=reshape(lat,[144,288]);
lon=reshape(lon,[144,288]);
poc_flux=reshape(poc_flux,[144,288]);

%% ��ͼ
m_proj('Equidistant','lat',[31,43],'lon',[120,144]);
m_pcolor(lon,lat,poc_flux);
shading flat;%��ɫģʽ
colormap(jet);%��ɫ����
hold on;

m_coast('patch',[1 1 1]);%����������
m_grid('linestyle','none','box','fancy','xtick',10,'ytick',8,...
'tickdir','in','yaxislocation','left','fontsize',10);
title('POC����ȡ��','fontsize',15)
xlabel('longitude');
ylabel('latitude')

colorbar();%ɫ��
caxis([0 250]);%��ɫ��Χ