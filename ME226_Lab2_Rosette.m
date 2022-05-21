clear all, close all

% Import data from .mat file
data = load('lab2_group1_rosette.mat');
disp = data.disp'; % load displacement into array
strain = data.strain; % load strain into array
strainA = strain(:,1); strainB = strain(:,2); strainC = strain(:,3);

% Plot Strain vs. Displacement
plot(disp,[strainA,strainB,strainC],'-o','linewidth',1);
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]); % expand window
xlabel('Displacement (mm)');
ylabel('Strain (mm/mm)');
title('Group 1: Rosette Strain vs. Displacement - Brass');
hold on, grid on

% Plot best-fit line
for i = 1:3 % loop through 3 strain data sets
    s(i) = disp\strain(:,i); % calculate slope of each line
    plot(disp,disp*(s(i)),':','linewidth',1.5); % plot best-fit lines
end
lgd1 = legend('Gauge A','Gauge B','Gauge C','Best Fit A','Best Fit B','Best Fit C','location','NorthWest');
lgd1.FontSize = 14; lgd1.FontName = 'Times New Roman';

% Calculate predicted strain (Pre-lab)
t = 0.135; % thickness of beam [in]; 3.42mm
w = 0.965; % width of beam [in]; 24.5mm
L = 9.941; % length of beam [in]; 25.25cm
l = 8.661; % length between gauge and micrometer [in]; 22cm
x = L - l; % x = L – l [in]
d = 8/25.4; % disp at tip [in]
epsilon = (3*(t/2)*(L-x)*d)/L^3; % compute predicted strain – same for 3 gauges

% Calculate measured strain at max disp using best fit line
% Slope of lines are already defined in Step 3: s(j) with j = 1, 2, 3 corresponds to slope A, B, C
sA = s(1)*8; % compute measured strain A at max disp 8mm based on best-fit line
sB = s(2)*8; % compute measured strain B at max disp 8mm based on best-fit line
sC = s(3)*8; % compute measured strain C at max disp 8mm based on best-fit line

% Compare the predicted strain (Pre-lab) and measured strain at max disp (best-fit line)
errorA = abs(100*(sA-epsilon)/epsilon); % calculate percent of difference for gauge A
errorB = abs(100*(sB-epsilon)/epsilon); % calculate percent of difference for gauge A
errorC = abs(100*(sC-epsilon)/epsilon); % calculate percent of difference for gauge A

txtA = ['\uparrow % Error Gauge A = ', num2str(errorA), ' %'];
txtB = ['% Error Gauge B = ', num2str(errorB), ' % \rightarrow '];
txtC = ['\downarrow % Error Gauge C = ', num2str(errorC), ' %'];

tA = text(4.56,0.000157,txtA); tA.FontSize = 14; tA.FontName = 'Times New Roman';
tB = text(1.7,0.000184,txtB); tB.FontSize = 14; tB.FontName = 'Times New Roman';
tC = text(4,0,txtC); tC.FontSize = 14; tC.FontName = 'Times New Roman';

% Calculate principal strains
ea = strain(:,1); % define strain of each gauge
eb = strain(:,2);
ec = strain(:,3);

% Calculate Mohr's circle parameters (Refer to Example 7-8 in textbook for rosette strain)
Gxy = 2*eb-(ea+ec); % shear strain
C = (ea+ec)/2; % average strain
R = sqrt(((ea-ec)/2).^2+(Gxy/2).^2); % radius of Mohr's circle
e1 = C + R; % principal strains
e2 = C - R;

% Plot principal strains
figure % New figure created to separate from Strain vs. Displacement plot in Step 3
plot(disp,e1,'r-o',disp,e2,'b-o','linewidth',1);
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]); % expand window
xlabel('Displacement (mm)');
ylabel('Principal Strain (mm/mm)');
title('Group 1: Principal Strain vs. Displacement - Brass');
hold on, grid on

% Plot best-fit lines
slope1 = disp\e1; % Slope of best-fit lines
slope2 = disp\e2;
plot(disp,[disp*slope1,disp*slope2],':','linewidth',1.5);
lgd2 = legend('Principal Strain 1','Principal Strain 2','Best Fit 1','Best Fit 2','location','northwest');
lgd2.FontSize = 14; lgd2.FontName = 'Times New Roman';

% Calculate angle of maximum principal strain
theta = atand(Gxy/(ea-ec))/2; 

% Compare the measured angle of maximum principal strain with calculated one
measured_angle = 15.5; % your measured angle
error_angle = abs(100*(theta-measured_angle)/measured_angle);

% Calculate Poisson ratio
v = -e2(2:end)./e1(2:end);

txtbook_v = 0.34; % Poisson ratio of brass; pg 992
error_v = abs(100*(v-txtbook_v)/txtbook_v); % percent difference

% Compute averages for data 
Gxy_avg = mean(Gxy(2:end));
ps1 = mean(e1(2:end));
ps2 = mean(e2(2:end));
v_avg = mean(v); v_error = abs(100*(v_avg - 0.34)/0.34);
theta_avg = mean(theta(:,8)); theta_error = abs(100*(theta_avg - 15.5)/15.5);
R_avg = mean(R(2:end)); C_avg = mean(C(2:end));

fig_txt = ['Poisson' '''s Ratio = ', num2str(v_avg), newline...
    'Theta = ', num2str(theta_avg)];
fig_t = text(0.15,0.00025,fig_txt); fig_t.FontSize = 16; fig_t.FontName = 'Times New Roman';