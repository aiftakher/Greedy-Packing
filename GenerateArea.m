function area = GenerateArea(L1, L2, L3, L4)
area = 0;
if(isempty(L1) == 0 && length(L1(1,:)) >= 2)
    area = area - trapz(L1(1,:),L1(2,:));
end
if(isempty(L2) == 0 && length(L2(1,:)) >= 2)
    area = area + trapz(L2(1,:),L2(2,:));
end
if(isempty(L3) == 0 && length(L3(1,:)) >= 2)
    area = area + trapz(L3(1,:),L3(2,:));
end
if(isempty(L4) == 0 && length(L4(1,:)) >= 2)
    area = area + trapz(L4(1,:),L4(2,:));
end

if area < 0
    area = area * (-1);
end

