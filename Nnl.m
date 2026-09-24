function Y=Nnl(varargin) % normalization coefficient for Rnl

% Defined by Biaoyan Hu on 241029

if nargin==0;Y=[];return;
elseif nargin==1;n=varargin{1}(:,1);l=varargin{1}(:,2);
elseif nargin>=2;n=varargin{1};l=varargin{2};
end
Y=sqrt(fac(n-l-1)./(2*n.*fac(n+l)));

end
