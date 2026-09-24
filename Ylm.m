function Y=Ylm(varargin) % Spheric harmonic function

% Defined by Biaoyan Hu on 241029
% Ylm(l,m,tp)

if nargin<2;Y=[];return;
elseif nargin==2;l=varargin{1}(:,1);m=varargin{1}(:,2);tp=varargin{2};
elseif nargin>=3;l=varargin{1};m=varargin{2};tp=varargin{3};
end
t=tp(:,1);
if size(tp,2)==1
    p=zeros(size(t));
else
    p=tp(:,2);
end
Nlm=sqrt((2*l+1).*fac(l-m)./(4*pi*fac(l+m)));
Y=Nlm.*Plm(l,m,cos(t)).*exp(1i*m.*p); % 241220 250220

end
