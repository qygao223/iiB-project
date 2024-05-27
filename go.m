close all;
clear all;

NA=6.022e23; % #/mol
mass=392.5*1e6; %in ug/mol
A= 1; %in cm2
K=NA*A/mass;

simulation = [0 200 400 600 800 1000 1200]; 
density = [0 72.46 138.2 180.9 189.4 199.2 195.8]; 
errors = [0 8.4 8.4 8.4 8.4 8.4 8.4];  

sim_fit=[400 600 800];
densi_fit=[138.2 180.9 189.4];
error1=[8.4 8.4 8.4];

sim2 = 0:20:400;
density2=20/1.8*[0 0.35 1 1.5 1.95 2.4 2.85 3.3 3.75 4.2 4.5 5.2 5.31 5.7 6.25 6.6 6.8 7.1 7.3 7.5 8];
error2 = 0.5*20/1.8*[0 0 0.75 0.85 0.85 1.05 1.1 1.3 1.6 1.95 2.05 2.25 2.27 2.45 2.95 2.97 3.2 3.1 3.15 3.15 3.15];

figure;
hold on;
errorbar(simulation, density, errors, 'o', 'MarkerSize', 4, 'MarkerEdgeColor', 'green', 'MarkerFaceColor', 'green');

% Define a finer x range for the curve
num_molecules =density2 * K;

p = polyfit(sim_fit, densi_fit, 2);  % '2' specifies the degree of the polynomial
equation = sprintf('y =%.6fx^2 + %.5fx +%.4f', p(1), p(2), p(3));
x_fine = linspace(min(sim_fit), max(sim_fit), 100);
y_fine = polyval(p, x_fine);
x1= linspace(0,400, 20);
x2= linspace(400,800, 20);
x3= linspace(800,1200, 20);
y1=0.3489*x1;
for i=1:length(x2)
    y2(i)=-0.000427*x2(i)^2+0.6418*x2(i)-49.8;
end
y3=repmat(192, 1, 20);
x=[x1 x2 x3];
y= [y1 y2 y3];
% Plot the fitted polynomial
plot(x, y, 'r-');

% Customize the plot
xlabel('Number of simulation'); 
ylabel('Cumulative DEX release in %');
title(['Segmented fitted curve'])
%title(['Second order fit: y = -0.0002x^2+0.2902x'])
%title(['Second Order Polynomial Fit: ', equation]); 
grid on;
legend('Data Points', 'Fitted Curve', 'Location', 'Best'); 

ylim([0, density(end)+35]); 
hold off; 