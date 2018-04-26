function K = SetupStiffnessMatrix(E,A,L0,nodes)
%{
This function sets up stiffness matrix K for the Finite Element Analysis of
a 2D, squared structure with n * n rows.
Inputs: Young's modulus "E", cross-section of beams "A", vertical/horizontal
length between nodes "L0" and number of nodes per row and column "nodes".
%}

    Ld = L0*sqrt(2);        % diagonal length between nodes
    n = nodes * nodes;      % total number of nodes
    K = zeros(2*n);         % initialize global stiffness matrix K

    % add all horizontal and vertical trusses to K
    mul1 = (E*A)/L0;      % multiplier for local stiffness matrices for all
                          % vertical and horizontal bars                      
    K = AddHorizontalLines(K,n,nodes,mul1);
    K = AddVerticalLines(K,n,nodes,mul1);


    % Adding diagonal trusses to K:
    
    mul2 = ((sqrt(2)/2)^2)*(E*A)/Ld;    % absolute value of multiplier for
                                        % cos and sin of 45°
    K = AddDiagonalLines(K,n,nodes,mul2);

end
