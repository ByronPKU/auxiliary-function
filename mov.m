function lf= mov(li,v0)

% Defined by Biaoyan HU on 171018
% 
% Example: 
% mov([1,0,0;0 1 0],[1,3,2])
% =
%    [ 2     3     2
%      1     4     2 ]

nr=size(li,1);
lf=li+ones(nr,1)*v0;

end




