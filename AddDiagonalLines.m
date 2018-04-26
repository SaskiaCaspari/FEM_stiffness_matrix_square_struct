function K = AddDiagonalLines(K,n,nodes,mul)
%{
The purpose of this function is to include all diagonal trusses into
the stiffness matrix.
Inputs: Stiffness matrix K, number of nodes in a row or column
"nodes", total number of nodes "n" and multiplier "mul".
Output: Updated stiffness matrix K
%}

    firstRow = 1:2*nodes;
    lastRow = 2*n-(2*nodes)+1:2*n;  % define last row

    for i = 1:2*n           % do for each node
        if mod(i,2) ~= 0    % exclude vertical components in the counting

            % Find node to the top right
            j1 = i - 2*nodes + 2;

            % Find node to the bottom right
            j2 = i + 2*nodes + 2;

            % if there is a node to the top right
            if ismember(i,firstRow) == 0 && mod(i+1,2*nodes) ~= 0

                % four top left entries in local stiffness matrix
                for k = i:i+1
                    for m = i:i+1
                        K(k,m) = K(k,m) + mul;
                    end
                end

                % four bottom right entries in local stiffness matrix
                for k = j1:j1+1
                    for m = j1:j1+1
                        K(k,m) = K(k,m) + mul;
                    end
                end

                % four top right entries in local stiffness matrix
                K(i,j1) = K(i,j1) - mul;
                K(i,j1+1) = K(i,j1+1) - mul;
                K(i+1,j1) = K(i+1,j1) - mul;
                K(i+1,j1+1) = K(i+1,j1+1) - mul;

                % four bottom left entries in local stiffness matrix
                K(j1,i) = K(j1,i) - mul;
                K(j1,i+1) = K(j1,i+1) - mul;
                K(j1+1,i) = K(j1+1,i) - mul;
                K(j1+1,i+1) = K(j1+1,i+1) - mul;

            end

            % if there is a node to the bottom right      
            if ismember(i,lastRow) == 0 && mod(i+1,2*nodes) ~= 0

                % four top left entries in local stiffness matrix
                % (including the fact that the cosine is negative)
                K(i,i) = K(i,i) + mul;
                K(i,i+1) = K(i,i+1) - mul;
                K(i+1,i) = K(i+1,i) - mul;
                K(i+1,i) = K(i+1,i) + mul;

                % four bottom right entries in local stiffness matrix
                % (including the fact that the cosine is negative)
                K(j2,j2) = K(j2,j2) + mul;
                K(j2,j2+1) = K(j2,j2+1) - mul;
                K(j2+1,j2) = K(j2+1,j2) - mul;
                K(j2+1,j2) = K(j2+1,j2) + mul;


                % four top right entries in local stiffness matrix
                % (including the fact that the cosine is negative)
                K(i,j2) = K(i,j2) - mul;
                K(i,j2+1) = K(i,j2+1) + mul;
                K(i+1,j2) = K(i+1,j2) + mul;
                K(i+1,j2+1) = K(i+1,j2+1) - mul;

                % four bottom left entries in local stiffness matrix
                % (including the fact that the cosine is negative)
                K(j2,i) = K(j2,i) - mul;
                K(j2,i+1) = K(j2,i+1) + mul;
                K(j2+1,i) = K(j2+1,i) + mul;
                K(j2+1,i+1) = K(j2+1,i+1) - mul;

            end     
        end
    end

end