%                                S/P ratios                               %
%                       for constraining focal mechanisms                 %
% ------------------  M.Mesimeri 11/2023  ---------------------------------
%                    Swiss Seismological Service                          %
%                     maria.mesimeri@sed.ethz.ch                          %
%--------------------------------------------------------------------------
clear;clc;close all; tic %start timer

%% 00.Setup
parameters %load parameter file
pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir)); %add all *.m scripts to path
stations=my_setup(workers,mydata);
%--------------------------------------------------------------------------
%% 01. Load data (Sac files)
for i=6%:length(stations) %loop through stations
disp(stations(i))    
disp('Loading files..')
[dataZ,dataE,dataN]=my_loadfiles(mydata,stations{i,1},wlen);

%% 02. Filter events
disp('Filter Data...')
[filtDataZ,filtDataE,filtDataN]=my_eventFilter(dataZ,dataE,dataN,min_sp);

%Clear old variables to save memory
clear dataZ dataE dataN

%% 03. Preprocessing Data 
disp('Preprocessing....')
[filtDataZ,filtDataE,filtDataN]=my_preprocessing(filtDataZ,filtDataE,filtDataN,co,type);


%% 04. Measure amplitudes [P,S] & noise 
disp('Calculate Amplitudes...')
[filtDataZ,filtDataE,filtDataN]=sp_ratio_cal(filtDataZ,filtDataE,filtDataN,P_Apick_win,P_Bpick_win,S_Apick_win,S_Bpick_win,Noise_win);

%% 05. Rename structure
newstructure=sprintf('%s_Z',stations{i,1});
eval([newstructure '=  filtDataZ']); 

newstructure=sprintf('%s_E',stations{i,1});
eval([newstructure '=  filtDataE']);

newstructure=sprintf('%s_N',stations{i,1});
eval([newstructure '=  filtDataN']);
end

%% 06. Shutdown parallel pool
delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer


save results.mat
