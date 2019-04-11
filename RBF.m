function k = RBF(xi, xj, sigma)

    % Gaussian Kernel
    gamma = 1 / (2 * sigma^2);
    k = exp(-gamma * norm(xi-xj));
    
end