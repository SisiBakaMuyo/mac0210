function r = erro(x0,h,k)
  f = @(x) sin(x);
  f3 = @(x) -cos(x);
  dh = (f(x0+h) - f(x0-h))/2*h;
  fl = ((f(x0+h) - 2* f(x0) + f(x0-h))/(h^2))/2*h;
  e = @(h) (h^2/6 * f3(x0)) + abs(fl - dh);
  r = e(h);
endfunction
