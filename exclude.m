function index = exclude(lines)
    var = zeros(length(lines), 1, 'double');
    for i = 1: length(lines)
        tmp = lines;
        tmp(i, :) = [];
        points = [];
        for m = 1: length(tmp)-1
            for n = m+1: length(tmp)
                 [tmpx, tmpy] = SolvePt(tmp(m, :),tmp(n, :));
                 points = [points; [tmpx, tmpy]];
            end
        end
        var(i) = GroupVar(points);
    end
    [~, index] = min(var);
end