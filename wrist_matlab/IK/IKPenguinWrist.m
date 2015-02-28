%% Copyright (C) 2015 Politecnico di Torino
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
% Contributors:
%   Giorgio Toscana (giorgio.toscana@polito.it)

function [ q1alto, q1medio, q1basso ] = IKPenguinWrist( locus_of_desired_pose )
% IK Penguin Wrist without Plots
% Output: q1alto, q1medio, q1basso in gradi ognuno e' vettore 1xN!!!
% Input: Matrice 3xN dove ogni colonna N e' un punto 3D nello spazio del
% path desiderato


%% Kinematics Constant:

% Fixed Point in Space

    P4 = [0;0;36.57];

% Equations Parameters definition
    %L 120-Angled: Alto Basso Medio creano una circonferenza con centro in Z=19.06 e raggio R nel piano XY w.r.t. RF0fixed

    %L ALTO (Medio e Basso formano lo stesso cerchio )
    l1a = 19.33;
    l2a = 22.01;
    psi = deg2rad(120);
    %Raggio cerchio generato da L-120angled nel piano XY
    %Rxy = l1a-l2a*cos(psi);
    %centro del medesimo cerchio
    centroXY = [0;0;19.06];
    % il raggio e' uguale per tutte e tre le Ldue
    Rl2 = 35.03;
    

%% Find the Plane Normal and hence the RF of the triangle
Num_Of_desired_pose = length(locus_of_desired_pose);
%init
vectorCircle_P4 = zeros(3,Num_Of_desired_pose);
q1alto = zeros(1,Num_Of_desired_pose);
q1medio = zeros(1,Num_Of_desired_pose);
q1basso = zeros(1,Num_Of_desired_pose);
for PoseNumber=1:1:Num_Of_desired_pose;
    %normal vector
    vectorCircle_P4(:,PoseNumber) = locus_of_desired_pose(:,PoseNumber) - P4;
    %normalization
    vectorCircle_P4(:,PoseNumber) = vectorCircle_P4(:,PoseNumber)/norm(vectorCircle_P4(:,PoseNumber));

% imin = 1;
% for i=1:3
%     if vectorCircle_P4(i,vectorNumber) < vectorCircle_P4(imin,vectorNumber)
%         imin = i;
%     end
% end
imin = 2; %%bias of y axis to be as close as possible to the Y axis of the inertial frame: 
%needed to keep the yaw angle as small as possible. High yaw values yields
%high joints variations from the rest pose!!!!

Yvector = zeros(3,1);
dt    = vectorCircle_P4(imin,PoseNumber);

Yvector(imin) = 1;
%Yvector(2) = 1;
for i=1:3
    Yvector(i) = Yvector(i) -  dt*vectorCircle_P4(i,PoseNumber);
end

Yvector = Yvector./norm(Yvector);

R0fixedtoP4 = [cross(Yvector,vectorCircle_P4(:,PoseNumber)) ,Yvector,vectorCircle_P4(:,PoseNumber)];

%con R=Rz*Ry*Rx 
%R0fixedtoP4 = rotz(rad2deg(yaw))*roty(rad2deg(pitch))*rotx(rad2deg(roll));

RPY = rot2rpy(R0fixedtoP4);

roll = deg2rad(RPY(1));
pitch = deg2rad(RPY(2));
yaw = deg2rad(RPY(3));

%% IK parameters

    A = centroXY(3) - P4(3);
    B = Rl2*sin(pitch);
    C = Rl2*cos(pitch)*cos(roll);

    D = l1a-l2a*cos(psi);
    E = Rl2*(cos(yaw)*sin(roll) - cos(roll)*sin(pitch)*sin(yaw));
    F = Rl2*cos(pitch)*sin(yaw);

    H = Rl2*(sin(roll)*sin(yaw) + cos(roll)*cos(yaw)*sin(pitch));
    I = Rl2*cos(pitch)*cos(yaw);
    L = Rl2*(sin(pitch)/2 - (3^(1/2)*cos(pitch)*sin(roll))/2);

    M = Rl2*((cos(pitch)*sin(yaw))/2 + (3^(1/2)*(cos(roll)*cos(yaw) + sin(pitch)*sin(roll)*sin(yaw)))/2);
    N = Rl2*((cos(pitch)*cos(yaw))/2 - (3^(1/2)*(cos(roll)*sin(yaw) - cos(yaw)*sin(pitch)*sin(roll)))/2);
    O = Rl2*(sin(pitch)/2 + (3^(1/2)*cos(pitch)*sin(roll))/2);
    P = Rl2*((cos(pitch)*sin(yaw))/2 - (3^(1/2)*(cos(roll)*cos(yaw) + sin(pitch)*sin(roll)*sin(yaw)))/2);
    R = Rl2*((cos(pitch)*cos(yaw))/2 + (3^(1/2)*(cos(roll)*sin(yaw) - cos(yaw)*sin(pitch)*sin(roll)))/2);

%% Solutions to IK:
%% ALTO solve t3 -> 2 solutions:
 % eq3alto = A - C*cos(t3) + B*sin(t3)
 % sols: 1) -2*atan2(B + (- A^2 + B^2 + C^2)^(1/2), A + C)
 %       2) -2*atan2(B - (- A^2 + B^2 + C^2)^(1/2), A + C)
 
%eps_zero = 1e-4;

temp = - A^2 + B^2 + C^2;
%testa temp se negativo:
if temp<0.0
    %%disp('Non real solutions');
    return;
end

i=1;

yplus = (B + (- A^2 + B^2 + C^2)^(1/2));
yminus = (B - (- A^2 + B^2 + C^2)^(1/2));
x = A + C;

    if (  ( yplus ~= 0) && (x ~= 0) )

        St3alto(i) = -2*atan2(yplus,x);
        i=i+1;
    end
    if (  (yminus ~= 0) && (x ~= 0) )

        St3alto(i) = -2*atan2(yminus,x);
        i=i+1;
    end 
 
% Solve for t1 alto: eq 1 and 2:
%eq2alto = E*cos(t3) + D*sin(t1) - F*sin(t3) 
%eq1alto = D*cos(t1) - H*cos(t3) - I*sin(t3)
%Combination to avoid asin and acos but using atan2

%           -E*cos(t3) + F*sin(t3)
% tan(t1) = ----------------------
%           H*cos(t3) + I*sin(t3)

y1 = -E*cos(St3alto(1)) + F*sin(St3alto(1));
x1 = H*cos(St3alto(1)) + I*sin(St3alto(1));

y2 = -E*cos(St3alto(2)) + F*sin(St3alto(2));
x2 = H*cos(St3alto(2)) + I*sin(St3alto(2));

if(i==3)
    %%disp('found 2 solutions for t3 alto')
    %%disp('solve for t1 alto...')
    %disp('trying first solution:')
    found_solutions = 0;
    
    
    
    if ( ( y1 ~=0) || ( x1 ~= 0) )
        %solve for t1
        %sol 1
        St1alto_1 = atan2( y1, x1 );
        
        found_solutions = 1;
        
    else
        %disp('atan2(0,0) Undefined...NO IK Available for sol 1 !!! ');
        %return;
    end
    
    %disp('trying second solution:')
    if ( ( y2 ~=0) || ( x2 ~= 0) )
        %solve for t1
        %sol 2
        St1alto_2 = atan2( y2, x2 ); 
        found_solutions = 1;
    else
        %disp('atan2(0,0) Undefined...NO IK Available for sol 2 !!! ');
        %return;
    end
    
    if(found_solutions == 0)
        %disp('t1 alto cannot be found...No IK Available for given poses...quit()')
        return;
    end
    
    
    
elseif(i==2)
    %disp('found only 1 solution for t3 alto')
    %disp('solve for t1 alto...')
    if ( y1 ~=0 ) || ( x1 ~= 0) 
        St1alto_1 = atan2( y1, x1 );
    else
        %disp('atan2(0,0) Undefined...NO IK Available...Quit() !!! ');
        return;
    end
elseif(i==1)
    %disp('found No solutions for t3 alto...quit!!')
    return;
else
    %disp('Error t3 alto');
    return;
end

%% MEDIO solve t3 -> 2 solutions:
 %eq3medio = A - C*cos(t3) - L*sin(t3)
    %sols: 1) 2*atan2(L + (- A^2 + C^2 + L^2)^(1/2), A + C)
    %      2) 2*atan2(L - (- A^2 + C^2 + L^2)^(1/2), A + C)

temp = - A^2 + C^2 + L^2;
%testa temp se negativo:
if temp<0.0
    %disp('Non real solutions');
    return;
end

i=1;

yplus = (L + (- A^2 + L^2 + C^2)^(1/2));
yminus = (L - (- A^2 + L^2 + C^2)^(1/2));
x = A + C;

    if (  ( yplus ~= 0) && (x ~= 0) )

        St3medio(i) = 2*atan2(yplus,x);
        i=i+1;
    end
    if (  (yminus ~= 0) && (x ~= 0) )

        St3medio(i) = 2*atan2(yminus,x);
        i=i+1;
    end


% Solve for t1 medio: eq 1 and 2:
%eq2medio = E*cos(t3) + D*sin(t1) + M*sin(t3)
%eq1medio = D*cos(t1) - H*cos(t3) + N*sin(t3)
%Combination to avoid asin and acos but using atan2

%           -E*cos(t3) - M*sin(t3)
% tan(t1) = ----------------------
%           H*cos(t3) - N*sin(t3)


y1 = -E*cos(St3medio(1)) - M*sin(St3medio(1));
x1 = H*cos(St3medio(1)) - N*sin(St3medio(1));

y2 = -E*cos(St3medio(2)) - M*sin(St3medio(2));
x2 = H*cos(St3medio(2)) - N*sin(St3medio(2));

if(i==3)
    %disp('found 2 solutions for t3 medio')
    %disp('solve for t1 medio...')
    %disp('trying first solution:')
    found_solutions = 0;
    
    
    
    if ( ( y1 ~=0) || ( x1 ~= 0) )
        %solve for t1
        %sol 1
        St1medio_1 = atan2( y1, x1 );
        
        found_solutions = 1;
        
    else
        %disp('atan2(0,0) Undefined...NO IK Available for sol 1 !!! ');
        %return;
    end
    
    %disp('trying second solution:')
    if ( ( y2 ~=0) || ( x2 ~= 0) )
        %solve for t1
        %sol 2
        St1medio_2 = atan2( y2, x2 ) ;
        found_solutions = 1;
    else
        %disp('atan2(0,0) Undefined...NO IK Available for sol 2 !!! ');
        %return;
    end
    
    if(found_solutions == 0)
        %disp('t1 medio cannot be found...No IK Available for given poses...quit()')
        return;
    end
    
    
    
elseif(i==2)
    %disp('found only 1 solution for t3 medio')
    %disp('solve for t1 medio...')
    if ( y1 ~=0 ) || ( x1 ~= 0) 
        St1medio_1 = atan2( y1, x1 );
    else
        %disp('atan2(0,0) Undefined...NO IK Available...Quit() !!! ');
        return;
    end
elseif(i==1)
    %disp('found No solutions for t3 medio...quit!!')
    return;
else
    %disp('Error t3 medio');
    return;
end

%% BASSO solve t3 -> 2 solutions:
 %eq3basso = A - C*cos(t3) - O*sin(t3)
    %sols: 1) 2*atan2(O + (- A^2 + C^2 + O^2)^(1/2), A + C)
    %      2) 2*atan2(O - (- A^2 + C^2 + O^2)^(1/2), A + C)

temp = - A^2 + C^2 + O^2;
%testa temp se negativo:
if temp<0.0
    %disp('Non real solutions');
    return;
end

i=1;

yplus = (O + (- A^2 + C^2 + O^2)^(1/2));
yminus = (O - (- A^2 + C^2 + O^2)^(1/2));
x = A + C;

    if (  ( yplus ~= 0) && (x ~= 0) )

        St3basso(i) = 2*atan2(yplus,x);
        i=i+1;
    end
    if (  (yminus ~= 0) && (x ~= 0) )

        St3basso(i) = 2*atan2(yminus,x);
        i=i+1;
    end

% Solve for t1 basso: eq 1 and 2:
%eq2basso = E*cos(t3) + D*sin(t1) + P*sin(t3)
%eq1basso = D*cos(t1) - H*cos(t3) + R*sin(t3)
%Combination to avoid asin and acos but using atan2

%           -E*cos(t3) - P*sin(t3)
% tan(t1) = ----------------------
%           H*cos(t3) - R*sin(t3)


y1 = -E*cos(St3basso(1)) - P*sin(St3basso(1));
x1 = H*cos(St3basso(1)) - R*sin(St3basso(1));

y2 = -E*cos(St3basso(2)) - P*sin(St3basso(2));
x2 = H*cos(St3basso(2)) - R*sin(St3basso(2));

if(i==3)
    %disp('found 2 solutions for t3 basso')
    %disp('solve for t1 basso...')
    %disp('trying first solution:')
    found_solutions = 0;
    
    
    
    if ( ( y1 ~=0) || ( x1 ~= 0) )
        %solve for t1
        %sol 1
        St1basso_1 = atan2( y1, x1 );
        
        found_solutions = 1;
        
    else
        %disp('atan2(0,0) Undefined...NO IK Available for sol 1 !!! ');
        %return;
    end
    
    %disp('trying second solution:')
    if ( ( y2 ~=0) || ( x2 ~= 0) )
        %solve for t1
        %sol 2
        St1basso_2 = atan2( y2, x2 ) ;
        found_solutions = 1;
    else
        %disp('atan2(0,0) Undefined...NO IK Available for sol 2 !!! ');
        %return;
    end
    
    if(found_solutions == 0)
        %disp('t1 basso cannot be found...No IK Available for given poses...quit()')
        return;
    end
    
    
    
elseif(i==2)
    %disp('found only 1 solution for t3 basso')
    %disp('solve for t1 basso...')
    if ( y1 ~=0 ) || ( x1 ~= 0) 
        St1basso_1 = atan2( y1, x1 );
    else
        %disp('atan2(0,0) Undefined...NO IK Available...Quit() !!! ');
        return;
    end
elseif(i==1)
    %disp('found No solutions for t3 basso...quit!!')
    return;
else
    %disp('Error t3 basso');
    return;
end


%% find the closest solution to home pose
    %disp('Solutions: q1 ALTO:' )
    if( abs(St1alto_1-0) < abs(St1alto_2-0) )
        q1alto(PoseNumber) = rad2deg(St1alto_1);
    else
        q1alto(PoseNumber) = rad2deg(St1alto_2);
    end
    
    %disp('Solutions: q1 MEDIO:' )
    if( abs(St1medio_1-(-(2/3)*pi)) < abs(St1medio_2-(-(2/3)*pi)) )
        q1medio(PoseNumber) = rad2deg(St1medio_1);
    else
        q1medio(PoseNumber) = rad2deg(St1medio_2);
    end
    
    %disp('Solutions: q1 BASSO:' )
    if(abs(St1basso_1-((2/3)*pi)) < abs(St1basso_2-((2/3)*pi)))
        q1basso(PoseNumber) = rad2deg(St1basso_1);
    else
        q1basso(PoseNumber) = rad2deg(St1basso_2);
    end


end

end

