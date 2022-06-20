clear
clc
global  P alpha L D Isp g S rho0 H
S=5;
rho0=1.25;
H=7206.64;
g=9.8;
Isp=282.9;
step=1;h=0.01;
P=0;
alpha=15*pi/180;
x(step,1)=457.3;x(step,2)=0;x(step,3)=0;x(step,4)=40*1000;x(step,5)=41700;x(step,6)=0;

cl=chazhi_cl(alpha*180/pi,x(step,1)/340);
cd=chazhi_x(alpha*180/pi,x(step,1)/340);
rho=rho0*exp(-x(step,4)/H);
dynamic_pressure=0.5*rho*x(step,1)^2;
L=S*cl*dynamic_pressure;
D=S*cd*dynamic_pressure;

while  x(step,4)>0 %终止条件
    step=step+1;
    x(step,:)=Runge_kutta_dynamic(h,x(step-1,:)); 
if  x(step,6)<90
    P=0;
else
    P=845.3*1000;
end
    if x(step,6)<50
    alpha=25*pi/180;
else
     alpha=20*pi/180-(x(step,6)-50)*pi/450;
    end
cl=chazhi_cl(alpha*180/pi,x(step,1)/340);
cd=chazhi_x(alpha*180/pi,x(step,1)/340);
rho=rho0*exp(-x(step,4)/H);
dynamic_pressure=0.5*rho*x(step,1)^2;
L=S*cl*dynamic_pressure;
D=S*cd*dynamic_pressure;
end
plot(x(:,3),x(:,4))
% 
% Xm = x(:,11)-x(:,5).*cos(x(:,6));
% Ym = x(:,12)-x(:,5).*sin(x(:,6));
% 
% figure(1)
% plot(x(:,4),x(:,5),'k')
% xlabel('t/s',  'FontSize',15)
% ylabel('R/m' ,'FontSize',15)
% title('弹目相对距离','FontSize',10)
% 
% figure(2)
% plot(x(:,4),x(:,2)*180/pi,'k')
% xlabel('t/s',  'FontSize',15)
% ylabel('\alpha/(°)' ,'FontSize',15)
% title('攻角','FontSize',10)
% 
% figure(3)
% plot(x(:,4),x(:,3)*180/pi,'k')
% xlabel('t/s',  'FontSize',15)
% ylabel('\omega_z/(°/s)' ,'FontSize',15)
% title('俯仰角速率','FontSize',10)
% 
% figure(4)
% plot(x(:,4),u(:)*180/pi,'k')
% xlabel('t/s',  'FontSize',15)
% ylabel('\delta_z/(°)' ,'FontSize',15)
% title('舵偏角','FontSize',10)
% 
% figure(5)
% plot(x(:,11),x(:,12),'k:',Xm,Ym,'k')
% xlabel('x/m',  'FontSize',15)
% ylabel('y/m' ,'FontSize',15)
% title('绝对弹道','FontSize',10)
% 
% legend('目标','导弹')

%figure(6)
%plot(x(:,4),x(:,1)*(-q*s*cy_alpha/m)/x(:,5))
%xlabel('t/s',  'FontSize',20)
%ylabel('V_r/(°/s)' ,'FontSize',20)
%title('视线角速率变化曲线','FontSize',20)



