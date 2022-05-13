%Matlab cache clearing commands
clc;                                                                                                        %clears command window
clear all;                                                                                                  %clears workspace variables
close all;                                                                                                  %closes all external matlab windows

 
Hte=input('Enter Base station Antenna Height (hte)');                                                       %Base Station Height                     between 30 m and 1000 m 
Hre=input('Enter Mobile Station Antenna Height (hre)');                                                     %Mobile Station Antenna Height           between 1 m and 10 m 
d =input('Enter distance from base station');                                                               %distance from base station              between 1Km and 100Km 
f=input('Enter the frequency: ');                                                                           %Frequency                               between 150Mhz and 1920Mhz 
 
for i=1:length(f)
    CH = 0.8 +((1.1*log( f(i)))-0.7)*Hre - 1.56*log(f(i));
    LU(i)=69.55+26.16*log (f(i))-13.82*log(Hte) -CH+(44.9-6.55*log(Hte))*log(d);                            %path loss formula
end
 
figure(1)
plot(f,LU)
title('Frequency vs Loss (dB) for small city for Hata Model');
xlabel('Frequency (MHz)');
ylabel('Propagation Path loss(dB)');
grid on;
[200 300 400 500 600 700 800 900 1000 1100]