function f=weifen(t,y)

G = 6.67259 * power( 10 , -11 );
M = 1.9891 * power( 10 , 30 );
mu = G * M;
m = 2000; 

% 系数
C1 = 2.04 * 10^17;

% 设置太阳帆的面积
A = 6*10^4;

% 设置太阳帆的姿态角度
alpha = 0.402;

f = [
y(2);
- mu * y(1) / sqrt( y(1)^2 + y(3)^2 )^3 + C1 * A * ( cos( alpha ) )^2 / ( m * ( y(1)^2 + y(3)^2 ) ) * ( cos( alpha ) * y(1) / sqrt( y(1)^2 + y(3)^2 ) - sin( alpha ) * y(3) / sqrt( y(1)^2 + y(3)^2 )  );                                                                              
y(4);
- mu * y(3) / power( sqrt( power(y(1),2) + power(y(3),2) ) , 3 ) + C1 * A * ( cos( alpha ) )^2 / ( m * ( y(1)^2 + y(3)^2 ) ) * ( cos( alpha ) * y(3) / sqrt( y(1)^2 + y(3)^2 ) + sin( alpha ) * y(1) / sqrt( y(1)^2 + y(3)^2 )  ) ;
];
end

