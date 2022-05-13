%Matlab cache clearing commands
clc;                                                                                                        %clears command window
clear all;                                                                                                  %clears workspace variables
close all;                                                                                                  %closes all external matlab windows


Hte=input('Enter Base station Antenna Height (hte)');                                                       %Base Station Height                     between 30 m and 1000 m 
Hre=input('Enter Mobile Station Antenna Height (hre)');                                                     %Mobile Station Antenna Height           between 1 m and 10 m 
d =input('Enter distance from base station');                                                               %distance from base station              between 1Km and 100Km 
f=input('Enter the frequency: ');                                                                           %Frequency                               between 150Mhz and 1920Mhz 

cm=0;
city_type=input('Enter 1 for small cities and 2 for large cities : ');                                         % Type of city size
for i=1:length(f)
if(city_type==1)                                                                                               % for small city
CH = 0.8 +((1.1*log(f(i)))-0.7)*(Hre) - 1.56*log(f(i));
else                                                                                                           % for large city
if(f(i)>=150 && f(i)<=200)
CH=8.29*(log(1.54*Hre))*2-1.1;
elseif(f(i)>200 && f(i)<=1500)
CH=3.2*(log(11.75*Hre))*2-4.97;
end
end
LU1(i)=69.55+26.16*log(f(i))-13.82*log(Hte)-CH+(44.9-6.55*log(Hte))*log(d);                                     % loss for hata model
LU2(i)=46.3+33.9*log(f(i))-13.82*log(Hte)-CH+(44.9-6.55*log(Hte))*log(d)+cm;                                    % loss for extended hata model
end

figure(1)
plot(f,LU2,'Linewidth',3)
hold on;
plot(f,LU1,'Linewidth',3)
hold on;
title('Hata Model and Extended Hata Model - Frequency (MHz) vs Loss (dB) ');
xlabel('Frequency (MHz)');
ylabel('Propagation Path loss(dB)');
legend('Extended Hata model','Hata Model');
grid on;

