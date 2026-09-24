function L=Lnl(varargin) % Laguerre polynomials for n,l

% Defined by Biaoyan Hu on 241127
% 原本的Lnl重命名为了Lnl_，目前的Lnl在定义并优化了laguerre后直接调用

if nargin<2;L=[];return;
elseif nargin==2;n=varargin{1}(:,1);l=varargin{1}(:,2);x=varargin{2};
elseif nargin>=3;n=varargin{1};l=varargin{2};x=varargin{3};
end

L=laguerre(n-l-1,2*l+1,x);return;

end
