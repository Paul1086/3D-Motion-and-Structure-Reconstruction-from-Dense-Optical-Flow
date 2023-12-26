function p0 = findepipole(X, Y, Vx, Vy)

all_W = zeros(length(X), length(X));
all_B = zeros(length(X), 3);

for i = 1:size(X,1)   
    i
    X(i);
    Y(i);
    points = [X(i), Y(i)];
    [delVx, delVy] = flowdiff(Vx, Vy, points);
    A_mat = A_matrix(delVx, delVy)
    [W,I] = WI(A_mat);
    temp_points = points;
    temp_I = I;
    temp_I(3) = 0.1;
    temp_points(3) = 1;
    CC = cross(temp_I, temp_points);
    all_W(i,i) = W;
    all_B(i,:) = CC;
end
[U,S,V] = svd(all_W*all_B);
p0 = V(:,3);
p0 = p0 / p0(3);
checks = (all_B)*V(:,3);

end