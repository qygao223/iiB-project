close all;
clear all;
vgs=[-3 -2.8 -2.5 -2.2 -2 -1.8 -1.6 -1.5 -1.35 -1.2 -1 -0.8 -0.5 -0.2 0 0.2 0.5 1 1.5 2];
ids=[1e-6 6.3e-7 3.89e-7 1.41e-7 4.73e-8 1.12e-8 1.4e-9 6e-10 3.24e-10 5e-10 2.48e-9 3e-8 4.17e-7 3e-6 9.44e-6 1.62e-5 2.2e-5 3e-5 3.55e-5 3.76e-5];

% Number of data points
n = length(vgs);

% Preallocate arrays for slopes and derivatives
slopes = zeros(1, n-1);
first_derivative = zeros(1, n-1);
%second_derivative = zeros(1, n-2);
figure;

% Plot data using semilogy for a logarithmic scale on y-axis
semilogy(vgs, ids, 'o-'); % Scatter plot with circles marking the data points and lines connecting them

% Calculate slopes (m) of each segment
for a = 1:n-1
    slopes(a) = (ids(a+1) - ids(a)) / (vgs(a+1) - vgs(a));
end

Gm=slopes;
new_vgs=vgs(1:end-1) + diff(vgs)/2;
for i = 1:length(Gm)-1
    slopes_gm(i) = (Gm(i+1) - Gm(i)) / (new_vgs(i+1) - new_vgs(i));
end
newnew_vgs=new_vgs(1:end-1) + diff(new_vgs)/2;
% Calculate and display equations of lines between points
line_equations = cell(length(Gm)-1, 1);
for i = 1:length(Gm)-1
    % Calculate the y-intercept (b = y - mx)
    b = Gm(i) - slopes_gm(i) * new_vgs(i);

    Vout(i)=slopes_gm(i)*vgs(i+1)+b
    
    % Create equation string for each segment
    line_equations{i} = sprintf('y = %.3e*x + %.3e', slopes(i), b);
end

for l=1:length(Vout)
    ratio_squared(l) = (ids(l+1)/Vout(l));
end


% Enhance the plot
xlabel('V_{GS} (V)'); % x-axis label
ylabel('I_{DS} (A)'); % y-axis label
title('Plot of I_{DS} vs. V_{GS} in Semi-log'); % Title of the plot
grid on; % Enable grid
legend('Data points connected', 'Location', 'best'); % Add legend
legend('Data points', 'Interpolated Curve', 'Location', 'best'); % Add legend

% Plot the first derivative (constant over each segment)
figure;
plot(vgs(1:end-1) + diff(vgs)/2, slopes, 'o-');
xlabel('V_{GS} (Volts)');
ylabel('g_m');
title('g_m vs. V_{gs}');
grid on;

% Plotting (ids/output)^2 vs V_{GS}
figure;
plot(newnew_vgs, slopes_gm,'o-');
%plot(vgs(2:19), ratio_squared, 'o-');
xlabel('V_{GS} (Volts)');
ylabel('\partial g_m / \partial V_{G S}');
title(' \partial g_m / \partial V_{G S} vs. V_{GS}');
grid on;

% Hold off the plot modifications
hold off;