tt='test260510_Mobius';
% test260510_Mobius
% Changed from test260328_Mobius

pathf='E:\Matlab\Figures\';

definter('latex');

deg=pi/180;
phi=(0:720).';
psi=exp(phi*deg*1i/2);
r0=3;
rs=r0+real(psi);
zs=imag(psi);
xyz=[rs.*cos(phi*deg) rs.*sin(phi*deg) zs];

ca;
figure;
plot3(xyz(:,1),xyz(:,2),xyz(:,3),'k.-');

%%
% 定义参数
u = linspace(0, 2*pi, 100); % 周期参数
v = linspace(-1, 1, 50); % 带宽参数
[U, V] = meshgrid(u, v);

% 莫比乌斯带的参数方程
X = (3 + V .* cos(U / 2)) .* cos(U);
Y = (3 + V .* cos(U / 2)) .* sin(U);
Z = V .* sin(U / 2);

mhsz=0.5;
lw=1.5;
fsz=20;

% 绘制莫比乌斯带
figure;hold on;
h = surf(X, Y, Z, 'EdgeColor', 'none'); % 绘制莫比乌斯带
colormap([1 1 0]*0.9); % 设置颜色为黄色
h.FaceAlpha = 0.5; % 设置半透明度

% 设置图形属性
axis equal; % 坐标轴比例一致
xl=xlabel('$x$');
yl=ylabel('$y$');
zl=zlabel('$z$');
% title('莫比乌斯带');
view(3); % 设置3D视角

% 在中心轴线上绘制箭头
arrowSpacing = 5; % 每隔5度画一个箭头
theta = deg2rad(0:arrowSpacing:360); % 将角度转换为弧度制

for i = 1:length(theta)
    angle = theta(i);
    
    % 箭头的起点：中心轴线上的点
    X0 = 3*cos(angle); % 中心点的 X 坐标
    Y0 = 3*sin(angle); % 中心点的 Y 坐标
    Z0 = 0;          % 中心点的 Z 坐标（轴线在 Z=0）

    % 箭头的终点：莫比乌斯带边缘
    % 对应 v = ±1 的边缘
    edgeV = 1; % 莫比乌斯带边缘的宽度
    X1 = (3 + edgeV * cos(angle / 2)) * cos(angle); % 边缘的 X 坐标
    Y1 = (3 + edgeV * cos(angle / 2)) * sin(angle); % 边缘的 Y 坐标
    Z1 = edgeV * sin(angle / 2);                   % 边缘的 Z 坐标

    % 箭头方向向量
    U_arrow = X1 - X0; % X 方向向量
    V_arrow = Y1 - Y0; % Y 方向向量
    W_arrow = Z1 - Z0; % Z 方向向量

    % 绘制箭头
    quiver3(X0, Y0, Z0, U_arrow, V_arrow, W_arrow, 0, ...
        'MaxHeadSize', mhsz, 'Color', 'k', 'LineWidth', lw);
end
arrow3([0 3 0;0 3 1],'MaxHeadSize', 3*mhsz, 'Color', 'b', 'LineWidth', 3*lw);
arrow3([0 3 0;0 4 0],'MaxHeadSize', 3*mhsz, 'Color', 'r', 'LineWidth', 3*lw);
arrow3([0 3 0;0 3+sqrt(2)/2 sqrt(2)/2],'MaxHeadSize', 3*mhsz, 'Color', 'k', 'LineWidth', 3*lw);
view(80,20);
plotc([0 3;0 0;3 0],'k--','linewidth',lw);
angtemp=(0:90)*deg;
plot(cos(angtemp),sin(angtemp),'k-','linewidth',lw);
len=0.3;
plotc([1 1;1 1-len]/sqrt(2),'k-','linewidth',lw);
plotc([1 1;1+len 1]/sqrt(2),'k-','linewidth',lw);
set(gca,'fontsize',fsz);
lent=0.5; % temporary length
text(0,4+lent,0,'Re','fontsize',fsz,'color','r','HorizontalAlignment','center');
text(0,3,1+lent,'Im','fontsize',fsz,'color','b','HorizontalAlignment','center');
text(0,3+(1+lent)/sqrt(2),(1+lent)/sqrt(2),'$e^{i\varphi/2}$','fontsize',fsz,'color','k','HorizontalAlignment','center');
text(1,1,0,'$\varphi$','fontsize',fsz,'color','k','HorizontalAlignment','center');

grid on;
axis([-inf inf -inf inf]);
set(xl,'position',get(xl,'position')+[-2 0.5 0]);
set(yl,'position',get(yl,'position')+[0 2 0.2]);
set(zl,'position',get(zl,'position')+[0 0.3 0]);

fign=[pathf tt '=L100.png'];
print(gcf,'-r300','-dpng',fign);
cropic([255 nan],fign);

