function P=Plm_Hunter(varargin)

% Changed from ePlm on 250716
% refer to Bildstein.2018
% Plm(l,m,x)
% Plm_250220
% Plm_250309type250220
% Plm_250312type250312_msgn
% 2025.3.12
% 发现在实际应用中角度是反的，而之前取+sgn实属随意，故改为-sgn，是为type250312
% Plm_250312type250312_msgni
% 2025.7.16
% 检查图时突然发现问题。还是用的老版本(-)^((M+|M|)/2)，现改为(-)^[(M+|M|)/2]

if nargin<2;P=[];return;
elseif nargin==2;l=varargin{1}(:,1);m=varargin{1}(:,2);x=varargin{2};
elseif nargin>=3;l=varargin{1};m=varargin{2};x=varargin{3};
end
if numel(l)>1 || numel(m)>1
    szl=size(l);szm=size(m);szx=size(x);
    dim=max([numel(szl);numel(szm);numel(szx)]);
    szmax=nan([1,dim]);
    szpro=nan([1,dim]);
    for jd=1:dim
        szmax(jd)=max([size(l,jd);size(m,jd);size(x,jd)]);
        szpro(jd)=prod([size(l,jd);size(m,jd);size(x,jd)]);
    end
    if any(szmax~=szpro);P=[];return;end
    onesz=ones(szmax);
    ls=l.*onesz;
    ms=m.*onesz;
    P=nan(szmax);
    if all(find(szx>1)==1)
        nx=numel(x);
        nn=numel(P)/nx;
        for jj=1:nn
            P((jj-1)*nx+1:jj*nx)=Plm(ls(jj*nx),ms(jj*nx),x);
        end
    else
        xs=x.*onesz;
        nn=numel(P);
        for jj=1:nn
            P(jj)=Plm(ls(jj),ms(jj),xs(jj));
        end
    end
    return;
end

if l==0 && m==0
    P=ones(size(x));
    return;
% elseif l<-1/2
%     P=Plm(abs(l)-1,m,x);
%     return;
end

% d=max([numel(size(l)) numel(size(m)) numel(size(x)) 1]);
zr=zeros(size(l+m+x));
jm1=m>0;
jm1_=(m+zr)>0;
m=-abs(m);
% x=x.*(1-2*jm1);

% l_=floor(l);
% m_=floor(m);


P=1./fac(-m).*((1+x)./(1-x)).^(m/2).*F2_1(-l,l+1,1-m,(1-x)/2); % 250208
% P=1./fac(-m).*((1+x)./(x-1)).^(m/2).*F2_1(-l,l+1,1-m,(1-x)/2); % 250210
% P_=pochfac(l+1,1,abs(m_)).*poch(-l,m_).*((1-x)./(1+x)).^(m/2).*F2_1(-l,l+1,1+m,(1-x)/2); % 250209
Pabs=1./fac(-m).*((1-x)./(1+x)).^(m/2).*F2_1(-l,l+1,1-m,(1+x)/2); % 250210

mm=m+zeros(size(P));
j_=mm==abs(floor(mm));
% P(j_)=P_(j_);
j_1=j_&x==-1;
P(j_1)=0;
jhi=l+1/2==round(l+1/2) & m+1/2==round(m+1/2); % those half-integer l,m
jhi_=jhi&x<0&true(size(P));
P(jhi_)=(-1).^(l-m+1).*Pabs(jhi_);
P=round(P,9);

absm=abs(m);
% P_=(-1).^absm.*fac(l+absm)./fac(l-absm).*P;
P_=(-1).^floor(absm).*fac(l+absm)./fac(l-absm).*P; % 250716
P(jm1_)=P_(jm1_);

if isnan(P);P=(Plm(l-1e-10,m,x)+Plm(l+1e-10,m,x))/2;end % 250120
% ↑此行(if isnan...)可能导致无限循环，如果无限循环，可以注释这一行。250215

end