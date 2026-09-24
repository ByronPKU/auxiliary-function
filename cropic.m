
function imr_=cropic(crops,fig0,fig1) % crop picture

% Defined by Biaoyan Hu on 220816
% 
% Example: 
% 
% fig0='E:\Matlab\Figures\Temp\test220816ub_TDS_plotu_3=L120.jpg';
% fig1='E:\Matlab\Figures\Temp\test220816ub_TDS_plotu_3=L120_1.jpg';
% fig2='E:\Matlab\Figures\Temp\test220816ub_TDS_plotu_3=L120_2.jpg';
% fig3='E:\Matlab\Figures\Temp\test220816ub_TDS_plotu_3=L120_3.jpg';
% cropic([255 nan],fig0,fig1);
% cropic(255,fig0,fig2);
% cropic([0.2 0.8 0.1 0.9],fig0,fig3);
% 

if nargin<3 && nargout>0;fig1=fig0;end

[imr,mp,af]=imread(fig0);
if ~isempty(mp);imr=ind2rgb(imr,mp);end
imr_=[];
if isempty(crops);crops=nan;end
if numel(crops)==4 && ~isnan(crops(end))
    sza=size(imr,1:2);
    r4=reshape(crops,2,2);
    r4_=[flip(1-r4(:,2)) r4(:,1)];
    j4=ceil(r4_.*sza);

    h=j4(2)-j4(1)+1; w=j4(4)-j4(3)+1;
    if h<=0 || w<=0
        imr_=[];
    else
        if isfloat(imr); white=1; else; white=intmax(class(imr)); end
        imr_=repmat(cast(white,class(imr)),h,w,size(imr,3));

        a=max(j4(1),1); b=min(j4(2),sza(1));
        c=max(j4(3),1); d=min(j4(4),sza(2));
        if a<=b && c<=d
            imr_(a-j4(1)+1:b-j4(1)+1,c-j4(3)+1:d-j4(3)+1,:)=imr(a:b,c:d,:);
        end
    end
else
    if numel(crops)>0 && isnan(crops(end))
        se=1;crops(end)=[];
        if isempty(crops);crops=nan;end
    else;se=0;
    end
    if isequaln(crops,nan)
        a1=any(af,2);a2=any(af,1);
    else
        imrcol=~all(imr==reshape(crops,1,1,[]),3);
        a1=any(imrcol,2);a2=any(imrcol,1);
    end
    if se==1 && any(a1)
        imr_=imr(find(a1,1):find(a1,1,'last'),find(a2,1):find(a2,1,'last'),:);
    elseif se==0
        imr_=imr(a1,a2,:);
    end
end

if nargin>2
    if ~isempty(imr_);imwrite(imr_,fig1);end
elseif nargout==0
    if ~isempty(imr_);imwrite(imr_,fig0);end
end
if nargout==0
    clear imr_;
end

end




