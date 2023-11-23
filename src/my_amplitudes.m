function amp=my_amplitudes(start,stop,yZ,yE,yN)

%simple function to calculate amplitudes
%It cuts the waveforms around the pick
%Finds the difference between the maximum and minimum amplitude
%Performs vector summation over three compontents


%00. Cut waveforms
cut1=yZ(start:stop,1);
cut2=yE(start:stop,1);
cut3=yN(start:stop,1);

%01. Find minimum and maximum
diff_cut1=max(cut1)-min(cut1);
diff_cut2=max(cut2)-min(cut2);
diff_cut3=max(cut2)-min(cut3);


%02. Return Amplitude
amp=diff_cut1+diff_cut2+diff_cut3;

end 