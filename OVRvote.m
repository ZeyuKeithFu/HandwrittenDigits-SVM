function voting = OVRvote(w, b, class_i_label, test, test_ind, voting_mat)

    % Predict Single Result
    y = test * w + b;
    if y >= 0
        voting_mat(test_ind,:) = voting_mat(test_ind,:) - 1/9;
        voting_mat(test_ind, class_i_label+1) = voting_mat(test_ind, class_i_label+1) + 1 + 1/9;
    else
        voting_mat(test_ind,:) = voting_mat(test_ind,:) + 1;
        voting_mat(test_ind, class_i_label+1) = voting_mat(test_ind, class_i_label+1) -1 - 1/9;
    end
    voting = voting_mat;

end