
function obstacle_bounds = Obstacles()
% 画椭圆和多边形
%[z1,z2] = PlotEllipse(30,3,16,11,(pi/180)*40);   % 中心， 长轴，短轴，方向角
%point_ellipse = [real(z1) imag(z1);real(z2) imag(z2)];
clear

% 椭圆障碍
halflong_axis = 27;
halfshort_axis = 15;
xc1 = 25;
yc1 = 8;
xt1 = (xc1-halfshort_axis):0.1:(xc1+halfshort_axis);
plotpoint = myellipse(xt1,xc1,yc1, halflong_axis, halfshort_axis);
figure(1)
plot(xt1, plotpoint(1,:),'k')
hold on
plot(xt1, plotpoint(2,:),'k')

% 圆障碍
xc2 = 75;
yc2 = -2;
r2 = 20;
xt2 = (xc2-r2):0.1:(xc2+r2);
plotpoint = mycircle(xt2,xc2,yc2,r2);
plot(xt2, plotpoint(1,:),'k')
hold on
plot(xt2, plotpoint(2,:),'k')

% 多边形障碍
p1x1 = [13 -10];
p1x2 = [34 -13];
p1x3 = [33   8];
p1x4 = [20  42];

p2x1 = [72  7];
p2x2 = [55 -10];
p2x3 = [69 -28];
p2x4 = [94 -12];

p3x1 = [35  -40];
p3x2 = [55 -40];
p3x3 = [45 -15];


% 不要改多边形总体形状！！！！！！！！！
x_poly1 = [p1x1(1) p1x2(1) p1x3(1) p1x4(1)];
y_poly1 = [p1x1(2) p1x2(2) p1x3(2) p1x4(2)];
x_poly2 = [p2x1(1) p2x2(1) p2x3(1) p2x4(1)];
y_poly2 = [p2x1(2) p2x2(2) p2x3(2) p2x4(2)];
x_poly3 = [p3x1(1) p3x2(1) p3x3(1) ];
y_poly3 = [p3x1(2) p3x2(2) p3x3(2) ];
pgon1 = polyshape(x_poly1,y_poly1);
pgon2 = polyshape(x_poly2,y_poly2);
pgon3 = polyshape(x_poly3,y_poly3);
%plot(pgon1)
axis([0,110,-50,50]);
hold on
%plot(pgon2)

% 三角形障碍
%plot(pgon3)
plot(0,0,'ro','MarkerFaceColor','r')
plot(110,0,'ro','MarkerFaceColor','r')

% 计算多边形障碍上下界
x = 0:1.1:110;
x_in = [];
poly_up = [];
poly_low = [];
for i = 1:size(x,2)
%     if x(i)>=p1x1(1) && x(i)<=p1x2(1)
%         x_in = [x_in, x(i)];
%         if x(i)>=p1x1(1) && x(i)<=p1x4(1)
%             poly_up = [poly_up, (x(i)-p1x4(1))*(p1x1(2)-p1x4(2))/(13-p1x4(1))+p1x4(2)];
%             poly_low = [poly_low, (x(i)-p1x2(1))*(p1x1(2)-p1x2(2))/(p1x1(1)-p1x2(1))+p1x2(2)];
%         elseif x(i)>p1x4(1) && x(i)<=p1x3(1)
%             poly_up = [poly_up, (x(i)-p1x3(1))*(p1x4(2)-p1x3(2))/(p1x4(1)-p1x3(1))+p1x3(2)];
%             poly_low = [poly_low, (x(i)-p1x2(1))*(p1x1(2)-p1x2(2))/(p1x1(1)-p1x2(1))+p1x2(2)];
%         elseif x(i)>p1x3(1) && x(i)<=p1x2(1)
%             poly_up = [poly_up, (x(i)-p1x2(1))*(p1x3(2)-p1x2(2))/(p1x3(1)-p1x2(1))+p1x2(2)];  
%             poly_low = [poly_low, (x(i)-p1x2(1))*(p1x1(2)-p1x2(2))/(p1x1(1)-p1x2(1))+p1x2(2)];
%         end 
        
%     elseif x(i)>=p2x2(1) && x(i)<=p2x4(1)
%         x_in = [x_in, x(i)];
%         if x(i)<=p2x3(1)
%             poly_up = [poly_up, (x(i)-p2x1(1))*(p2x2(2)-p2x1(2))/(p2x2(1)-p2x1(1))+p2x1(2)];
%             poly_low = [poly_low, (x(i)-p2x3(1))*(p2x2(2)-p2x3(2))/(p2x2(1)-p2x3(1))+p2x3(2)];
%         elseif x(i)>p2x3(1) && x(i)<=p2x1(1)
%             poly_up = [poly_up, (x(i)-p2x1(1))*(p2x2(2)-p2x1(2))/(p2x2(1)-p2x1(1))+p2x1(2)];
%             poly_low = [poly_low, (x(i)-p2x4(1))*(+p2x3(2)-p2x4(2))/(p2x3(1)-p2x4(1))+p2x4(2)];    
%         elseif x(i)>p2x1(1)
%             poly_up = [poly_up, (x(i)-p2x4(1))*(p2x1(2)-p2x4(2))/(p2x1(1)-p2x4(1))+p2x4(2)];
%             poly_low = [poly_low, (x(i)-p2x4(1))*(p2x3(2)-p2x4(2))/(p2x3(1)-p2x4(1))+p2x4(2)];    
%         end  
    if x(i) >= xc1 - halfshort_axis && x(i) <= xc1+halfshort_axis
        x_in = [x_in, x(i)];
        bound = myellipse(x(i),xc1,yc1, halflong_axis, halfshort_axis);
        poly_up = [poly_up, bound(1)];
        poly_low = [poly_low, bound(2)];
        
    elseif x(i)>=xc2-r2 && x(i)<=xc2+r2
        x_in = [x_in, x(i)];
        bound = mycircle(x(i),xc2,yc2,r2);
        poly_up = [poly_up, bound(1)];
        poly_low = [poly_low, bound(2)];
    end
end

for i = 1:size(x,2)
    if x(i)>=p3x1(1) && x(i)<=p3x3(1)
        x_in = [x_in, x(i)];
        poly_up = [poly_up, (x(i)-p3x3(1))*(p3x1(2)-p3x3(2))/(p3x1(1)-p3x3(1))+p3x3(2)];
        poly_low = [poly_low, (x(i)-p3x2(1))*(p3x1(2)-p3x2(2))/(p3x1(1)-p3x2(1))+p3x2(2)];
    elseif x(i)>p3x3(1) && x(i)<=p3x2(1)
        x_in = [x_in, x(i)];
        poly_up = [poly_up, (x(i)-p3x2(1))*(p3x3(2)-p3x2(2))/(p3x3(1)-p3x2(1))+p3x2(2)];
        poly_low = [poly_low, (x(i)-p3x2(1))*(p3x1(2)-p3x2(2))/(p3x1(1)-p3x2(1))+p3x2(2)];   
    end
end


obstacle_bounds = [x_in; poly_up; poly_low];
%plot(x_in, poly_up, 'LineWidth', 2)
%plot(x_in, poly_low, 'LineWidth', 2)


function bound = myellipse(xt,xc,yc, halflong_axis, halfshort_axis)
    upbound = [];
    lowbound = [];
    upbound = [upbound, yc + sqrt(halflong_axis^2 - halflong_axis^2*(xt-xc).^2/halfshort_axis^2)];
    lowbound = [lowbound, yc - sqrt(halflong_axis^2 - halflong_axis^2*(xt-xc).^2/halfshort_axis^2)];
    bound = [upbound; lowbound];
end

function bound = mycircle(xt,xc,yc,r)
    upbound = [];
    lowbound = [];
    upbound = [upbound, yc + sqrt(r^2-(xt-xc).^2)];
    lowbound = [lowbound, yc - sqrt(r^2-(xt-xc).^2)];
    bound = [upbound; lowbound];
end


function [z1,z2] = PlotEllipse(Xcenter,Ycenter,LongAxis,ShortAxis,Angle)
Ycenter = -Ycenter;
t1=0:0.01:pi;
t2=pi:0.01:2*pi;
z1=exp(1i*t1);
z2=exp(1i*t2);
z1=(LongAxis*real(z1)+1i*ShortAxis*imag(z1))*exp(1i*(-Angle));
z2=(LongAxis*real(z2)+1i*ShortAxis*imag(z2))*exp(1i*(-Angle));
z1=z1+Xcenter+Ycenter*1i;
z2=z2+Xcenter+Ycenter*1i;
z1=z1';
z2=z2';
plot(z1,'r');
hold on
plot(z2,'r');
hold off
grid on
end

end
