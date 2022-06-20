classdef Obstacle
    properties
        ox
        oy
        ra
        rb
        gamma
    end
    methods
        function obj = Obstacle(ox_, oy_, ra_, rb_, g_)
            if nargin == 3
                rb_ = ra_;
                g_ = 0;
            elseif nargin == 4
                g_ = 0;
            end
            obj.ox = ox_;
            obj.oy = oy_;
            obj.ra = ra_;
            obj.rb = rb_;
            obj.gamma = deg2rad(g_);
        end
        function [flag, y_max, y_min] = intersect(obj, x)
            R = [cos(obj.gamma) -sin(obj.gamma); sin(obj.gamma) cos(obj.gamma)];
            r = [1 / obj.ra ^ 2, 0; 0, 1 / obj.rb ^ 2];
            syms inter_y real;
            p = [x - obj.ox; inter_y - obj.oy];
            sol = solve((R' * p)' * r * (R' * p) == 1, inter_y);
            flag = size(sol, 1) > 0;
            y_max = 0;
            y_min = 0;
            if size(sol, 1) > 0
                y_max = double(max(sol));
                y_min = double(min(sol));
            end
        end
        function b = boundary(obj)
            t = linspace(0, 2 * pi);
            xx = obj.ra * cos(t);
            yy = obj.rb * sin(t);
            R = [cos(obj.gamma) -sin(obj.gamma); sin(obj.gamma) cos(obj.gamma)];
            b = [xx' yy'] * R';
            b(:, 1) = b(:, 1) + obj.ox;
            b(:, 2) = b(:, 2) + obj.oy;
        end
    end
end