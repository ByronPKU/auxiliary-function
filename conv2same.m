function c= conv2same(varargin)

% Defined by Biaoyan Hu on 190320
% conv2same(a,cs,n)
% n>0，超出裁剪，适合稀疏强点阵
% n<0，超出裁剪+边缘补偿，适合稠密强度谱
% 
% Example: 
% conv2same(2*ones(7,4),3)
% conv2same(2*ones(7,4),-3)
% conv2same(2*ones(7,4),[0 2 0;1 3 1;0 2 0],1)
% conv2same(2*ones(7,4),[0 2 0;1 3 1;0 2 0],-1)
% 

if nargin==1;a=varargin{1};cs=[];n=-3;
elseif nargin==2;a=varargin{1};cs=[];n=varargin{2};
elseif nargin==3;a=varargin{1};cs=varargin{2};n=sign(varargin{3});
end

dima=dimen(a);
if dima<=1;c=conv1same(varargin{:});return;
elseif dima>2;error('The input in conv2same should be 2-D array. ');
end

jnan=isnan(a);
if any(jnan(:)~=0)
    a(jnan)=0;
end
if isempty(cs)
    num=numel(n);
    if num==1;n2=abs([n,n]);
    elseif num==2;n2=abs([n(1) n(2)]);
    else;error('Wrong in conv2same');
    end
    scs=1; % 一个格子应该扩展的格数
    cs=ones(n2)/prod(n2);
else
    scs=sum(cs(:)); % 一个格子应该扩展的格数
end
c=conv2(a,cs,'same');

if all(n<0)
    a0=~jnan;
    spr=conv2(a0,cs,'same'); % 每个格子实际扩展的格数
    c=c+a.*(scs-spr); % 每个格子补上损失的量
end

if n==0
    c=(conv2same(a,cs,1)+conv2same(a,cs,-1))/2;
end

c(jnan)=nan;

end