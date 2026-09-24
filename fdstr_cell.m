function [fd]=fdstr_cell(varargin) % Find string in a cell
% >>>>>>>>>Being Deprecated<<<<<<<<<<
% The function can be replaced by find(strcmp(...))
% =================================

% Defined by Biaoyan on 160928
% fdstr_cell(obj,var)
% 
% Example:
% fdstr_cell('a',{'b','a',struct('f1','u'),'c','a',[1 2 3;3 2 1]})
% = [2 5]
% find(strcmp('a',{'b','a',struct('f1','u'),'c','a',[1 2 3;3 2 1]}))
% = [2 5]
% 

obj=varargin{1};var=varargin{2};

nu=numel(var);
fd=nan*ones(1,nu);
nfd=0;

for j=1:nu
    if ischar(var{j}) && strcmp(var{j},obj)
        fd(nfd+1)=j;
        nfd=nfd+1;
    end
%     if nfd<nu;nfd(nfd+1:end)=[];end;
end
fd=omitnan(fd);
end