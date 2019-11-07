function test(jpg, img,mask_ground,mask_target,mask_person1,...\
    mask_person2,ref_height1,ref_height2,point_target,lines)
    %% 绘制示意图部分，可以删去
    figure;
    imshow(img);
    hold on;
    set(gca,'YDir','reverse');
    for i = 1: 2
        points = jpg.shapes(i).points;
        scatter(points(: , 1), points(: , 2),'k', 'linewidth', 2);
    end
    for i = 5: length(jpg.shapes)
        pointx = jpg.shapes(i).points(:, 1);
        pointy = jpg.shapes(i).points(:, 2);
        plot(pointx, pointy, 'linewidth', 2);
    end
    
    H = size(img, 1);
    W = size(img, 2);
    
    %% 添加部分
    vanish_line=VanishLine(lines);
    refline(vanish_line(1), vanish_line(2));
    [point1,line1] = fitPerson(img, 1, mask_person1);
    [point2,line2] = fitPerson(img, 1, mask_person2);
    scatter(point1(:, 1), point1(:, 2),'b');
    plot(point1(:, 1), point1(:, 2), 'linewidth', 5);
    scatter(point2(:, 1), point2(:, 2),'b');
    plot(point2(:, 1), point2(:, 2), 'linewidth', 5);
%     [arc_point,arc_line,vanish_point]=arcMeasure(line1,line2,point_target,mask_target);
    [arc_point,arc_line,vanish_point]=arcMeasure(line1,line2,point_target,mask_ground);
    %画出建筑物测量点及建筑物测量线
%     scatter(vanish_point(1),vanish_point(2),'b');
    scatter(arc_point(1),arc_point(2),'b');
     scatter(point_target(1),point_target(2),'b');
     plot([arc_point(1),point_target(1)],[arc_point(2),point_target(2)]);
     height1 = calc(vanish_line,point1,ref_height1,arc_point,point_target,arc_line,vanish_point)
     height2 = calc(vanish_line,point2,ref_height2,arc_point,point_target,arc_line,vanish_point)
    %% 绘图部分
    axis equal;
    set(gca, 'ylim', [0, H]);
    set(gca, 'xlim', [0, W]);
%     cftool;
end
