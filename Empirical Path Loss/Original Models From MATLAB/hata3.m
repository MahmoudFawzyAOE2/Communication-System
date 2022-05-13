%Matlab cache clearing commands
clc;                                                                                                        %clears command window
clear all;                                                                                                  %clears workspace variables
close all;                                                                                                  %closes all external matlab windows


Hte=input('Enter Base station Antenna Height (hte)');                                                       %Base Station Height                     between 30 m and 1000 m 
Hre=input('Enter Mobile Station Antenna Height (hre)');                                                     %Mobile Station Antenna Height           between 1 m and 10 m 
d =input('Enter distance from base station');                                                               %distance from base station              between 1Km and 100Km 
f=input('Enter the frequency: ');                                                                           %Frequency                               between 150Mhz and 1920Mhz 

for i=1:length(Hre)
    CH = 0.8 +((1.1*log( f))-0.7)*Hre(i) - 1.56*log(f);
    LU(i)=69.55+26.16*log(f)-13.82*log(Hte)-CH+(44.9-6.55*log(Hte))*log(d);                                 %path loss formula
end
 
figure(1)
plot(Hre,LU)
title('Receiver Antenna Height(m) vs Loss (dB) for small city for Hata Model');
xlabel('Receiver Antenna Height(m)');
ylabel('Propagation Path loss(dB)');
grid on;


