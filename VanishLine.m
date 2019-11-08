function [coef] = VanishLine(lines)
    [L, W] = size(lines);
%     x = zeros(L,1);
%     y = zeros(L,1);
    k = (lines(:,1)./lines(:,2))*(-1);    
    index = 1:L;
%     %斜率化为角度制
%     k = atan(k);
%     for m = 1:L
%         if k(m)<0
%            k(m) = k(m)+pi/2;
%         end
%     end   

    %对斜率排序，index中为斜率从大到小的索引值
    for m = 1:L-1
        for n = m+1:L
            if k(index(n))>k(index(m))
                temp = index(n);
                index(n) = index(m);
                index(m) = temp;
            end
        end
    end
    
    temp = [];
    
    for m = 1:L
        temp(m,:) = lines(index(m), :);
    end
    lines = temp;
    
    %% 去重
    %若两条直线的相角差小于delta,则去掉其中的一条直线
    delta = pi/180;
    phi = atan((lines(:,1)./lines(:,2))*(-1));
    temp_phi = [phi(2: end); phi(1)];
    delta_phi = abs(phi-temp_phi); %相邻直线的相角差
    lines(delta_phi < delta, : ) = [];
    
    L = size(lines, 1);
    %% 分组
    point = zeros(L,2);
    for m = 1: L-1
        [point(m,1),point(m,2)]= SolvePt(lines(m,:),lines(m+1,:));
    end
    % point中存放相邻直线的交点
    [point(L,1),point(L,2)] = SolvePt(lines(L,:),lines(1,:));
%     stem(point(:, 1), point(:, 2));
    minDis = 1e8;
    minM = 0;
    minN = 0;
    minP = [0,0];
    for m = 1:L-1
        for n = m+1:L
            line1_index = [m+1: n-1]; %第一组点
            line2_index = [1: m-1, n+1: L]; %第二组点
            dis1 = GroupVar(point(line1_index, : ))...
                /sum(mean(point(line1_index, : )).^2); %第一组点的归一化均方差
            dis2 = GroupVar(point(line2_index, : ))...
                /sum(mean(point(line2_index, : )).^2); %第二组点的归一化均方差
            dis = dis1+dis2;
            if dis < minDis
                minDis = dis;
                minM = m;
                minN = n;
            end
        end
    end
    
    %% 拟合
    line1_index = [minM+1: minN]; %第一组直线
    line2_index = [1:minM, minN+1: L]; %第二组直线

%     for m = 1: length(line1_index)
%         tmp = lines(line1_index(m),:);
%         tmpk = -tmp(1)/tmp(2);
%         tmpb = -tmp(3)/tmp(2);
%         refline(tmpk, tmpb);
%     end
    
    %分别取出两组直线的组内所有交点
    points1 = [];
    points2 = [];
    for m = 1: length(line1_index)-1
        for n = m+1: length(line1_index)
             [tmpx, tmpy] = SolvePt(lines(line1_index(m),:),lines(line1_index(n),:));
             points1 = [points1; [tmpx, tmpy]];
        end
    end
%     stem(points1(:, 1), points1(:, 2));
    for m = 1: length(line2_index)-1
        for n = m+1: length(line2_index)
             [tmpx, tmpy] = SolvePt(lines(line2_index(m),:),lines(line2_index(n),:));
             points2 = [points2; [tmpx, tmpy]];
        end
    end
%     stem(points2(:, 1), points2(:, 2));
    
    %两组点中分别舍去n/2个点
    point1 = Refine(points1, 1/2);
    point2 = Refine(points2, 1/2);
    points = [point1; point2];
    coef = polyfit(points(: , 1), points(: , 2), 1);

end