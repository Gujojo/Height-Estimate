% ��points��ѡȡk*n�������ų�
function point = Refine(points, k)
    cnt = 0;
    n = size(points, 1);
    while cnt < floor(n*k)
        m = optimize(points);
        points(m, : ) = [];  % ɾ���õ�
        cnt = cnt+1;
    end
    point = mean(points);
end