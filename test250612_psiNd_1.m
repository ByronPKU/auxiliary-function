tt='test250612_psiNd_1';
% test250612_psiNd_1
% Changed from test250608_psiNd_2

% test250123_psiCe_2 % 更改了Plm的定义，再运行_1
% test241228_psiCe_1 % 代码没改，只是略微改了Plm的定义
% test241227_psiYb_1 % 采用莫比乌斯波函数计算
% test241220_psiYb_Sievers_2 % 重新理解Sievers，改3√为2√

definter('latex');

pathd='E:\Matlab\Data\';
pathf='E:\Matlab\Figures\';
% test241106_Sievers1981;

% psi 4,3
n=4;l=3;J=4.5;
d=dSla(n);
n_=n-d;
l_=l-d;
% Z=13;
% Z_=4*(n/n_); % Ce
% Z_=11.8*(n/n_); % Yb
Z_=5.3*(n/n_); % Nd
N4f=1;

xmax=5;
dx=xmax/50;
xs0=-xmax:dx:xmax;
nn=numel(xs0);
psi_=nan(nn,nn,nn,4);
[y,x,z]=meshgrid(xs0,xs0,xs0);
xyzs=[x(:) y(:) z(:)];
rtps=xyz2rtp(xyzs);
rs=rtps(:,1);
tps=rtps(:,2:3);
th=rtps(:,2);
ph=rtps(:,3);
% r=(0:0.01:50).';
Rs=Ranl(1/Z_,n,l,rs);
jj=0;
t0=now;
for m_=-J:J
    jj=jj+1;

    Yt=sqrt(N4f)*Ylm(J,m_,tps);
    psis=Rs.*Yt;

    psi=reshape(psis,[nn,nn,nn]);
    psi_(:,:,:,jj)=psi;
    disperct(jj,2*J+1,[],t0);

end
rh=abs(psi_).^2;
%%
fsz=30;
rhs=psi_*nan;
ca;
for jp=1:2*J+1
%     ca;
    % cmin=0.5;
    rh_=abs(psi_(:,:,:,jp)).^2;
    rh_(isinf(rh_))=nan;
%     rh_(1:(nn-1)/2,1:(nn-1)/2,(nn+1)/2:end)=nan;
    rhs(:,:,:,jp)=round(rh_(:,:,:),10);
%     cmin=0.002;
%     [~,cmin]=plotisos(rh_,{xs0+1.6*(jp-1)*xmax,xs0,xs0},[nan,0.99]);
    
end
% cmins=nan;
% load([pathd 'dt250305_psiCe_1=cmins.mat']);
Npsi=ceil(J+0.5);
J2=2*J;
% cmins=ones(Npsi,1)*0.0019;
cmins=nan;
xshift=9;
bigfigure;hold on;
for jp=ceil(J+0.5):-1:1
    [~,cminj]=plotisos(rhs(:,:,:,jp),{xs0-0.9*(jp-1)*xmax,xs0,xs0},[nan]);
    cmins(jp)=cminj;
end
save([pathd 'dt' tt(5:end) '=rhs=.mat'],'rhs','cmins','J','l','n','xs0','Z_','-v7.3');
% bigfigure;hold on;
% for jp=Npsi:-1:1
%     cminj=cmins(jp);
%     plotisos(rhs(:,:,:,jp),{xs0-xshift*(jp-1),xs0,xs0},cminj);
% end
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
% text(-2*xshift,0,ztext+2*dz,'Ce$^{3+}$','HorizontalAlignment','center','FontSize',fsz);
text(-4*xshift,0,ztext+4*dz,['Nd$^{3+}\left|\left|\pm\frac{' num2str(J2-8) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-3*xshift,0,ztext+3*dz,['$\left|\left|\pm\frac{' num2str(J2-6) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-2*xshift,0,ztext+2*dz,['$\left|\left|\pm\frac{' num2str(J2-4) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(-1*xshift,0,ztext+1*dz,['$\left|\left|\pm\frac{' num2str(J2-2) '}{2}\right>\right|^2$'], ...
    'HorizontalAlignment','center','FontSize',fsz);
text(0*xshift,0,ztext,['$\left|\left|\pm\frac{' num2str(J2) '}{2}\right>\right|^2$'], ...
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

