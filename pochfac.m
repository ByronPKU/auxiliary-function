function y=pochfac(a,c,n) % poch(a,n)./poch(c,n)

% Defined by Biaoyan Hu on 250208
% 
% Example: 
% 
% poch(2,180)./poch(3,180)
% pochfac(2,3,180)
% pochfac([2 3],[3 4].',permute([180;179],[3 2 1]))
% 

% nd=max([numel(size(a)),numel(size(c)),numel(size(n))]);

jneg=n<0;
n=abs(n);

a_n=poch(a,n);
c_n=poch(c,n);

if any(isinf(a_n(:)))&&~any(isinf(a(:))) || any(isinf(c_n(:)))&&~any(isinf(c(:)))
%     js=permute((0:n-1).',[2:nd+1 1]);
    n_=n+a*0+c*0;
    js=eld(n_-1);
    js(js<0)=nan;
    f=(a+js)./(c+js);
    y=prod(f,numel(size(js)),'omitnan');
else
    y=poch(a,n)./poch(c,n);
end

if any(jneg(:))
    jneg_=jneg&true(size(y));
    y2=pochfac(a-n+1,c-n+1,n);
    y(jneg_)=y2(jneg_);
end

function b = eld(a) % expand_last_dim
    max_val = ceil(max(a(:))); % 获取a中的最大值，确定新维度大小
    b = repmat(a, [ones(1, ndims(a)), max_val]) - reshape(0:max_val-1, [ones(1, ndims(a)), max_val]);
end

end

