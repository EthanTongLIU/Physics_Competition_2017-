function [Jugement1 , Jugement2]=orbit(angle_of_gesture,area_of_sail)
 
global alpha; % Coefficient of light pressure 
global Area; % Area of solar sail

alpha = angle_of_gesture;
Area = area_of_sail;

format long g;
% -----------------------------Constants-----------------------------------
RM=2.2794*10^11; % <-- The distance from Mars to the sun
RE=1.496*10^11; % <-- The distance from Mars to the sun
Rs=14.96*10^9; % <-- The radius of the sun after exaggeration
Rm = 3.397 * 10^6; % <-- The radius of Mars
TM = 687*24*3600; % <--  Period of revolution of Mars
V_Mars = 24130; % <-- The speed of Mars revolution

tend = 100000000; % <-- An enough time given 
ts = [ 0 , tend ]; % <-- Set the performance period

%---------------------------Initial Conditions-----------------------------
beta_start = pi / 2;
VX0 = 29783 * cos(beta_start);
VY0 = 29783 * sin(beta_start);
y0 = [ 1.496*power(10,11) , 0 , VX0 , VY0 ];

%------------------------Solve differential equations----------------------
[t,y] = ode45( @weifen , ts , y0 , 10 ); % equation with light pressure
[t1,y1] = ode45( @weifen1 , ts , y0 , 10 ); % equation without light pressure

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

%-----------------------------Plot the orbits------------------------------
plot( y1(:,1) , y1(:,3) , 'o' , y1(:,1) , y1(:,3) , '-' ,'color', 'm' );
hold on;
g1 = plot( y1(:,1) , y1(:,3) , '.' , 'color', 'm', 'MarkerSize',20 );
hold on;
plot( y(:,1) , y(:,3) , 'o' , y(:,1) , y(:,3) , '-' ,'color' , 'g');
g2 = plot( y(:,1) , y(:,3) , 'o' ,'color' , 'g');
hold on;

%-----------------Obtain Time to get to Mars orbit-------------------------
Temp = 1 : length( y(:,1) );
for k = 1 : length( y(:,1) )
    Temp(k) = RM;
end
% Consider the distance captured by the gravity of Mars
 for i = 1 : length( y(:,1) )
     if abs( y(i,1)^2 + y(i,3)^2 - RM^2 ) < (5*power(10,7))
         b = i;
         break 
     else
         [a , b] = min( abs( power( y(:,1)' , 2 ) + power( y(:,3)' , 2 ) - power( Temp , 2 ) ) );
     end
 end
 tarrive = t(b);
 tarrive / 86400

%-----------------Obtain Velocity get to Mars orbit------------------------
Varrive = sqrt( y(b,2)^2 + y(b,4)^2 );

%-----------------Obtain Position get to Mars orbit------------------------
Xarrive = y( b , 1 );
Yarrive = y( b , 3 );


%-------------------Jugements: if the arrived point satisfy 2 conditions,
%--------------------one is relative velocity, another is the relative 
%--------------------position between aircraft and Mars 

% 1st: Velocity jugement
if abs( V_Mars - Varrive ) <= 9000 
    Jugement1 = 1;
else
    Jugement1 = 0;
end

% 2nd: Position jugement
posi_x_mars = RM * cos( tarrive / TM * 2 * pi );
posi_y_mars = RM * sin( tarrive / TM * 2 * pi );
if sqrt( (Xarrive - posi_x_mars)^2 + (Yarrive - posi_y_mars)^2 ) <= (2*power(10,10))
    Jugement2 = 1;
else
    Jugement2 = 0;
end

%-----------------------Plot orbits of Mars--------------------------------
alpha_=0:pi/20:2*pi; 
xm = RM * cos(alpha_); 
ym = RM * sin(alpha_); 
h2 = plot(xm,ym,'-','Linewidth',3);
hold on;

%-----------------------Plot orbits of Earth-------------------------------
xe = RE * cos(alpha_); 
ye = RE * sin(alpha_); 
h3 = plot(xe,ye,'-','Linewidth',3);
hold on;

%---------------------------------Plot sun---------------------------------
xs = Rs * cos(alpha_); 
ys = Rs * sin(alpha_); 
plot(xs,ys,'r-');
fill(xs,ys,'r');    
hold on;

%-------------------Plot mars when aircraft get to Mars--------------------
xmend = posi_x_mars + Rs/2 * cos(alpha_);
ymend = posi_y_mars + Rs/2 * sin(alpha_);
plot( xmend , ymend ,'b-' );
h4 = fill( xmend , ymend ,'b-' );
hold on;

%-----------------Plot position of aircraft get to Mars--------------------
xaend = Xarrive + Rs/3 * cos(alpha_);
yaend = Yarrive + Rs/3 * sin(alpha_);
plot( xaend , yaend ,'b-' );
h5 = fill( xaend , yaend ,'y-' );

legend([g1 , g2 , h2 , h3, h4 ,h5],'Orbit of aircraft without light pressure','Orbit of aircraft with light pressure','Orbit of Mars','Orbit of Earth','Position of Mars when aircraft get to Mars','Position of aircraft when get to Mars','Location','NorthOutside');

axis equal

end



















