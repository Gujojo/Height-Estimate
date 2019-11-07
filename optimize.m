% 从点列中选取偏移最大的点，用于优化
function index = optimize(points)
    n = size(points, 1);
    dis = zeros(n, 1);
    for i = 1: n
        dis(i) = GroupVar(points([1: i-1, i+1: end], : ));
    end
    [~, index] = min(dis);
end