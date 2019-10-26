function [px, py] = test(img, jpg)
    figure;
    hold on;
    set(gca,'YDir','reverse');
    for i = 1: 4
        points = jpg.shapes(i).points;
        for j = 1: size(points, 1)
            scatter(points(j, 1), points(j, 2),'k');
        end
    end
    for i = 5: 10
        pointx = jpg.shapes(i).points(:, 1);
        pointy = jpg.shapes(i).points(:, 2);
        plot(pointx, pointy);
    end
    
    H = size(img, 1);
    W = size(img, 2);
    
    maskp = poly2mask(jpg.shapes(4).points(:,1),...
        jpg.shapes(4).points(:,2), H, W);
    [B, ~] = bwboundaries(maskp, 'noholes');
    Boundary = B{1, 1};
    py = Boundary(:, 1);
    px = Boundary(:, 2);
    fitAns = polyfit(px, py, 1);
    maxX = 0;
    minX = 0;
    maxY = 0;
    minY = 0;
    for x = 1: W
        y = fitAns(1)*x+fitAns(2);
        if round(y) > 0 && round(y) < H && maskp(round(y), x)
            if ~minX
                minX = x;
                minY = round(y);
            end
            if x > maxX
                maxX = x;
                maxY = round(y);
            end
        end
    end
    scatter(minX, minY,'b');
    scatter(maxX, maxY,'b');
    plot([minX; maxX], [minY; maxY]);
    
    axis equal;
    set(gca, 'ylim', [0, 1440]);
    set(gca, 'xlim', [0, 1080]);
%     cftool;
end
