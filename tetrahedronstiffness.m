
clc;clear;
tic
%material properties
E = 2.1; mu = 0.3;

%connectivity matrix
c = [0 0 0;0 0 20;10 0 0;0 15 0];
  
  %Jacobian matrix
j = [(c(1,1) - c(4,1)) (c(1,2)-c(4,2)) (c(1,3)-c(4,3));...
    (c(2,1)-c(4,1)) (c(2,2)-c(4,2)) (c(2,3)-c(4,3));...
    (c(3,1)-c(4,1)) (c(3,2)-c(4,2)) (c(3,3)-c(4,3))];

%inverse jacobian
a = inv(j);

a1 = sum(a(1,:));
a2 = sum(a(2,:));
a3 = sum(a(3,:));

%b matrix
b = [a(1,1) 0 0 a(1,2) 0 0 a(1,3) 0 0 -a1 0 0;...
    0 a(2,1) 0 0 a(2,2) 0 0 a(2,3) 0 0 -a2 0;...
    0 0 a(3,1) 0 0 a(3,2) 0 0 a(3,3) 0 0 -a3;...
    0 a(3,1) a(2,1) 0 a(3,2) a(2,2) 0 a(3,3) a(2,3) 0 -a3 -a2;...
    a(3,1) 0 a(1,1) a(3,2) 0 a(1,2) a(3,3) 0 a(1,3) -a3 0 -a1;...
    a(2,1) a(1,1) 0 a(2,2) a(1,2) 0 a(2,3) a(1,3) 0 -a2 -a1 0];

q = E/((1 + mu)*(1 - 2*mu)) ;
w = 1- mu ;
r = (1 - 2*mu)/2 ;

% D matrix of material
d = q*[w mu mu 0 0 0;...
       mu w mu 0 0 0;...
       mu mu w 0 0 0;...
       0 0 0 r 0 0;...
       0 0 0 0 r 0;...
       0 0 0 0 0 r];

%Volume of element
v = (1/6)*det(j) ;


% Stiffness matrix
k = b.'*d*b*v ;

toc
