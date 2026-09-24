tt='test260924_HHH_YbBr3a';
% test260924_HHH_YbBr3a
% Changed from test260918_HHH_YbBr3_3
%% YbBr3 ground-state auxiliary densities: Hobson, Hunter, and this work
% State:
% |1,1> = 0.2987 |7/2> - 0.5151 |1/2> - 0.8034 |-5/2>.
%
% Requirements on the MATLAB path:
%   Ylm.m, Ylm_Hunter.m, Plm.m, Plm_Hunter.m, Ranl.m, plotisos.m
%
% Hobson's P_J^M is implemented below directly from Table S1 of
% arXiv:2509.00889v3. Hunter and this-work functions are evaluated by the
% author's Ylm_Hunter and Ylm, respectively.

% clear; close all; clc;

% tt = 'test260905_HHH_YbBr3_Kramers_pair_v2';
% addpath('E:\Matlab');

%% Parameters
J = 7/2;

pathd = 'E:\Matlab\Data\';
matfile = [pathd tt '=rhos_states=.mat'];

% Everything below is cheap to (re)compute, so it is defined fresh on
% every run, regardless of whether the cache file exists. Only the
% expensive angular-function evaluation loop below (which produces
% rhos_states) is cached to/loaded from matfile.
Ms1 = [7/2, 1/2, -5/2];
Cs1 = [0.299, -0.515, -0.803];

% Kramers partner from T|J,M> = (-1)^(J-M)|J,-M>.
% Its overall phase is arbitrary.
Ms2 = -Ms1;
Cs2 = conj(Cs1).*(-1).^(J-Ms1);
Ms_states = {Ms1,Ms2};
Cs_states = {Cs1,Cs2};

% Yb3+ radial parameters, following test260128_psiCe_0.m.
n = 4;
l = 3;
d = dSla(n);
n_ = n-d;
l_ = l-d; %#ok<NASGU> % retained to mirror the reference implementation
Zs = [4,4.65,5.3,5.95,6.6,7.25,7.9,8.55,9.2,9.85,10.5,11.15,11.8,12.45];
j4f = 13;                 % Yb3+ is 4f^13
N4f = 1;                  % unit-normalized auxiliary density, not total 4f charge
Z_ = Zs(j4f)*(n/n_);

% Common Cartesian grid. With the correct Yb3+ effective charge, xmax=5
% is the same range used in the reference code and contains the radial
% density comfortably.
xmax = 3;
dx = xmax/50;
xs0 = -xmax:dx:xmax;
[xs,ys,zs] = meshgrid(xs0,xs0,xs0);
rs = sqrt(xs.^2 + ys.^2 + zs.^2);

theta = zeros(size(rs));
jr = rs > 0;
costheta = zeros(size(rs));
costheta(jr) = zs(jr)./rs(jr);
costheta = max(-1,min(1,costheta));
theta(jr) = acos(costheta(jr));
phi = atan2(ys,xs);
tp = [theta(:),phi(:)];

% Same normalized Yb3+ 4f radial envelope for all three constructions.
% Ranl's first argument is a=a0/Z_ (with a0 as the length unit), not 1.
R = Ranl(1/Z_,n,l,rs(:));

%% Construct both Kramers partners with all three definitions
names = {'with Hobson''s','with Hunter''s','This work'};

if exist(matfile,'file')
    load(matfile);   % 只读取之前算好的 rhos_states（唯一需要耗时重算的部分）
else
    rhos_states = cell(2,3);

    for js = 1:2
        Ms = Ms_states{js};
        Cs = Cs_states{js};
        psis = {complex(zeros(numel(rs),1)), ...
            complex(zeros(numel(rs),1)), complex(zeros(numel(rs),1))};

        for jm = 1:numel(Ms)
            M = Ms(jm);
            C = Cs(jm);
            Ys = {hobson_Y_7half(M,tp),Ylm_Hunter(J,M,tp),Ylm(J,M,tp)};
            for j = 1:3
                psis{j} = psis{j}+C.*R.*sqrt(N4f).*Ys{j};
            end
        end

        for j = 1:3
            rho = reshape(abs(psis{j}).^2,size(rs));
            rho(~isfinite(rho)) = NaN;
            rhos_states{js,j} = rho;
        end
    end

    if ~exist(pathd,'dir'); mkdir(pathd); end
    save(matfile,'rhos_states','-v7.3');
end

%% Numerical diagnostics
fprintf('\nYbBr3 ground state: J = 7/2\n');
fprintf('|1,1> = 0.299|7/2> - 0.515|1/2> - 0.803|-5/2>\n');
fprintf('|1,2> = 0.299|-7/2> + 0.515|-1/2> - 0.803|5/2>\n');
fprintf('4f radial parameters: N4f=%g, n*=%g, Z_=%g, a=1/Z_=%g\n', ...
    N4f,n_,Z_,1/Z_);
for js = 1:2
    fprintf('\nState |1,%d>\n',js);
    fprintf('%-12s  %-18s  %-18s\n','Construction','finite-grid integral','inversion mismatch');
    for j = 1:3
        rho = rhos_states{js,j};
        integral_j = sum(rho(:),'omitnan')*dx^3;
        rho_inv = flip(flip(flip(rho,1),2),3);
        valid = isfinite(rho) & isfinite(rho_inv);
        scale = max(rho(valid),[],'omitnan');
        if isempty(scale) || scale == 0
            inv_mismatch = NaN;
        else
            inv_mismatch = max(abs(rho(valid)-rho_inv(valid)),[],'omitnan')/scale;
        end
        fprintf('%-12s  %-18.8g  %-18.8g\n',names{j},integral_j,inv_mismatch);
    end
end

pathd='E:\Matlab\Data\';
% load([pathd 'test260905_HHH_YbBr3_3=rhos_states=.mat']);

%% Draw two figures with one shared set of appearance controls
pathf = 'E:\Matlab\Figures\';
if ~exist(pathf,'dir'); mkdir(pathf); end

ca;
for js = 1:2
    figure('Color','w','Position',[80 120 1680 560]);
    panel_w = 0.30;    % 每个子图的宽度(归一化坐标，0~1)，嫌图太小就调大这个数
    panel_h = 0.85;    % 每个子图的高度
    gap = -0.04;        % 子图之间的间距，就是你想调的那个数，改小它就是了
    bottom = 0.05;      % 子图底边距离整张图底部的距离
    left0 = (1 - 3*panel_w - 2*gap)/2;  % 自动让三张图整体居中，不用手算
    positions = { ...
        [left0, bottom, panel_w, panel_h], ...
        [left0+panel_w+gap, bottom, panel_w, panel_h], ...
        [left0+2*(panel_w+gap), bottom, panel_w, panel_h] ...
        };
    for j = 1:3
        ax = axes('Position', positions{j});
        hold on;        rho = rhos_states{js,j};
        pis = plotisos(rho,{xs0,xs0,xs0},0.1);

%         if j==1
%             pis = plotisos(rho,{xs0,xs0,xs0},0.005);
%         else
%             pis = plotisos(rho,{xs0,xs0,xs0},[NaN 0.19]);
%         end

        % Change brightness/material here once; it affects both figures.
        set(pis,'FaceColor',[0.48 0.48 0.96], ...
            'EdgeColor','none','FaceLighting','gouraud', ...
            'AmbientStrength',0.30,'DiffuseStrength',0.72, ...
            'SpecularStrength',0.30,'SpecularExponent',18);
        axis vis3d tight off;
        view(-35,15);
        delete(findall(ax,'Type','light'));
        camlight(ax,'headlight');
        % camlight(ax,110,25);
        lighting(ax,'gouraud');
    end
    label_y = 0.84;   % 三个词统一的高度，数值越大越靠上，自己调到满意为止
    for j = 1:3
        annotation('textbox',[positions{j}(1), label_y, positions{j}(3), 0.06], ...
            'String',names{j},'Interpreter','latex','FontSize',22, ...
            'EdgeColor','none','HorizontalAlignment','center');
    end

    if js==1
        formula = ['$|1,1\rangle=0.299|7/2\rangle' ...
            '-0.515|1/2\rangle-0.803|-5/2\rangle$'];
    else
        formula = ['$|1,2\rangle=0.299|-7/2\rangle' ...
            '+0.515|-1/2\rangle-0.803|5/2\rangle$'];
    end
%     sgtitle(['YbBr$_3$: ' formula],'Interpreter','latex','FontSize',22);
%     st = sgtitle(['YbBr$_3$: ' formula],'Interpreter','latex','FontSize',22);
%     st.Position(2) = st.Position(2)-0.1;  % 正数往上移，负数往下移，具体数值自己试
    annotation('textbox',[0 0.9 1 0.08], ...
    'String',['YbBr$_3$: ' formula], ...
    'Interpreter','latex','FontSize',22, ...
    'EdgeColor','none','HorizontalAlignment','center');
    exportgraphics(gcf,fullfile(pathf, ...
        sprintf('%s=state1%d.png',tt,js)),'Resolution',300);
end


function Y = hobson_Y_7half(M,tp)
%HOBSON_Y_7HALF Hobson auxiliary angular function for J=7/2.
% Explicit P_J^M expressions are from Table S1 of arXiv:2509.00889v3.

J = 7/2;
theta = tp(:,1);
phi = tp(:,2);
x = cos(theta);
u = max(0,1-x.^2);

switch M
    case 7/2
        % 3*x*(16*x^6-56*x^4+70*x^2-35) /
        % sqrt[(pi/2)*sqrt((1-x^2)^7)]
        den = sqrt((pi/2).*sqrt(u.^7));
        P = 3.*x.*(16.*x.^6-56.*x.^4+70.*x.^2-35)./den;

    case 5/2
        % 3*(16*x^6-40*x^4+30*x^2-5) /
        % sqrt[(pi/2)*sqrt((1-x^2)^5)]
        den = sqrt((pi/2).*sqrt(u.^5));
        P = 3.*(16.*x.^6-40.*x.^4+30.*x.^2-5)./den;

    case 3/2
        % x*(24*x^4-40*x^2+15) / sqrt[(pi/2)*sqrt((1-x^2)^3)]
        den = sqrt((pi/2).*sqrt(u.^3));
        P = x.*(24.*x.^4-40.*x.^2+15)./den;

    case 1/2
        % (8*x^4-8*x^2+1) / sqrt[(pi/2)*sqrt(1-x^2)]
        den = sqrt((pi/2).*sqrt(u));
        P = (8.*x.^4-8.*x.^2+1)./den;

    case -1/2
        % x*(2*x^2-1)*sqrt(2/pi)*(1-x^2)^(1/4)
        P = x.*(2.*x.^2-1).*sqrt(2/pi).*u.^(1/4);

    case -3/2
        % ((6*x^2-1)/15)*sqrt(2/pi)*(1-x^2)^(3/4)
        P = ((6.*x.^2-1)./15).*sqrt(2/pi).*u.^(3/4);

    case -5/2
        % (x/15)*sqrt(2/pi)*(1-x^2)^(5/4)
        P = (x./15).*sqrt(2/pi).*u.^(5/4);

    case -7/2
        % (1/105)*sqrt(2/pi)*(1-x^2)^(7/4)
        P = (1/105).*sqrt(2/pi).*u.^(7/4);

    otherwise
        error('Hobson J=7/2 expression is unavailable for M=%g.',M);
end

% Same angular prefactor used by Ylm.m and by Eq. (1) of the manuscript.
NJM = sqrt((2*J+1).*gamma(J-M+1)./(4*pi.*gamma(J+M+1)));
Y = NJM.*P.*exp(1i.*M.*phi);
end
