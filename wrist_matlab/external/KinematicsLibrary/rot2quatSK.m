function x = rot2quatSK(R)

% Uso:  Angles = rot2quatSK(R)
%
% Calcola il quaternione corrispondente a partire dalla matrice di rotazione R
% utilizzando l'algoritmo di Sheppard-Klumpp HAL/S
% descritto a pag. 4 del "Interoffice Memorandum IOM 343-79-1199 Oct. 1979"
% by Breckenridge, NASA
%
% B Bona, DAUIN, POLITO

if isrot(R) == 0
    tr=R(1,1)+R(2,2)+R(3,3);
    m=[R(1,1) R(2,2) R(3,3) tr]';
    [y,i]=max(m);
    M=R';
    switch i
        case 1
            s(1)=0.5*sqrt(1+2*m(1,1)-tr);
            s(2)=0.25*(M(1,2)+M(2,1))/s(1);
            s(3)=0.25*(M(1,3)+M(3,1))/s(1);
            s(4)=0.25*(M(2,3)-M(3,2))/s(1);
        case 2
            s(2)=0.5*sqrt(1+2*m(2,2)-tr);
            s(1)=0.25*(M(1,2)+M(2,1))/s(2);
            s(3)=0.25*(M(2,3)+M(3,2))/s(2);
            s(4)=0.25*(M(3,1)-M(1,3))/s(2);
        case 3
            s(3)=0.5*sqrt(1+2*m(3,3)-tr);
            s(1)=0.25*(M(1,3)+M(3,1))/s(3);
            s(2)=0.25*(M(2,3)+M(3,2))/s(3);
            s(4)=0.25*(M(1,2)-M(2,1))/s(3);
        case 4
            s(4)=0.5*sqrt(1+tr);
            s(1)=0.25*(M(2,3)-M(3,2))/s(4);
            s(2)=0.25*(M(3,1)-M(1,3))/s(4);
            s(3)=0.25*(M(1,2)-M(2,1))/s(4);
        otherwise
            disp ('Error in input matrix')
            x='ERROR';
    end
   	x(1) = s(4);
   	x(2) = s(1);
   	x(3) = s(2);
   	x(4) = s(3);
else
	disp ('Error in input matrix')
	x='ERROR';
end
