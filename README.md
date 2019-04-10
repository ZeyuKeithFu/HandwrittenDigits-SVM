# HandwrittenDigits-SVM
An SVM practice on MNIST handwritten digits image [dataset](http://yann.lecun.com/exdb/mnist/). Dataset includes 4,000 training examples and 1,000 testing examples.
## Gaussian Kernel SVM
Implementation of Gaussian kernel function including two voting scheme for multi-class classification:
* ***One versus one***   
For K classes(K = 10 in this handwritten digits classification task), K*(K-1)/2 classifiers are trained. Each one of them can classify between two classes, where positive class get ```+1``` vote and ```0``` vote for negtive class. The prediction result is the class with max number of votes.
* ***One versus the rest***   
For K classes, only K classifiers are trained. Each classifier can tell if a training example is in a class or not. Here I use a variant of the one-versus-the-rest scheme where the target value is modified so that the positive class has the value ```+1``` and the negative class has the value ```−1/(K − 1)```. This scheme is proposed by [Lee et al](https://amstat.tandfonline.com/doi/abs/10.1198/016214504000000098?casa_token=IWVpikLEAy8AAAAA:rYcXWekSx_QZjPW4dyGdgLf8nyyhzJxQV-iErQQBWGk6bKYsBo_F_413d6IAx54vVpVN2K5pVJA-#.XK1nZev0nBI).   
   
Comparing the prediction result and true labels of testing examples, we can compute the accuracy of the multi-class SVM classifier. Using [confusion matrix](https://en.wikipedia.org/wiki/Confusion_matrix) is a good way to show the result and also visualize it.   
* Accuracy of ```One versus one``` scheme : 0.943
![](https://github.com/ZeyuKeithFu/HandwrittenDigits-SVM/blob/master/Gaussian%20Kernel%20SVM/SVM_RBF_OVO.png)   
   
* Accuracy of ```One versus the rest``` scheme : 0.876
![](https://github.com/ZeyuKeithFu/HandwrittenDigits-SVM/blob/master/Gaussian%20Kernel%20SVM/SVM_RBF_OVR.png)   
