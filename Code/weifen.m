function f=weifen(t,y)

G = 6.67259 * power( 10 , -11 );
M = 1.9891 * power( 10 , 30 );
mu = G * M;
f = [
y(2);
- mu * y(1) / sqrt( y(1)^2 + y(3)^2 )^3 ;
y(4);
- mu * y(3) / power( sqrt( power(y(1),2) + power(y(3),2) ) , 3 )
];

