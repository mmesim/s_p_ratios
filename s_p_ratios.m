%                                S/P ratios                               %
%                                                                         %
% ------------------  M.Mesimeri 11/2023  ---------------------------------
%               Swiss Seismological Service                               %
%                      maria.mesimeri@utah.edu                            %
%--------------------------------------------------------------------------
clear;clc;close all; tic %start timer

%% 00.Setup
parameters %load parameter file
pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir)); %add all *.m scripts to path
[stations,dtE,dtN,dtZ]=my_setup(workers,mydata);
%--------------------------------------------------------------------------
%% 01. Load data (Sac files)
for i=1:length(stations) %loop through stations
disp(stations(i))    
disp('Loading files..')
[yN,yE,yZ,headerN,headerE,headerZ,idZ,idE,idN]=my_loadfiles(mydata,stations{i,1});
%% 02. Preprocess data 
disp('Preprocessing...')
[yZ_proc,yN_proc,yE_proc]=my_preprocessing(yZ,yN,yE,headerZ(1).DELTA,type,co);

%% 03. Do Cross Correlations
disp('Xcorr...')
[npairsZ,npairsE,npairsN,yZ_cut,yE_cut,yN_cut]=my_correlation(yZ_proc,yE_proc,yN_proc,P_Bpick_win,P_Apick_win,S_Bpick_win,S_Apick_win,headerE,headerN,headerZ,idE,idN,idZ,i);

%% 04.Save results for each station
dtZ{i,1}=npairsZ; dtE{i,1}=npairsE; dtN{i,1}=npairsN;
%and jump to next station
end

%% 05. output correlation file
[all_event_pairs,cut_event_pairs]=my_output(dtZ,dtE,dtN,stations,cc_thres,obs_thres,fhypodd,fgrowclust);

%% 06. Shutdown parallel pool
delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer