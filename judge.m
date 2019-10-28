% 判断图片方向，1234分别表示地面在下方，左方，上方和右方；
function [dir] = judge(mask_ground)
    [height,width] = size(mask_ground);
    H = uint8(height/2);
    W = uint8(width/2);
    count1 = 0;
    count2 = 0;
    count3 = 0;
    count4 = 0;
    %count1 = sum(sum(mask_ground(H:end, :)));
    for i = 1:height
        for k = 1:width
            if(i<=H && mask_ground(i,k)=='1')
                count3 = count3 + 1;
            elseif mask_ground(i,k)==1
                count1 = count1 + 1;
            end
            if(k<=W && mask_ground(i,k)=='1')
                count2 = count2 + 1;
            elseif mask_ground(i,k)==1
                count4 = count4 + 1;
            end
        end
    end
    if max([count1,count2,count3,count4]) == count1 
        dir = 1;
    elseif max([count1,count2,count3,count4]) == count2
        dir = 2;
    elseif max([count1,count2,count3,count4]) == count3
        dir = 3;
    elseif max([count1,count2,count3,count4]) == count4
        dir = 4;
    else
        dir = 0;
    end
            