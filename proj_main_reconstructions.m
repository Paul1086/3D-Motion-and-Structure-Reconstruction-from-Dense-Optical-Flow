clc;
clear all;
close all;
files = load("D:\CV Project\Final Submission\Dataset\flow_50/flow_50.mat");
flows = files.flow;
Vx = flows.Vx;% Vx matrix
Vy = flows.Vy;% Vy matrix
T = readtable('D:\CV Project\Final Submission\Dataset/frame_50_N_points_new.csv');
T = table2array(T);
X = T(:,2);
Y = T(:,3);


int_mat = [1979.39048795494 0 0;
0 1979.39048795494 0;
958 517 1];


int_mat = int_mat';


f = 1979.39048795494;
p0 = findepipole(X, Y, Vx, Vy);
omegas = findomegas(X,Y,p0,Vx,Vy,f);


box_points = load("D:\CV Project\Final Submission/pts_all.mat");
pts_all = box_points.pts_all;

X = pts_all(:,1);
Y = pts_all(:,2);

solutions = zeros(length(X),2);
for i=1:length(X)
    
    AA = omegas(3)*Y(i) - omegas(2)*f + (omegas(1)*X(i)*Y(i))/f - (omegas(2)*X(i)^2)/f;
    BB = omegas(1)*f - omegas(3)*X(i) - (omegas(2)*X(i)*Y(i))/f + (omegas(1)*Y(i)^2)/f;
    M = [Vx(Y(i),X(i)) - AA, -(X(i)-p0(1));
        Vy(Y(i),X(i)) - BB, -(Y(i)-p0(2))];
    [~, ~, V2] = svd(M);
    solution = V2(:, end);
%      if norm(solution) > 0
%      solution = solution / norm(solution);
%      end
    x = solution(1);
    y = solution(2);
    solutions(i,:) = [x, y];
end

Z = solutions(:,1);

recon_matrix = zeros(length(X),3);
c0 = int_mat(1,3);
r0 = int_mat(2,3);
for i = 1:length(X)
    
    z_coor = solutions(i,1)/solutions(i,2);  
    
    if z_coor <10000 && z_coor >1000
        x_coor = (X(i)*Z(i) - c0*Z(i));
        y_coor = (Y(i)*Z(i) - r0*Z(i));
        recon_matrix(i,:) = [x_coor, y_coor, z_coor];   
    end
end

figure;scatter3(recon_matrix(:,1)', recon_matrix(:,2)', recon_matrix(:,3)',12);
xlabel("X")
ylabel("Y")
zlabel("Z")

