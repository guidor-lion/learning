function outputs = getpic(path)
% ����ͼƬ������1x1024�ľ���

% ����ͼƬ
pic = imread(path);
% ����ͼƬ��СΪ32x32
afpic = imresize(pic,[32,32]);

% rgb����ֵÿ����С��130�����ص���Ϊ1��������Ϊ0
pic_shape = size(afpic);
outputs = [];
for i=1:pic_shape(1)
    for j=1:pic_shape(2)
        if afpic(i,j,1)<=130 && afpic(i,j,2)<=130 && afpic(i,j,3)<=130
            outputs = [outputs 1];
        else
            outputs = [outputs 0];
        end
    end
end
end