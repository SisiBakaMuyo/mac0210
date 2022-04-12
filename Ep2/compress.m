function r = compress(originalImg, k)
  I = imread(originalImg);
  p = size(I,1);
  
  for (i = 1: p/2)   
      if (rem((k + 1), i) != 0)
        I(i,:) = [];
        I(:,i) = [];
      endif
  endfor
  
  imwrite(I, "compressed.png");
endfunction
