function plotDigit(allvalues)
%�������ֵ�ͼ��
digit = [];
row = [];
%�����ֻ������ص�
%0 => [255,255,255]  1 => [0,0,0]
for i = 1:1024
    if allvalues(i) == 0
        row = [row,[255,255,255]];
    else
        row = [row,[0,0,0]];
    end
    %ÿ32������
    if mod(i,32) == 0
        digit = [digit;row];
        row = [];
    end
end
imshow(digit,'InitialMagnification','fit');
end