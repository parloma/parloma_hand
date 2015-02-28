function [w,tetap] = rot2omeg(R,Rp)

% Uso: [w,tetap] = rot2omeg(R,Rp)
%
% costruisce la velocita` angolare w (vettore colonna unitario 3x1) 
% e il modulo di w (tetap)
% a partire dalla matrice di rotazione R e dalla matrice derivata temporale Rp
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0
	w = 0.5.*(cross(R(:,1),Rp(:,1)) + cross(R(:,2),Rp(:,2)) + cross(R(:,3),Rp(:,3)));
	tetap=norm(w);
	if abs(tetap) > eps
		w = w/tetap;
	end 
else
	disp ('Error in input matrix')
	x='ERROR';
end
