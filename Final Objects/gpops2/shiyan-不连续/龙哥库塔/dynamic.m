function dx=dynamic(x)
global P alpha L D Isp g
dx(1)=-(P*cos(alpha)+D)/x(5)-g*sin(x(2));%x(1)=v
dx(2)=(-P*sin(alpha)+L)/(x(5)*x(1))-g*cos(x(2))/x(1);%x(2)=theta
dx(3)=x(1)*cos(x(2));%x(3)=X
dx(4)=x(1)*sin(x(2));%x(4)=Y
dx(5)=-P/(g*Isp);%x(5)=m
dx(6)=1;%t

end