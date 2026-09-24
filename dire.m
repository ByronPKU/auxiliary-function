function di= dire(vec) % direction

% Defined by Biaoyan HU on 171018
% 
% Example: 
% 
% dire([1 2 3 4;4 3 2 1;1 0 1 0])
% = 
%   [ 0.1826    0.3651    0.5477    0.7303
%     0.7303    0.5477    0.3651    0.1826
%     0.7071         0    0.7071         0 ]
% 

nvec=rssq(vec,2);
di=vec./nvec;
if any(nvec==0)
    di(nvec==0,:)=0;
end

end




