clear,clc,clf;

  for k = 1 : 200
      %disp( ['ALPHA = ',num2str( k * 0.00785 ),' figure',num2str(k)] );
      [juge1,juge2] = orbit( k * 0.00785  );
      if (juge2 == 1)
          disp( 'Find a good point!' );
      end
  end