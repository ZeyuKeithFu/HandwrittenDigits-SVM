function voting = OVOvote(w, b, class_i_label, class_j_label, test, test_ind, voting_mat)
    
    % Predict Single Result
    y = test * w + b;
    if y >= 0
        voting_mat(test_ind, class_i_label+1) = voting_mat(test_ind, class_i_label+1) + 1;
    else
        voting_mat(test_ind, class_j_label+1) = voting_mat(test_ind, class_j_label+1) + 1;
    end
    voting = voting_mat;
    
end