clear,clc,clf;

Border_of_sail = 100;

% for j = 1 : 20
%   for k = 1 : 40
%       [juge1,juge2] = orbit( k * 0.00785 ,Border_of_sail^2 );
%       if (juge1==1) && (juge2 == 1)
%           disp( j );
%           disp( [num2str(k), 'Find a good point!'] );
%       end
%   end
%   Border_of_sail = Border_of_sail + 20;
% end

% orbit( 0.21195 , (100 + 16 * 20)^2 );
% 
% figure;
% orbit( 0.2198 , (100 + 16 * 20)^2 );
% 
% figure;
% orbit( 0.14915 , (100 + 17 * 20)^2 );
% 
% figure;
% orbit( 0.1099 , (100 + 18 * 20)^2 );
% 
% figure;
% orbit( 0.1256 , (100 + 18 * 20)^2 );
% 
% figure;
% orbit( 0.0628 , (100 + 19 * 20)^2 );
% 
% figure;
% orbit( 0.0942 , (100 + 19 * 20)^2 );

orbit( 0.42 , 10^5 );
figure;
orbit( -0.42 , 10^5 );


