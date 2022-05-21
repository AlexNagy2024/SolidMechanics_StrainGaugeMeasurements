clear all, close all

% Import data from .mat file
data = load('lab2_group1_single.mat');
disp = data.disp'; % load displacement into array
strain = data.strain'; % load strain into array

% Average data
% On the right side, there are 15 values in each array representing 8 measurements back and forth
% For each measurement/displacement, take the average value of the forward and backward strains
disp1 = disp(1:8,:); % forward displacements
disp2 = flip(disp(8:15,:)); % backward displacements – flip the array to align with forward disp
strain1 = strain(1:8,:); % forward strain
strain2 = flip(strain(8:15,:)); % backward strain – flip the array to align with forward strain
disp_avg = (disp1 + disp2)/2; % average displacement – or just 0-8 [mm] in 8 increments
strain_avg = (strain1 + strain2)/2; % average strain measurements

% Plot Strain vs. Displacement
plot(disp_avg,strain_avg,'ro-','linewidth',1)
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]); % expand window
xlabel('Tip Displacement (mm)')
ylabel('Strain (mm/mm)')
title('Group 1: Single Strain vs. Displacement - Brass')

% Plot best-fit line
slope = disp_avg\strain_avg; % Slope of best-fit line
hold on, grid on
plot(disp_avg,disp_avg*slope,'k:','linewidth',1.5);
legend('Average Data','Best-Fit');

% Calculate predicted strain (Pre-lab)
t = 0.135; % thickness of beam [in]; 3.42mm
w = 0.965; % width of beam [in]; 24.5mm
L = 9.941; % length of beam [in]; 25.25cm
l = 8.858; % length between gauge and micrometer [in]; 22.5cm
x = L - l; % x = L – l [in]
d = 8/25.4; % disp at tip [in]
epsilon = (3*(t/2)*(L-x)*d)/L^3; % compute predicted strain

% Calculate measured strain at max disp using best fit line
s = slope*8; % compute measured strain at max disp 8mm based on best-fit line

% Compare the predicted strain (Pre-lab) and measured strain at max disp (best-fit line)
error = abs(100*(s-epsilon)/epsilon); % calculate percent of difference

% Plot the error percent onto Strain vs. Displacement plot using text(x,y,...) command
txt = ['\leftarrow % Error = ', num2str(error), ' %'];
t = text(3.6,strain_avg(4),txt); t.FontSize = 14; t.FontName = 'Times New Roman';