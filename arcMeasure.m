% ����person_lineΪ�������˵Ļ�׼�ߵ�бʽ��point_targetΪ����߶ȵĵ㣬masktΪ���������Ĥ
% ���pointΪ�����㣬����Ϊ[x, y]������Ϊ������
% ���lineΪ[k, b]����ʾ����������ߵ�бʽ
% ���vanish_pointΪ��ֱ��������
function [point line vanish_point] = arcMeasure(person1_line,person2_line,point_target,maskt)
%�����ֱ���淽������
[H,W,~] = size(maskt);
v_x = (person2_line(2)-person1_line(2))/(person1_line(1)-person2_line(1));  
v_y = person1_line(1)*v_x+person1_line(2);
vanish_point = [v_x , v_y];
%�����������Ϊ���ʹ����Ľ���
k = (v_y-point_target(2))/(v_x-point_target(1));
b = v_y - (point_target(2)-v_y)*v_x/(point_target(1)-v_x);
line=[k,b];
%���������һ����Ϊ����������Ĥ�Ľ���
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

