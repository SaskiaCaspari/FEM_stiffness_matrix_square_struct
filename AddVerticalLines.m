function K = AddVerticalLines(K,n,nodes,mul)
%{
The purpose of this function is to include all vertical trusses into
the stiffness matrix.
Inputs: Stiffness matrix K, number of nodes in a row or column
"nodes", total number of nodes "n" and multiplier "mul".
Output: Updated stiffness matrix K
%}


lastRow = (2*(n-nodes+1)-1):2*n;  % define last row for check in while-loop

for i = 1:nodes    % do for each column
        k = 2*i;   % number of vertical component of first node in column i
        
        while ismember(k,lastRow) == 0  % do as long as we have not reached
                                              % the last row yet
            K(k,k) = K(k,k) + mul;
            K(k+2*nodes,k) = K(k+2*nodes,k) - mul;
            K(k,k+2*nodes) = K(k,k+2*nodes) - mul;
            K(k+2*nodes,k+2*nodes) = K(k+2*nodes,k+2*nodes) + mul;
            k = k + 2*nodes; % go to the next row in that column
        end   
end


end

