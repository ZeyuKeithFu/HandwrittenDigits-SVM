function confusion = Accuracy(pred, test, conf_mat)
    
    % Test Accuracy
    num = size(test,1);
    for i = 1:num
        
        pred_ind = pred(i) + 1;
        true_ind = test(i) + 1;
        conf_mat(pred_ind, true_ind) = conf_mat(pred_ind, true_ind) + 1;
        
    end
    
    confusion = conf_mat;
    
end