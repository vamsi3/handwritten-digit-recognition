clear all;

train_set = imagesMNIST('train-images.idx3-ubyte')';
train_label = labelsMNIST('train-labels.idx1-ubyte');
test_set = imagesMNIST('t10k-images.idx3-ubyte')';
test_label = labelsMNIST('t10k-labels.idx1-ubyte');

alpha = 0.1;
hidden_layer = 250;
iterations = 1;

K = 10;
train_set_size = size(train_set);
N = train_set_size(1);
D = train_set_size(2);
W1 = 2*rand(1+D, hidden_layer)-1; 
W2 = 2*rand(1+hidden_layer, K)-1;
Y = eye(K);

for i=1:iterations
    for j=1:N
        inp = [1; train_set(j, :)'];
        hidden_o = [1; sigmoid(W1'*inp)];
        output = sigmoid(W2'*hidden_o);
        delta_c = (output - Y(:, train_label(j)+1)) .* output .* (1-output);
        delta_h = (W2*delta_c) .* (hidden_o) .* (1-hidden_o);
        delta_h = delta_h(2:end);
        W1 = W1 - alpha*(inp * delta_h');
        W2 = W2 - alpha*(hidden_o * delta_c');
    end
end

counter = 0;
test_size = size(test_set);

for i=1:test_size(1)
    inp = [1; test_set(i, :)'];
    hidden_o = [1; sigmoid(W1' * inp)];
    output = sigmoid(W2' * hidden_o);
    [unit, index] = max(output);
    if(index == test_label(i)+1)
        counter = counter + 1;
    end
end

accuracy = counter/test_size(1);
disp(['The accuracy is: ', num2str(accuracy)]);