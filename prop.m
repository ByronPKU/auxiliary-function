function [pr,nfx]= prop(x) % Proportion of x

% Defined by Biaoyan Hu on 211228
% 
% Example: 
% prop(rand(100,3)>0.5)
% 

nfx=numel(find(x)); % 250304
pr=nfx/numel(x);
% pr=numel(x(x~=0))/numel(x);

end