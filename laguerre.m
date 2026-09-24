function y=laguerre(n,a,x)

% Defined by Biaoyan Hu on 241127
% 适用n为正实数，a和x可以是矩阵。
% 对于n<0的情况，将来可以用递推公式扩展。
% 

sz=size(a+x);
nn=prod(sz);
a=a+zeros(sz);
x=x+zeros(sz);

if n==0
    y=ones(sz);
    return;
elseif n~=round(n)
    if n<1
        y1=x./a;
    else
        y1=laguerre(floor(n)-1,a,x);
    end
    y2=laguerre(floor(n),a,x);
    y3=laguerre(floor(n)+1,a,x);
    y4=laguerre(floor(n)+2,a,x);
    if nn==1
        y=interp1(floor(n)-1:floor(n)+2,[y1 y2 y3 y4],n,'cubic');
    else
        [nys,nxs]=meshgrid(floor(n)-1:floor(n)+2,1:nn);
        y_=interp2(nys,nxs,[y1(:) y2(:) y3(:) y4(:)],n*ones(nn,1),(1:nn).','cubic');
        y=reshape(y_,sz);
    end
    return;
elseif n<0
    y=nan(sz);
    return;
end

jj=0;
c=[];
while jj<n
    jj=jj+1;
    c=[1 c(1:end-1)+c(2:end) 1];
end

y=zeros(size(a+x));
for jjj=0:n
    yj=(-1)^(jjj+n).*c(jjj+1).*fac(a+n)./fac(a+n-jjj).*x.^(n-jjj);
    y=y+yj;
end

y=y/fac(n);

end