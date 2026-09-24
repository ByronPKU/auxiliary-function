function d=dSla(n) % Slater's rules, n*=n-dSla

% Defined by Bioayan Hu on 241127
% 
% Example: 
% 
% n=0:0.1:10;
% d=dSla(n);
% figure;
% plot(n,d,'k.-');
% 

d=interp1(1:8,[0 0 0 0.3 1 1.2 1.2 1.2],n,'makima');

end
