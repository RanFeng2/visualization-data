clear;clc;clf;
fileName = "poc.flux.201801.hdf";
fileDiscription=hdfinfo(fileName);
data2 = hdfread(fileName,'pe_ratio');
latitude = linspace(-90,90,2160);
longitude = linspace(-180,180,4320);
[xlon,xlat] = meshgrid(longitude,latitude);%����ά��,����
%%ɸ����Ч����
t2=find(data2==-9999);
data2(t2)=nan;

%%�Ҿ�γ��
pos=find(xlat>=31&xlat<=43&xlon>=120&xlon<=144);%[31,43][120,144]
lat=xlat(pos);
lon=xlon(pos);
e_ratio=data2(pos);
%%�ҵ�֮�����������У�Ҫ�ָ�һ��1:2��������״
lat=reshape(lat,[144,288]);
lon=reshape(lon,[144,288]);
e_ratio=reshape(e_ratio,[144,288]);


%% ��ͼ
m_proj('Equidistant','lat',[31,43],'lon',[120,144]);
m_pcolor(lon,lat,e_ratio);
shading flat;%��ɫģʽ
colormap(jet);%��ɫ����
hold on;

m_coast('patch',[1 1 1]);%����������
m_grid('linestyle','none','box','fancy','xtick',10,'ytick',8,...
'tickdir','in','yaxislocation','left','fontsize',10);
title('�������ֺ���e-ratio[2018��1��]','fontsize',15)
xlabel('longitude');
ylabel('latitude');

colorbar();%ɫ��
caxis([0.05 0.2]);%��ɫ��Χ[0.05 0.2]