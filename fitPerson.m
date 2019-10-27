% 传入img为图像，pos为judge函数输出，maskp为该人的掩膜
% 输出point为两个点，各列为[x, y]，各行为各个点
% 输出line为[k, b]，表示人的基准线点斜式
function [point, line] = fitPerson(img, pos, maskp)
    H = size(img, 1);
    W = size(img, 2);
    [B, ~] = bwboundaries(maskp, 'noholes');
    Boundary = B{1, 1};
    py = Boundary(:, 1);
    px = Boundary(:, 2);
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
    
    line = [k, b];
    
%% 遍历x方向求边界点，由于斜率一般比较大，精度不好
%     maxX1 = 0;
%     minX1 = 0;
%     maxY1 = 0;
%     minY1 = 0;
%     for x = 1: W
%         y = k*x + b;
%         if round(y) > 0 && round(y) <= H && maskp(round(y), x)
%             if ~minX1
%                 minX1 = x;
%                 minY1 = round(y);
%             end
%             if x > maxX1
%                 maxX1 = x;
%                 maxY1 = round(y);
%             end
%         end
%     end
%     point = [minX1, minY1; maxX1, maxY1];
%     figure;
%     hold on;
%     scatter(px, py);
%     scatter(point(:, 1), point(:, 2),'b');
%     plot(point(:, 1), point(:, 2));
%     axis equal;
%     set(gca, 'ylim', [0, 1440]);
%     set(gca, 'xlim', [0, 1080]);
%     set(gca,'YDir','reverse');

%% 遍历y方向求边界点
    maxX2 = 0;
    minX2 = 0;
    maxY2 = 0;
    minY2 = 0;
    b = -b / k;
    k = 1 / k;
    for y = 1: H
        x = k*y + b;
        if round(x) > 0 && round(x) <= W && maskp(y, round(x))
            if ~minY2
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