function ret = misocp(x_start, y_start, theta_start, x_end, y_end, theta_end, obstacles, options)
    arguments
        x_start
        y_start
        theta_start
        x_end
        y_end
        theta_end
        obstacles
        options.Method = 'algo1'
        options.IterRes = 'off'
        options.Solver = 'Mosek'
    end
    x_0 = x_start;
    y_0 = y_start;
    theta_0 = deg2rad(theta_start);
    vartheta_0 = tan(theta_0);
    
    x_f = x_end;
    y_f = y_end;
    theta_f = deg2rad(theta_end);
    vartheta_f = tan(theta_f);
    
    m = size(obstacles, 2);
    for i = 1 : m
        o(i) = obstacles(i);
    end
    
    omega_max = deg2rad(20);
    V = 5;
    N = 101; 
    D = 1000;
    dx = (x_f - x_0) / (N - 1);
    

    y = sdpvar(N, 1);
    vartheta = sdpvar(N, 1);
    u = sdpvar(N, 1);
    delta = sdpvar(N, 1);
    x = sdpvar(N, 1);
    t = sdpvar(N, 1);
    eta = binvar(m, 1);
    
    delta_s = ones(N, 1);

    if strcmp(options.Method, 'algo1')
        iter_num = 10;
        delta_s = delta_s * 1.1;
    else
        iter_num = 1;
    end
    
    x_r = x_0 : dx : x_f;
    
    
    for count = 1 : iter_num
        fprintf('Iteration #%d...\n', count);
        F = (y(1) == y_0);
        F = F + (x(1) == x_0);
        F = F + (vartheta(1) == vartheta_0);
        F = F + (y(N) == y_f);
        F = F + (x(N) == x_f);
        F = F + (vartheta(N) == vartheta_f);
        F = F + (t(1) == 0);
        
        for i = 1 : N - 1
            F = F + (y(i + 1) == y(i) + vartheta(i) * dx);
            F = F + (vartheta(i + 1) == vartheta(i) + u(i) * dx);
            F = F + (x(i + 1) == x(i) + dx);
            F = F + (t(i + 1) == t(i) + delta(i) * dx / V);
        end
        
        for i = 1 : N
            F = F + (u(i) <= omega_max / V * ...
                (3 * delta_s(i) ^ 2 * delta(i) - 2 * delta_s(i) ^ 3));
            F = F + ((-u(i)) <= omega_max / V * ...
                (3 * delta_s(i) ^ 2 * delta(i) - 2 * delta_s(i) ^ 3));
        end
        
        for i = 1 : N
            F = F + (delta(i) >= sqrt(1 + vartheta(i) ^ 2));
        end
        
        for i = 1 : N
            for j = 1 : m
                [flag, y_max, y_min] = o(j).intersect(x_r(i));
                if flag
                    F = F + (y(i) >= y_max + D * (eta(j) - 1));
                    F = F + (y(i) <= y_min + D * eta(j));
                end
            end
        end
        opt = sdpsettings('verbose', 0, 'solver', options.Solver);
        solve = solvesdp(F, t(N), opt);

        if strcmp(options.IterRes, 'on')
            ret.y(:, count) = double(y);
            ret.x(:, count) = double(x);
            ret.delta(:, count) = double(delta);
            ret.vartheta(:, count) = double(vartheta);
            ret.theta(:, count) = rad2deg(atan(ret.vartheta(:, count)));
            ret.t(:, count) = double(t);
            ret.omega(:, count) = rad2deg(double(u) * V ./ double(delta) .^ 3);
        end

        if strcmp(options.Method, 'algo1')
            if max(abs(double(delta) - delta_s)) <= 1e-2
                fprintf('Converging! Exit!\n');
                break;
            end
        end


        delta_s = double(delta);
    end
    ret.algo = strcmp(options.Method, 'algo2') + 1;
    ret.N = N;
    ret.m = m;
    ret.obstacles = obstacles;
    if strcmp(options.IterRes, 'off')
        ret.y = double(y);
        ret.x = double(x);
        ret.delta = double(delta);
        ret.vartheta = double(vartheta);
        ret.theta = rad2deg(atan(ret.vartheta));
        ret.t = double(t);
        ret.omega = rad2deg(double(u) * V ./ double(delta) .^ 3);
    end

end