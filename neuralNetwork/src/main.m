% ʹ����������ʶ����д����
% ����Ϊ0/1����ɫ����Ϊ0����ɫ����Ϊ1.
% digit-training.txtΪѵ������
% digit-testing.txtΪ��������
% digit-predict.txtΪ����ʶ�������
clear;clc;

% �ж��Ƿ��Ѿ�����ѵ���õ�������
y_n = 1;
if exist('network.mat','file')
    y_n = input('ѵ���õ��������Ѵ��ڣ���(1)��(0)����ѵ��������:');
end

if y_n == 1
    % ����ѵ������
    input_nodes = 1024; % �������ݴ�С
    hidden_nodes = 100; % ���ز�����
    output_nodes = 10; % �������
    learning_rate = 0.4; % ѧϰ��

    n = neuralNetwork(input_nodes,hidden_nodes,output_nodes,learning_rate);

    % ѵ��������
    disp('Beginning of geting training data');

    % �õ�ѵ������
    trainfile = fopen('../data/digit-training.txt','r');
    train_data = getData(trainfile);
    fclose(trainfile);

    % ���ñ�ǩ
    trainmenu = [0 0 0 0 0 0 0 0 0 0];
    data_shape = size(train_data);

    disp('Beginning of Training');
    % ��ÿ�����ݶ�����ѵ���������Ѽ�Ȩ
    for i = 1:data_shape(1)
        all_values = train_data(i,:);
        trainmenu(all_values(1025)+1) = trainmenu(all_values(1025)+1)+1;% ��ÿ�����ֽ��м���
        % ��Ϊ0��ֵ��Ϊ0.01��1��ֵ��Ϊ1
        inputs = (all_values(1:1024)*0.99)+0.01;
        % ����Ŀ��ֵ
        targets = zeros(1,output_nodes)+0.01;
        targets(all_values(end)+1)= 0.99;
        n.train(inputs,targets)
    end

    % ��ѵ����������索������
    save network.mat n;

    % ����������
    disp('Beginning of geting testing data');

    % �õ���������
    testfile = fopen('../data/digit-testing.txt','r');
    % testfile = fopen('./test.txt','r');
    test_data = getData(testfile);
    fclose(testfile);

    % ���ñ�ǩ
    testmenu = [[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0]];
    data_shape = size(test_data);

    disp('Beginning of testing');
    % ��ÿ�����ݽ��в��ԣ����������ʵֵ�Ƿ�һ��
    for i = 1:data_shape(1)
        all_values = test_data(i,:);
        real_digit = all_values(end);
        % ��Ϊ0��ֵ��Ϊ0.01��1��ֵ��Ϊ1
        inputs = (all_values(1:1024)*0.99)+0.01;
        % ����ʶ��
        outputs = n.query(inputs);
        [value,predict_digit] = max(outputs(:));
        % �Խ�������жϣ������������С�
        if (predict_digit-1) == real_digit
            testmenu(real_digit+1,1) = testmenu(real_digit+1,1)+1;
        else
            testmenu(real_digit+1,2) = testmenu(real_digit+1,2)+1;
        end 
    end

    % ���ѵ������
    disp('----------------------------');
    disp('        Training Info       ');
    disp('----------------------------');
    for i = 1:10
        disp(['           ',num2str(i-1),' : ',num2str(trainmenu(i))]);
    end

    % ������Խ��
    disp('----------------------------');
    disp('        Testing Info        ');
    disp('----------------------------');
    right = 0;
    wrong = 0;
    for i = 1:10
        disp(['        ',num2str(i-1),' : ',...
            num2str(100*testmenu(i,1)/(testmenu(i,1)+testmenu(i,2))),'%'])
        right = right + testmenu(i,1);
        wrong = wrong + testmenu(i,2);
    end
    disp('----------------------------');
    disp(['right/wrong=',num2str(right),'/',num2str(wrong),' '...
        ,num2str(100*right/(right+wrong)),'%']);
    disp('----------------------------');
else
    load('network.mat');
end

% �ж��Ƕ���ͼƬ����ʹ������
readpic = input('��(1)��(0)ʹ��ͼƬ(�׵׺�����):');

if ~readpic
    % �����ݽ���ʶ��
    predictfile = fopen('../data/digit-predict.txt','r');
    predict_data = getData(predictfile);
    fclose(predictfile);

    % ���Ҫʶ������ֵ�����
    data_shape = size(predict_data);
    disp(['Ҫʶ�����ֵ�����:',num2str(data_shape(1))]);

    while 1
        % ����Ҫʶ������
        index = input('���������[�˳�������0]:');

        % �ж��Ƿ��˳�
        if index == 0
            break;
        end

        % �ж����
        while (index<1) || (index>12)
            index = input('���벻��1~12֮�䣬����������:');
        end

        % ����ʶ��,�����
        all_values = predict_data(index,:);
        inputs = (all_values(1:1024)*0.99)+0.01;
        outputs = n.query(inputs);
        [value,predict_digit] = max(outputs(:));
        disp(['ʶ����:',num2str(predict_digit-1)]);
        plotDigit(all_values(1:1024));
    end
else
    while 1
        path = input('������ͼƬ�ľ���·��(·��������)[�˳�������0]��');
        
        % �ж��Ƿ��˳�
        if path == 0
            break;
        end
        
        % �ж�ͼƬ�Ƿ����
        while ~exist(path,'file')
            path = input('ͼƬ�����ڣ�');
        end
        
        % ����ʶ��,�����
        all_values = getpic(path);
        inputs = (all_values(1:1024)*0.99)+0.01;
        outputs = n.query(inputs);
        [value,predict_digit] = max(outputs(:));
        disp(['ʶ����:',num2str(predict_digit-1)]);
        plotDigit(all_values(1:1024));
    end
end