function Rp = rpunto(w,tetap,R)

% Uso: Rp = rpunto(w,tetap,R)
%
% costruisce matrice derivata temporale Rp
% a partire dalla velocita` angolare w (vettore unitario 3x1), 
% dalla norma (tetap) di w
% e dalla matrice di rotazione R 
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0
	Rp = antisim(w)*R*tetap;
else
	disp ('Error in input matrix')
	x='ERROR';
end

