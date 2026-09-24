tt='test260920_psiCeN_before_after_2';
% test260920_psiCeN_before_after_2
% Changed from test260920_psiCeN_before_after
% Combines test260511_psiCeN (before cubic symmetrization) and
% test260905_psiCeN_cubic_2 (after cubic symmetrization), keeping only
% the physical ground-state candidate psi_1 = -sqrt(1/6)|-5/2>+sqrt(5/6)|+3/2>
% (jp=1 in the original scripts; jp=3 there was the unphysical psi_2,
% which is dropped here).
%
% Layout: left panel = psi_1 density BEFORE cubic symmetrization
%         right panel = psi_1 density AFTER cubic symmetrization
%
% Everything up through the rho_z / rho_x / rho_y / rho_sym construction
% is copied unchanged from test260511_psiCeN.m and
% test260905_psiCeN_cubic_2.m; only the plotting section at the bottom
% is new (single row, two panels, instead of the original jp=[1 3] loop).

definter('latex');

pathd='E:\Matlab\Data\';
pathf='E:\Matlab\Figures\';
fsz=25;

p4=sqrt(1/6);
p9=sqrt(5/6);

load([pathd 'dt260128_psiCe_0=psi_=.mat']); % loads psi_, J, l, n, xs0, Z_

%% Step 1: z-quantized cubic eigenstate densities (same as test260511_psiCeN.m)
psijs=psi_.*nan;
psijs(:,:,:,1)=-p4*psi_(:,:,:,1)+p9*psi_(:,:,:,5);   % psi_1 (Gamma7, physical ground state)
psijs(:,:,:,2)=-p9*psi_(:,:,:,2)+p4*psi_(:,:,:,6);
psijs(:,:,:,3)= p4*psi_(:,:,:,1)+p9*psi_(:,:,:,5);   % psi_2 (unphysical, not used here)
psijs(:,:,:,4)= p9*psi_(:,:,:,2)+p4*psi_(:,:,:,6);
psijs(:,:,:,5)=psi_(:,:,:,3);
psijs(:,:,:,6)=psi_(:,:,:,4);

rho_z=abs(psijs).^2;
rho_z(isinf(rho_z))=nan;
rho_z=round(rho_z,10);

%% Step 2: rho_x, rho_y via axis permutation (same as test260905_psiCeN_cubic_2.m)
Nstates=size(rho_z,4);
rho_x=nan(size(rho_z));
rho_y=nan(size(rho_z));
for jp=1:Nstates
    rho_x(:,:,:,jp)=permute(rho_z(:,:,:,jp),[3,1,2]);
    rho_y(:,:,:,jp)=permute(rho_z(:,:,:,jp),[2,3,1]);
end

%% Step 3: cubic-symmetrized density rho_sym = rho_z*nz^2+rho_x*nx^2+rho_y*ny^2
[y,x,z]=meshgrid(xs0,xs0,xs0);
r2=x.^2+y.^2+z.^2;
nz2=z.^2./r2;  nz2(r2==0)=0;
nx2=x.^2./r2;  nx2(r2==0)=0;
ny2=y.^2./r2;  ny2(r2==0)=0;

rho_sym_unnorm=rho_z.*nz2 + rho_x.*nx2 + rho_y.*ny2;

%% Step 4: per-state normalization (same as test260905_psiCeN_cubic_2.m)
dx=xs0(2)-xs0(1);
normfac=nan(Nstates,1);
rho_sym=rho_sym_unnorm.*nan;
for jp=1:Nstates
    integral_jp=sum(reshape(rho_sym_unnorm(:,:,:,jp),[],1),'omitnan')*dx^3;
    normfac(jp)=integral_jp;
    rho_sym(:,:,:,jp)=rho_sym_unnorm(:,:,:,jp)/integral_jp;
end

%% Step 5: plot ¡ª single row, two panels: psi_1 before (left) and after (right) symmetrization
xshift=4.5;
dz=0.42;
ca;
bigfigure;hold on;

% left panel: psi_1, BEFORE symmetrization
plotisos(rho_z(:,:,:,1),{xs0-xshift,xs0,xs0},[nan 0.5]);
% right panel: psi_1, AFTER symmetrization
plotisos(rho_sym(:,:,:,1),{xs0+xshift,xs0,xs0+0.43},[nan 0.5]);

view(-45,20);
camlight(0,0);
camlight(0,0);
axis vis3d tight
colormap([0.4 0.4 1;0.7 0.7 1;0.6 0.6 1;1 1 1]);
view(10,15);
axis off;
set(gca,'position',[0.1 0.35 0.8 0.5]);

text(-1*xshift,0,3.5+4*dz-0.43,['before cubic symmetrization'], ...
    'HorizontalAlignment','center','FontSize',fsz*0.6);
text(1*xshift,0,3.5+4*dz,['after cubic symmetrization'], ...
    'HorizontalAlignment','center','FontSize',fsz*0.6);
text(0,0,4.5+4*dz,['Ce$^{3+}$ in CeN, physical ground state $\left|\psi_1\right\rangle$'], ...
    'HorizontalAlignment','center','FontSize',fsz*0.85);

fign=[pathf tt '=L080.png'];
print(gcf,'-r300','-dpng',fign);
cropic([255 nan],fign);
