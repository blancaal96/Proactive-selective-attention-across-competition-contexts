function [] = soundFeedback()

%% 1. SIGNAL PARAMETERS
% -------------------------------------------------------------------------
fs = 20500;         % Sampling frequency
dt = 1/fs;          % Time resolution
T = 0.1;            % Signal duration
t = 0:dt:T-dt;      % Total duration
N = length(t);      % Number of time samples

%% 2. SIGNAL GENERATION
% -------------------------------------------------------------------------
f0_1 = 1000;                % Fundamental frequency of first sinusoid
x1 = sin(2*pi*f0_1*t);      % First sinusoid

sound (x1);

end

