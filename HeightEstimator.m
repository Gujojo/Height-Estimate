function height = HeightEstimator(img,mask_ground,mask_target,mask_person1,...\
    mask_person2,ref_height1,ref_height2,point_target,lines)
%% 绘制示意图部分
    figure;
    imshow(img);
    hold on;
    set(gca,'YDir','reverse');  % y轴反向，便于观察
    H = size(img, 1);
    W = size(img, 2);
    
%% 绘制轮廓点
%     for i = 1: 2
%         points = jpg.shapes(i).points;
%         scatter(points(: , 1), points(: , 2),'k', 'linewidth', 2);
%     end
%     for i = 5: length(jpg.shapes)
%         pointx = jpg.shapes(i).points(:, 1);
%         pointy = jpg.shapes(i).points(:, 2);
%         plot(pointx, pointy, 'linewidth', 2);
%     end

%% 求出地平面灭线
    pos = judge(mask_ground);
    vanish_line=VanishLine(lines,img);
    vline = refline(vanish_line(1), vanish_line(2));
    vline.LineWidth = 3;
%% 利用最小二乘法求出人的竖直线以及头脚两点
    [point1,line1] = fitPerson(img, pos, mask_person1);
    [point2,line2] = fitPerson(img, pos, mask_person2);
    % 绘制拟合结果
    scatter(point1(:, 1), point1(:, 2),'b');
    plot(point1(:, 1), point1(:, 2), 'linewidth', 2);
    scatter(point2(:, 1), point2(:, 2),'b');
    plot(point2(:, 1), point2(:, 2), 'linewidth', 2);
    
%% 利用前述结果求取建筑物高度
    [arc_point,arc_line,vanish_point]=arcMeasure(line1,line2,point_target,mask_ground);
    % 画出建筑物测量点及建筑物测量线
    scatter(arc_point(1),arc_point(2),'b');
    scatter(point_target(1),point_target(2),'b');
    plot([arc_point(1),point_target(1)],[arc_point(2),point_target(2)], 'linewidth', 2);
    % 分别利用两个人求取建筑物高度
    height1 = calc(vanish_line,point1,ref_height1,arc_point,point_target,arc_line,vanish_point);
    height2 = calc(vanish_line,point2,ref_height2,arc_point,point_target,arc_line,vanish_point);
    
    % 对两个高度进行有效性判断，如果有效输出平均值
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
    
%% 绘图设置部分
    axis equal;
    set(gca, 'ylim', [0, H]);
    set(gca, 'xlim', [0, W]);

end
