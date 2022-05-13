clc;
clear all;

% System parameters
M = 16;             % Number of Symbols
k = log2(M);        % Number of bits per Symbol
N_bits = 1000000*k;    % total number of bits


Hte= 50;  %Base Station Height                     between 30 m and 1000 m 
Hre= 5;   %Mobile Station Antenna Height           between 1 m and 10 m 
d = 50;   %distance from base station              between 1Km and 100Km 
f= 1400;   %Frequency                               between 150Mhz and 1920Mhz 
 
P_sig = 250; %dB

% Generating Transmitted signal
Xn= randi([0 1 ],N_bits,1);          %Generate a sequence of bits equal to the total number of bits
txSig = qammod(Xn,M,'InputType','bit','UnitAveragePower',true);  % Generate a Modulated sequence

% Hata Model for small city
CH = 0.8 +((1.1*log( f))-0.7)*Hre - 1.56*log(f);    
L=69.55+26.16*log (f)-13.82*log(Hte) -CH+(44.9-6.55*log(Hte))*log(d);
    
% Reciving
SNR_vec = [0:15] + P_sig - L ;
BER_vec = zeros(1,15); % Use this vector to store the resultant BER

for i = 1:length(SNR_vec)

    rxSig = awgn(txSig,SNR_vec(i));    % Generate a recieved seq.
    Dn = qamdemod(rxSig,M, 'bin','OutputType','bit'); % Generate a DeModulated sequence
    [N_error_bits,BER_vec(i)] = biterr(Xn,Dn); %Calculate the bit error rate

end
figure;
% Plotting results
plot(SNR_vec,BER_vec,'d-b','linewidth',2); hold on;
xlabel('SNR(dB)','fontsize',10)
ylabel('BER','fontsize',10)
title('Relation between BER & SNR')