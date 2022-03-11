clear;clc;clf;
fileName = "poc.flux.201801.hdf";
fileDiscription=hdfinfo(fileName);
data1 = hdfread(fileName,'poc_flux');
data2 = hdfread(fileName,'pe_ratio');
latitude = linspace(-90,90,2160).';%ת��
latitude = repmat(latitude,[1,4320]);%�ظ�2160��
longitude = linspace(-180,180,4320);
longitude = repmat(longitude,[2160,1]);%�ظ�4320��,�൱��meshgrid(lat,lon)
%%ɸ����Ч����
t1=find(data1==-9999);
data1(t1)=nan;
t2=find(data2==-9999);
data2(t2)=nan;

%%�Ҿ�γ��
pos=find(latitude>=31&latitude<=43&longitude>=120&longitude<=144);%[31,43][120,144]
lat=latitude(pos);
lon=longitude(pos);
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
title('�������ֺ���','fontsize',15)
xlabel('longitude');
ylabel('latitude')

colorbar();%ɫ��
caxis([0 250]);%��ɫ��Χ