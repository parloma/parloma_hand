function [w,tetap1] = u2omega(u,up,teta,tetap)

% Uso: [w,tetap1] = u2omega(u,up,teta,tetap)
%
% costruisce velocita` angolare w normalizzata e la sua norma tetap
% a partire da:
% asse u vettore (3x1) anche non normalizzato, derivata asse up vettore (3x1), 
% angolo teta (in gradi), derivata tetap (in rad/s)
% NOTA BENE: tetap1 in uscita puo` essere diversa da tetap in ingresso
%            se norm(up) ~= 0
%
% B Bona, DAUIN, POLITO

nu=norm(u);
if nu ~= 0 
	u = u/nu;
	nup=norm(up);
	if nup ~= 0
		up = up/nup;
	end
	w = tetap*u + sind(teta)*up + (1-cosd(teta))*(cross(u,up));
	tetap1 = norm(w);
	if abs(tetap1) > eps
		w = w/tetap1;
	end 
	w=w';
else
	disp('u norm = 0')
end	
