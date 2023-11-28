function   [dataZ,dataE,dataN]=my_loadfiles(mydata,station)
%list all sac files in "STATION"/ directory
%and loop through them to read sac files

% Define structures - This fix here solves the issue with variable length
% sac headers. This can happen if the header contains info about the
% station coordinates and the event coordinates. Specifically, if you open
% this files with sac automaticaly adds new entries regarding azimuth and
% backazimuth. That means that if you open a few files to visualize the
% waveforms then the headers will not have the same length as those that
% were never touched. 
%the idea was taken from my template detection code
dataZ = struct('ID',{},'waveform',{},'DELTA',{}, 'A', {}, 'EVLA',{}, ...
                   'EVLO',{}, 'EVDP', {}, ...
                    'MAG',{}, 'NZYEAR',{}, 'NZJDAY',{}, ...
                    'KSTNM', {}, 'KCMPNM',{}, 'KNETWK', {} );

dataE = struct('ID',{},'waveform',{},'DELTA',{}, 'T0', {}, 'EVLA',{}, ...
                   'EVLO',{}, 'EVDP', {}, ...
                    'MAG',{}, 'NZYEAR',{}, 'NZJDAY',{}, ...
                    'KSTNM', {}, 'KCMPNM',{}, 'KNETWK', {} );

dataN = struct('ID',{},'waveform',{},'DELTA',{}, 'T0', {}, 'EVLA',{}, ...
                   'EVLO',{}, 'EVDP', {}, ...
                    'MAG',{}, 'NZYEAR',{}, 'NZJDAY',{}, ...
                    'KSTNM', {}, 'KCMPNM',{}, 'KNETWK', {} );

data_path=sprintf('%s/%s/*',mydata,station);
listing=dir(data_path);
listing(ismember( {listing.name}, {'.', '..'})) = [];  %remove . and ..
%--------------------------------------------------
j=1;jj=1;jjj=1;
for i=1:length(listing)
filename=sprintf('%s/%s/%s',mydata,station,listing(i).name);
[D,~,header]=rdsac(filename);    
splitfilename=strsplit(listing(i).name,'.');
%Comment --- The filename should be something like 
%         ID NETWORK STATION CHANNEL SAC
%         eg. 001.UU.FORU.HHZ.sac
%--------------------------------------------------
    if splitfilename{1,4}(3) == 'Z'    
    %------- add headers to a signle structure --------
    %Upadated to keep specific entries
    dataZ(j)=struct('ID',str2double(splitfilename{1,1}),'waveform',double(D),'DELTA',header.DELTA, 'A', header.A, 'EVLA', header.EVLA, ...
                   'EVLO',header.EVLO, 'EVDP', header.EVDP , ...
                    'MAG',header.MAG, 'NZYEAR',header.NZYEAR, 'NZJDAY',header.NZJDAY, ...
                    'KSTNM', header.KSTNM, 'KCMPNM', header.KCMPNM , 'KNETWK', header.KNETWK );
    
    j=j+1;
    elseif splitfilename{1,4}(3) == 'E' || splitfilename{1,4}(3) == '1' 
    %------- add headers to a signle structure --------
    %Upadated to keep specific entries
    dataE(jj)=struct('ID',str2double(splitfilename{1,1}),'waveform',double(D),'DELTA',header.DELTA, 'T0', header.T0, 'EVLA', header.EVLA, ...
                   'EVLO',header.EVLO, 'EVDP', header.EVDP , ...
                    'MAG',header.MAG, 'NZYEAR',header.NZYEAR, 'NZJDAY',header.NZJDAY, ...
                    'KSTNM', header.KSTNM, 'KCMPNM', header.KCMPNM , 'KNETWK', header.KNETWK );
    jj=jj+1;
     elseif splitfilename{1,4}(3) == 'N' || splitfilename{1,4}(3) == '2' 
    %------- add headers to a signle structure --------
    %Upadated to keep specific entries
    dataN(jjj)=struct('ID',str2double(splitfilename{1,1}),'waveform',double(D),'DELTA',header.DELTA, 'T0', header.T0, 'EVLA', header.EVLA, ...
                   'EVLO',header.EVLO, 'EVDP', header.EVDP , ...
                    'MAG',header.MAG, 'NZYEAR',header.NZYEAR, 'NZJDAY',header.NZJDAY, ...
                    'KSTNM', header.KSTNM, 'KCMPNM', header.KCMPNM , 'KNETWK', header.KNETWK );
    
    jjj=jjj+1;  
    end
end



%--------------------------------------------------
end

