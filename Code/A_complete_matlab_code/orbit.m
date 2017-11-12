clear , clc , clf;

format long g;
% ����
% ���ǵ�̫���ľ���
RM=2.2794*10^11; 
% ����̫���ľ���
RE=1.496*10^11;
% ���ź��̫���뾶
Rs=14.96*10^9;   
% ���ǰ뾶
Rm = 3.397 * 10^6;

% ����һ�����ж೤ʱ��
tend = 120000000;

% ��������ʱ��
ts = [ 0 , tend ];
% ���ó�ʼ������ ���г�ʼ�ٶ���Ϊ���߱���
% ���ó�ʼ����Ƕȣ���һ�����߱���
beta_start = pi / 2;
% ��ʼx�����ٶ�
VX0 = 30000 * cos(beta_start);
% ��ʼy�����ٶ�
VY0 = 30000 * sin(beta_start);
% ��ʼ����
y0 = [ 1.496 * power(10,11) , 0 , VX0 , VY0 ];


% ���濪ʼ����ѭ������ alpha ѭ����ֵ��alpha �ı���ȡ����ѭ���е� k

% �й�ѹ��������µķ���
[t,y] = ode45( @weifen , ts , y0 , 10 );
% �޶�������µķ���
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

% figure;
plot( y1(:,1) , y1(:,3) , 'o' , y1(:,1) , y1(:,3) , '-' ,'color', 'm' );
hold on;
plot( y1(:,1) , y1(:,3) , '.' , 'color', 'm', 'MarkerSize',20 );
hold on;
plot( y(:,1) , y(:,3) , 'o' , y(:,1) , y(:,3) , '-' ,'color' , 'g');
hold on;

% ��ȡ������ǹ��ʱ��
Temp = 1 : length( y(:,1) );
for k = 1 : length( y(:,1) )
    Temp(k) = RM;
end
[a , b] = min( abs( power( y(:,1)' , 2 ) + power( y(:,3)' , 2 ) - power( Temp , 2 ) ) );
tarrive = t(b)
% �����ǵ�����ǹ�����ٶ�
Varrive = sqrt( y(b,2)^2 + y(b,4)^2 )
% �����ǵ�����ǵ�λ��
Xarrive = y( b , 1 )
Yarrive = y( b , 3 )

% �жϵ�����ǹ���Ƿ�������������Ҫ��������������1��������������ٶ�С�� 9000
% 2������������Ǻ͸õ����֮��ľ���С��һ������޶�

% ����1 ����ٶ�
V_Mars = 24130; % ���ǹ�ת�ٶ�
if abs( V_Mars - Varrive ) <= 9000 
    disp( ['Varrive=', num2str(Varrive) , 'is good'] );
else
    disp( ['Varrive=', num2str(Varrive) , 'is not good'] );
end

% ����2 λ��Լ��
% ���㵱������������ǹ��ʱ���ǵ�λ��
TM = 687*24*3600; % ���ǹ�ת����
posi_x_mars = RM * cos( tarrive / TM * 2 * pi )
posi_y_mars = RM * sin( tarrive / TM * 2 * pi )
if abs( (Xarrive^2 + Yarrive^2) - (posi_x_mars^2 + posi_y_mars^2) ) <= 10^9
    disp( 'Position arrive is good' );
else
    disp( 'Position arrive is not good' );
end

alpha=0:pi/20:2*pi;    %�Ƕ�[0,2*pi] 
% �����ǹ��        
xm = RM * cos(alpha); 
ym = RM * sin(alpha); 
plot(xm,ym,'-','Linewidth',3);
hold on;

% ��������          
xe = RE * cos(alpha); 
ye = RE * sin(alpha); 
plot(xe,ye,'-','Linewidth',3);
hold on;

% ��̫��
xs = Rs * cos(alpha); 
ys = Rs * sin(alpha); 
plot(xs,ys,'r-');
fill(xs,ys,'r');    
hold on;

% ������ʱ���ǵ�λ��
xmend = posi_x_mars + Rs/2 * cos(alpha);
ymend = posi_y_mars + Rs/2 * sin(alpha);
plot( xmend , ymend ,'b-' );
fill( xmend , ymend ,'b-' );
hold on;

% ������ʱ��������λ��
xaend = Xarrive + Rs/3 * cos(alpha);
yaend = Yarrive + Rs/3 * sin(alpha);
plot( xaend , yaend ,'b-' );
fill( xaend , yaend ,'m-' );
axis equal




















