function r = achar_raizes(f, a, b, nprobe, tol)
  #teste da funcao no intervalo para descobrir onde muda o sinal
  j = 0;
  for (i = 0:(b-1))
    sinal = f(a + i) * f(a + i + 1);
    if (sinal < 0) 
      xini = f(a + i);
      xfim = f(a + i + 1);
      
      #chamada do metodo de newton para achar a raiz no subintervalo [xini,xfim]
      n = newton(f, (xini + nprobe), tol);
      
      # 3 etapas de bisseccao se newton nao tem reducao suficiente
      if (n == 0)
        b = bisseccao(f,xini,xfim);
        #nova chamada de newton
        n = newton(f, (b + nprobe), tol);
      endif
      j++;
      vraiz(j) = n;
     endif
  endfor
  
  r = vraiz;
endfunction
