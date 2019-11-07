function point = Refine(points, k)
    cnt = 0;
    n = size(points, 1);
%     figure;
%     stem(points(:, 1), points(:, 2));
    while cnt < floor(n*k)
        m = optimize(points);
        points(m, : ) = [];
        cnt = cnt+1;
%         clf;
%         stem(points(:, 1), points(:, 2));
    end
    point = mean(points);
end