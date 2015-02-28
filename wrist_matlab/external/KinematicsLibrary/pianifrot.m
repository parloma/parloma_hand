function [R1,R2,R3] = pianifrot(R0,Rf,s)

% Uso: [R1,R2,R3] = pianifrot(alfa0,alfaf,s)
%
% Pianificazione di una matrice di rotazione usando i tre metodi:
%
% calcolo di R(s) per 0<=s<=1 assegnato
% a partire dalla matrice iniziale R0 
% per giungere alla matrice finale Rf
%
% restituisce R1 usando il metodo asse, angolo
%             R2 usando il metodo di scivolamento piano
%             R3 usando il metodo degli angoli di eulero
%
% B Bona, DAUIN, POLITO

if s>=0 & s<=1
   
% Metodo 1: asse, angolo

   RL=R0'*Rf;
   [u,deltalfa1]=rot2uth(RL);
   R1s=uth2rot(u,s*deltalfa1);
   R1=R0*R1s;

% Metodo 2: scivolamento piano

   k0=R0(:,3);
   kf=Rf(:,3);
   j0=R0(:,2);
   jf=Rf(:,2);
   u2=cross(k0,kf);
   normu2=norm(u2);
   
   if normu2==0
      RL=R0'*Rf;
      [u,deltalfa2]=rot2uth(RL);
      R2s=uth2rot(u,s*deltalfa2);
      R2=R0*R1s;
   else
      deltabeta=asind(normu2);
      u2=u2/normu2;
      Rubeta=uth2rot(u2,deltabeta);
      jtilde=Rubeta'*j0;
      deltalfa2=asind(norm(cross(jtilde,jf)));
      R2=uth2rot(u2,s*deltabeta)*Rotz(s*deltalfa2);
      R2=R0*R2;
   end
   
% Metodo 3: angoli di eulero

   alfa0=rot2eul(R0);
   alfaf=rot2eul(Rf);
   deltalfa3=alfaf-alfa0;
   alfas=alfa0 + s*deltalfa3;
   R3=eul2rot(alfas);

else
   disp ('planning variable s is not between 0 and 1')
   R1='error';R2='error';R3='error';
end
