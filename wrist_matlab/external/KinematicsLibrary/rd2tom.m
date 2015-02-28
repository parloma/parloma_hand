function T = rd2tom(R,d)

% Uso:  
% T = rd2tom(R,d)
% calcola la matrice di trasformazione omogenea T=T_d*T_R
% a partire dalla matrice di rotazione R (3x3) e dal vettore di traslazione d (3x1)
%
% T = rd2tom(R)
% calcola la matrice di trasformazione omogenea T=T_R
% a partire dalla matrice di rotazione R (3x3), assumendo il vettore di traslazione d=0
%
% T = rd2tom(d)
% calcola la matrice di trasformazione omogenea T=T_d
% a partire dal vettore di traslazione d, assumendo la matrice di rotazione R=I
%
% B Bona, DAUIN, POLITO

if nargin == 1
   if size(R,1)==size(R,2)
      R=R;
      d=zeros(3,1);
   elseif size(R,2)==1
      d=R;
      R=eye(3);
   else
      disp ('Error in input arguments')
      x='ERROR';
   end
end

if isrot(R) == 0

	T(1,1) = R(1,1);
	T(1,2) = R(1,2);
	T(1,3) = R(1,3);
	T(1,4) = d(1);
	
	T(2,1) = R(2,1);
	T(2,2) = R(2,2);
	T(2,3) = R(2,3);
	T(2,4) = d(2);
	
	T(3,1) = R(3,1);
	T(3,2) = R(3,2);
	T(3,3) = R(3,3);
	T(3,4) = d(3);

	T(4,1) = 0;
	T(4,2) = 0;
	T(4,3) = 0;
	T(4,4) = 1;

else

   disp ('Error in input matrix')
   T='ERROR';

end
