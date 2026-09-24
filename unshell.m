function [dt,SH]=unshell(dtSH)

% Defined by Biaoyan Hu on 210731
% 
% Example: 
% 
% unshell(addshell(rand(4,3)))
% =
%   [ 0.8055    0.8865    0.9787
%     0.5767    0.0287    0.7127
%     0.1829    0.4899    0.5005
%     0.2399    0.1679    0.4711 ]
% 

sz=size(dtSH);
dm=numel(find(sz));
if dm==1
    dt=dtSH(2:end,2);
    SH={dtSH(2:end,1)};
elseif dm==2
    dt=dtSH(2:end,2:end);
    SH={dtSH(2:end,1);dtSH(1,2:end)};
elseif dm==3
    dt=dtSH(2:end,2:end,2:end);
    SH={dtSH(2:end,1,1);dtSH(1,2:end,1);dtSH(1,1,2:end)};
elseif dm>=4
    eval(['dt=dtSH(2:end' repmat(',2:end',1,dm-1) ');']);
    if nargout>=2
        SH=cell(dm,1);
        for jd=1:dm
            eval(['SH{jd}=dtSH(' repmat('1,',1,jd-1) '2:end' repmat(',1',1,dm-jd) ');']);
        end
    end
end

end