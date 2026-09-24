function dm=dimen(arr)
%NFY
% Defined by Biaoyan Hu on 180828
% 
% Needed functions: 
% []
%

sz=size(arr);
dm=sum(logical((sz-1)*min(sz)));
% dm=nnz(sz-1);

end