function k = Poly(xi, xj, c)

    % Polynomial Kernel
    k = (xi * xj' + c)^2;

end