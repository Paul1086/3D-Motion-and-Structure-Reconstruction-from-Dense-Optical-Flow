function [W,I] = WI(A_mat)

[V,D] = eig(A_mat, 'vector')
%eig_val = diag(D)
indexs = find(D==max((D)))
I = V(:,indexs);
W = D(indexs);

end