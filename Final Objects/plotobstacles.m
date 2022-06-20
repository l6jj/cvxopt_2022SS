function plotobstacles(ob)
    figure
    hold on;
    
    for i = 1 : size(ob, 2)
        o = ob(i);
        b = o.boundary;
        plot(b(:, 1), b(:, 2), 'k', 'LineWidth', 2);
        text(o.ox, o.oy, num2str(i));
    end
    
    xlabel('x/m', 'Interpreter','latex');
    ylabel('y/m','Interpreter','latex');
    axis equal
    title('Obstacles','Interpreter','latex');
    set(gca, 'fontsize', 15);
    hold off
end