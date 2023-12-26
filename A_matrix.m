function A_mat = A_matrix(delVx, delVy)

sq_delVx = delVx.^2;
sq_delVx = sq_delVx(:);
sq_delVy = delVy.^2;
sq_delVy = sq_delVy(:);

delvxvy = delVx(:).*delVy(:);

A_mat = [sum(sq_delVx) sum(delvxvy);
    sum(delvxvy) sum(sq_delVy)];

end