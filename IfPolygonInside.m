function OO = IfPolygonInside(L1,L2,L3,L4,A,B,C,D)
X_coor = [A(1,1) A(1,length(A)) B(1,length(B)) B(1,1)]
Y_coor = [A(2,1) A(2,length(A)) B(2,length(B)) B(2,1)]

OO = 0;
if(isempty(L1)==0)        
    if((inpolygon(L1(1,1),L1(2,1),X_coor,Y_coor) == 1) || (inpolygon(L1(1,length(L1)),L1(2,length(L1)),X_coor,Y_coor) == 1))
    OO = 1;
    return
    end
end
if(isempty(L2)==0)
    if((inpolygon(L2(1,1),L2(2,1),X_coor,Y_coor) == 1) || (inpolygon(L2(1,length(L2)),L2(2,length(L2)),X_coor,Y_coor) == 1)) 
    OO = 1;
    return
    end
end
if(isempty(L3)==0)
    if((inpolygon(L3(1,1),L3(2,1),X_coor,Y_coor) == 1) || (inpolygon(L3(1,length(L3)),L3(2,length(L3)),X_coor,Y_coor) == 1)) 
    OO = 1;
    return
    end
end
if(isempty(L4)==0)
    if((inpolygon(L4(1,1),L4(2,1),X_coor,Y_coor) == 1) || (inpolygon(L4(1,length(L4)),L4(2,length(L4)),X_coor,Y_coor) == 1)) 
    OO = 1;
    return
    end
end