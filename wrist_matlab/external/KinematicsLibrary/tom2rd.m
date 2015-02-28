function [R,d] = tom2rd(T)

% Uso:  
% [R,d] = tom2rd(T)
% Calcola la matrice di rotazione R (3x3) e il vettore di traslazione d (3x1)
% a partire dalla matrice di trasformazione omogenea (4x4) T
%
% B Bona, DAUIN, POLITO

	R(1,1) = T(1,1);
	R(1,2) = T(1,2);
	R(1,3) = T(1,3);
	  d(1) = T(1,4);
	  
	R(2,1) = T(2,1);
	R(2,2) = T(2,2);
	R(2,3) = T(2,3);
	  d(2) = T(2,4);
	  
	R(3,1) = T(3,1);
	R(3,2) = T(3,2);
	R(3,3) = T(3,3);
	  d(3) = T(3,4);
	
	d=d(:);
	
if isrot(R) ~= 0

   disp ('Error in input matrix, R has been set to eye(3), d to zero')
   R=eye(3);
   d=[0 0 0]'
  
end

