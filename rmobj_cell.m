function ce2= rmobj_cell(varargin)

% Defined by Biaoyan on 160928
% rmobj_cell(ce1,arr)
% 
% Example:
% rmobj_cell({'b','a','c'},[1,3])
% = 'a'

ce1=varargin{1};arr=varargin{2};

arra=sortrows(reshape(arr,[],1));
sa=numel(arra);
ce2=ce1;

for j=1:sa;
    ce2(arra(sa-j+1))=[];
end;

end