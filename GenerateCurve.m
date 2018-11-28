function [L1,L2,L3,L4]  = GenerateCurve(xL, yL, lengthL, theta, funcL, H, lengthH,funcH, rotate)

id = 1;
if funcL == 1   % f(x) = constant
    for i = 1:0.5:lengthL+1
        x1(id) = xL+i-1;
        y1(id) = yL;
        id = id + 1;
    end
elseif funcL == 2  % f(x) = x^3 - x^2
    for i = 1:0.5:lengthL+1
        x1(id) = xL+i-1;
        y1(id) = x1(id).^3 - x1(id).^2;
        id = id + 1;
    end 
elseif funcL == 3  % f(x) = sqrt(x)
    for i = 1:0.5:lengthL+1
        x1(id) = xL+i-1;
        y1(id) = sqrt(x1(id));
        id = id + 1;
    end
elseif funcL == 4  % f(x) = polynomial
    for i = 1:0.5:lengthL+1
        x1(id) = xL+i-1;
        y1(id) = 0.0003*(x1(id).^3 - 1) - 0.0021*(x1(id) - 1).^2 + 0.0681*(x1(id)-1) - 0.0344;
        id = id + 1;
    end
elseif funcL == 5  % f(x) = polynomial
    for i = 1:0.5:lengthH+1
        x1(id) = xL+i-1;
        y1(id) = -0.1133*(x1(id) - xL).^2 + 0.6709*(x1(id) - xL) + 0.004 + yL;
        id = id + 1;
    end    
end
% We can create a database like this depending on our required function
%axis([0 20 0 20]);
%hold on

if(theta == pi/2) 
    xH = xL;
else
    xH = xL + H/tan(theta);
end
%xH = xL;
yH = yL + H;
id = 1;
if funcH == 1   % f(x) = constant
    for i = 1:0.5:lengthH+1
        x2(id) = xH+i-1;
        y2(id) = yL + H;
        id = id + 1;
    end
elseif funcH == 2  % f(x) = x^3 - x^2
    for i = 1:0.5:lengthH+1
        x2(id) = xH+i-1;
        y2(id) =  (x2(id)).^2 + H;
        id = id + 1;
    end 
elseif funcH == 3  % f(x) = sqrt(x)
    for i = 1:0.5:lengthH+1
        x2(id) = xH+i-1;
        y2(id) = sqrt(x2(id)) + H;
        id = id + 1;
    end 
elseif funcH == 4  % f(x) = polynomial
    for i = 1:0.5:lengthH+1
        x2(id) = xH+i-1;
        y2(id) = 0.0322*(x2(id) - xH).^3 - 0.0209*(x2(id) - xH).^2 + 0.0681*(x2(id) - xH) - 0.0034 + H + yL;
        id = id + 1;
    end
elseif funcH == 5  % f(x) = polynomial
    for i = 1:0.5:lengthH+1
        x2(id) = xH+i-1;
        y2(id) = -0.1133*(x2(id) - xH).^2 + 0.6709*(x2(id) - xH) + 0.004 + H + yL;
        id = id + 1;
    end
    
elseif funcH == 6  % f(x) = polynomial
    for i = 1:0.5:lengthH+1
        x2(id) = xH+i-1;
        y2(id) = -0.1133*(x2(id) - xH).^2 + 0.0088*(x2(id) - xH) + 0.9971 + H + yL;
        id = id + 1;
    end
elseif funcH == 7  % f(x) = polynomial
    for i = 1:0.5:lengthH+1
        x2(id) = xH+i-1;
        y2(id) = 0.0901*(x2(id) - xH).^2 - 0.5626*(x2(id) - xH) + 0.9084 + H + yL;
        id = id + 1;
    end
end

%plot(x1,y1);
%hold on
%plot(x2, y2);
%hold on
A = [xL xH]; %x
B = [yL y2(1,1)]; %y
C = [xL+lengthL-1 xH+lengthH-1];  %x
D = [y1(1, length(y1)), y2(1, length(y2))]; %y
%plot(A,B);
%hold on
%line(A,B);
%line(C,D);
%hold on
%delx = xL - xH;
%dely = yL - yH;

v1 = [x1;y1];
v2 = [x2;y2];    
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
if (AA(1,1) == AA(1,2)) && (BB(1,1) == BB(1,2))
    x3 = [];
    y3 = [];
else
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
end


CC = [vr1(1,length(vr1(1,:))), vr2(1,length(vr2(1,:)))]; %x
DD = [vr1(2,length(vr1(1,:))), vr2(2,length(vr2(1,:)))]; %y


if (CC(1,1) == CC(1,2)) && (DD(1,1) == DD(1,2))
    x4 = [];
    y4 = [];
else
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
end

L1 = [x1;y1];
L2 = [x2;y2];
L3 = [x3;y3];
L4 = [x4;y4];
%plot(CC,DD);
%line(CC,DD);
%hold on
%v = fillline([2,4],[3 6],10)



