load MNIST_data;

% %% Displaying single image
% imagesc(reshape(train_samples(1,:),[28,28]));


%% Parameters Setting
C = 1;
sigma = 1;
train_num = size(train_samples, 1);
test_num = size(test_samples, 1);


%% One VS Rest
global confusion_mat;
global voting_mat;
confusion_mat = zeros(10,10);
voting_mat = zeros(test_num,10);

% Start voting
for i = 0:9
            
    class_i_index = find(test_samples_labels == i);
    class_i = test_samples(class_i_index,:);
    class_0_index = find(test_samples_labels ~= i);
    class_0 = test_samples(class_0_index,:);
    [ovr_w, ovr_b] = binarySVM(class_i, class_0, C, sigma);
            
    for k = 1:test_num
        voting_mat = OVRvote(ovr_w, ovr_b, i, test_samples(k,:), k, voting_mat);
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
