%Parameter file for S_P ratio calculation                                 %
%                                                                         % 
% ------------------  M.Mesimeri 10-11/2023  ---------------------------------
%               Swiss Seismological Service | Bedretto Lab                %
%                      maria.mesimeri@sed.ethz.ch                         %
%--------------------------------------------------------------------------
%path to waveforms
mydata='/scratch/mesimeri/data_sac/'; 
%--------------------------------------------------------------------------
% Parallel settings
workers=80;                 %Set number of cores to work on a local machine

%-------------- Pre-processing parameters ---------------------------------
type='bandpass';           %'low', 'high', 'bandpass'
%co=1;                     %low or high corner frequency (high or low pass)
co=[1.0;10];                %low-high corner frequency for bandpass
%--------------------------------------------------------------------------
%---------------- Signal Window  ----------------------------------
P_Bpick_win=0.1;           %Window before P arrival [in sec] 
S_Bpick_win=0.5;           %Window before S arrival [in sec]  
P_Apick_win=0.9;           %Window after P arrival [in sec]
S_Apick_win=1.0;           %Window after S arrival [in sec] 
%--------------------------------------------------------------------------
Noise_win=1.0;             %Window for Noise [in sec]
%------------------Selection parameters -----------------------------------
min_sn=3;                  %Minimum SNR  [no units] 
min_sp=2;                  %Minimum S-P time [in sec]  
%--------------------------------------------------------------------------
wlen=60;                   %Input waveform length [in sec]
