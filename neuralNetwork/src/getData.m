function data = getData(infile)
%�õ�����
s = fscanf(infile,'%s');

count1 = 0;count2 = 0;
data = [];indata = [];

% ÿ1024��0/1Ϊһ�����֣�ÿ������ռһ�С�
% ���һ��Ϊ�����ֵ�ֵ(Ԥ����������һ������9)��
for i=s
    if count1~=32
        indata = [indata str2num(i)];
        count1 = count1+1;
    else
        count2 = count2+1;
        if count2 == 32
            indata = [indata str2num(i)];
            data = [data;indata];
            indata = [];
            count2 = 0;
            count1 = 0;
        else
            indata = [indata str2num(i)];
            count1 = 1;
        end
    end  
end

end