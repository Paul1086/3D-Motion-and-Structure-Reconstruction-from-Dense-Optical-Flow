clc;
clear all;
close all;
files = load("D:\CV Project\Final Submission\Dataset\flow_50/flow_50.mat");
flows = files.flow;
Vx = flows.Vx;% Vx matrix
Vy = flows.Vy;% Vy matrix
T = readtable('D:\CV Project\Final Submission\Dataset/frame_50_N_points.csv');
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

T1 = readtable('D:\CV Project\Final Submission\Dataset/frame_50_N_points_tree1.csv');
T1 = table2array(T1);
X = T1(:,2);
Y = T1(:,3);

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
    %solutions(i,:) = solutions(i,:)/(solutions(i,2));
end

Z = solutions(:,1);
Z = solutions(:,1)./solutions(:,2);
Z_mean = mean(Z);

Tz = solutions(:,2);
V_mat= velocity_matrix(X,Y,Z,Tz,p0,f,omegas);

t=zeros(1,length(V_mat));
figure;
quiver3(t,t,t,V_mat(1:length(V_mat),1)',V_mat(1:length(V_mat),2)',V_mat(1:length(V_mat),3)');
xlabel("40 * Vx (mm/sec)")
ylabel("40 * Vy (mm/sec)")
