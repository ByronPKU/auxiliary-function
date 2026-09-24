tt='test260510_psiNd_1';
% test260510_psiNd_1
% Changed from test260322_psiNd_1

% test250123_psiCe_2 % 更改了Plm的定义，再运行_1
% test241228_psiCe_1 % 代码没改，只是略微改了Plm的定义
% test241227_psiYb_1 % 采用莫比乌斯波函数计算
% test241220_psiYb_Sievers_2 % 重新理解Sievers，改3√为2√

definter('latex');

pathd='E:\Matlab\Data\';
pathf='E:\Matlab\Figures\';
% test241106_Sievers1981;
fsz=50;
xmax=5;
dx=xmax/50;

load([pathd 'dt250612_psiNd_1=rhs=.mat']);
Npsi=ceil(J+0.5);
J2=2*J;
cmins=ones(Npsi,1)*0.0019;
xshift=9;
bigfigure;hold on;
for jp=Npsi:-1:1
    cminj=cmins(jp);
    plotisos(rhs(:,:,:,jp),{xs0-xshift*(Npsi-jp),xs0,xs0},cminj);
end
cmin_=mean(cmins);
view(-45,20);
camlight(0,0);
camlight(0,0);
% camlight(0,0);
% camlight(0,0);
% camlight(0,0);
axis vis3d tight
caxis([0.8 3.5]*cmin_);
% caxis([0.6 2.5]*cmin_);
% a=colormap(jet);
% a(1,:)=[0.8 0.8 1];
% a(2,:)=[0.8 0.8 1];
% a(3,:)=[0.8 0.8 1];
% a(4,:)=[0.8 0.8 1];
colormap([0.4 0.4 1;0.7 0.7 1;0.6 0.6 1;1 1 1]);
view(-10,15);dz=0.42;
axis off;
xyz1=[[1 -1]*0 -3.7];
% plotc([xyz1(1:2) xyz1(3)-1;xyz1(1:2) xyz1(3)],'k-','linewidth',2);
% text(xyz1(1),xyz1(2),xyz1(3)-1/2,'$\ a_0$','FontSize',fsz);
ztext=-8;
text(-4*xshift+3,1.5,2.9+4*dz,['Nd$^{3+}$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
% text(-2*xshift,0,ztext+2*dz,'Ce$^{3+}$','HorizontalAlignment','center','FontSize',fsz);
text(-4*xshift,0,ztext+4*dz,['$\left|\left|\pm\frac{' num2str(J2) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-3*xshift,0,ztext+3*dz,['$\left|\left|\pm\frac{' num2str(J2-2) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-2*xshift,0,ztext+2*dz,['$\left|\left|\pm\frac{' num2str(J2-4) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-1*xshift,0,ztext+1*dz,['$\left|\left|\pm\frac{' num2str(J2-6) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(0*xshift,0,ztext,['$\left|\left|\pm\frac{' num2str(J2-8) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);

fign=[pathf tt '=L080.png'];
print(gcf,'-r300','-dpng',fign);
cropic([255 nan],fign);


%%

for jp=1:2*J+1
sum(reshape(rhs(:,:,:,jp),[],1),'omitnan')*dx^3
% sum(reshape(rhs(:,:,:,2),[],1),'omitnan')*dx^3
% sum(reshape(rhs(:,:,:,3),[],1),'omitnan')*dx^3
% sum(reshape(rhs(:,:,:,4),[],1),'omitnan')*dx^3
% sum(reshape(rhs(:,:,:,5),[],1),'omitnan')*dx^3
% sum(reshape(rhs(:,:,:,6),[],1),'omitnan')*dx^3
end

