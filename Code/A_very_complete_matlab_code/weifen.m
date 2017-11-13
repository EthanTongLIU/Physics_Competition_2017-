function f=weifen(t,y)

G = 6.67259 * power( 10 , -11 );
M = 1.9891 * power( 10 , 30 );
mu = G * M;
m = 2000; 

% Coefficient of light pressure 
C1 = 2.04 * 10^17;

% Area of solar sail
global Area;

% Attitude angle of solar sail 
global alpha ;

f = [
y(2);
- mu * y(1) / sqrt( y(1)^2 + y(3)^2 )^3 + C1 * Area * ( cos( alpha ) )^2 / ( m * ( y(1)^2 + y(3)^2 ) ) * ( cos( alpha ) * y(1) / sqrt( y(1)^2 + y(3)^2 ) - sin( alpha ) * y(3) / sqrt( y(1)^2 + y(3)^2 )  );                                                                              
y(4);
- mu * y(3) / power( sqrt( power(y(1),2) + power(y(3),2) ) , 3 ) + C1 * Area * ( cos( alpha ) )^2 / ( m * ( y(1)^2 + y(3)^2 ) ) * ( cos( alpha ) * y(3) / sqrt( y(1)^2 + y(3)^2 ) + sin( alpha ) * y(1) / sqrt( y(1)^2 + y(3)^2 )  ) ;
];
end