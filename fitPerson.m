% 传入img为图像，pos为judge函数输出，maskp为该人的掩膜
% 输出point为两个点，各列为[x, y]，各行为各个点
% 输出line为[k, b]，表示人的基准线点斜式
function [point, line] = fitPerson(img, pos, maskp)
%% 初始化
    H = size(img, 1);
    W = size(img, 2);
    [B, ~] = bwboundaries(maskp, 'noholes');  % 求出mask的包络
    Boundary = B{1, 1};
    py = Boundary(:, 1);
    px = Boundary(:, 2);
    % 根据judge函数判断的图片方位进行最小二乘拟合
    switch pos
        case 1
            tmp = polyfit(py, px, 1);
            k = 1 / tmp(1);
            b = -tmp(2) / tmp(1);
        case 2
            tmp = polyfit(px, py, 1);
            k = tmp(1);
            b = tmp(2);
        case 3
            tmp = polyfit(py, px, 1);
            k = 1 / tmp(1);
            b = -tmp(2) / tmp(1);
        case 4
            tmp = polyfit(px, py, 1);
            k = tmp(1);
            b = tmp(2);
        otherwise
            error("Invalid pos");
    end
    
    % 利用初期拟合结果旋转人形，进一步拟合减小误差
    for i = 1: 5
        theta = atan(k);
        if theta < 0
            theta = theta + pi;
        end
        [k, b] = refit(pos, Boundary, pi/2-theta);
    end
    % 记录
    line = [k, b];
%% 由于一般斜率比较大，所以遍历y方向求边界点
    maxX2 = 0;
    minX2 = 0;
    maxY2 = 0;
    minY2 = 0;
    % 化为x = k*y + b的形式
    b = -b / k;
    k = 1 / k;
    for y = 1: H
        x = k*y + b;
        if round(x) > 0 && round(x) <= W && maskp(y, round(x))
            if ~minY2  % 没有记录过
                minX2 = round(x);
                minY2 = y;
            end
            if y > maxY2
                maxX2 = round(x);
                maxY2 = y;
            end
        end
    end
    
    point = [minX2, minY2; maxX2, maxY2];
    
    %% 绘图debug部分
%     figure;
%     hold on;
%     scatter(px, py);
%     scatter(point(:, 1), point(:, 2),'b');
%     plot(point(:, 1), point(:, 2));
%     axis equal;
%     set(gca, 'ylim', [0, 1440]);
%     set(gca, 'xlim', [0, 1080]);
%     set(gca,'YDir','reverse');
    
end