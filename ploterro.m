function r = ploterro(x0)
  k = 0:0.5:8;
  i = 1;
  while (i < 18)
    h(i) = 10^(-k(i));
    i++;
  endwhile
  i = 1; 
  while (i < 18)
    e(i) = erro(x0,h(i),k(i));
    i++;
  endwhile
  loglog(e,h)
  r = e
endfunction
