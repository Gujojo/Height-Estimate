%����vanish_lineΪ�ر����ߵ�бʽ��pointΪ�˵����㣬person_heightΪ�˵ĸ߶ȣ�arc_pointΪ������׵㣬point_targetΪ�����ﶥ��,arc_lineΪ������
function height = calc(vanish_line,point,person_height,arc_point,point_target,arc_line,vanish_point)
%%�����˺ͽ�����׵����ߺ͵ر����ߵĽ��㣬�����
%Ĭ���˿���������Ǹ����ڵڶ���
hold on;
k=(point(2,2)-arc_point(2))/(point(2,1)-arc_point(1));
b = point(2,2) - (arc_point(2)-point(2,2))*point(2,1)/(arc_point(1)-point(2,1));
v_x = (b-vanish_line(2))/(vanish_line(1)-k);  
v_y = vanish_line(1)*v_x+vanish_line(2);
scatter(v_x,v_y,'b');
%%���������˶������ߺͽ���������ߵĽ���
k=(point(1,2)-v_y)/(point(1,1)-v_x);
b = point(1,2) - (v_y-point(1,2))*point(1,1)/(v_x-point(1,1));
p_x = (b-arc_line(2))/(arc_line(1)-k);  
p_y = arc_line(1)*p_x+arc_line(2);
scatter(p_x,p_y,'b');
%%���ݽ��ȼ����������߶�
%H=R*(t-b)/(r-b)*(vz-r)/(vz-t)
height=person_height*abs((point_target(2)-arc_point(2))/(p_y-arc_point(2))*(vanish_point(2)-p_y)/(vanish_point(2)-point_target(2)));
%height=person_height*abs((point_target(1)-arc_point(1))/(p_x-arc_point(1))*(vanish_point(1)-p_x)/(vanish_point(1)-point_target(1)));

end

