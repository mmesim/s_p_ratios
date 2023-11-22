function y_proc=do_preprocessing(mystructure,co,type,sps)

%Preallocate memory
y_proc=cell(length(mystructure),1);


for i=1:length(y_proc)
%01. remove trend
yr=my_detrend(mystructure(i).waveform,1);
%02. remove mean
yrm=yr-mean(yr);
       
%03. Resample if needed
if sps ~= round(1/mystructure(1).DELTA)
yrmr=resample(yrm,round(1/mystructure(1).DELTA),sps);
%04. filter
yrmrf=my_filter(yrmr,type,mystructure(1).DELTA,co);

y_proc{i,1}=yrmrf;

else
%04. filter
yrmf=my_filter(yrm,type,mystructure(1).DELTA,co);
y_proc{i,1}=yrmf;          
           
end % end of resampling if

        
end %end of for loop



end


       