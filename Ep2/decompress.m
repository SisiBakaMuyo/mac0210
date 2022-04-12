function r = decompress(compressedImg, method, k, h)
  I = imread(compressedImg);
  n = size(I,1);
  p = n - (n-1) * k;
  x = y = 0;
  a00 = a01 = a02 = a03 = a10 = a11 = a12 = a13 = a20 = a21 = a22 = a23 = a30 = a31 = a32 = a33 = 1;
  a0 = a1 = a2 = a3 = 1; 
  Ic = zeros(p);
  
  for (i=1:n-1)
    for(j=1:n)
      
      xi = x + i * h;
      yj = y + j * h;
      
      Ic(i,j,1) = I(i,j,1);
      Ic(i,j,2) = I(i,j,2);
      Ic(i,j,3) = I(i,j,3);
      
      dxf = @(xi,yj) (I(xi+1,yj,c) - I(xi-1,yj,c)) / 2 * h;
      dyf = @(xi,yj) (I(xi,yj+1,c) - I(xi,yj-1,c)) / 2 * h;
      dxyf = @(xi,yj) (dyf(xi+1,yj) - dyf(xi-1,yj)) / 2 * h;
      
      C2 = [a00,a01,a02,a03;a10,a11,a12,a13;a20,a21,a22,a23;a30,a31,a32,a33];
      
      pij = @(x,y) [1,(x-xi),(x-xi)^2,(x-xi)^3] * C * [1;(y-yj);(y-yj)^2;(y-yj)^3];
      f = @(x,y) a0 + a1 * (x - xi) + a2 * (y - yj) + a3 * (x - xi) * (y - yj);
      
      
      if (method == 1) % bilinear
        A1 = [f(xi,yj);f(xi,yj+1);f(xi+1,yj);f(xi+1,yj+1)];
        B1 = [1,0,0,0;1,0,h,0;1,h,0,0;1,h,h,h^2];
        C1 = [a0;a1;a2;a3];
        
        c = 1;
        for (z = 1:3)
          C1 = A1\B1;
          Ic(xi+1,yj,c) = f(xi,yj);  
          c++;
        endfor
      endif
      if (method == 2) % bicubico
        A2 = [f(xi,yj),f(xi,yj+1),dyf(xi,yi),dyf(xi,yj+1);
             f(xi+1,yj),f(xi+1,yj+1),dyf(xi+1,yj),dyf(xi+1,yj+1);
             dxf(xi,yj),dxf(xi,yj+1),dxyf(xi,yj),dxyf(xi,yj+1);
             dxf(xi+1,yj),dxf(xi+1,yj+1),dxyf(xi+1,yj),dxyf(xi+1,yj+1)];
        B2 = [1,0,0,0;1,h,h^2,h^3;0,1,0,0;0,1,2*h,3*h^2];
        
        c = 1;
        for (z = 1:3)
          C2 = A2 * inv(B2) * inv(B2');
          Ic(xi+1,yj,c) = pij(xi,yj);
        endfor  
      endif
    endfor
  endfor
  
  imwrite(Ic, "decompressed.png");
endfunction
