% This is a script that uses the output of the s_p_ratios.
% and prepares an input file for HASH.
%Format
%Header
%Event_ID Nobs
%column 01: station name
%column 02: station channel
%column 03: network code
%column 04: noise level
%column 05: P amplitude
%column 06: noise lvel
%column 07: S amplitude

clear;clc;close all
%----------------------------------------------------------------------
%% Parameters
%path to mat files
mydata='/data/tmp/output';
%Minimum Number of observations per event
thres=10;

%% 00.load data
data_path=sprintf('%s/*',mydata);
listing=dir(data_path);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..

for i=2:length(listing)
    
filename=sprintf('%s/%s',mydata,listing(i).name);

S{i,1}=struct2cell(load(filename,'*_Z'));

%Remove NaN from structure
Snew=S{i,1}{1,1}(~cellfun(@isnan,{S{i,1}{1,1}.Pamp}));
Snew=S{i,1}{1,1}(~cellfun(@isnan,{S{i,1}{1,1}.Samp}));
Sfinal{i,1}=S{i,1}{1,1}(~cellfun(@isnan,{S{i,1}{1,1}.Namp}));

end

%One structure
mystruct=[Sfinal{1:end,1}];
clear Snew Sfinal S

%% Filter observations
%Extract IDs from the concatenate structure
ids=vertcat(mystruct.ID);
[N,edges] = histcounts(ids,min(ids):max(ids));

%now find events with minimum Nobs
ind=find(N>=thres);

%% Create output 
fout=fopen('output.txt','w');
for i=1%:length(ind)
        %Here write the header
        index=find(ids==edges(ind(i)));
        fprintf(fout,'%d %d \n',edges(ind(i)),length(index));
    
        for k=1:length(index)
            %Here start writing observations
           
            fprintf(fout,'%4s %3s %2s %10.3f %10.3f %10.3f %10.3f \n',...
                          mystruct(index(k)).KSTNM,...
                          mystruct(index(k)).KCMPNM,...
                          mystruct(index(k)).KNETWK,...
                          mystruct(index(k)).Namp,...
                          mystruct(index(k)).Pamp,...
                          mystruct(index(k)).Namp,...
                          mystruct(index(k)).Samp);
            
        end
    
     
end

fclose(fout);
