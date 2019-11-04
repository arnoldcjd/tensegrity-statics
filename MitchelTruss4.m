% Static force analysis of 2D Michell Topology
clear; clf; figure(1);
% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
order=4;phi=pi/8;beta=pi/6;dim=2;a=sin(beta)/sin(beta+phi);
radi=zeros(order+1,1);
radi(1)=1;
for i=2:order+1
    radi(i)=radi(1)*a^(i-1);
end
Q=[];
for i=0:order %set up free and fixed nodes
    for k=0:order-i
        theta=(i-k)*phi;
        r=radi(i+k+1);
        if i+k==order
            P(:,i+1)=[r*cos(theta);r*sin(theta)];
        else
            Q(:,end+1)=[r*cos(theta);r*sin(theta)];
        end
    end
end
q=size(Q,2);p=size(P,2);n=q+p;
C=[];
b=0;s=0;
for i=0:order-1 % set up bars connectivity
    k=order-i;
    sum=0;
    for step=order:-1:k
        sum=sum+step;
    end
    C(end+1,sum)=1;C(end,q+i+1)=-1;
    b=b+1;
    sum=sum-step;
    for k=0:order-2-i
        index=sum+k+1;
        C(end+1,index)=1;C(end,index+1)=-1;
        b=b+1;
    end
end
for k=0:order-1 % set up string connectivity
    i=order-k;
    sum=0;
    for step=order:-1:k
        sum=sum+step;
    end
    C(end+1,q+i+1)=1;C(end,sum-k)=-1;
    s=s+1;
    for i=0:order-2-k
        sum1=0;
        for step=0:i-1
            sum1=sum1+(order-step);
        end
        sum2=0;
        for step=0:i
            sum2=sum2+(order-step);
        end
        C(end+1,sum1+k+1)=1;C(end,sum2+k+1)=-1;
        s=s+1;
    end
end
U(1:dim,1:q)=0; %external force
U(1:dim,1)=[1;0];
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U)
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;