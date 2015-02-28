function gms = grad2gms (g)
%
% converte i gradi decimali in gradi, minuti, secondi
%
% B Bona, DAUIN, POLITO

gradi_dec=g;
gms(1)=fix(gradi_dec);
min_dec=(gradi_dec-gms(1))*60;
gms(2)=fix(min_dec);
gms(3)=(min_dec-gms(2))*60;
