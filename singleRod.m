% Static force analysis of 2D Michell Topology Figure6.2 in book
clear; clf; figure(1);
% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
dim=3;
theta=2*pi/3;
r=1;
P=[0;0;0];
for i=1:3
    P(:,i+1)=[r*cos(theta*(i-1));r*sin(theta*(i-1));0];
end
Q=[0;0;1];
p=4;q=1;
b=1;s=3;

C(1,1)=1;C(1,2)=-1; %bar
for i=1:3
    C(i+1,i+2)=1;C(i+1,1)=-1;
end
U(1:dim,1:q)=0; %external force
U(1:dim,1)=[1;1;1];
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U)
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;