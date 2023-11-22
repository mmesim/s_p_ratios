function  [filtDataZ,filtDataE,filtDataN]=my_eventFilter(dataZ,dataE,dataN)

%% First find events that are recorded on three stations
ABC_inter=intersect(intersect(vertcat(dataZ.ID),vertcat(dataE.ID),'stable'),vertcat(dataN.ID),'stable');

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
j=1;
for i=1:length(ndataZ)
    temp=ndataN(i).T0-ndataZ(i).A;
   if  temp>min_sp
       ind(j,1)=i;
       j=j+1;
   end
end

%Final filtering of data
filtDataZ=ndataZ(ind);

filtDataE=ndataE(ind);

filtDataN=ndataN(ind);
end