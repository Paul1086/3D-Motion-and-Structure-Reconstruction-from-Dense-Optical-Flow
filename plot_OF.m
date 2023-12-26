clc;
clear all;
close all;
XXX = load("D:\CV Project\Video Frames\flows/flow_50.mat");
U = XXX.flow.Vx;
V = XXX.flow.Vy;
x = 1:1:1920;
y = 1080:-1:1;
quiver(x,y,U,V,1);