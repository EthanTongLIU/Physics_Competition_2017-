clear , clc , clf;

format long g;
RM=2.2794*10^11;  
RE=1.496*10^11;
Rs=14.96*10^9;          
Rm = 3.397 * 10^6;

tend = 60000000;

ts = [ 0 , tend ];
y0 = [ 1.496 * power(10,11) , 0 , 0 , 11200+30000 ];

[t,y] = ode45( @weifen , ts , y0 , 10 );
subplot( 2 , 2 , 1 );
plot( t , y(:,1) , 'o' );
title( 'x' );
subplot( 2 , 2 , 2 );
plot( t , y(:,2) , 'o' );
title( 'Vitesse on x label' );
subplot( 2 , 2 , 3 );
plot( t , y(:,3) , 'o' );
title( 'y' );
subplot( 2 , 2 , 4 );
plot( t , y(:,4) , 'o' );
title( 'Vitesse on y label' );

figure;
plot( y(:,1) , y(:,3) , 'o' );
hold on;

Temp = 1 : length( y(:,1) );

for k = 1 : length( y(:,1) )
    Temp(k) = RM;
end

abs( power( y(:,1)' , 2 ) + power( y(:,3)' , 2 ) - power( Temp , 2 ) )
[a , b] = min( abs( power( y(:,1)' , 2 ) + power( y(:,3)' , 2 ) - power( Temp , 2 ) ) )

sqrt( y(b,2)^2 + y(b,4)^2 )

alpha=0:pi/20:2*pi;    %½Ç¶È[0,2*pi] 
% »­»ðÐÇ¹ìµÀ        
xm = RM * cos(alpha); 
ym = RM * sin(alpha); 
plot(xm,ym,'-') 
hold on;

% »­µØÇò¹ìµÀ          
xe = RE * cos(alpha); 
ye = RE * sin(alpha); 
plot(xe,ye,'-') 
hold on;

% »­Ì«Ñô
xs = Rs * cos(alpha); 
ys = Rs * sin(alpha); 
plot(xs,ys,'r-') 
fill(xs,ys,'r');     

axis equal




















