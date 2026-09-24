function y=F2_1(a,b,c,z) % Hypergeometric function

% Defined by Biaoyan Hu on 250208
% 

if abs(z)>1;y=nan.*z;return;end
nd=max([numel(size(a)),numel(size(b)),numel(size(c)),numel(size(z))]);
y=f21(a,b,c,z);
jnan=isnan(y);
if any(jnan(:))
    y3=mean(cat(nd+1,f21(a,b,c-1e-10,z),f21(a,b,c+1e-10,z)),nd+1,'omitnan');
    y4=mean(cat(nd+1,f21(a,b,c,z-1e-10),f21(a,b,c,z+1e-10)),nd+1,'omitnan');
    y_=mean(cat(nd+1,y3,y4),nd+1,'omitnan');
    y(isnan(y))=y_(isnan(y));
end

    function y=f21(a,b,c,z)
        min_=min([a;b;c]);
        N0=max(0,ceil(-min_));
        % if min_>=0
        %     N0=0;
        %     abc1=a*b/c;
        % else
        %     N0=ceil(-min_);
        %     abc1=(a+N0)*(b+N0)*(c+N0)
        % end
        % abc1=(a+N0)*(b+N0)*(c+N0);
        ne=3; % 判断收敛是e的负几次方
        N1=ceil(exp(ne/2).*max([a;b;c]+N0));
        N2=max(ceil(-ne./log(abs(z))),0);
        Nmax=1024; % 最多允许多少个加和
        N=3*min(Nmax,N0+N1+N2); % 这里的系数越大越准，特别对于x→-1的情况
        
        js=permute((1:N).',[2:nd+1 1]);
        fs=pochfac(a,c,js).*pochfac(b,1,js).*z.^js;
        
        y=1+sum(fs,nd+1,'omitnan');

    end
end

