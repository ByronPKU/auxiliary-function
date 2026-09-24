function ax2= axes2(varargin)

% Defined by Biaoyan Hu on 191129
% 
% Example: 
% figure;
% plot(rand(10,1),'ko');
% xlabel('\itx');
% ylabel('\ity\rm_1');
% set(gca,'box','off');
% ax2=axes2;
% plot(2*rand(10,1),'r^');
% ylabel('\ity\rm_2');
% set(ax2,'color','none','yaxislocation','right','box','off','ycolor','r');
% 

% pos=get(gca,'Position');
% ax2=axes('Position',pos);
ax2=axes;
% set(ax2,'color','none','yaxislocation','right','color','none','box','off');
if nargin>=1
    set(ax2,varargin{:});
end

end