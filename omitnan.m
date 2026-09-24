function [b,omt,wt]=omitnan(varargin) % Omit nan in some row(column) in a matrix

%NFY Lack of examples. 
% Defined by Biaoyan on 160620
% Omit the rows or the columns which has nan in a matrix.
% omitnan(xy,n). 
% 'xy' is the matrix.
% 'n' should be the column(row) no. one wants to check. If there are some
% nans in the nth column(row), the function will omit those rows(columns). 
% If one want to omit some columns, n should be negtive (used to be
% roc='omitcolumns' before 170425 or roc=2 before 161028), otherwise, it
% will omit some rows. 
% 
% Change-170425-Biaoyan
%   Changed from omitnan(xy,n,roc) to omitnan(xy,n). The function will omit
%   the columns when n<0. 
% 
% Needed functions: 
% []
%

xy=varargin{1};
if nargin==1;if size(xy,1)==1;n=-1;else;n=1:size(xy,2);end % 如果只有一个输入：如果只有一行，简单删除nan；否则检索每一列，删除所有含nan的行
elseif nargin>=2;xy=varargin{1};n=varargin{2};
end

nun=numel(n);
if nun>1
    b=xy;
    omt=cell(nun,1);
    wt=cell(nun,1);
    for jn=1:nun
        [b,omtj,wtj]=omitnan(b,n(jn));
        omt{jn}=omtj;
        wt{jn}=wtj;
    end
    return;
end

if isnan(n);b=omitnan(reshape(xy,[],1));return;end

if n<0;xy=xy.';end
% s=size(xy,1);
absn=abs(n);
if ~istable(xy)
    omt=isnan(xy(:,absn));
else % 2024.2.23
    xyj=xy{:,absn};
    if iscell(xyj)
        omt=false(size(xyj));
    else
        omt=isnan(xyj);
    end
end
wt=~omt;
% omt=setdiff(s,wt);
b=xy(wt,:);
if n<0;b=b.';end

end