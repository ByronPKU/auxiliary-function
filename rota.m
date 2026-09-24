function rt= rota(varargin) % Rotation

% Defined by Biaoyan HU on 171018
% rota(v0,arc)
% rota(vi,v0,arc)
% 
% Example: 
% 
% rota([1,0,0],[1,1,1],1)
% =
% [0.6935    0.6391   -0.3326]
% 
% [1,0,0]*rota([1,1,1],1)
% =
% [0.6935    0.6391   -0.3326]
% 
% Needed functions: 
%   dire, mov, vect, proj

if nargin<=2
    if nargin==1
        v0=dire(varargin{1});
        arc=norm(varargin{1});
    elseif nargin==2
        v0=varargin{1};
        arc=varargin{2};
    end
    if arc==0;rt=eye(3,3);return;end
    dv0=dire(v0);
    i=dv0(1);
    j=dv0(2);
    k=dv0(3);
    s=sin(arc);
    c=cos(arc);
    rt=[
        c+i^2*(1-c), j*i*(1-c)+k*s, k*i*(1-c)-j*s;
        i*j*(1-c)-k*s, c+j^2*(1-c), k*j*(1-c)+i*s;
        i*k*(1-c)+j*s, j*k*(1-c)-i*s, c+k^2*(1-c);    ];
    return;
elseif nargin>=3;vi=varargin{1};v0=varargin{2};arc=varargin{3};
end
if size(v0,1)>=2
    mv=v0(1,:);
    v0v=vect(v0);
    vi0=mov(vi,-mv);
    rt=mov(rota(vi0,v0v,arc),mv);
    return;
end
szvi=size(vi);
rt=nan*ones(szvi);
if szvi(1)>=2
    for j1=1:szvi(1)
        rt(j1,:)=rota(vi(j1,:),v0,arc);
    end
    return;
end
cv0i=cross(v0,vi);
if cv0i==0;rt=vi;return;end
ax3=dire(v0);
ax2=dire(cv0i);
ax1=dire(cross(ax2,ax3));
[vlen3,len3]=proj(vi,v0);
vlen12=vi-vlen3;
len12=norm(vlen12);
if len12==0;rt=vi;return;end
rt=ax1*len12*cos(arc)+ax2*len12*sin(arc)+ax3*len3;

end