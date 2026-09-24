tt='test250829_Plm_1';
% test250829_Plm_1
% Changed from test250814_Plm_1

% 250311
% 经过画图发现Plamu(1/2,1/2,cosA)=sqrt(2/pi)cosA/sqrt(sinA)

pathf='E:\Matlab\Figures\';
definter('latex');

x=-1:0.001:1;
% nx=numel(x);
% lm=[1.5 1.5];
lm=[2.5 1.5];
l=lm(1);m=lm(2);
y1=Plamu(l,m,x);
y2=Plm(l,m,x);
y3=-imag(ePlm(l,m,x))/(8*sqrt(2/pi));
% y2=(1-x.^2).^(-m/2).*x.^(l+m);
% k=y1(200)/y2(200);
% ymax=max(5,abs(y(round(numel(x)/2+0.5))));
% if any(abs(y)>ymax)
%     y(1:find(abs(y)<=ymax,1)-1)=nan;
%     y(find(abs(y)<=ymax,1,'last')+1:end)=nan;
% end
% y(abs(y)>15)=nan;

fsz=14;
lw=2;
msz=20;

ca;
figure;hold on;
p1=plot(x,y1,'r-','linewidth',lw);
p2=plot(x,y2,'b-','linewidth',lw,'markersize',msz);
p3=plot(x,y3,'g-','linewidth',lw);
% plot(x,imag(y),'r-','linewidth',lw);
% plot(-x,y,'r.-');
% title(['$P_{' num2str(l) '}^{' num2str(m) '}(x)$']);
s2l=num2str(2*l);s2m=num2str(2*m);
lg=legend([p1 p3 p2],{['$P_{' s2l '/2}^{' s2m '/2}(x)$ (Hobson)'],['$P_{' s2l '/2}^{' s2m '/2}(x)$ (Hunter)'],['$P_{' s2l '/2}^{' s2m '/2}(x)$ (this work)']});
% lg=legend([p1 p3 p2],{['Hobson''s $P_{' s2l '/2}^{' s2m '/2}(x)$'],['Hunter''s $P_{' s2l '/2}^{' s2m '/2}(x)$'],['$P_{' s2l '/2}^{' s2m '/2}(x)$ in this work']});
% set(lg,'position',[0.4 0.817 0 0]);
% set(lg,'position',[0.422 0.26 0 0]); % lm=[2.5 1.5];
set(lg,'position',[0.515 0.3 0 0],'box','off'); % lm=[2.5 1.5];
% set(lg,'position',[0.739 0.817 0 0]);
% set(lg,'position',[0.72 0.72 0 0]); % lm=[1.5 1.5];
xlabel('$x$');
ylabel('$y$');
set(gca,'fontsize',fsz,'linewidth',lw);
axis([-inf inf [-1 1]*2.7522]); % lm=[2.5 1.5];
axis([-inf inf [-1 1]*3]); % lm=[2.5 1.5];
% axis([-inf inf [-1 1]*2]); % lm=[1.5 1.5];
box on;

fign=[pathf tt '=L010.png'];
exportgraphics(gcf,fign,'Resolution',300);
cropic([255 nan],fign);

