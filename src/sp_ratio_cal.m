function   [filtDataZ,filtDataE,filtDataN]=sp_ratio_cal(filtDataZ,filtDataE,filtDataN,P_Apick_win,P_Bpick_win,S_Apick_win,S_Bpick_win,Noise_win)
%function to calculate S/P ratios
%Similar to Yang et al., 2012 [BSSA] Southern California

%Preallocate memory 
Pamp=NaN(length(filtDataZ),1);
Samp=Pamp; Namp=Pamp; SP=Pamp; SNR=Pamp;

if ~isempty(filtDataZ) && ~isempty(filtDataZ) && ~isempty(filtDataZ)

%% Calculate amplitudes
parfor i=1:length(filtDataZ)
% 00. Extract vector from structure
yZ=filtDataZ(i).wav_proc;    
yE=filtDataE(i).wav_proc; 
yN=filtDataN(i).wav_proc; 

% 01. Define start and Stop
Pstart=round((filtDataZ(i).A-P_Bpick_win)./filtDataZ(1).DELTA); %window before P pick
Sstart=round((filtDataE(i).T0-S_Bpick_win)./filtDataE(1).DELTA); %window before S pick

Pstop=round((filtDataZ(i).A+P_Apick_win)./filtDataZ(1).DELTA); %window after P pick
Sstop=round((filtDataE(i).T0+S_Apick_win)./filtDataE(1).DELTA); %window after S pick;


Nstart=Pstart-(Noise_win/filtDataZ(1).DELTA); %window after pick;
Nstop=Pstart; %Noise window stops when P window starts 


%Compute Amplitudes

Pamp(i,1)=my_amplitudes(fix(Pstart),fix(Pstop),yZ,yE,yN);

Samp(i,1)=my_amplitudes(fix(Sstart),fix(Sstop),yZ,yE,yN);

Namp(i,1)=my_amplitudes(fix(Nstart),fix(Nstop),yZ,yE,yN);

SNR(i,1)=Pamp(i,1)./Namp(i,1);

SP(i,1)=Samp(i,1)./Pamp(i,1);


end 

%% import new vectors to the structure
   Pamp=num2cell(Pamp);
   [filtDataZ.Pamp] = Pamp{:};
   [filtDataE.Pamp] = Pamp{:};
   [filtDataN.Pamp] = Pamp{:};
   
   Samp=num2cell(Samp);
   [filtDataZ.Samp] = Samp{:};
   [filtDataE.Samp] = Samp{:};
   [filtDataN.Samp] = Samp{:};
   
   Namp=num2cell(Namp);
   [filtDataZ.Namp] = Namp{:};
   [filtDataE.Namp] = Namp{:};
   [filtDataN.Namp] = Namp{:};
   
   SNR=num2cell(SNR);
   [filtDataZ.SNR] = SNR{:};
   [filtDataE.SNR] = SNR{:};
   [filtDataN.SNR] = SNR{:};
   
   SP=num2cell(SP);
   [filtDataZ.SP] = SP{:};
   [filtDataE.SP] = SP{:};
   [filtDataN.SP] = SP{:};
   
   
end %end of if [that checks if structure is not empty]
end %end of function