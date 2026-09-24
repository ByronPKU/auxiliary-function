function hh=arrow3(varargin)

% Defined by Biaoyan Hu on 241022
% 
% Example: 
% figure;
% arrow3([1 0;2 1;2 2;1 3;0 3;-1 2;-1 1;0 0],'b');
% 

if nargin==0;hh=arrow3([0 0 0;0 0 0]);return;end
xys=varargin{1};
if nargin>1
    vr=varargin(2:end);
else
    vr=cell(0,0);
end

if size(xys,2)==2;xys(:,3)=0;end
nl=size(xys,1)-1;
if nl>1
    hh=[];
    hold on;
    for jl=1:nl
        hh(jl)=arrow3(xys(jl:jl+1,:),vr{:});
    end
    return;
end

df=diff(xys);
hh=quiver3(xys(1,1),xys(1,2),xys(1,3),df(1),df(2),df(3),0,vr{:});

end
