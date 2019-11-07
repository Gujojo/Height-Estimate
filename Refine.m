% 从points中选取k*n个进行排除
function point = Refine(points, k)
    cnt = 0;
    n = size(points, 1);
    while cnt < floor(n*k)
        m = optimize(points);
        points(m, : ) = [];  % 删除该点
        cnt = cnt+1;
    end
    point = mean(points);
end