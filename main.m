% Clear previous content in Command Window and Workspace and close all open
% figure windows.
clear; close all; clc;

% Ask user which option to choose.
inputText = ['Please choose either Bernoulli equation (enter 1), ', ...
    'conservation of mass (enter 2), momentum (enter 3), ', ...
    'or energy (enter 4): '];
option = str2double(input(inputText, 's'));

% Check if number is entered
if isnan(option)
    disp('You didn''t enter a number'); % You didn't enter a number
    return;
end

switch option
    case 1 % Bernoulli equation choosed
        BernoulliEquation();
    case 2 % Mass equation choosed
        massEquation();
    case 3 % Momentum equation choosed
        momentumEquation();
    case 4 % Energy equation choosed
        energyEquation();
    otherwise % Another number entered
        % Displays: You didn't enter one of offered numbers
        disp('You didn''t enter one of offered numbers');
end