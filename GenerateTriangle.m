function [L1, L2, L3, L4]  = GenerateTriangle(xL, yL, lengthL, theta, H,rotate)
for i = 1:lengthL+1
    x1(i) = xL+i-1;
    y1(i) = yL;
end
%plot(x1,y1);
%hold on
xH = xL + H/tan(theta);
yH = yL + H;
%axis([0 10 0 10]);
%hold on

A = [xL xH]; %x
B = [yL yH]; %y
C = [xL+lengthL-1 xH]; %x
D = [yL yH]; %y
%plot(A,B);
%hold on
%line(A,B);
%line(C,D);
%hold on
%delx = xL - xH;
%dely = yL - yH;

v1 = [x1;y1];
v2 = [xH;yH];    
vr1 = rotateAboutPoint(v1,[xL,yL], rotate);
x1 = vr1(1,:);
y1 = vr1(2,:);
%plot(vr1(1,:),vr1(2,:)); %vr1 has two rows comprising x's and y's
%hold on
vr2 = rotateAboutPoint(v2,[xL,yL], rotate);
x2 = vr2(1,:);
y2 = vr2(2,:);
%plot(vr2(1,:),vr2(2,:));
%hold on
AA = [vr1(1,1) vr2(1,1)]; %x
BB = [vr1(2,1) vr2(2,1)]; %y
%plot(AA,BB);
%line(AA,BB);
%hold on
CC = [vr1(1,length(vr1(1,:))), vr2(1,length(vr2(1,:)))]; %x
DD = [vr1(2,length(vr1(1,:))), vr2(2,length(vr2(1,:)))]; %y
%plot(CC,DD);
%line(CC,DD);
%hold on
%v = fillline([2,4],[3 6],10)
if AA(1,1) == AA(1,2)
    id = 1;
    jump = (max(BB(1,2), BB(1,1)) - min(BB(1,2), BB(1,1)))/5;
    for i = min(BB(1,2), BB(1,1)): jump : max(BB(1,2), BB(1,1))
        x3(id) = AA(1,1);
        y3(id) = i;
        id = id + 1;
    end
else
    id = 1;
    jump = (max(AA(1,1), AA(1,2)) - min(AA(1,2), AA(1,1)))/5;
    X1 = AA(1,1); X2 = AA(1,2); Y1 = BB(1,1); Y2 = BB(1,2);
    for i = min(AA(1,2), AA(1,1)): jump : max(AA(1,2), AA(1,1))
        x3(id) = i;
        y3(id) = (((x3(id) - X1)*(Y1 - Y2))/(X1 - X2)) + Y1;
        id = id + 1;
    end
end

if CC(1,1) == CC(1,2)
    id = 1;
    jump = (max(DD(1,2), DD(1,1)) - min(DD(1,2), DD(1,1)))/5;
    for i = min(DD(1,2), DD(1,1)): jump : max(DD(1,2), DD(1,1))
        x4(id) = CC(1,1);
        y4(id) = i;
        id = id + 1;
    end
else
    id = 1;
    jump = (max(CC(1,1), CC(1,2)) - min(CC(1,2), CC(1,1)))/5;
    X1 = CC(1,1); X2 = CC(1,2); Y1 = DD(1,1); Y2 = DD(1,2);
    for i = min(CC(1,2), CC(1,1)): jump : max(CC(1,2), CC(1,1))
        x4(id) = i;
        y4(id) = (((x4(id) - X1)*(Y1 - Y2))/(X1 - X2)) + Y1;
        id = id + 1;
    end
end

L1 = [x1;y1];
L2 = [];
L3 = [x3;y3];
L4 = [x4;y4];
