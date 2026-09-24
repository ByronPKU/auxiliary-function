tt='test260510_psiNdCl3_0';
% test260510_psiNdCl3_0
% Changed from test250814_psiNdCl3_0

% test250123_psiCe_2 % 更改了Plm的定义，再运行_1
% test241228_psiCe_1 % 代码没改，只是略微改了Plm的定义
% test241227_psiYb_1 % 采用莫比乌斯波函数计算
% test241220_psiYb_Sievers_2 % 重新理解Sievers，改3√为2√

definter('latex');

pathd='E:\Matlab\Data\';
pathf='E:\Matlab\Figures\';
% test241106_Sievers1981;
fsz=50;

load([pathd 'dt250716_psiNd_0=psi_=.mat']);
psijs=psi_.*nan;
psijs(:,:,:,1)=0.9989*psi_(:,:,:,1)...
    +(0.0359+0.0296i)*psi_(:,:,:,7);
psijs(:,:,:,2)=0.9909*psi_(:,:,:,2)...
    +(0.1037+0.0855i)*psi_(:,:,:,8);
psijs(:,:,:,3)=0.9909*psi_(:,:,:,3)...
    +(-0.1037-0.0855i)*psi_(:,:,:,9);
psijs(:,:,:,4)=0.9909*psi_(:,:,:,4)...
    +(-0.0359-0.0296i)*psi_(:,:,:,10);
psijs(:,:,:,5)=psi_(:,:,:,5);
rhs=abs(psijs).^2;
rhs(isinf(rhs))=nan;
rhs=round(rhs,10);

Npsi=ceil(J+0.5);
J2=2*J;
cmins=ones(Npsi,1)*0.0019;
xshift=9;
ca;
bigfigure;hold on;

for jp=Npsi:-1:1
    cminj=cmins(jp);
    plotisos(rhs(:,:,:,jp),{xs0-xshift*(Npsi-jp),xs0,xs0},cminj);
end
cmin_=mean(cmins);
view(-45,20);
camlight(0,0);
camlight(0,0);
axis vis3d tight
caxis([0.8 3.5]*cmin_);
colormap([0.4 0.4 1;0.7 0.7 1;0.6 0.6 1;1 1 1]);
view(-10,15);dz=0.42;
axis off;
set(gca,'position',[0.1 0.35 0.8 0.8]);
% text(-4*xshift+4,0,3+4*dz,['Nd$^{3+}$'], ...
%     'HorizontalAlignment','center','FontSize',fsz);
text(-4*xshift+6.5,0,3+4*dz,['Nd$^{3+}$ in NdCl$_3$'], ...
    'HorizontalAlignment','center','FontSize',fsz);

axes2('position',[0.1 0 0.8 0.8]);
hold on;
lw=5.15;
deg=pi/180;
dphi=-6.72*deg;
for jp=Npsi:-1:1
    cminj=cmins(jp);
    dxj=-xshift*(Npsi-jp);
    plotisos(rhs(:,:,:,jp),{xs0+dxj,xs0,xs0},cminj);
    dd=4.5;
    if jp<=Npsi % 260510加=，最后一个也加虚线
        plotc([-1 0 1;1 0 1]*rota([0 0 dphi])*dd+[dxj 0 0],'k--','linewidth',lw);
    end
end
cmin_=mean(cmins);
view(-45,20);
axis vis3d tight
view(0,90);
camlight(-45,15);
camlight(-45,15);
caxis([0.8 3.5]*cmin_);
colormap([0.4 0.4 1;0.7 0.7 1;0.6 0.6 1;1 1 1]);
axis off;

ytext=-6;
% text(-4*xshift+4,3,['Nd$^{3+}$'], ...
%     'HorizontalAlignment','center','FontSize',fsz);
text(-4*xshift,ytext,['$\left|\left|\psi_0\right>_{\pm}\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-3*xshift,ytext,['$\left|\left|\psi_1\right>_{\pm}\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-2*xshift,ytext,['$\left|\left|\psi_2\right>_{\pm}\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-1*xshift,ytext,['$\left|\left|\psi_3\right>_{\pm}\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(0*xshift,ytext,['$\left|\left|\psi_4\right>_{\pm}\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);

fign=[pathf tt '=L080.png'];
print(gcf,'-r300','-dpng',fign);
cropic([255 nan],fign);


%%
dx=0.1;
for jp=1:floor(J+1)
sum(reshape(rhs(:,:,:,jp),[],1),'omitnan')*dx^3
end

