clear all
clc

%% General tranfer function information
%{
    Transfer function:
             10
     ------------------ ;  Y(s)/U(s) = 10/[s(s+2)(s+5)]
     s^3 + 7 s^2 + 10 s
%}

np = 10;
dp = poly([-5 -2 0]);