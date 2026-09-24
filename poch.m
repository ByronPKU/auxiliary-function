function y=poch(x,n) % Pochhammer, falling and rising factorials

% Defined by Biaoyan Hu on 250208
% 
% Example: 
% 
% poch(0.5,3)
% = 1.8750
% 

% sz=max(size(x),size(n));
y=nan.*x.*n;
if ~isreal(n)
    return;
end

j0=n==0;
j1=n>0;
j2=n<0;

y(j0)=1;
y1=gamma(x+n)./gamma(x);
y1b=(gamma(x+n+1e-10)./gamma(x+1e-10)+gamma(x+n-1e-10)./gamma(x-1e-10))/2;
y1(isnan(y1))=y1b(isnan(y1));
y2=gamma(x+1)./gamma(x+n+1);
y2b=(gamma(x+1+1e-10)./gamma(x+n+1+1e-10)+gamma(x+1-1e-10)./gamma(x+n+1-1e-10))/2;
y2(isnan(y2))=y2b(isnan(y2));
y(j1)=y1(j1);
y(j2)=y2(j2);
% if n==0
%     y=ones(sz);
% elseif n>0
%     y=gamma(x+n)/gamma(x);
% elseif n<0
%     y=gamma(x+1)/gamma(x-n+1);
% end

% jnan=isnan(y);
% y(jnan)

end

