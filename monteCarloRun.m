
clear all; close all; clc;

dev = 5;
dev2= 1.05;

A = [75-dev; 75-dev; 75-dev; 75-dev; 75-dev; 75-dev;
    75+dev; 75+dev; 75+dev; 75+dev; 75+dev; 75+dev];

A2 = [75-dev2; 75-dev2; 75-dev2; 75-dev2; 75-dev2; 75-dev2;
    75+dev2; 75+dev2; 75+dev2; 75+dev2; 75+dev2; 75+dev2];


B  = 2;
B2 = 1.9968;
W  = 1;
R  = 1;

[Kstar,Lstar,TotalProfit]    = LongRunProfit(A,B,W,R);
[Kstar2,Lstar2,TotalProfit2] = LongRunProfit(A2,B2,W,R);

productivity1 = log(sum(Lstar)) - 0.5*log(12*Kstar) - 0.5*log(sum(Lstar));
productivity2 = log(sum(Lstar2)) - 0.5*log(12*Kstar2) - 0.5*log(sum(Lstar2));

exp(productivity2)/exp(productivity1)