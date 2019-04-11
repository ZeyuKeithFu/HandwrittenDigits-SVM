load MNIST_data;

% %% Displaying single image
% imagesc(reshape(train_samples(1,:),[28,28]));


%% Parameters Setting
C = 10;
sigma = 10;
train_num = size(train_samples, 1);
test_num = size(test_samples, 1);


%% Build 1v1 SVMs
global w_mat;
global b_mat;
w_mat = zeros(784, 10, 10);
b_mat = zeros(10,10);
for i = 0:9
    for j = 0:9
        if i<j
            
            class_i_index = find(test_samples_labels == i);
            class_i = test_samples(class_i_index,:);
            class_j_index = find(test_samples_labels == j);
            class_j = test_samples(class_j_index,:);
            [ovo_w, ovo_b] = binarySVM(class_i, class_j, C, sigma);
            
            w_mat(:, i+1, j+1) = ovo_w;
            b_mat(i+1, j+1) = ovo_b;
            
        end
    end
end


%% Decision DAGs
global pred_labels;
pred_labels = zeros(test_num,1);

for i = 1:test_num
    
    test = test_samples(i,:);
    j = 0;
    k = 9;
    for l = 1:9
        temp_w = w_mat(:,j+1,k+1);
        temp_b = b_mat(j+1,k+1);
        pred = test * temp_w + temp_b;
        if pred >= 0
            k = k-1;
        else
            j = j+1;
        end
    end
    
    if j == k
        pred_labels(i) = j;
    end
    
end


%% Accuracy
global confusion_mat;
confusion_mat = zeros(10,10);
confusion_mat = Accuracy(pred_labels, test_samples_labels, confusion_mat);
acc = trace(confusion_mat) / test_num;
imagesc(confusion_mat);
title("Accuracy : " + num2str(acc));
