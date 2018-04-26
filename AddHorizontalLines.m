function K = AddHorizontalLines(K,n,nodes,mul)
%{
The purpose of this function is to include all horizontal trusses into
the stiffness matrix.
Inputs: Stiffness matrix K, number of nodes in a row or column
"nodes", total number of nodes "n" and multiplier "mul".
Output: Updated stiffness matrix K
%}

    for i = 1 : 2*n-3
        if mod(i,2) ~= 0    % exclude all vertical components
            if mod(i+1,2*nodes) ~= 0    % check whether the end of the row
                                        % is reached
                K(i,i) = K(i,i) + mul;
                K(i+2,i) = K(i+2,i) - mul;
                K(i,i+2) = K(i,i+2) - mul;
                K(i+2,i+2) = K(i+2,i+2) + mul;  
            end
        end
    end


end

