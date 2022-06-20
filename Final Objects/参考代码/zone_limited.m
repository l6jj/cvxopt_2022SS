%addpath('D:\Matlab2020b\toolbox\mosek\9.3\toolbox\R2015a');
%which quadprog
clear
yalmip('clear')

x=0:1.1:110;
yf = 0;
wmax = 20*pi/180;
v = 5;
wv = wmax/v;

%---------------------------------初始参数----------------------------------
algorithm = 1;
num_obstacle = 2;

%---------------------------------------------------------------------------

obstacle_bounds = Obstacles();

if algorithm == 1
    delta0 = 1.1*ones(1,101);
    num_iterations = 100;
else
    delta0 = 1*ones(1,101);
    num_iterations = 1;
end


for ppp=1:num_iterations
    % 定义变量
    z = sdpvar(404,1);
    eta = binvar(num_obstacle,1);    % 0,1变量
    xone = sdpvar(1);

    % Define constraints 
    Constraints = [];

    % y的约束
    for i = 1:100 
      Constraints = [Constraints, z(i) - z(i+1) + 1.1*z(i+101) == 0];
    end

    % theta的约束
    for i = 102:201
      Constraints = [Constraints, z(i) - z(i+1) + 1.1*z(i+101) == 0];
    end

    % u的约束
    for i = 1:101
      Constraints = [Constraints, -wv*(3*delta0(i)^2*z(i+303) - 2*delta0(i)^3) <= z(i+202) <= wv*(3*delta0(i)^2*z(i+303) - 2*delta0(i)^3)];
    end

    % delta的二阶锥约束
    for i = 1:101
      Constraints = [Constraints, z(i+303)>=sqrt(xone^2 + z(i+101)^2)];
    end

    % 障碍物1的约束
    for i = 11:37
      Constraints = [Constraints, obstacle_bounds(2,i-10)+1000*(eta(1)-1) <=z(i)<= obstacle_bounds(3,i-10)+1000*eta(1)];
    end

    % 障碍物2的约束
    for i = 51:87
      Constraints = [Constraints, obstacle_bounds(2,i-23)+1000*(eta(2)-1) <=z(i)<= obstacle_bounds(3,i-23)+1000*eta(2)];
    end
% 
%     % 障碍物3的约束
%     for i = 33:51
%       Constraints = [Constraints, obstacle_bounds(2,i+32)+1000*(eta(3)-1) <=z(i)<= obstacle_bounds(3,i+32)+1000*eta(3)];
%     end
    

    Constraints = [Constraints, z(1)==0, z(101) == yf, xone == 1];


    % Define an objective
    Objective = 1.1/5 * sum(z(304:404));

    % Set some options for YALMIP and solver
    options = sdpsettings('solver','mosek');
    sol = optimize(Constraints,Objective,options);
    
    
    % Analyze error flags
    if sol.problem == 0
        delta1 = value(z(304:404));
        %value(eta)
        
    else
     disp('Hmm, something went wrong!');
     sol.info
     yalmiperror(sol.problem)
    end

    % 判断是否收敛
    if max(abs(delta1 - delta0)) <= 0.01
        break
    end
    
    delta0 = delta1;
        
end

theta = atan(value(z(102:202)));
u = value(z(203:303));
delta = value(z(304:404));

t = zeros(101,1);
for i = 2:101
deltat = 1.1./(v.*cos(theta));
t(i) = t(i-1) + deltat(i);
end
omega = v.*u./delta.^3;

% 轨迹
figure(1)
plot(0:1.1:110,value(z(1:101)),'g--', 'LineWidth', 2)   % g--
hold on
legend('Algorithm 1')
xlabel('X (m)')
ylabel('Y (m)')

% 控制
figure(2)
plot(t,omega*180/pi, 'g--','LineWidth', 2)
hold on
xlabel('t (s)')
ylabel('角速度 (deg/s)')
legend('Algorithm 1')

% 角度
figure(3)
plot(t,theta*180/pi, 'g--','LineWidth', 2)
hold on
xlabel('t (s)')
ylabel('角度 (deg)')
legend('Algorithm 1')




