function r = trabalho()
  f = [0, 9, 13, 14, 10.5, 12, 5];
  c = [cos(0.5), cos(1.4), cos(0.75), cos(0.9), cos(1.3), cos(1.48), cos(1.5)];
  x = [0,5,10,15,20,25,30];
  fcos = f .* c;

  %interpolacao de newton para os 7 pontos da tabela 
  A = [1,1,1,1,1,1,1];
  N = [1,0,0,0,0,0,0;1,x(2)-x(1),0,0,0,0,0;1,x(3)-x(1),x(3)-x(2),0,0,0,0;1,x(4)-x(1),x(4)-x(2),x(4)-x(3),0,0,0;1,x(5)-x(1),x(5)-x(2),x(5)-x(3),x(5)-x(4),0,0;1,x(6)-x(1),x(6)-x(2),x(6)-x(3),x(6)-x(4),x(6)-x(5),0;1,x(7)-x(1),x(7)-x(2),x(7)-x(3),x(7)-x(4),x(7)-x(5),x(7)-x(6)]; 
  A = fcos * inv(N);
  
  %polinomio interpolador
   P6 = @(x) A(1) + A(2)*(x-0) + A(3)*(x-0)*(x-5) + A(4)*(x-0)*(x-5)*(x-10) + A(5)*(x-0)*(x-5)*(x-10)*(x-15) + A(6)*(x-0)*(x-5)*(x-10)*(x-15)*(x-20) + A(7)*(x-0)*(x-5)*(x-10)*(x-15)*(x-20)*(x-25);
   p = [P6(0),P6(5), P6(10), P6(15), P6(20), P6(25), P6(30)];

  %aproximacao pela regra do trapezio composto
  T = (30 - 0)/2 * (1/2 * P6(0) + P6(5) + P6(10) + P6(15) + P6(20) + P6(25) + 1/2 * P6(30));
  
  %aproximacao pela regra de simpson composto
  S = (30 - 0)/3 * (P6(0) + 4*P6(5) + 2*P6(10) + 4*P6(15) + 2*P6(20) + 4*P6(25) + P6(30));
  
  disp("As interpolacoes dos pontos para f(x)cos(teta(x)) são:");
  disp(p);
  disp("A aproximacao da interpolacao pela regra do trapezio composto é:");
  disp(T);
  disp("A aproximacao da interpolacao pela regra de simpson composto é:");
  disp(S);
endfunction
