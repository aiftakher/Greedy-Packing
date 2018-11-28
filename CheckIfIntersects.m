function Y = CheckIfIntersects(A,B,C,D,AA)
Y = 0;
if(isempty(AA))
    Y = 0;
elseif (length(AA(1,:)) < 2)
    Y = 0;
else
    if(isempty(A) == 0) %not empty
        if(length(A(1,:)) >= 2) %contains atleast two elements
            [a,b,c,d] = intersections(A(1,:),A(2,:),AA(1,:), AA(2,:));
            if(isempty(a))
                Y = 0;
            else
                Y = 1;
            end
        end
    end
    if(Y == 0)
        if(isempty(B) == 0) %not empty
            if(length(B(1,:)) >= 2) %contains atleast two elements
                [a,b,c,d] = intersections(B(1,:),B(2,:),AA(1,:), AA(2,:));
                if(isempty(a))
                    Y = 0;
                else
                    Y = 1;
                end
            end
        end
    end
        
    if(Y == 0)
        if(isempty(C) == 0) %not empty
            if(length(C(1,:)) >= 2) %contains atleast two elements
                [a,b,c,d] = intersections(C(1,:),C(2,:),AA(1,:), AA(2,:));
                if(isempty(a))
                    Y = 0;
                else
                    Y = 1;
                end
            end
        end
    end

    if(Y == 0)
        if(isempty(D) == 0) %not empty
            if(length(D(1,:)) >= 2) %contains atleast two elements
                [a,b,c,d] = intersections(D(1,:),D(2,:),AA(1,:), AA(2,:));
                if(isempty(a))
                    Y = 0;
                else
                    Y = 1;
                end
            end
        end
    end
end
    
