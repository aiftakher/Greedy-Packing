function [] = PrintShape(L1,L2,L3,L4)
hold on
if(isempty(L1) == 0)
    plot(L1(1,:), L1(2,:))
    hold on
end
if(isempty(L2) == 0)
    plot(L2(1,:), L2(2,:))
    hold on
end
if(isempty(L3) == 0) 
    plot(L3(1,:), L3(2,:))
    hold on
end
if(isempty(L4) == 0) 
    plot(L4(1,:), L4(2,:))
end

hold on