function [coef] = VanishLine(lines)
    [L,W] = size(lines);
%     x = zeros(L,1);
%     y = zeros(L,1);
    k = (lines(:,1)./lines(:,2))*(-1);    
    index = 1:1:L;
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
    %point中为斜率相邻的两直线的交点
    point = zeros(L,2);
    for m = 1:L
        if m==L
            [point(L,1),point(L,2)] = SolvePt(lines(index(L),:),lines(index(1),:));
        else
            [point(m,1),point(m,2)]= SolvePt(lines(index(m),:),lines(index(m+1),:));
        end
    end
    minDis = 9999999.0;
    minP = [0,0];
    for m = 1:L-1
        for n = m+1:L
            temp = point;
            temp(n,:) = [];
            temp(m,:) = [];  %删除两个交点
            p = polyfit(temp(:,1),temp(:,2),1);
%             [y_fit,delta] = polyval(p,temp(:,1),S);
            y_fit = polyval(p,temp(:,1));
            delta = (y_fit - temp(:,2))'*(y_fit - temp(:,2));
            if delta < minDis
                minDis = delta;
                minP = p;
            end
        end
    end
    coef = minP;
            
     
%     %分界线
%     avg = (k(index(1))+k(index(L)))/2;
%     sep = 0;
%     % 第sep个元素为分界（即第一组有sep条线）
%     for m = 1:L
%         if k(index(m))<=avg
%             sep = m-1;
%             break
%         end
%     end
%     count = 1;
%     for m = 1:sep-1
%         for n = m+1:sep
%             [x(count,1),y(count,1)] = SolvePt(lines(index(m),:),lines(index(n),:));
%             count = count+1;
%         end
%     end
%     for m = sep+1:L-1
%         for n = m+1:L
%             [x(count,1),y(count,1)] = SolvePt(lines(index(m),:),lines(index(n),:));
%             count = count+1;
%         end
%     end
% 
%     p = polyfit(x,y,1);