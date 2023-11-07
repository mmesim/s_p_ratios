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
%-------------- Filtering parameters --------------------------------------
type='bandpass';           %'low', 'high', 'bandpass'
%co=1;                     %low or high corner frequency (high or low pass)
co=[1.5;10];                %low-high corner frequency for bandpass
%--------------------------------------------------------------------------
%---------------- Correlation Parameters ----------------------------------
P_Bpick_win=0.1;           %Window before P arrival [in sec] 
S_Bpick_win=0.1;           %Window before S arrival [in sec]  
P_Apick_win=0.9;           %Window after P arrival [in sec]
S_Apick_win=1.9;           %Window after S arrival [in sec] 
%--------------------------------------------------------------------------
%----------------- Output Files parameters --------------------------------
cc_thres=0.8;              %Minimum CC value for both P and S [0-1]
obs_thres=0;               %Minimum observations for each event pair
fhypodd='hypoDD.cc';       %Filename for hypoDD cc file
fgrowclust='growclust.cc'; %Filename for Growclust  cc file
%--------------------------------------------------------------------------
