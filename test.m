function test(jpg, img,mask_ground,mask_target,mask_person1,...\
    mask_person2,ref_height1,ref_height2,point_target,lines)
    %% 绘制示意图部分，可以删去
    figure;
    hold on;
    set(gca,'YDir','reverse');
    for i = 1: 4
        points = jpg.shapes(i).points;
        scatter(points(: , 1), points(: , 2),'k');
    end
    for i = 5: length(jpg.shapes)
        pointx = jpg.shapes(i).points(:, 1);
        pointy = jpg.shapes(i).points(:, 2);
        plot(pointx, pointy);
    end
    
    H = size(img, 1);
    W = size(img, 2);
    
    %% 添加部分
    point1 = fitPerson(img, 1, mask_person1);
    point2 = fitPerson(img, 1, mask_person2);
    scatter(point1(:, 1), point1(:, 2),'b');
    plot(point1(:, 1), point1(:, 2));
    scatter(point2(:, 1), point2(:, 2),'b');
    plot(point2(:, 1), point2(:, 2));

    
    
    %% 绘图部分
    axis equal;
    set(gca, 'ylim', [0, H]);
    set(gca, 'xlim', [0, W]);
%     cftool;
end
