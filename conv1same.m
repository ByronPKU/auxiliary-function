function c= conv1same(varargin)
%NFY
% Defined by Biaoyan Hu on 190608
% conv1same(a,con,n)
% Similiar to conv2same
% 
% Example: 
% conv1same(2*ones(7,1),3)
% conv1same(2*ones(7,1),-3)
% conv1same(2*ones(7,1),[1;3;1],1)
% conv1same(2*ones(7,1),[1;3;1],-1)
% 

if nargin==1;a=varargin{1};cs=[];n=-3;
elseif nargin==2;a=varargin{1};cs=[];n=varargin{2};
elseif nargin==3;a=varargin{1};cs=varargin{2};n=sign(varargin{3});
end

dima=dimen(a);
if dima==0;c=a;return;
elseif dima>1;error('The input in conv1same should be 1-D array. ');
end
a_0=a;
if size(a_0,1)==1;a=a.';end
jnan=isnan(a);
a(jnan)=0;
if isempty(cs)
    num=numel(n);
    n2=abs(n);
    if num~=1
        error('Wrong in conv1same');
    end
    scs=1; % 一个格子应该扩展的格数
    cs=ones(n2,1)/n2;
else
    scs=sum(cs(:));
end
c=conv(a,cs,'same');

if n<0
    a0=~jnan;
    spr=conv(a0,cs,'same'); % 每个格子实际扩展的格数
    c=c+a.*(scs-spr); % 每个格子补上损失的量
end

c(jnan)=nan;
if size(a_0,1)==1;c=c.';end

end