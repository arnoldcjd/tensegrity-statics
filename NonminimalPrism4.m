% Static force analysis of 2D Michell Topology
clear; clf; figure(1);
% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
h=1;r=1;dim=3;
pBar=4;
alpha=pi*(1/2-1/pBar);
theta=2*pi/pBar;
Q=[];P=[];
for i=1:pBar
    Q(1:dim,i)=[r*cos(theta*(i-1));r*sin(theta*(i-1));0];
    Q(1:dim,i+pBar)=[r*cos(theta*(i)+alpha);r*sin(theta*(i)+alpha);h];
end
q=size(Q,2);p=size(P,2);
n=p+q;
b=0;
s=0;
C=[];
%bar
for i=1:pBar
    C(end+1,i)=1;C(end,i+pBar)=-1;
    b=b+1;
end
%bottom string
for i=1:pBar
    if i+1>pBar
        index=i+1-pBar;
    else
        index=i+1;
    end
    C(end+1,i)=1;C(end,index)=-1;
    s=s+1;
end
%top string
for i=1:pBar
    if i+1>pBar
        index=i+1-pBar;
    else
        index=i+1;
    end
    C(end+1,pBar+i)=1;C(end,pBar+index)=-1;
    s=s+1;
end
%vertical string
C(end+1,1)=1;C(end,size(C,2))=-1;
s=s+1;
for i=2:pBar
    C(end+1,i)=1;C(end,i+pBar-1)=-1;
    s=s+1;
end
%diagonal string
for i=1:pBar
    indexTop=pBar+adjustIdx(i+1,pBar);
    indexBottom=adjustIdx(i-1,pBar);
    C(end+1,indexTop)=1;C(end,indexBottom)=-1;
    s=s+1;
end
U(1:dim,1:q)=0; %external force
for i=1:4
   U(1:dim,i)=[0;0;-1];
end
for i=5:8
    U(1:dim,i)=[0;0;1];
end
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U)
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;

function adjustedIdx=adjustIdx(idx,pBar)
    if idx<=0
        adjustedIdx=pBar-idx;
    elseif idx>pBar
        adjustedIdx=idx-pBar;
    else
        adjustedIdx=idx;
    end
end