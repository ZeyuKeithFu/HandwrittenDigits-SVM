load MNIST_data;

% %% Displaying single image demo
% imagesc(reshape(train_samples(1,:),[28,28]));


%% Parameters Setting
C = 1;
sigma = 1;
train_num = size(train_samples, 1);
test_num = size(test_samples, 1);


%% One VS One
global confusion_mat;
global voting_mat;
confusion_mat = zeros(10,10);
voting_mat = zeros(test_num,10);

% Start voting
for i = 0:9
    for j = 0:9
        if i<j
            
            class_i_index = find(test_samples_labels == i);
            class_i = test_samples(class_i_index,:);
            class_j_index = find(test_samples_labels == j);
            class_j = test_samples(class_j_index,:);
            [ovo_w, ovo_b] = binarySVM(class_i, class_j, C, sigma);
            
            for k = 1:test_num
                voting_mat = OVOvote(ovo_w, ovo_b, i, j, test_samples(k,:), k, voting_mat);
            end
            
        end
    end
end

% Voting result
pred_label = zeros(test_num,1);
for i = 1:test_num
    vote = voting_mat(i,:);
    pred = find(vote == max(vote));
    pred_label(i) = pred(1) - 1;
end

% Accuracy
confusion_mat = Accuracy(pred_label, test_samples_labels, confusion_mat);
acc = trace(confusion_mat) / test_num;
imagesc(confusion_mat);
title("Accuracy : " + num2str(acc));
