function r = newton(f, x0, tol)
  x1 = x0;
  x2 = x1;
  Fx = f(x1);
  dx = 1e-6;
  dfx = @(x) (f(x1 + dx) - f(x1))/dx;
  DFx = dfx(x1);
  
  while (1)
    DeltaX = -Fx / DFx;
    x2 = x1 + DeltaX;
    Fx0 = Fx;
    x1 = x2;
    Fx = f(x1);
    DFx = dfx(x1);

    if (abs(Fx) >= 0.5 * abs(Fx0))
      r = 0;
      break;
    endif
  end
  
  if (abs(x2 - x1) < tol * abs(1 + abs(x2)) && abs(Fx0) < tol)
    r = x1;  
  endif
  
endfunction
