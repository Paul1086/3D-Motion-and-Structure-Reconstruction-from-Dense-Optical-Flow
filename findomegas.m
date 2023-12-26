function omegas = findomegas(X,Y,p0,Vx,Vy,f)

interim_matrix = zeros(length(X), 2);

for i=1:length(X)    
    interim_matrix(i,:) = [Y(i)-p0(2), -(X(i)-p0(1))];
end



flow_mat = zeros(length(X),2);

for i = 1:length(X)
    flow_mat(i,:) = [Vx(Y(i),X(i)), Vy(Y(i),X(i))];
end
full_matrix = zeros(size(X,2),3);
for i = 1:length(X)
    rx = (X(i)*Y(i)*(Y(i)-p0(2)))/f - f*(X(i)-p0(1)) - (Y(i)^2*(X(i)-p0(1)))/f;
    ry = -f*(Y(i)-p0(2)) - (X(i)^2*(Y(i)-p0(2)))/f + (X(i)*Y(i)*(X(i)-p0(1)))/f;
    rz = Y(i)*(Y(i)-p0(2)) + X(i)*(X(i)-p0(1));
    full_matrix(i,:) = [rx, ry, rz];
end

VN = diag(flow_mat*interim_matrix');
omegas = full_matrix\VN;

end