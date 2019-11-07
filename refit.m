% 根据已知的图片方向pos和边，Boundary和矫正角度调整拟合
% 输出修正后的斜率k和截距b
function [k1, b1] = refit(pos, Boundary, theta)
    px = Boundary(:, 1);
    py = Boundary(:, 2);
    % 求旋转后的边界坐标
    y = px*cos(theta) + py*sin(theta);
    x = -px*sin(theta) + py*cos(theta);
    % 根据judge函数判断的图片方位进行最小二乘拟合
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
    % 将k和b反向旋转回去
    k1 = (k*cos(theta)-sin(theta)) / (k*sin(theta)+cos(theta));
    b1 = b / (k*sin(theta)+cos(theta));
end