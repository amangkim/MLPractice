function RegModel = MLRegFcnGen(varargin)
% Generatate the regession functions and parameters
% By using Machine Learning (Training Scheme)
%
% Usage:
%   [RegModel (S)] = MLRegFcnGen(X-Y Data, Iterations, LearningRate)
% 
% Output:
%   S.Iter          : Number of Iterations
%   S.XRange        : Range of X [min(X) max(X)]
%   S.YRange        : Range of Y [min(Y) max(Y)]
%   S.Slope (b0)    : Slope of an X-Y graph;
%   S.Y0            : Y-intercept
%   S.PredFcn       : Linear regression function F(x) = b0+b1*x
%   S.MSE           : Mean Square Error
%
% Input:
%   X-Y Data        : Dataset of X and Y values    
%   Iterations      : Number of iterations (<= Length of dataset)
%   LearningRate    : Learning rate; Default = 10^(-6)
%
% Note:
%   - This function is generating a regression function
%   - Gerating the function based on training (ML)
%	
% Made by Amang Kim [v0.1 || 2/15/2021]

%--------------------(XY_data,iter)
inputs={'XY_data', 'iter', 'learn_rate'};
iter = 2;
learn_rate = 0.00001;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------


A = [];
B = [];

A1 = [];
B1 = [];
MSE1 = [];


%[X,i0] = sort(XY_data (:,1));
%Y = XY_data (i0,2);

X = XY_data (:,1);
Y = XY_data (:,2);

y0 = min(Y);
y1 = max(Y);
x0 = min(X);
x1 = max(X);


a0 = (y1-y0)/(x1-x0);
b0 = y1 - a0*x1;


iter0 = min(iter,length(X)-1);

dfa = 0;
dfb = 0;


for i1 = 2:iter0
    
    x0 = X(i1-1);
    y0 = Y(i1-1);
    
    x1 = X(i1);
    y1 = Y(i1);

    %(-a0*x0-b0)
    dfa = dfa+(-1)*x0*2*(y0-a0*x0-b0);
    dfb = dfb+(-1)*2*(y0-a0*x1-b0);

    %pause;

    a1 = a0 - dfa*learn_rate/i1;
    b1 = b0 - dfb*learn_rate/i1;
    
    A1 = [A1 a1];
    B1 = [B1 b1];
    
    %a2 = mean(A1);
    %b2 = mean(B1);
    
    mse0 = (y1 - a1*x1-b1)^2;
    MSE1 = [MSE1 mse0];
    
    %------
    a0 = a1;
    b0 = b1;
    %------

end

%b0_m = mean(B1);
%a0_m = mean(A1);
b0_m = b1;
a0_m = a1;


MSE = mean(MSE1);
%MSE = mse0;

%===========================================

%b1 = sum(XY_bar)/sum(XXbar2);
%b0 = Y_bar - b1*X_bar;
b1 = a0_m;
b0 = b0_m;

Fcn = @(x) b0+b1*x;
Y0 = Fcn(X);
MSE = mean((Y-Y0).^2);
%===========================================


S.Iter = iter0;
S.XRange = [min(X) max(X)];
S.YRange = [min(Y) max(Y)];
S.Slope = b1;
S.Y0 = b0;
S.PredFcn = Fcn;
S.MSE = MSE;
S.RMSE = sqrt(MSE);

RegModel = S;

end

