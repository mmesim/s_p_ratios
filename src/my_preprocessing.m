function [filtDataZ,filtDataE,filtDataN]=my_preprocessing(filtDataZ,filtDataE,filtDataN,co,type)

%Preprocessing
%Check if structure is not empty and then 
%(1) remove trend
%(2) remove mean
%(3) Resample
%(4) Filter

if ~isempty(filtDataZ) && ~isempty(filtDataZ) && ~isempty(filtDataZ)
    yZ_proc=do_preprocessing(filtDataZ,co,type);
    yE_proc=do_preprocessing(filtDataE,co,type);
    yN_proc=do_preprocessing(filtDataN,co,type);    

    [filtDataZ.wav_proc] = yZ_proc{:};
    [filtDataE.wav_proc] = yE_proc{:};
    [filtDataN.wav_proc] = yN_proc{:};
    
    
end % end of initial if that checks if structure is not empty

end  % end of function