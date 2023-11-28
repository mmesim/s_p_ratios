function y_proc=do_preprocessing(mystructure,co,type)

%Preallocate memory
y_proc=cell(length(mystructure),1);


parfor i=1:length(y_proc)
%01. remove trend
yr=my_detrend(mystructure(i).waveform,1);

%02. remove mean
yrm=yr-mean(yr);    

%03. filter
yrmf=my_filter(yrm,type,mystructure(i).DELTA,co);
y_proc{i,1}=yrmf;          
                   
end %end of for loop



end


       