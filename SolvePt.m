% 解两条直线的交点
function [x,y] = SolvePt(line1, line2)
    temp = line1(1)*line2(2) - line2(1)* line1(2);
    x = (line1(2)*line2(3) - line2(2)*line1(3))/ temp;
    y = (line2(1)*line1(3) - line1(1)*line2(3))/ temp;
