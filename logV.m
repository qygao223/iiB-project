close all;

Pdensity = [0.003 0.013 0.058 0.49 1.20 2.74 5.78]; 
photoV = [0.146 0.476 0.951 1.62 1.88 2.107 2.28]; 

T=300;
q=1.6e-19;
k=1.38e-23;
a=0.3123/9;
n=a*q/(k*T)
f=3e8/(1800e-9);
A=60e-12;
h=6.63e-34;
b=0.031;
b1=b*h*f/(A*q)

% Define the fit type and options, including bounds to ensure a positive argument for the logarithm
ft = fittype('a*log(b*x+1)', 'independent', 'x', 'dependent', 'y');
opts = fitoptions(ft);
opts.Lower = [-Inf, 0, 0.1]; % Adjust these bounds as needed
opts.Upper = [Inf, Inf, Inf];

% Perform the fit
[fitResult, gof] = fit(Pdensity', photoV', ft, opts);

% Extract the fit coefficients
coeffs = coeffvalues(fitResult);
equation = sprintf('Fitted Equation: y = %.2f*log(%.2fx+1)', coeffs(1), coeffs(2));

figure;
plot(Pdensity, photoV, 'rx', 'MarkerSize', 6); 
hold on;
% Plot the fit
% Generate a range of x values for plotting the fit curve
x_fit = linspace(min(Pdensity), max(Pdensity), 400); 
y_fit = feval(fitResult, x_fit);

plot(x_fit, y_fit, 'b-', 'LineWidth', 2); 

% Customize the plot
xlabel('Number of simulation'); 
ylabel('Density'); % Label for the y-axis
title(equation, 'Interpreter', 'none'); % Title for the plot
legend('Data Points', 'Fitted Curve', 'Location', 'Best'); % Legend

ylim([0, 2.5]); 
hold off; 