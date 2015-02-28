function gradi = gms2grad(gms)
%
% converte i gradi, minuti, secondi in gradi decimali
% gms(1) = gradi
% gms(2) = minuti
% gms(3) = secondi
%
% B Bona, DAUIN, POLITO

gradi=gms(1)+gms(2)/60+gms(3)/3600;