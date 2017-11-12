function [Jugement1 , Jugement2]=orbit(angle_of_gesture)

global alpha; 

alpha = angle_of_gesture;

format long g;
% 常量
% 火星到太阳的距离
RM=2.2794*10^11; 
% 地球到太阳的距离
RE=1.496*10^11;
% 夸张后的太阳半径
Rs=14.96*10^9;   
% 火星半径
Rm = 3.397 * 10^6;

% 设置一共运行多长时间
tend = 120000000;

% 设置运行时间
ts = [ 0 , tend ];
% 设置初始条件， 其中初始速度作为决策变量
% 设置初始发射角度，是一个决策变量
beta_start = pi / 2;
% 初始x方向速度
VX0 = 29783 * cos(beta_start);
% 初始y方向速度
VY0 = 29783 * sin(beta_start);
% 初始条件
y0 = [ 1.496 * power(10,11) , 0 , VX0 , VY0 ];


% 有光压动力情况下的方程
[t,y] = ode45( @weifen , ts , y0 , 10 );
% 无动力情况下的方程
[t1,y1] = ode45( @weifen1 , ts , y0 , 10 );

% subplot( 2 , 2 , 1 );
% plot( t , y(:,1) , 'o' );
% title( 'x' );
% subplot( 2 , 2 , 2 );
% plot( t , y(:,2) , 'o' );
% title( 'Vitesse on x label' );
% subplot( 2 , 2 , 3 );
% plot( t , y(:,3) , 'o' );
% title( 'y' );
% subplot( 2 , 2 , 4 );
% plot( t , y(:,4) , 'o' );
% title( 'Vitesse on y label' );

% figure
plot( y1(:,1) , y1(:,3) , 'o' , y1(:,1) , y1(:,3) , '-' ,'color', 'm' );
hold on;
plot( y1(:,1) , y1(:,3) , '.' , 'color', 'm', 'MarkerSize',20 );
hold on;
plot( y(:,1) , y(:,3) , 'o' , y(:,1) , y(:,3) , '-' ,'color' , 'g');
hold on;

% 提取到达火星轨道时间
Temp = 1 : length( y(:,1) );
for k = 1 : length( y(:,1) )
    Temp(k) = RM;
end
[a , b] = min( abs( power( y(:,1)' , 2 ) + power( y(:,3)' , 2 ) - power( Temp , 2 ) ) );
tarrive = t(b);
% 以下是到达火星轨道的速度
Varrive = sqrt( y(b,2)^2 + y(b,4)^2 );
% 以下是到达火星的位置
Xarrive = y( b , 1 );
Yarrive = y( b , 3 );

% 判断到达火星轨道是否满足条件，需要满足两个条件，1，必须满足相对速度小于 9000
% 2，必须满足火星和该到达点之间的距离小于一个误差限度

% 条件1 相对速度
V_Mars = 24130; % 火星公转速度
if abs( V_Mars - Varrive ) <= 9000 
    %disp( ['Varrive=', num2str(Varrive) , 'is good'] );
    Jugement1 = 1;
else
    %disp( ['Varrive=', num2str(Varrive) , 'is not good'] );
    Jugement1 = 0;
end

% 条件2 位置约束
% 计算当航天器到达火星轨道时火星的位置
TM = 687*24*3600; % 火星公转周期
posi_x_mars = RM * cos( tarrive / TM * 2 * pi );
posi_y_mars = RM * sin( tarrive / TM * 2 * pi );
if sqrt( (Xarrive - posi_x_mars)^2 + (Yarrive - posi_y_mars)^2 ) <= 8 * 10^10
    %disp( 'Position arrive is good' );
    Jugement2 = 1;
else
    %disp( 'Position arrive is not good' );
    Jugement2 = 0;
end

alpha_=0:pi/20:2*pi;    %角度[0,2*pi] 
% 画火星轨道        
xm = RM * cos(alpha_); 
ym = RM * sin(alpha_); 
plot(xm,ym,'-','Linewidth',3);
hold on;

% 画地球轨道          
xe = RE * cos(alpha_); 
ye = RE * sin(alpha_); 
plot(xe,ye,'-','Linewidth',3);
hold on;

% 画太阳
xs = Rs * cos(alpha_); 
ys = Rs * sin(alpha_); 
plot(xs,ys,'r-');
fill(xs,ys,'r');    
hold on;

% 画到达时火星的位置
xmend = posi_x_mars + Rs/2 * cos(alpha_);
ymend = posi_y_mars + Rs/2 * sin(alpha_);
plot( xmend , ymend ,'b-' );
fill( xmend , ymend ,'b-' );
hold on;

% 画到达时航天器的位置
xaend = Xarrive + Rs/3 * cos(alpha_);
yaend = Yarrive + Rs/3 * sin(alpha_);
plot( xaend , yaend ,'b-' );
fill( xaend , yaend ,'m-' );
axis equal

end



















