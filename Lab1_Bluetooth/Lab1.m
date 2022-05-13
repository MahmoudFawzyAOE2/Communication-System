clc;
clear all;
%%
% System parameters
M      = 8;       % Number of Symbols
k      = log2(M); % Number of bits per Symbol
N_bits = 1000000;    % total number of bits
SNR = 0;

%% 

Xn= randi([0 1],1,N_bits); %Generate a sequence of bits equal to the total number of bits

Zn = dpskmod(Xn,M); % Generate a Modulated sequence

rn = Zn + (1/(2*sqrt(SNR)))*(randn + j*randn); % Generate a recieved seq.

Dn = dpskdemod(rn,M); % Generate a DeModulated sequence

[N_error_bits,BER] = biterr(Xn,Dn); %Calculate the bit error rate

BER
%%
SNR = 0:0.5:15;
BER_vec = zeros(1,15);  % Use this vector to store the resultant BER
    
for i = 1:length(SNR)
    
    
    rn = Zn + (1/(2*sqrt(SNR(i))))*(randn(1,N_bits) + j*randn(1,N_bits)); % Generate a recieved seq.

    Dn = dpskdemod(rn,M); % Generate a DeModulated sequence

    [N_error_bits,BER_vec(i)] = biterr(Xn,Dn); %Calculate the bit error rate

end

% Plotting results
plot(SNR,BER_vec,'d-b','linewidth',2); hold on;
xlabel('SNR(dB)','fontsize',10)
ylabel('BER','fontsize',10)
title('Relation between BER & SNR')