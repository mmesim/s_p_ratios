%Parameter file for waveform cross correlation code                       %
%                                                                         % 
% ------------------  M.Mesimeri 04/2020  ---------------------------------
%               University of Utah seismograph Stations                   %
%                      maria.mesimeri@sed.ethz.ch                         %
%--------------------------------------------------------------------------
%path to waveforms
mydata='example'; 
%--------------------------------------------------------------------------
% Parallel settings
workers=2;                 %Set number of cores to work on a local machine

%-------------- Pre-processing parameters ---------------------------------
sps=100;                   %target sampling rate
type='bandpass';           %'low', 'high', 'bandpass'
%co=1;                     %low or high corner frequency (high or low pass)
co=[1.0;10];                %low-high corner frequency for bandpass
%--------------------------------------------------------------------------
%---------------- Signal Window  ----------------------------------
P_Bpick_win=0.5;           %Window before P arrival [in sec] 
S_Bpick_win=0.5;           %Window before S arrival [in sec]  
P_Apick_win=1.0;           %Window after P arrival [in sec]
S_Apick_win=1.0;           %Window after S arrival [in sec] 
%--------------------------------------------------------------------------
Noise_win=1.5;             %Window for Noise [in sec]
%------------------Selection parameters -----------------------------------
min_sn=3;                  %Minimum SNR  [no units] 
min_sp=2;                  %Minimum S-P time [in sec]  
%--------------------------------------------------------------------------
