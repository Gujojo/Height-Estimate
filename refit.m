function [k1, b1] = refit(pos, Boundary, theta)
    px = Boundary(:, 1);
    py = Boundary(:, 2);
    x = px*cos(theta) - py*sin(theta);
    y = px*sin(theta) + py*cos(theta);
    y = px*cos(theta) + py*sin(theta);
    x = -px*sin(theta) + py*cos(theta);
%     scatter(x, y);
    switch pos
        case 1
            tmp = polyfit(y, x, 1);
            k = 1 / tmp(1);
            b = -tmp(2) / tmp(1);
        case 2
            tmp = polyfit(x, y, 1);
            k = tmp(1);
            b = tmp(2);
        case 3
            tmp = polyfit(y, x, 1);
            k = 1 / tmp(1);
            b = -tmp(2) / tmp(1);
        case 4
            tmp = polyfit(x, y, 1);
            k = tmp(1);
            b = tmp(2);
        otherwise
            error("Invalid pos");
    end
    k1 = (k*cos(theta)-sin(theta)) / (k*sin(theta)+cos(theta));
    b1 = b / (k*sin(theta)+cos(theta));
end