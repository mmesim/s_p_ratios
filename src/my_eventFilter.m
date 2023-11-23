function  [filtDataZ,filtDataE,filtDataN]=my_eventFilter(dataZ,dataE,dataN,min_sp)

%% First find events that are recorded on three stations
ABC_inter=intersect(intersect(vertcat(dataZ.ID),vertcat(dataE.ID),'stable'),vertcat(dataN.ID),'stable');

if ~isempty(ABC_inter)
%Now filter them
%Z
[~,Zindex]=intersect(vertcat(dataZ.ID),ABC_inter);
ndataZ=dataZ(Zindex);

%E
[~,Eindex]=intersect(vertcat(dataE.ID),ABC_inter);
ndataE=dataE(Eindex);

%N
[~,Nindex]=intersect(vertcat(dataN.ID),ABC_inter);
ndataN=dataN(Nindex);

%% Keep events with S-P below the given threshold
Ptime=[ndataZ.A]';
Stime=[ndataE.T0]';

SPdiff=Stime-Ptime;

ind=find(SPdiff>min_sp);


if ~isempty(ind)
%Final filtering of data
filtDataZ=ndataZ(ind);

filtDataE=ndataE(ind);

filtDataN=ndataN(ind);

else 
    filtDataZ = [];
    filtDataE = [];
    filtDataN = [];
end % end if for ind 

else 
    filtDataZ = [];
    filtDataE = [];
    filtDataN = [];
end % end if for ABC_inter
end % end of function 