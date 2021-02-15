function RegModel = RegFcnGen(XY_data)
% Generatate the regession functions and parameters
% XY_data must be [Nx2]


X = XY_data (:,1);
Y = XY_data (:,2);

Y_bar = mean(Y);
X_bar = mean(X);

XXbar2 = (X-X_bar*ones(1,length(X_bar))).^2;
XY_bar = (X-X_bar*ones(1,length(X_bar))).*(Y-Y_bar*ones(1,length(Y_bar)));

b1 = sum(XY_bar)/sum(XXbar2);
b0 = Y_bar - b1*X_bar;

Fcn = @(x) b0+b1*x;
Y0 = Fcn(X);
MSE = mean((Y-Y0).^2);

S.XRange = [min(X) max(X)];
S.YRange = [min(Y) max(Y)];
S.Slope = b1;
S.Y0 = b0;
%S.predictFcn = @(x) b0+b1*x;
S.PredFcn = Fcn;
S.MSE = MSE;
S.RMSE = sqrt(MSE);

RegModel = S;

end

