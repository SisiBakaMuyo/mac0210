function r = bisseccao (f, xini, xfim)
  i = 1;
  do
    xm = (xini + xfim)/2;
    
    if (f(xini) * f(xm) < 0)
      xfim = xm;
    else
      xini = xm;
    endif
    i++;
 until (i == 3)
  r = xm;
endfunction
