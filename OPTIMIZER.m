%things to fix :
%Warning error in intersections.m


clc
clear all
clc

id = 1;
nShape = input('How many category of shapes? ');
for i = 1:nShape
    str = input('Category of shape? ','s');
    if(length(str) == 10)
        if(str == 'quadrangle')
            lengthL = input('lengthL? ');
            theta = input('theta? ');
            H = input('H? ');
            lengthH = input('lengthH? ');
            rem = input('How Many of this kind? ');
            [L1,L2,L3,L4] = GenerateQuadrangle(1,1,lengthL,theta,H,lengthH,0)
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
        else
            disp('Invalid shape');
        end
    elseif(length(str) == 5)
        if(str == 'curve')
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
        else
            disp('Invalid shape');
        end
    elseif(length(str) == 8)
        if(str == 'triangle')
            lengthL = input('lengthL? ');
            theta = input('theta? ');
            H = input('H? ');
            rem = input('How Many of this kind? ');            
            [L1,L2,L3,L4] = GenerateTriangle(1,1,lengthL,theta,H,0)
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
        else
            disp('Invalid shape');
        end
    end
end

area = sort(area,'descend');
n = length( area );

L = input('Length of SHEET? ');
W = input('Width of SHEET? ');

EDGES = []; taken = 1;
    for i = 1:n  %number of pieces
        fprintf('currently at %dth piece\n',i);
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
        placed = 0;
        for x = 0:.05:W    %try all x coordinate
            if(placed == 1)
                break;
            end
            for y = 0:.05:L    %try all y coordinate
                if(placed == 1)
                    break;
                end
                if(shapes(k).b == 1)    %quadrangle
                    lengthL = shapes(k).c; 
                    theta = shapes(k).d;
                    H = shapes(k).e;
                    lengthH = shapes(k).f;
                    for rot = 0: 2*pi / 5: 2*pi  %try angular orientation 
                        %disp(rot);
                        [L1,L2,L3,L4] = GenerateQuadrangle(x,y,lengthL,theta,H,lengthH,rot);
                        if((inside(L1,L,W) == 0) ||(inside(L2,L,W) == 0) ||(inside(L3,L,W) == 0) ||(inside(L4,L,W) == 0)) % line segment is outside of the box
                            continue; %check other rotation
                        end
                        %check intersection
                        intersects = 0; %0 = doesn't intersect, 1 = intersects
                        if(isempty(EDGES) == 0)
                            for t = 1: length(EDGES)
                                if(intersects == 1)
                                    break;
                                end
                                % in EDGES we store all the sides of shapes. Each
                                % shape is characterized by 4 sides ( possibly
                                % 0 length)
                                A = EDGES(t).a;
                                B = EDGES(t).b;
                                C = EDGES(t).c;
                                D = EDGES(t).d;
                                if((CheckIfIntersects(A,B,C,D,L1) == 1) || (CheckIfIntersects(A,B,C,D,L2) == 1) || (CheckIfIntersects(A,B,C,D,L3) == 1) || (CheckIfIntersects(A,B,C,D,L4)==1))
                                    intersects = 1;
                                    break; % try other rotation
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
                            taken = taken + 1;
                            placed = 1;
                            break; % no need to try other angular orientation
                        end
                    end
                elseif(shapes(k).b == 2) %curve
                    lengthL = shapes(k).c; 
                    theta = shapes(k).d;
                    funcL = shapes(k).e;
                    H = shapes(k).f;
                    lengthH = shapes(k).g;
                    funcH = shapes(k).h;
                    for rot = 0: 2*pi / 10: 2*pi  %try angular orientation 
                        [L1,L2,L3,L4] = GenerateCurve(x,y,lengthL,theta,funcL,H,lengthH,funcH,rot);
                        if((inside(L1,L,W) == 0) ||(inside(L2,L,W) == 0) ||(inside(L3,L,W) == 0) ||(inside(L4,L,W) == 0)) % line segment is outside of the box
                            continue; %check other rotation
                        end
                        %check intersection
                        intersects = 0;
                        if(isempty(EDGES) == 0)
                            for t = 1: length(EDGES)
                                if(intersects == 1)
                                    break;
                                end
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
                            break;
                        end
                    end
                elseif(shapes(k).b == 3) %triangle
                    lengthL = shapes(k).c; 
                    theta = shapes(k).d;
                    H = shapes(k).e;
                    for rot = 0: 2*pi / 10: 2*pi  %try angular orientation 
                     %disp(rot)
                     [L1,L2,L3,L4] = GenerateTriangle(x,y,lengthL,theta,H,rot);
                        if((inside(L1,L,W) == 0) ||(inside(L2,L,W) == 0) ||(inside(L3,L,W) == 0) ||(inside(L4,L,W) == 0)) % line segment is outside of the box
                            continue; %check other rotation
                        end
                        %check intersection
                        intersects = 0;
                        if(isempty(EDGES) == 0)
                            for t = 1: length(EDGES)
                                if(intersects == 1)
                                    break;
                                end
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
                    
                    
                    
                    
                    
                    


