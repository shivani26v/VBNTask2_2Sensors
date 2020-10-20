
% measurement model
% all errors are random and introduced linearly
% all state parameters are measured independent of each other

% variance
sigma_Px = 10; %can assume any value for now
sigma_Py = 10;
sigma_Vx = 10;
sigma_Vy = 10;

% measurement errors
v_Px1 = normrnd (0, sigma_Px, [1, n+1]);
v_Py1 = normrnd (0, sigma_Py, [1, n+1]);
v_Vx1 = normrnd (0, sigma_Vx, [1, n+1]);
v_Vy1 = normrnd (0, sigma_Vy, [1, n+1]);
v_Px2 = normrnd (0, sigma_Px, [1, n+1]);
v_Py2 = normrnd (0, sigma_Py, [1, n+1]);
v_Vx2 = normrnd (0, sigma_Vx, [1, n+1]);
v_Vy2 = normrnd (0, sigma_Vy, [1, n+1]);

v = zeros(8,n+1); %error vector

for i=1:1:n+1
   v(:,i) = [v_Px1(i); v_Py1(i); v_Vx1(i); v_Vy1(i); v_Px2(i); v_Py2(i); v_Vx2(i); v_Vy2(i)];
   Z(:,i) = H*X_true(:,i) + v(:,i);
end

% measurement noise covariance R
for i=1:1:4
    R(i,i) = var(Z(i,:) - X_true(i,:));
    P_updated(i,i,1)=R(i,i);
end

for i=5:1:8
    R(i,i) = var(Z(i,:) - X_true(i-4,:));
end

% position measurement plot
plot(Z(1,:));
hold on;
plot(Z(2,:));

%***