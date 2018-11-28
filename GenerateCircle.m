function [L1,L2,L3,L4]  = GenerateCircle(xL, yL, lengthL, rotate)

h = (2*xL + lengthL)/2;
k = yL;
r = sqrt((xL - h).^2 + (yL - k).^2);
id = 1;
for i = 1:lengthL+1
    x1(id) = xL+i-1;
    y1(id) = k + sqrt(r.^2 - (x1(id) - h).^2);
    id = id + 1;
    
end
%plot(x1,y1);
%hold on
id = 1;
for i = 1:lengthL+1
    x2(id) = xL+i-1;
    y2(id) = k - sqrt(r^2 - (x2(id) - h)^2);
    id = id + 1;
    
end
%plot(x2,y2);
%xH = xL + H/tan(theta);
%yH = yL + H;
%axis([-100 100 -100 100]);
%hold on

%for i = 1:lengthH
%    x2(i) = xH+i-1;
%    y2(i) = yH;
%end
%plot(x2, y2);
%hold on
%A = [xL xH]; %x
%B = [yL yH]; %y
%C = [xL+lengthL-1 xH+lengthH-1];
%D = [yL yH];
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
%AA = [vr1(1,1) vr2(1,1)];
%BB = [vr1(2,1) vr2(2,1)];
%plot(AA,BB);
%line(AA,BB);
%hold on
%CC = [vr1(1,length(vr1(1,:))), vr2(1,length(vr2(1,:)))];
%DD = [vr1(2,length(vr1(1,:))), vr2(2,length(vr2(1,:)))];
%plot(CC,DD);
%line(CC,DD);
%hold on
%v = fillline([2,4],[3 6],10)

L1 = [x1;y1];
L2 = [x2;y2];
L3 = [];
L4 = [];



