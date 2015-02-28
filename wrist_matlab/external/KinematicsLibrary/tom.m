function y = tom(T,x)

% Uso:  
% y = tom(T,x)
% Calcola la trasformazione del vettore x (3x1) secondo la matrice omogenea (4x4) T
% e restituisce il vettore trasformato y (3x1)
%
% B Bona, DAUIN, POLITO

if size(T,1)~=4 | size(T,2)~=4
   disp ('Error in input homogeneous matrix ')
   y='error';
elseif isrot(T(1:3,1:3))==1
   disp ('Error in input rotation matrix ')
   y='error';
end
xh=[x(:); 1];
yh=T*xh;
y=yh(1:3);