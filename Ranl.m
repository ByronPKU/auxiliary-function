function Y=Ranl(varargin) % Radial wave function

% Defined by Biaoyan Hu on 241029
% Rnl(a,n,l,r)
% a=a0/Z，类氢原子的基态半径
% 

if nargin<2;Y=[];return;
elseif nargin==2;a=1;n=varargin{1}(:,1);l=varargin{1}(:,2);r=varargin{2};
elseif nargin==3;a=1;n=varargin{1};l=varargin{2};r=varargin{3};
elseif nargin>=4;a=varargin{1};n=varargin{2};l=varargin{3};r=varargin{4};
end
b=(n.*a)/2;
x=r./b;
Y=b.^-1.5.*rnl(n,l,x);
% Y=x.^l.*exp(-x/2).*Nnl(n,l).*Lnl(n,l,x);

end
