%% PID controller project - Control system toolbox
% PID control design with control system toolbox

% link: https://www.mathworks.com/videos/pid-control-design-with-control-system-toolbox-68748.html

%% Control system toolbox
clear all
clc

% Use MATLAB system toolbox to design the PID controller
% Export the data after design
s = tf('s');
sys = 1/(s+1)^3

pidtool(sys)

