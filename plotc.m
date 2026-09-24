function h=plotc(varargin) % Plot combined xyz
%NFY
% Defined by Biaoyan Hu on 180830

if iscell(varargin{1})
    xyzs=varargin{1};
    nv1=numel(xyzs);
    h=cell(size(xyzs));
    for j1=1:nv1
        if nargin==1
            h{j1}=plotc(xyzs{j1});
        else
            h{j1}=plotc(xyzs{j1},varargin{2:end});
        end
    end
    return;
end

xl=get(gca,'xlabel');
yl=get(gca,'ylabel');
zl=get(gca,'zlabel');

if nargin==1
    h=[];
    xyz=varargin{1};
    if istable(xyz);xyz=table2array(xyz);end
    if min(size(xyz))==1
        h=plot(xyz);
        return;
    elseif size(xyz,2)==2
        h=plot(xyz(:,1),xyz(:,2));
        xl=get(gca,'xlabel');
        yl=get(gca,'ylabel');
        zl=get(gca,'zlabel');

        %         xlabel('Axis 1');
        %         ylabel('Axis 2');
        if isempty(xl.String)
            xlabel('Axis 1');
        end
        if isempty(yl.String)
            ylabel('Axis 2');
        end
    elseif size(xyz,2)>=3
        h=plot3(xyz(:,1),xyz(:,2),xyz(:,3));
        xl=get(gca,'xlabel');
        yl=get(gca,'ylabel');
        zl=get(gca,'zlabel');

        %         xlabel('Axis 1');
        %         ylabel('Axis 2');
        %         zlabel('Axis 3');
        if isempty(xl.String)
            xlabel('Axis 1');
        end
        if isempty(yl.String)
            ylabel('Axis 2');
        end
        if isempty(zl.String)
            zlabel('Axis 3');
        end
    end
elseif nargin>=2
    fdxyy=fdstr_cell('xyy',varargin);
    if ~isempty(fdxyy)
        %         varargin=rmobj_cell(varargin,fdxyy);
        xyy=varargin{1};
        if istable(xyy);xyy=table2array(xyy);end
        h=plot(xyy(:,1),xyy(:,2),'ko',xyy(:,1),xyy(:,3),'r*');
        return;
    end
    h=[];
    xyz=varargin{1};
    if istable(xyz);xyz=table2array(xyz);end
    %     if min(size(xyz))==1
    if size(xyz,2)==1
        h=plot(varargin{:});
        return;
    elseif size(xyz,2)==2
        h=plot(xyz(:,1),xyz(:,2),varargin{2:end});
        xl=get(gca,'xlabel');
        yl=get(gca,'ylabel');
        zl=get(gca,'zlabel');

        %         xlabel('Axis 1');
        %         ylabel('Axis 2');
        if isempty(xl.String)
            xlabel('Axis 1');
        end
        if isempty(yl.String)
            ylabel('Axis 2');
        end
    elseif size(xyz,2)>=3
        h=plot3(xyz(:,1),xyz(:,2),xyz(:,3),varargin{2:end});
        xl=get(gca,'xlabel');
        yl=get(gca,'ylabel');
        zl=get(gca,'zlabel');

        %         xlabel('Axis 1');
        %         ylabel('Axis 2');
        %         zlabel('Axis 3');
        if isempty(xl.String)
            xlabel('Axis 1');
        end
        if isempty(yl.String)
            ylabel('Axis 2');
        end
        if isempty(zl.String)
            zlabel('Axis 3');
        end
    end
end

end