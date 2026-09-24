function P=Plamu(varargin) % Legendre function P_lambda^mu

% Changed from Plm_250224LegendreFunction on 250310
% Plamu(l,m,x)
% 
% 对于m为正整数的情况需要优化！！！ 250313

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

P=1./fac(-m).*((1+x)./(1-x)).^(m/2).*F2_1(-l,l+1,1-m,(1-x)/2); % 250208
% P=1./fac(-m).*((1+x)./(x-1)).^(m/2).*F2_1(-l,l+1,1-m,(1-x)/2); % 250210
% P_=pochfac(l+1,1,abs(m)).*poch(-l,m).*((1-x)./(1+x)).^(m/2).*F2_1(-l,l+1,1+m,(1-x)/2); % 250209
P_=1./fac(m).*((1+x)./(1-x)).^(m/2).*F2_1(-l,l+1,1+m,(1-x)/2); % 250210c
Pabs=1./fac(-m).*((1-x)./(1+x)).^(m/2).*F2_1(-l,l+1,1-m,(1+x)/2); % 250210

mm=m+zeros(size(P));
j_=mm==abs(floor(mm));
P(j_)=P_(j_);

% j_=mm>0;

j_1=j_&x==-1;
P(j_1)=0;
jhi=l>-0.5 & l+1/2==round(l+1/2) & m+1/2==round(m+1/2); % those half-integer l,m
jhi_=jhi&x<0&true(size(P));
P(jhi_)=(-1).^(l-m+1).*Pabs(jhi_);

% P(j_)=(-1).^-floor(l).*fac(l+m)./fac(l-m).*P_(j_);

P=round(P,9);

% if isnan(P);P=(Plm(l-1e-10,m,x)+Plm(l+1e-10,m,x))/2;end % 250120

end