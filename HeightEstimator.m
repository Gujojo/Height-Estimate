function height = HeightEstimator(img,mask_ground,mask_target,mask_person1,...\
    mask_person2,ref_height1,ref_height2,point_target,lines)
%% ����ʾ��ͼ����
    figure;
    imshow(img);
    hold on;
    set(gca,'YDir','reverse');  % y�ᷴ�򣬱��ڹ۲�
    H = size(img, 1);
    W = size(img, 2);
    
%% ����������
%     for i = 1: 2
%         points = jpg.shapes(i).points;
%         scatter(points(: , 1), points(: , 2),'k', 'linewidth', 2);
%     end
%     for i = 5: length(jpg.shapes)
%         pointx = jpg.shapes(i).points(:, 1);
%         pointy = jpg.shapes(i).points(:, 2);
%         plot(pointx, pointy, 'linewidth', 2);
%     end

%% �����ƽ������
    pos = judge(mask_ground);
    vanish_line=VanishLine(lines,img);
    vline = refline(vanish_line(1), vanish_line(2));
    vline.LineWidth = 3;
%% ������С���˷�����˵���ֱ���Լ�ͷ������
    [point1,line1] = fitPerson(img, pos, mask_person1);
    [point2,line2] = fitPerson(img, pos, mask_person2);
    % ������Ͻ��
    scatter(point1(:, 1), point1(:, 2),'b');
    plot(point1(:, 1), point1(:, 2), 'linewidth', 2);
    scatter(point2(:, 1), point2(:, 2),'b');
    plot(point2(:, 1), point2(:, 2), 'linewidth', 2);
    
%% ����ǰ�������ȡ������߶�
    [arc_point,arc_line,vanish_point]=arcMeasure(line1,line2,point_target,mask_ground);
    % ��������������㼰�����������
    scatter(arc_point(1),arc_point(2),'b');
    scatter(point_target(1),point_target(2),'b');
    plot([arc_point(1),point_target(1)],[arc_point(2),point_target(2)], 'linewidth', 2);
    % �ֱ�������������ȡ������߶�
    height1 = calc(vanish_line,point1,ref_height1,arc_point,point_target,arc_line,vanish_point);
    height2 = calc(vanish_line,point2,ref_height2,arc_point,point_target,arc_line,vanish_point);
    
    % �������߶Ƚ�����Ч���жϣ������Ч���ƽ��ֵ
    hLim = [2, 200];
    htmp = [];
    if height1 > hLim(1) && height1 < hLim(2)
        htmp = [htmp, height1];
    end
    if height2 > hLim(1) && height2 < hLim(2)
        htmp = [htmp, height2];
    end
    height = mean(htmp);
    disp(height);
    
%% ��ͼ���ò���
    axis equal;
    set(gca, 'ylim', [0, H]);
    set(gca, 'xlim', [0, W]);

end
