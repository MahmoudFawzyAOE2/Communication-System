clc;
clear all;
close all;

%%
%%%%%%%%%%%%%%%%%%%%%%%C/A code with phase tap(3,8)%%%%%%%%%%%%%%%%%%%%%%%
%Register1
SR1=[1 1 1 1 1 1 1 1 1 1];%initial fill of first shift register
SR1_code=zeros(1,1023);% just initialization of the o/p code vector of SR1 and the values have to be changed in the following for loop 
for i=1:1023
    SR1_code(1,i)= SR1(1,10);                    % taking the output
    new_value    = bitxor(SR1(1,10),SR1(1,3));   % creating new value to be added 
    SR1          = circshift(SR1',1)';           % shifting
    SR1(1,1)     = new_value;                    % adding new value from the left
end

%Register2
SR2=[1 1 1 1 1 1 1 1 1 1];%initial fill of second shift register
SR2_code=zeros(1,1023);   % just initialization of the o/p code vector of SR2 and the values have to be changed in the following for loop 
for i=1:1023
    SR2_code(1,i) = bitxor(SR2(1,3),SR2(1,8));
    new_value    = bitxor(SR2(1,10),bitxor(SR2(1,9),bitxor(SR2(1,8),bitxor(SR2(1,6),bitxor(SR2(1,3),SR2(1,2))))));
    SR2          = circshift(SR2',1)';
    SR2(1,1)     = new_value;
end

CA_code_1=xor(SR1_code,SR2_code);    % xor between G1 and G2 to get C/A code_1 

%autocorrelation calculation 
CA_code_1=CA_code_1';   % transpose the code 
CA_code_1=2*CA_code_1-1;%change 1/0 to 1/-1

for shift=0:1022
shifted_code= circshift(CA_code_1,shift);            %shifted version of C/A code 1
autocorrelation_1(shift+1) = CA_code_1'*shifted_code;
end

figure
stem(autocorrelation_1)
grid on
xlabel('shifts');
xlim([0,1023]);
ylabel('value of correlations');
title('1023 chip Gold code(3,8) autocorrelation')

%%
%%%%%%%%%%%%%%C/A code with phase tap (2,6)%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Register1
SR1=[1 1 1 1 1 1 1 1 1 1];%initial fill of first shift register
SR1_code=zeros(1,1023); % just initialization of the o/p code vector of SR1 and the values have to be changed in the following for loop 
for i=1:1023
    SR1_code(1,i)= SR1(1,10);                    % taking the output
    new_value    = bitxor(SR1(1,10),SR1(1,3));   % creating new value to be added 
    SR1          = circshift(SR1',1)';           % shifting
    SR1(1,1)     = new_value;                    % adding new value from the left
    
end

%Register2
SR2=[1 1 1 1 1 1 1 1 1 1];%initial fill of second shift register
SR2_code=zeros(1,1023);% just initialization of the o/p code vector of SR2 and the values have to be changed in the following for loop 
for i=1:1023
    SR2_code(1,i) = bitxor(SR2(1,2),SR2(1,6));
    new_value    = bitxor(SR2(1,10),bitxor(SR2(1,9),bitxor(SR2(1,8),bitxor(SR2(1,6),bitxor(SR2(1,3),SR2(1,2))))));
    SR2          = circshift(SR2',1)';
    SR2(1,1)     = new_value;
end

CA_code_2=xor(SR1_code,SR2_code);             % xor G1 and G2 to get C/A code_2 

% autocorrelation calculation

CA_code_2=CA_code_2';   % transpose the code 
CA_code_2=2*CA_code_2-1;%change 1/0 to 1/-1

for shift=0:1022
shifted_code= circshift(CA_code_2,shift);            %shifted version of C/A code 2
autocorrelation_2(shift+1) = CA_code_2'*shifted_code;
end

figure
stem(autocorrelation_2)
grid on
xlabel('shifts');
xlim([0,1023]);
ylabel('value of correlations');
title('1023 chip Gold code(2,6) autocorrelation')


%%
%%%%%%%%%%%%Cross Correlation between first and second C/A codes %%%%%%%%%%
for i = 0:1:1022
    CA_code_1_sh   = circshift(CA_code_1,[i,0]);
    cross_correlation(i+1) = CA_code_2' * CA_code_1_sh;
end

figure
stem(cross_correlation)
grid on
xlabel('shifts');
xlim([0,1022]);
ylabel('value of correlations');
title('Gold code(3,8)and Gold code(2,6) crosscorrelation')