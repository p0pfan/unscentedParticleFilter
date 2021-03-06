function [sigma_points, sigma_weights, number_of_points] = getSigmaPoints(x_mean_previous_a, P_previous_a, alpha, beta, kappa)
% the Scaled Unscented transformation
% Input:
    % x_mean_previous_a     
    % P_previous_a 
    % alpha
    % beta
    % kappa
% Output:
    % sigma_points          -- dim(3x7)
    % sigma_weights         -- dim(1x7)
    % number_of_points      

n_x_mean_a = size(x_mean_previous_a,1); %3
number_of_points = n_x_mean_a*2 + 1; %7

lambda = alpha^2*(n_x_mean_a + kappa)-n_x_mean_a; 

sigma_points = zeros(n_x_mean_a, number_of_points); %3x7
sigma_weights = zeros(1, number_of_points); %1x7

% Calculate matrix square root 
sqrt_matrix = (chol((n_x_mean_a+lambda)*P_previous_a))'; % 3x3
% Define the sigma_points columns
sigma_points = [zeros(size(P_previous_a,1),1), -sqrt_matrix, sqrt_matrix]; %%%%% 
% Add mean to the rows
sigma_points = sigma_points + repmat(x_mean_previous_a, 1, number_of_points);

% Define the sigma_weights columns 
sigma_weights = [lambda, 0.5*ones(1,(number_of_points-1)), 0] / (n_x_mean_a+lambda);

sigma_weights(number_of_points+1) = sigma_weights(1) + (1-(alpha^2)+beta); 

end

