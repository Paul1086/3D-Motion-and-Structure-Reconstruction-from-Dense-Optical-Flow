function[delVx, delVy] = flowdiff(Vx, Vy, pts)
nhood = 5;
% size(Vx);
% size(Vy);
flow_x = Vx(pts(2),pts(1));
flow_y = Vy(pts(2),pts(1));
x_axis = (pts(1)-nhood):(pts(1)+nhood);
y_axis = (pts(2)-nhood):(pts(2)+nhood);
delVx = zeros(length(x_axis),length(x_axis));
delVy = zeros(length(y_axis),length(y_axis));

for i=1:length(y_axis)
    for j = 1:length(x_axis)
        col = x_axis(j);
        row = y_axis(i);
        % extreme condition 
        if row >= 1 && col >=1 && row<=1080 && col <=1920
            delVx(i,j) = Vx(row, col)-flow_x;
            delVy(i,j) = Vy(row, col)-flow_y;
        end
    end
end

