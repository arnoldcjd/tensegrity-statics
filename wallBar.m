% Static force analysis of 2D Michell Topology Figure 1.39 in book
clear; clf; figure(1);
% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
dim=2;
Q=[10 10;0 1];
P=[0 0;0 1];
q=2;p=2;
C(1,1)=1;C(1,4)=-1;
C(2,2)=1;C(2,3)=-1;
b=2;
C(3,1)=1;C(3,2)=-1;
C(4,1)=1;C(4,3)=-1;
C(5,2)=1;C(5,4)=-1;
s=3;
U(1:dim,1:q)=0;
U(1:dim,1)=[1;1];
display(Q);
display(P)
display(C)
display(U)
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U)
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;