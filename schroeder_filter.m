%schroeder_filter:
%Read in the sound data from the .wav file
[d,r]=audioread('song.wav');  %d - sampled data; r- sample rate

%Set the tap attenuation, delay, number of echoes
a = 0.8;
R = 4; %Delay = 1 second

%Difference equation: 
%Equivalently, by the transfer function: H[z] = -a+z^-R / 1-az^-R , |α| < 1
num=[-a,zeros(1,R-1),1];
den=[1,zeros(1,R-1),-a];

%The output of the filter is computed using the function ’filter’
d1 = filter(num,den,d);

%Play the output of the filter
soundsc(d1,r);

%Save output of the filter
audiowrite('schroeder_filter.wav', d1, r);

%Plot the unit impulse response
subplot(3,2,1);
i =[1,zeros(1,1000000)];
d2= filter(num,den,i);
stem(d2);grid;
xlabel('Sample index');
ylabel('Amplitude');
title(('(a)Unit impulse response'));

%Plot the original signal
subplot(3,2,3);
plot(abs(d));
xlabel('Sample index');
ylabel('Amplitude');
title(('(b)Original signal'));

%Plot the output signal
subplot(3,2,5);
plot(abs(d1));
xlabel('Sample index');
ylabel('Amplitude');
title(('(c)Output signal with artificial reverberation'));

%Plot the magnitude response
subplot(3,2,2);
[h1,w] = freqz(num,den,512);
plot(w/pi,20*log10(abs(h1)));grid
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Magnitude (dB)');
title(('(d)Magnitude response'));

%Plot the spectrogram of the original signal
subplot(3,2,4);
spectrogram(d,[],[],[],r,'yaxis')
title(('(e)Spectrogram of original signal'));

%Plot the spectrogram of the output signal
subplot(3,2,6);
spectrogram(d1,[],[],[],r,'yaxis')
title(['(f)Spectrogram of output signal with artificial reverberation']);