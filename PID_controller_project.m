%% PID controller project - Ziegler-Nichols methodology
% Ziegler-Nichols methodology is based on the gain margin for a proportional controller. 
% The gain causes the system to oscillate will be called Km, and the frequency wm.

% Author: Marcos Henrique do Nascimento Sousa

% São Paulo State University - UNESP - Brazil - 2018
% marcoshns@outlook.com

%% Load transfer function information
clear all
clc 

    data_transfer_function

% print transfer function 
printsys(np,dp)

%% Root-Locus method

figure()
rlocus(np,dp)
[Km pmf] = rlocfind(np,dp)

%% Select a point in the graphics window
% Choose the point where Real Axis is zero 

% Looking the frequency value into the Root-Locus 
prompt = 'Please enter the frequency value [rad/s] using the Data Cursor tool: ';
wm = input(prompt);

% Setting the gains 
Kp = 0.6*Km; %proporcional gain
Kd = (Kp*pi)/(4*wm); %differential gain
Ki = (Kp*wm)/pi; %integral gain

%% PID transfer function
%{
    PID transfer function:
          Kd.s^2 + Kp.s + Ki
    K(s) -------------------- ;
                 s
%}

nk = [Kd Kp Ki];
dk = [1 0]; 

%% Open-loop systems transfer function
% P(s) is the plant transfer function 

% KP(s) = K(s).P(s);
nma = conv(nk,np);
dma = conv(dk,dp);

%print open-loop transfer function 
fprintf('Open-loop transfer function:')
printsys(nma,dma)

%% Closed-loop systems transfer function
% Use cloop command

[nmf dmf] = cloop(nma,dma);

%print closed-loop transfer function 
fprintf('Cloed-loop transfer function:')
printsys(nmf,dmf)

%% Plotting step reponse for the closed-loop system

figure()
t = 0:0.01:10;
y = step(nmf,dmf,t);
plot(t,y);
grid on

% The Ziegler-Nichols method is only reasonable, being used as a 
% starting point to find the final values of the PID controller.

% The decrease in the percentage of overshoot and stability time 
% is obtained by increasing the derivative gain.


%% Changing differential gain
nk
Kd = input('Enter with a new differential gain (Kd): ');
nk = [Kd Kp Ki];
nma = conv(nk,np);
[nmf dmf] = cloop(nma, dma);

%% Plotting step reponse for the closed-loop system
figure()
t = 0:0.01:10;
y = step(nmf,dmf,t);
plot(t,y);
grid on

% The second overshoot is an effect of the integration constant. 
% Decreasing this value improves the response to the step input.

%% Changing integral gain
nk
Ki = input('Enter with a new integral gain (Ki): ');
nk = [Kd Kp Ki];
nma = conv(nk,np);
[nmf dmf]=cloop(nma,dma);

%% Plotting step reponse for the closed-loop system
figure()
t = 0:0.01:10;
y = step(nmf,dmf,t);
plot(t,y);
grid on
