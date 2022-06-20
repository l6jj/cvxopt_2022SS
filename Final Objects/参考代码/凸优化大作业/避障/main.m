clc
clear all
close all

%% 参数设置
% 通用参数
rad=pi/180;

% 初始状态
x_0=0;
y_0=0;
theta_0=0*rad;
vartheta_0=tan(theta_0);

% 终端状态
x_f=100;
y_f=0;
theta_f=0*rad;
vartheta_f=tan(theta_f);

% 障碍位置
x_ob(1)=20;
y_ob(1)=5;
a_ob(1)=10;
b_ob(1)=10;
x_ob(2)=50;
y_ob(2)=-5;
a_ob(2)=15;
b_ob(2)=10;
x_ob(3)=80;
y_ob(3)=5;
a_ob(3)=10;
b_ob(3)=10;
% eta=[0 1 1];
m=width(x_ob);

% 系统参数
omega_max=20*rad;
V=5;
N=101; %取100个区间（1米）
D=1000;
epsilon_d=0.01;
dx=(x_f-x_0)/(N-1);

%% 初始化
% 迭代量初始化
y=sdpvar(N,1);
vartheta=sdpvar(N,1);
u=sdpvar(N,1);
delta=sdpvar(N,1);
x=sdpvar(N,1);
t=sdpvar(N,1);
eta=binvar(m, 1);

% 状态量初始化
delta_s=ones(N,1);
delta_s=delta_s*1;

% 区域初始化
l_min=ones(N,1);
l_max=ones(N,1);
l_max=l_max*500;
l_min=l_min*(-500);
x_r=x_0:dx:x_f;
for j=1:m
    for i=1:N
        if x_r(i)>=x_ob(j)-a_ob(j) && x_r(i)<=x_ob(j)+a_ob(j)
            l_max(i)=y_ob(j)+sqrt(1-((x_r(i)-x_ob(j))^2/a_ob(j)^2))*b_ob(j);
            l_min(i)=y_ob(j)-sqrt(1-((x_r(i)-x_ob(j))^2/a_ob(j)^2))*b_ob(j);
        end
    end
end

for count=1:10
%% 建模与约束
%初末约束
    F=(y(1)==y_0);
    F=F+(x(1)==x_0);
    F=F+(vartheta(1)==vartheta_0);
    F=F+(y(N)==y_f);
    F=F+(x(N)==x_f);
    F=F+(vartheta(N)==vartheta_f);
    F=F+(t(1)==0);
    
    % 动力学模型
    for i=1:N-1
        F=F+(y(i+1)==y(i)+vartheta(i)*dx);
        F=F+(vartheta(i+1)==vartheta(i)+u(i)*dx);
        F=F+(x(i+1)==x(i)+dx);
        F=F+(t(i+1)==t(i)+delta(i)*dx/V);
    end
    
    % 控制量约束
    for i=1:N
        F=F+(u(i)<=omega_max/V*(3*delta_s(i)^2*delta(i)-2*delta_s(i)^3));
        F=F+((-u(i))<=omega_max/V*(3*delta_s(i)^2*delta(i)-2*delta_s(i)^3));
    end
    
    % delta约束
    for i=1:N
        F=F+(delta(i)>=sqrt(1+vartheta(i)^2));
    end
    
    % 避障约束
    
    for i=1:N
        for j = 1 : m
            if x_r(i) >= x_ob(j) - a_ob(j) && x_r(i) <= x_ob(j) + a_ob(j)
                F = F + (y(i) >= l_max(i) + D * (eta(j) - 1));
                F = F + (y(i) <= l_min(i) + D * eta(j));
            end
        end
%         F=F+(y(i)<=l_max(i));
%         F=F+(y(i)>=l_min(i));
    end
    
    
    solve=solvesdp(F,t(N));
    delta_s=double(delta);
end
data_y=double(y);
data_x=double(x);
data_delta=double(delta);
data_vartheta=double(vartheta);
data_theta=atan(data_vartheta)/rad;
data_t=double(t);

%% 画图
% 画圆
for i=1:m
    t=0:pi/100:2*pi;
    t=t';
    x_c(:,i)=x_ob(i)+a_ob(i)*sin(t);
    y_c(:,i)=y_ob(i)+b_ob(i)*cos(t);
end

% 画图
figure(1)
plot(data_x,data_y);
hold on 
plot(x_c,y_c);
axis equal

figure
plot(data_t,data_theta);
% 
% figure
% plot(data_t,data_x);
% 
% figure
% plot(data_t,data_y);