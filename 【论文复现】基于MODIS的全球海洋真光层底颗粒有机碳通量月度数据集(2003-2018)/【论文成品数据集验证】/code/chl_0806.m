clc;clear;clf;
%% ��������
fileName1='AQUA_MODIS.20180101_20180131.L3m.MO.SST.sst.9km.nc';
fileName2='A20180012018031.L3m_MO_ZLEE_Zeu_lee_9km.nc';
fileName3='A20180012018031.L3m_MO_CHL_chlor_a_9km.nc';
fileName4='npp.sabpm.20181.hdf';
% ncdisp(fileName1);
% ncdisp(fileName2);
% ncdisp(fileName3);
sst = ncread(fileName1,'sst');% 'degree_C'
zeu = ncread(fileName2,'Zeu_lee');% 'm'
chl = ncread(fileName3,'chlor_a');% 'mg m^-3'
npp = hdfread(fileName4,'npp')';

latitude = ncread(fileName1,'lat');
longitude = ncread(fileName1,'lon');
[lat1,lon1] = meshgrid(latitude,longitude);

%�޳���Ч����
t3=find(npp==-9999);
npp(t3)=nan;

%���ݱ߽�
real_id = ~isnan(sst)&~isnan(chl)&~isnan(zeu);
e_ratio = nan(4320,2160);
e_ratio(real_id) = max(0.04,min(0.72,(-0.0081.*sst(real_id)+0.0806.*log(chl(real_id)./zeu(real_id))+0.426)));%%[�߽���ʱûд]


%%�Ҿ�γ��
pos=find(lat1>=31&lat1<=43&lon1>=120&lon1<=144);%[31,43][120,144]
lat2=lat1(pos);
lon2=lon1(pos);
e_ratio2=e_ratio(pos);
npp2=npp(pos);
%%�ҵ�֮�����������У�Ҫ�ָ�һ��1:2��������״��9km�Ĳ���Ҫ��С��
lat2=reshape(lat2,[288,144]);
lon2=reshape(lon2,[288,144]);
e_ratio2=reshape(e_ratio2,[288,144]);
npp2=reshape(npp2,[288,144]);

poc=npp2.*e_ratio2;

%% ��ͼ
colormap(jet);%��ɫ����
m_proj('Equidistant','lat',[31,43],'lon',[120,144]);
m_pcolor(lon2,lat2,poc);
shading flat;%��ɫģʽ
hold on;

% m_coast('patch',[1 1 1]);%����������
m_grid('linestyle','none','box','fancy','xtick',10,'ytick',8,...
'tickdir','in','yaxislocation','left','fontsize',10);

title('POC��0.0806chl���㡿','fontsize',15)
xlabel('longitude');
ylabel('latitude')

colorbar();%ɫ��
caxis([0 250]);%��ɫ��Χ
% % ���ú�����ͼ����2��
% colormap(jet);%��ɫ����
% imagesc(poc);%ÿһ��12��ͼ�����أ���������
