% 传入person_line为两个人人的基准线点斜式，point_target为待求高度的点，maskt为建筑物的掩膜
% 输出point为两个点，各列为[x, y]，各行为各个点
% 输出line为[k, b]，表示建筑物测量线点斜式
% 输出vanish_point为垂直方向的灭点
function [point line vanish_point] = arcMeasure(person1_line,person2_line,point_target,maskt)
%求出垂直地面方向的灭点
[H,W,~] = size(maskt);
v_x = (person2_line(2)-person1_line(2))/(person1_line(1)-person2_line(1));  
v_y = person1_line(1)*v_x+person1_line(2);
vanish_point = [v_x , v_y];
%建筑物测量线为灭点和待测点的交点
k = (v_y-point_target(2))/(v_x-point_target(1));
b = v_y - (point_target(2)-v_y)*v_x/(point_target(1)-v_x);
line=[k,b];
%建筑物的另一个点为测量线与掩膜的交点
    maxX2 = 0;
    minX2 = 0;
    maxY2 = 0;
    minY2 = 0;
    b = -b / k;
    k = 1 / k;
    for y = 1: H
        x = k*y + b;
        if round(x) > 0 && round(x) <= W && maskt(y, round(x))
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
    point=[maxX2,maxY2]; 

end

