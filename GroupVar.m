% 求一组点的均方差
function dis = GroupVar(points)
    if size(points, 1) == 0
        dis = 1e8;
        return;
    end
    X0 = mean(points(: , 1));
    Y0 = mean(points(: , 2));
    tmp = points-[X0, Y0];
    dis = sum(sum(tmp.^2));
end