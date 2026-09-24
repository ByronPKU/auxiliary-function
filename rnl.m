function y=rnl(varargin) % Reduced radial wave function

% Defined by Biaoyan Hu on 241029
% rnl(n,l,x)
% 

if nargin<2;y=[];return;
elseif nargin==2;n=varargin{1}(:,1);l=varargin{1}(:,2);x=varargin{2};
elseif nargin>=3;n=varargin{1};l=varargin{2};x=varargin{3};
end
y=x.^l.*exp(-x/2).*Nnl(n,l).*Lnl(n,l,x);

end
