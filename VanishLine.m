function [p] = VanishLine(lines)
    [L,W] = size(lines);
    x = zeros(L,1);
    y = zeros(L,1);
    k = (lines(:,1)./lines(:,2))*(-1);
    %斜率化为角度制
    k = atan(k);
%     for m = 1:L
%         if k(m)<0
%            k(m) = k(m)+pi/2;
%         end
%     end
    index = 1:1:L;
    %对倾斜角排序，index中为倾斜角从大到小的索引值
    for m = 1:L-1
        for n = m+1:L
            if k(index(n))>k(index(m))
                temp = index(n);
                index(n) = index(m);
                index(m) = temp;
            end
        end
    end
    %分界线
    avg = (k(index(1))+k(index(L)))/2;
    sep = 0;
    % 第sep个元素为分界（即第一组有sep条线）
    for m = 1:L
        if k(index(m))<=avg
            sep = m-1;
            break
        end
    end
    count = 1;
    for m = 1:sep-1
        for n = m+1:sep
            [x(count,1),y(count,1)] = SolvePt(lines(index(m),:),lines(index(n),:));
            count = count+1;
        end
    end
    for m = sep+1:L-1
        for n = m+1:L
            [x(count,1),y(count,1)] = SolvePt(lines(index(m),:),lines(index(n),:));
            count = count+1;
        end
    end
%     [x(1,1),y(1,1)] = SolvePt(lines(1,:),lines(2,:));
%     [x(2,1),y(2,1)] = SolvePt(lines(1,:),lines(3,:));
%     [x(3,1),y(3,1)] = SolvePt(lines(2,:),lines(3,:));
% 
%     [x(4,1),y(4,1)] = SolvePt(lines(4,:),lines(5,:));
%     [x(5,1),y(5,1)] = SolvePt(lines(4,:),lines(6,:));
%     [x(6,1),y(6,1)] = SolvePt(lines(5,:),lines(6,:));

    p = polyfit(x,y,1);