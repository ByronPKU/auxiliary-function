function c= convnsame(varargin)

% Defined by Biaoyan Hu on 191115
% convnsame(a,con,n)
% 
% Example: 
% a=cat(3,[0 2 0;1 3 1;0 2 0],[3 2 3;2 3 2;5 2 5]);
% convnsame(2*ones(7,4,3),3)
% convnsame(2*ones(7,4,3),-3)
% convnsame(2*ones(7,4,3),a,1)
% convnsame(2*ones(7,4,3),a,-1)
% 

if nargin==1;a=varargin{1};cs=[];n=-3;
elseif nargin==2;a=varargin{1};cs=[];n=varargin{2};
elseif nargin==3;a=varargin{1};cs=varargin{2};n=sign(varargin{3});
end

dima=numel(size(a));
if dima==2;dima=dimen(a);end
if dima<=2;c=conv2same(varargin{:});return;end
jnan=isnan(a);
a(jnan)=0;
if isempty(cs)
    num=numel(n);
    if num==1;n2=abs(repmat(n,1,dima));
    elseif num>=2;n2=abs(n(:).');
    else;error('Wrong in convnsame');
    end
    scs=1; % 一个格子应该扩展的格数
    cs=ones(n2)/prod(n2);
else
    scs=sum(cs(:)); % 一个格子应该扩展的格数
end
c=convn(a,cs,'same');

if all(n<0)
    a0=~jnan;
    spr=convn(a0,cs,'same'); % 每个格子实际扩展的格数
    c=c+a.*(scs-spr); % 每个格子补上损失的量
end

c(jnan)=nan;

end