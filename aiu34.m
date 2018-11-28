tic
id = 1;
nShape = input('How many category of shapes? ');
for i = 1:nShape
    str = input('Category of shape? ','s');
    if(strcmp(str,'quadrangle'))
        lengthL = input('lengthL? ');
        theta = input('theta? ');
        H = input('H? ');
        lengthH = input('lengthH? ');
        rem = input('How Many of this kind? ');
        [L1,L2,L3,L4] = GenerateQuadrangle(1,1,lengthL,theta,H,lengthH,0);
        xx = GenerateArea(L1,L2,L3,L4);
        for ii = 1:rem
            area(id) = xx;
            id = id + 1;
        end
        shapes(i).a = xx;
        shapes(i).b = 1;
        shapes(i).c = lengthL;
        shapes(i).d = theta;
        shapes(i).e = H;
        shapes(i).f = lengthH;
    elseif(strcmp(str,'curve'))
        lengthL = input('lengthL? ');
        theta = input('theta? ');
        funcL = input('funcL? ');
        H = input('H? ');
        lengthH = input('lengthH? ');
        funcH = input('funcH? ');
        rem = input('How Many of this kind? ');
        [L1,L2,L3,L4] = GenerateCurve(1,1,lengthL,theta,funcL,H,lengthH,funcH,0);
        xx = GenerateArea(L1,L2,L3,L4);
        for ii = 1:rem
            area(id) = xx;
            id = id + 1;
        end
        shapes(i).a = xx;
        shapes(i).b = 2;
        shapes(i).c = lengthL;
        shapes(i).d = theta;
        shapes(i).e = funcL;
        shapes(i).f = H;
        shapes(i).g = lengthH;
        shapes(i).h = funcH;
    elseif(strcmp(str,'triangle'))
        lengthL = input('lengthL? ');
        theta = input('theta? ');
        H = input('H? ');
        rem = input('How Many of this kind? ');            
        [L1,L2,L3,L4] = GenerateTriangle(1,1,lengthL,theta,H,0);
        xx = GenerateArea(L1,L2,L3,L4);
        for ii = 1:rem
            area(id) = xx;
            id = id + 1;
        end
        shapes(i).a = xx;
        shapes(i).b = 3;
        shapes(i).c = lengthL;
        shapes(i).d = theta;
        shapes(i).e = H;
        elseclc
        disp('Invalid shape');
    end
end

area = sort(area,'descend');
n = length( area );

L = input('Length of SHEET? ');
W = input('Width of SHEET? ');

EDGES = []; taken = 1; PLACED = zeros(1,n);
for x = 0:0.5:W    %try all x coordinate
    if(taken == n + 1)
        break;
    end
    for y = 0:0.5:L    %try all y coordinate
        if(taken == n + 1)
            break;
        end
        fprintf('currently taken %d at %.2f %.2f th place\n',taken,x,y);
        placed = 0;
        for i = 1:n  %number of pieces
            if(placed == 1) %placed at (x,y)
                break;
            end
            if(PLACED(1,i) == 1) %already placed
                continue;
            end
            AREA = area(i);
            k = -1;
            for j=1:nShape 
                if(shapes(j).a == AREA)
                    k = j;
                    break;
                end
            end
            if (k==-1) %not found
                break;
            end
            
            % found a piece to be placed at (x,y)
    
            if(shapes(k).b == 1)    %quadrangle
                lengthL = shapes(k).c; 
                theta = shapes(k).d;
                H = shapes(k).e;
                lengthH = shapes(k).f;
                for rot = 0: pi/2 : 2*pi - 1  %try angular orientation 
                    %disp(rot);
                    [L1,L2,L3,L4] = GenerateQuadrangle(x,y,lengthL,theta,H,lengthH,rot);
                    if((inside(L1,L,W) == 0) ||(inside(L2,L,W) == 0) ||(inside(L3,L,W) == 0) ||(inside(L4,L,W) == 0)) % line segment is outside of the box
                        continue; %check other rotation
                    end
                    %check intersection
                    intersects = 0;
                    if(isempty(EDGES) == 0)
                        for t = 1: length(EDGES)
                            A = EDGES(t).a;
                            B = EDGES(t).b;
                            C = EDGES(t).c;
                            D = EDGES(t).d;
                            X_coor = [A(1,1) A(1,length(A(1,:))) B(1,length(B(1,:))) B(1,1)];
                            Y_coor = [A(2,1) A(2,length(A(2,:))) B(2,length(B(2,:))) B(2,1)];
                            
                            
                            if(isempty(L1)==0)
                                if((inpolygon(L1(1,1),L1(2,1),X_coor,Y_coor) == 1) || (inpolygon(L1(1,length(L1(1,:))),L1(2,length(L1(2,:))),X_coor,Y_coor) == 1))
                                intersects = 1;
                                break;
                                end
                            end
                            if(isempty(L2)==0)
                                if((inpolygon(L2(1,1),L2(2,1),X_coor,Y_coor) == 1) || (inpolygon(L2(1,length(L2(1,:))),L2(2,length(L2(2,:))),X_coor,Y_coor) == 1)) 
                                intersects = 1;
                                break;
                                end
                            end
                            if(isempty(L3)==0)
                                if((inpolygon(L3(1,1),L3(2,1),X_coor,Y_coor) == 1) || (inpolygon(L3(1,length(L3(1,:))),L3(2,length(L3(2,:))),X_coor,Y_coor) == 1)) 
                                intersects = 1;
                                break;
                                end
                            end
                            if(isempty(L4)==0)
                                if((inpolygon(L4(1,1),L4(2,1),X_coor,Y_coor) == 1) || (inpolygon(L4(1,length(L4(1,:))),L4(2,length(L4(2,:))),X_coor,Y_coor) == 1)) 
                                intersects = 1;
                                break;
                                end
                            end
                        end
                        for t = 1: length(EDGES)
                            A = EDGES(t).a;
                            B = EDGES(t).b;
                            C = EDGES(t).c;
                            D = EDGES(t).d;
                            if((CheckIfIntersects(A,B,C,D,L1) == 1) || (CheckIfIntersects(A,B,C,D,L2) == 1) || (CheckIfIntersects(A,B,C,D,L3) == 1) || (CheckIfIntersects(A,B,C,D,L4)==1))
                                intersects = 1;
                                break;
                            end
                        end
                    end
                    if(intersects == 0)
                        disp('found');
                        disp(taken);
                        EDGES(taken).a = L1;
                        EDGES(taken).b = L2;
                        EDGES(taken).c = L3;
                        EDGES(taken).d = L4;
                        placed = 1;
                        taken = taken + 1;
                        PLACED(1,i) = 1;
                        break;
                    end
                end
            elseif(shapes(k).b == 2) %curve
                lengthL = shapes(k).c; 
                theta = shapes(k).d;
                funcL = shapes(k).e;
                H = shapes(k).f;
                lengthH = shapes(k).g;
                funcH = shapes(k).h;
                for rot = 0: pi / 2: 2*pi-1  %try angular orientation 
                    [L1,L2,L3,L4] = GenerateCurve(x,y,lengthL,theta,funcL,H,lengthH,funcH,0);
                    if((inside(L1,L,W) == 0) ||(inside(L2,L,W) == 0) ||(inside(L3,L,W) == 0) ||(inside(L4,L,W) == 0)) % line segment is outside of the box
                        continue; %check other rotation
                    end
                    %check intersection
                    intersects = 0;
                    if(isempty(EDGES) == 0)
                        for t = 1: length(EDGES)
                            A = EDGES(t).a;
                            B = EDGES(t).b;
                            C = EDGES(t).c;
                            D = EDGES(t).d;
                            X_coor = [A(1,1) A(1,length(A(1,:))) B(1,length(B(1,:))) B(1,1)];
                            Y_coor = [A(2,1) A(2,length(A(2,:))) B(2,length(B(2,:))) B(2,1)];
                            
                            
                            if(isempty(L1)==0)
                                if((inpolygon(L1(1,1),L1(2,1),X_coor,Y_coor) == 1) || (inpolygon(L1(1,length(L1(1,:))),L1(2,length(L1(2,:))),X_coor,Y_coor) == 1))
                                intersects = 1;
                                break;
                                end
                            end
                            if(isempty(L2)==0)
                                if((inpolygon(L2(1,1),L2(2,1),X_coor,Y_coor) == 1) || (inpolygon(L2(1,length(L2(1,:))),L2(2,length(L2(2,:))),X_coor,Y_coor) == 1)) 
                                intersects = 1;
                                break;
                                end
                            end
                            if(isempty(L3)==0)
                                if((inpolygon(L3(1,1),L3(2,1),X_coor,Y_coor) == 1) || (inpolygon(L3(1,length(L3(1,:))),L3(2,length(L3(2,:))),X_coor,Y_coor) == 1)) 
                                intersects = 1;
                                break;
                                end
                            end
                            if(isempty(L4)==0)
                                if((inpolygon(L4(1,1),L4(2,1),X_coor,Y_coor) == 1) || (inpolygon(L4(1,length(L4(1,:))),L4(2,length(L4(2,:))),X_coor,Y_coor) == 1)) 
                                intersects = 1;
                                break;
                                end
                            end
                            %fprintf('currently at %d %.2f %.2f %.2f\n',i,x,y,(rot*180.0)/3.14159);
                        end
                        for t = 1: length(EDGES)
                            A = EDGES(t).a;
                            B = EDGES(t).b;
                            C = EDGES(t).c;
                            D = EDGES(t).d;
                            if((CheckIfIntersects(A,B,C,D,L1) == 1) || (CheckIfIntersects(A,B,C,D,L2) == 1) || (CheckIfIntersects(A,B,C,D,L3) == 1) || (CheckIfIntersects(A,B,C,D,L4)==1))
                                intersects = 1;
                                break;
                            end
                        end
                    end
                    if(intersects == 0)
                        disp('found');
                        disp(taken);
                        EDGES(taken).a = L1;
                        EDGES(taken).b = L2;
                        EDGES(taken).c = L3;
                        EDGES(taken).d = L4;
                        placed = 1;
                        taken = taken + 1;
                        PLACED(1,i) = 1;
                        break;
                    end
                end
            end
        end
    end
end

                            
                    
N = length(EDGES);

for i = 1:N
   L1 = EDGES(i).a;
   L2 = EDGES(i).b;
   L3 = EDGES(i).c;
   L4 = EDGES(i).d;
   PrintShape(L1,L2,L3,L4);
end
%check if the sides are inside the grid.
%check if intersects.
%include all the sides inside a struct       
TimeElapsed = toc                    
                    
                    
                    


