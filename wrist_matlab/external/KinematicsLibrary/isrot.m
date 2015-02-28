function x = isrot (R)

% Uso: isrot(R)
% verifica che la matrice R sia una matrice di rotazione
% fissa lo zero numerico pari alla variabile zeroeps
%      isrot(R)==0 matrice di rotazione
%      isrot(R)~=0 errore
%
% B Bona, DAUIN, POLITO

zeroeps=5E-6;
stringp=num2str(zeroeps);
warning=strcat('Matrix is not orthonormal, i.e. norm(R''R-I) > ',stringp);

[r c] = size(R);
x = 1;
if r ~= 3
   disp ('Matrix has not 3 rows')
elseif c ~= 3
    disp ('Matrix has not 3 columns')
elseif norm ( R * R' - eye(3) ) > zeroeps
    warning 
elseif det (R) < 0
    disp ('Matrix determinant is -1')
else x = 0;
end
