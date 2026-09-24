function [pis,val,cl]= plotisos(varargin)

% Defined by Biaoyan Hu on 180828
% Changed plotisos(dt3,val,dds) to plotisos(dt3,xyz,val,dds) on 191113
%
% Example:
% figure;plotisos(rand(5,4,3));
%

fdmfc=fdstr_cell('alfa',varargin);
ng=nargin;
if ~isempty(fdmfc)
    fa=varargin{fdmfc(1)+1};
    fdmfcc=unique([fdmfc,fdmfc+1]);
    varargin=rmobj_cell(varargin,fdmfcc);
    ng=ng-numel(fdmfcc);
else
    fa=1; % Changed from 0.2 to 1 on 211101
end

if ng==1;dt3=varargin{1};xyz=[];val=[];dds=[1 1 1];
elseif ng==2
    if ~iscell(varargin{2});dt3=varargin{1};xyz=[];val=varargin{2};dds=[1 1 1];
    else;dt3=varargin{1};xyz=varargin{2};val=[];dds=[1 1 1];
    end
elseif ng==3;dt3=varargin{1};xyz=varargin{2};val=varargin{3};dds=[1 1 1];
elseif ng>=4;dt3=varargin{1};xyz=varargin{2};val=varargin{3};dds=varargin{4};
end


% 判断矩阵是否有壳
SH=0;
if dt3(1)==-inf
    SH=1;
    [dt3,theSH]=unshell(dt3);
end

dts=omitnan(dt3,nan);
ndts=numel(dts);
if isempty(val)
    val=median(dts);
elseif any(isnan(val))
    if numel(val)==1
        rr=0.5;
    else
        rr=val(2);
    end
    dts0=dts;dts0(dts==inf)=nan;
    dts(dts==inf)=max(dts0(:),[],'omitnan'); % 250313
    dts_=sortrows(dts,-1);
    sum_=sum(dts);
    sums=cumsum(dts_);
    jf=find(sums>=sum_*rr,1)-1/2;
    val=mean(dts_(jf+[-1 1]/2));
    [pval,nval]=prop(dts_==val);
    % 按比例确定val时，当val为某个数值，且不是绝大多数时，调整val使其避免为某已有。
    if nval>1 && pval<0.5
        udts_=flip(unique(dts_));
        jf_=find(udts_==val); % 一定只有一个
        jfm1=find(dts_==val,1);
        jfm2=find(dts_==val,1,'last');
        jfm=(jfm1+jfm2)/2; % 判断jf往前还是往后靠
        if jf<jfm
            val=mean(udts_(jf_-[0 1]));
        else
            val=mean(udts_(jf_+[0 1]));
        end
    end
end

% val若为虚数可以取冷核
isrealval=1; % 默认热核
if ~isreal(val)
    isrealval=-1; % 冷核模式
    dt3=-dt3;
    val=-imag(val);
end

if max(dt3(:))<val
    pis=[];
    cl=[];
    return;
end

% dt3=tranxy(dt3); % Changed to 'permute' on 20.9.27
dt3=permute(dt3,[2 1 3]);

if size(dt3,2)==1
    dt3=cat(2,dt3,dt3);
    if ~isempty(xyz)
        xyz{1}=[xyz{1} xyz{1}];
    end
end

if size(dt3,1)==1
    dt3=cat(1,dt3,dt3);
    if ~isempty(xyz)
        xyz{2}=[xyz{2} xyz{2}];
    end
end

if size(dt3,3)==1
    dt3=cat(3,dt3,dt3);
    if ~isempty(xyz)
        xyz{3}=[xyz{3} xyz{3}];
    end
end

szdt3=size(dt3);
del=max(dt3(:))-min(dt3(:));

if ~isempty(xyz)
    [xs,ys,zs]=meshgrid(xyz{1},xyz{2},xyz{3});
elseif SH==0
    xyz{1}=1:szdt3(2);
    xyz{2}=1:szdt3(1);
    xyz{3}=1:szdt3(3);
    [xs,ys,zs]=meshgrid(xyz{1},xyz{2},xyz{3});
else
	xyz{1}=theSH{1}(:).';
    xyz{2}=theSH{2}(:).';
    xyz{3}=theSH{3}(:).';
    [xs,ys,zs]=meshgrid(xyz{1},xyz{2},xyz{3});
end

% i1b=isosurface(xs,ys,zs,dt3,val);
jnan=isnan(dt3);
dt3(jnan)=-realmax(class(dt3));
if dimen(dt3)>=3
    i0=isocaps(xs,ys,zs,dt3,val); % 边界面
    i1=isosurface(xs,ys,zs,dt3,val); % 等强度面
else
    pis=[];
    cl=[];
    return;
end

if isempty(i1.faces)
    pis=[];
    cl=[];
    return;
end

dt3_1a=dt3;
dt3_1a(jnan)=0;
dt3_1b=convnsame(dt3_1a,3);
dt3_1c=convnsame(dt3_1a~=0,3);
dt3_1d=dt3_1b./dt3_1c;
dt3_color=dt3;
dt3_color(jnan)=dt3_1d(jnan);

if isrealval==1
    i1.facevertexcdata=interp3(xs,ys,zs,dt3_color,i1.vertices(:,1),i1.vertices(:,2),i1.vertices(:,3));
else
    i0.facevertexcdata=-i0.facevertexcdata;
    i1.facevertexcdata=-interp3(xs,ys,zs,dt3_color,i1.vertices(:,1),i1.vertices(:,2),i1.vertices(:,3));
end

pi0=patch(i0,'FaceColor','interp','EdgeColor','none','FaceAlpha',fa);
pi1=patch(i1,'FaceColor','interp','EdgeColor','none','FaceAlpha',fa);

view(3);
mdds=min(dds);
dtasp=mdds*dds.^-1;
set(gca,'dataaspectratio',dtasp);
% axis vis3d tight
% camlight headlight
% cl=camlight(0,0); % 241030
cl=[];
colormap('jet');
lighting gouraud
pis=[pi0;pi1];
% % ↑分别表示边界面，等强度面(含与nan的边界)

xl=get(gca,'xlabel');
yl=get(gca,'ylabel');
zl=get(gca,'zlabel');
if isempty(xl.String)
    xlabel('Axis 1');
end
if isempty(yl.String)
    ylabel('Axis 2');
end
if isempty(zl.String)
    zlabel('Axis 3');
end
if val~=0
    caxis(sort(isrealval*[val val+abs(val)]));
else
    cax=[0 std(dt3(:),'omitnan')];
    if abs(cax(2))>0
        caxis(sort(isrealval*cax));
    end
end

end


