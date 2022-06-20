function plotit(res, op)
    arguments
        res
        op.ThetaLegend = 'off'
        op.OmegaLegend = 'off'
    end
    figure
    hold on;
    
    for i = 1 : res{1, 1}.m
        o = res{1, 1}.obstacles(i);
        b = o.boundary;
        plot(b(:, 1), b(:, 2), 'k', 'LineWidth', 2);
        text(o.ox, o.oy, num2str(i));
    end
    
    for i = 1 : size(res, 2)
        p(i) = plot(res{1, i}.x(:, end), res{1, i}.y(:, end), 'LineWidth', 3);
        plot([res{1, i}.x(1, end) res{1, i}.x(end, end)], ...
             [res{1, i}.y(1, end) res{1, i}.y(end, end)], ...
            'bo','MarkerSize', 8, 'LineWidth', 2.5);
        lgd{i} = ['$ \rm \#' num2str(i) '$'];
    end
    legend(p, lgd ,'Location','best','Interpreter','latex', 'NumColumns', 2);
    xlabel('x/m', 'Interpreter','latex');
    ylabel('y/m','Interpreter','latex');
    axis equal
    title('UAV Trajectory','Interpreter','latex');
    set(gca, 'fontsize', 15);
    hold off;

    figure
    subplot(2, 1, 1);
    hold on;
    for i = 1 : size(res, 2)
        p(i) = plot(res{1, i}.t(:, end), res{1, i}.theta(:, end), 'LineWidth', 3);
    end
    xlabel('{\rm Time}/s', 'Interpreter','latex');
    ylabel('$\theta/\circ$','Interpreter','latex');
    if strcmp(op.ThetaLegend, 'on')
        legend(p, lgd ,'Location','north','Interpreter','latex', 'NumColumns', 2);
    end
    axis tight
    set(gca, 'fontsize', 15);

    subplot(2, 1, 2);
    hold on;
    for i = 1 : size(res, 2)
        p(i) = plot(res{1, i}.t(1 : end - 1, end), res{1, i}.omega(1 : end - 1, end), '-', 'LineWidth', 3);
    end
    if strcmp(op.OmegaLegend, 'on')
        legend(p, lgd ,'Location','north','Interpreter','latex', 'NumColumns', 2);
    end
    xlabel('${\rm Time}/s$', 'Interpreter','latex');
    ylabel('$\omega/\circ\cdot s^{-1}$','Interpreter','latex');
    axis tight
    set(gca, 'fontsize', 15);


    figure
    hold on

    id = 1;
    for i = 1 : size(res, 2)
        if size(res{1, i}.y, 2) >= size(res{1, id}.y, 2)
            id = i;
        end
    end
    for i = 1 : res{1, 1}.m
        o = res{1, 1}.obstacles(i);
        b = o.boundary;
        plot(b(:, 1), b(:, 2), 'k', 'LineWidth', 2);
        text(o.ox, o.oy, num2str(i));
    end
    for i = 1 : size(res{1, id}.y, 2)
        p_iter(i) = plot(res{1, id}.x(:, i), res{1, id}.y(:, i), 'LineWidth', 3);
        plot([res{1, id}.x(1, i) res{1, id}.x(end, i)], ...
             [res{1, id}.y(1, i) res{1, id}.y(end, i)], ...
            'bo','MarkerSize', 8, 'LineWidth', 2.5);
        lgd_iter{i} = ['$\rm Iter\ \#' num2str(i) '$'];
    end
    legend(p_iter, lgd_iter ,'Location','best','Interpreter','latex', 'NumColumns', 2);
    xlabel('x/m', 'Interpreter','latex');
    ylabel('y/m','Interpreter','latex');
    axis equal
    title(['$\rm UAV\ Trajectory\ in\ Task\ \# ' num2str(id) '$'],'Interpreter','latex');
    set(gca, 'fontsize', 15);
    hold off;

end