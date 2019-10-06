classdef neuralNetwork < handle
    %NEURALNETWORK ������
    %   �����ݽ��д�����ʶ������
    
    properties
        inodes
        hnodes
        onodes
        wih
        who
        lr
    end
    
    methods
        function obj = neuralNetwork(inputnodes,hiddennodes,outputnodes,learninggrate)
            %NEURALNETWORK ��ֵ
            
            obj.inodes = inputnodes; % �������Ĵ�С
            obj.hnodes = hiddennodes; % ���ز������
            obj.onodes = outputnodes; % �������

            obj.wih = normrnd(0.0,obj.hnodes^(-0.5),[obj.hnodes,obj.inodes]); % ���ز�
            obj.who = normrnd(0.0,obj.onodes^(-0.5),[obj.onodes,obj.hnodes]); % �����

            obj.lr = learninggrate; % ѧϰ��
        end
        
        function train(obj,inputs_list,targets_list)
            %METHOD1 �����ݽ���ѵ��
            
            % �����ݵĽ������ת��
            inputs = inputs_list';
            targets = targets_list';

            hidden_inputs = obj.wih*inputs; % ���������ز���е��
            hidden_outputs = activation_function(hidden_inputs); % �����������0~1

            final_inputs = obj.who*hidden_outputs; % ���ز����������
            final_outputs = activation_function(final_inputs); % �����������0~1
            output_errors = targets - final_outputs; % �����ʵ�ʵĲ�ֵ
            hidden_errors = obj.who'*output_errors; % ���ز����������Ĳ�ֵ
            
            % �������ز������㣬�Ի����Ѽ�Ȩ
            obj.who = obj.who+obj.lr*((output_errors.*final_outputs.*(1.0 - final_outputs))*hidden_outputs');
            obj.wih = obj.wih+obj.lr*((hidden_errors.*hidden_outputs.*(1.0 - hidden_outputs))*inputs');
        end
        
        function final_outputs = query(obj,inputs_list)
            % ��δ֪���ݽ���Ԥ��
            % �����������ѵ������һ��
            
            inputs = inputs_list';
        
            hidden_inputs = obj.wih*inputs;
            hidden_outputs = activation_function(hidden_inputs);

            final_inputs = obj.who*hidden_outputs;
            final_outputs = activation_function(final_inputs);
        end
    end
end

