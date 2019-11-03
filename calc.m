%传入vanish_line为地表灭线点斜式，point为人的两点，person_height为人的高度，arc_point为建筑物底点，point_target为建筑物顶点,arc_line为测量线
function height = calc(vanish_line,point,person_height,arc_point,point_target,arc_line,vanish_point)
%%计算人和建筑物底点连线和地表灭线的交点，即灭点
%默认人靠近地面的那个点在第二行
hold on;
k=(point(2,2)-arc_point(2))/(point(2,1)-arc_point(1));
b = point(2,2) - (arc_point(2)-point(2,2))*point(2,1)/(arc_point(1)-point(2,1));
v_x = (b-vanish_line(2))/(vanish_line(1)-k);  
v_y = vanish_line(1)*v_x+vanish_line(2);
scatter(v_x,v_y,'b');
%%计算灭点和人顶点连线和建筑物测量线的交点
k=(point(1,2)-v_y)/(point(1,1)-v_x);
b = point(1,2) - (v_y-point(1,2))*point(1,1)/(v_x-point(1,1));
p_x = (b-arc_line(2))/(arc_line(1)-k);  
p_y = arc_line(1)*p_x+arc_line(2);
scatter(p_x,p_y,'b');
%%根据交比计算出建筑物高度
%H=R*(t-b)/(r-b)*(vz-r)/(vz-t)
height=person_height*abs((point_target(2)-arc_point(2))/(p_y-arc_point(2))*(vanish_point(2)-p_y)/(vanish_point(2)-point_target(2)));
%height=person_height*abs((point_target(1)-arc_point(1))/(p_x-arc_point(1))*(vanish_point(1)-p_x)/(vanish_point(1)-point_target(1)));

end

