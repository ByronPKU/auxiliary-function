function [v12,r]= proj(vec1,vec2) % vec1在vec2上的投影
%NFY
% Defined by Biaoyan HU on 171018

r=dot(vec1,dire(vec2));
v12=dire(vec2)*r;

end




