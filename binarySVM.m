function [w, b] = binarySVM(first, second, C, sigma)
    
    pos = size(first,1);
    neg = size(second,1);
    num = pos + neg;
    sample = [first;second];
    label = [ones(pos,1);-ones(neg,1)];
    
    for i = 1:num
        for j = 1:num
            H(i,j) = label(i) * label(j) * RBF(sample(i,:), sample(j,:), sigma) * (sample(i,:) * sample(j,:)');
        end
    end
    
    f = -ones(num,1);
    a = quadprog(H,f,[],[],label', 0, zeros(num,1), C * ones(num,1)); % alpha
    SV = find(a > 1e-4);
    SV1 = find(a > 1e-4 & a < C);
    b = 0;
    
    for i=1:size(SV1,1)
        temp = 0;
        for j=1:size(SV,1)
            temp = temp + a(SV(j)) * label(SV(j)) * RBF(sample(SV1(i),:), sample(SV(j),:), sigma) * ((sample(SV1(i),:) * (sample(SV(j),:))'));
        end
        b = b + label(SV1(i)) - temp;
    end
    
    % Compute W and b for a binary classifier
    w = sample' * (a .* label);
    b = b / size(SV1,1);

end