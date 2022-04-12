function r = montecarlo()
  f1 = @(x) sin(x);
  f2 = @(x) x^3;
  f3 = @(x) e^(-x);
  f4 = @(x,y) x^2 + y^2;
  
  %monte carlo unidimensional
  i = 1;
  I1 = I2 = I3 = 0;
  U1 = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]; % 0 a 1
  U2 = [3, 3.25, 3.5, 4, 4.25, 4.5, 5, 5.25, 6, 6.5, 7]; % 3 a 7
  U3 = [0,10,100,1000,10000,100000,100000,1000000,10000000,100000000,1000000000]; % 0 a infinito
  U4 = [-1, -0.8, -0.6, -0.4, -0.2, 0, 0.3, 0.5, 0.7, 0.9, 1]; % -1 a 1
  while (i <= 11)
    I1 = I1 + f1(U1(i))/11;
    I2 = I2 + f2(U2(i))/11;
    I3 = I3 + f3(U3(i))/11;
    i++;
  endwhile
  I1 = (1-0) * I1;
  I2 = (7-3) * I2;
  I3 = (1000000000 - 0) * I3;
  
  
  disp("Aproximação de monte carlo unidimensional para caso 1:");
  disp(I1);
  disp("Aproximação de monte carlo unidimensional para caso 2:");
  disp(I2);
  disp("Aproximação de monte carlo unidimensional para caso 3:");
  disp(I3);
  
  %monte carlo multidimensional
  i = 1;
  I4 = 0;
  while (i <= 11)
    I4 = I4 + 2* f4(U4(i),(U4(i))^2)/11;
    i++;
  endwhile
  I4 = (1 + 1) * I4;
  
  disp("Aproximação de monte carlo multidimensional para pi:");
  disp(I4);
endfunction
