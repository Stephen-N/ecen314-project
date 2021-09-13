% A network of filters to create a natural sounding reveberator
[d,r]=audioread('song.wav');  %d - sampled data; r- sample rate

%Set the tap attenuation, delay
a1 = 0.6;
a2 = 0.4;
a3 = 0.2;
a4 = 0.1;
R1 = 2000;
R2 = 3000;
R3 = 1000;
R4 = 500;

%Difference equations:
num1 =(1);
den1 =[1,zeros(1,R1-1),-a1];
d1 = filter(num1,den1,d);   %feedback_comb filter1

num2 =(1);
den2 =[1,zeros(1,R2-1),-a2];
d2 = filter(num2,den2,d);   %feedback_comb filter2

num3 =[-a3,zeros(1,R3-1),1];
den3 =[1,zeros(1,R3-1),-a3];
d3 = filter(num3,den3,d);   %schroeder_filter

% combine the filters
dSum = d1 + d2 + d3;
num4=[a4,zeros(1,R4-1),1];
den4=[1,zeros(1,R4-1),a4];
dFilter1 = filter(num4, den4, dSum);

%Play the output of the filter
soundsc(dFilter1,r);

%Save output of the filter
audiowrite('filter_network.wav', dFilter1, r);