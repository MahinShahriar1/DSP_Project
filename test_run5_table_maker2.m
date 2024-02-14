clc;
clear;
close all;

%% Reading edf file
chb = edfread("E:\L-3,T-1\DSP project\CHBMIT\chb-mit-scalp-eeg-database-1.0.0\chb03\chb03_36.edf");
info = edfinfo("E:\L-3,T-1\DSP project\CHBMIT\chb-mit-scalp-eeg-database-1.0.0\chb03\chb03_36.edf");
fs = info.NumSamples/seconds(info.DataRecordDuration);

% signum = 1; %channel number

wav_mat=[];
for signum=1:info.NumSignals
    
    wav_vec=[];
    for N=1665: 1778
        
        y=window;
        y.wav=[];
        for recnum=N:N
            y.wav=[y.wav; chb.(signum){recnum}];
        end
        %% Discrete wavelet Transform
        [y.c, y.l] = wavedec(y.wav, 5, 'db4'); % level & coefficient;
        y.a5 = appcoef(y.c, y.l, 'db4');
        [y.d5, y.d4, y.d3] = detcoef(y.c, y.l, [1 2 3 4 5]);
        
        %% Feature Extraction
        y.a5e = energy(y.a5);
        y.a5cof = Coefficirntofvariation(y.a5);
        y.d5e = energy(y.d5);
        y.d5cof = Coefficirntofvariation(y.d5);
        y.d4e = energy(y.d4);
        y.d4cof = Coefficirntofvariation(y.d4);
        y.d3e = energy(y.d3);
        y.d3cof = Coefficirntofvariation(y.d3);
        y.iqr = Interquartilerange(y.wav);
        y.mad = Medianabsolutedeviation(y.wav);
        
        
        wav_vec = [wav_vec; y];
        
    end   
    
    wav_mat=[wav_mat wav_vec];
     
end
%% Frequency Polygonplot
% data_a5e=[];
% 
% for channel=1:info.NumSignals
%     arr=[];
%     for row=1:length(wav_mat)
%         arr = [arr; wav_mat(row,channel).a5cof];
%     end
%     
%     data_a5e = [data_a5e arr];
% end
% 
% temp3 = [];
% p = 1;
% for k = 1:(length(wav_vec)/24)
% temp2 =[];
% for i = p:1:(p + info.NumSignals)
%     temp1 = [];
%     for j = 1:info.NumSignals
%         temp1 = [temp1 data_a5e(i,j)];
%     end
%     i = i + 1;
%     temp2 = [temp2 temp1];
% end
% temp3 = [temp3; temp2];
% p = 1;
% p = (p + info.NumSignals)*k + 1;
% end
% 
% for i = 1:10
% plot(temp3(i,:),'-');
% hold on;
% end



%% Data Preprocessing
% Taking avg value of the feature
data_a5e=[];data_d5e=[];data_d4e=[];data_d3e=[];data_a5cof = [];data_d5cof = [];data_d4cof = [];data_d3cof=[];data_iqr=[];data_mad =[];
data_a5e_avg=[];data_d5e_avg=[];data_d4e_avg=[];data_d3e_avg=[];data_a5cof_avg = [];data_d5cof_avg = [];data_d4cof_avg = [];data_d3cof_avg=[];data_iqr_avg=[];data_mad_avg =[];

for row=1:length(wav_mat)
    arr1=[];arr2=[];arr3=[];arr4=[];arr5=[];arr6=[];arr7=[];arr8=[];arr9=[];arr10=[];
    for channel=1:info.NumSignals
        arr1 = [arr1 wav_mat(row,channel).a5e];
        arr2 = [arr2 wav_mat(row,channel).a5cof];
        arr3 = [arr3 wav_mat(row,channel).d5e];
        arr4 = [arr4 wav_mat(row,channel).d5cof];
        arr5 = [arr5 wav_mat(row,channel).d4e];
        arr6 = [arr6 wav_mat(row,channel).d4cof];
        arr7 = [arr7 wav_mat(row,channel).d3e];
        arr8 = [arr8 wav_mat(row,channel).d3cof];
        arr9 = [arr9 wav_mat(row,channel).iqr];
        arr10 =[arr10 wav_mat(row,channel).mad];
    end
   
   
    data_a5e = [data_a5e; arr1];
    data_a5cof = [data_a5cof; arr2];
    data_d5e = [data_d5e; arr3];
    data_d5cof = [data_d5cof; arr4];
    data_d4e = [data_d4e; arr5];
    data_d4cof = [data_d4cof; arr6];
    data_d3e = [data_d3e; arr7];
    data_d3cof = [data_d3cof; arr8];
    data_iqr = [data_iqr; arr9];
    data_mad = [data_mad; arr10];

end

% averaging datas

for i=1:length(wav_mat)
    data_a5e_avg = [data_a5e_avg  ;  average(data_a5e(i,:))];
    
    data_a5cof_avg = [data_a5cof_avg  ;   average(data_a5cof(i,:))];
    
    data_d5e_avg = [data_d5e_avg;  average(data_d5e(i,:))];
    
    data_d5cof_avg = [data_d5cof_avg  ;  average(data_d5cof(i,:))];
    
    data_d4e_avg =[data_d4e_avg ; average(data_d4e(i,:))];
    
    data_d4cof_avg = [data_d4cof_avg  ;  average(data_d4cof(i,:))];
    
    data_d3e_avg = [data_d3e_avg;  average(data_d3e(i,:))];
    
    data_d3cof_avg = [data_d3cof_avg  ;  average(data_d3cof(i,:))];
    
    data_iqr_avg = [data_iqr_avg ;  average(data_iqr(i,:))];
    
    data_mad_avg = [data_mad_avg;   average(data_mad(i,:))];   
    
end
    




%% Csv file creation
false = "Non-Seizure";
true = "Seizure";
%data_set = [ "Energy_a5", "Coefficient_of_Variance_a5", "Energy_d5", "Coefficient_of_Variance_d5", "Energy_d4", "Coefficient_of_Variance_d4", "Energy_d3", "Coefficient_of_Variance_d3", "InterQuartile", "MedianDeviation", "Detection"];
data_set=[];
data_col = [];

%here we took 60 seconds of data before the seizure started, then took 40
%seconds of non seizure data, a 20 second gap and then the seizure data was
%taken

 for i = 1:length(wav_mat)
     if (i>=62 && i<=length(wav_mat))
          data_col = [ data_a5e_avg(i), data_a5cof_avg(i), data_d5e_avg(i), data_d5cof_avg(i), data_d4e_avg(i), data_d4cof_avg(i), data_d3e_avg(i), data_d3cof_avg(i), data_iqr_avg(i), data_mad_avg(i), true];
          data_set = [data_set; data_col];
    
     elseif (i>=1 && i<=40)
         data_col = [ data_a5e_avg(i), data_a5cof_avg(i), data_d5e_avg(i), data_d5cof_avg(i), data_d4e_avg(i), data_d4cof_avg(i), data_d3e_avg(i), data_d3cof_avg(i), data_iqr_avg(i), data_mad_avg(i), false];
         data_set = [data_set; data_col];
     end
        
 end
 
%writematrix(data_set,'Dataset_new.csv');   
  
T=readtable("E:\L-3,T-1\DSP project\practise codes\Dataset_new.csv");

Tnew=array2table(data_set);


Tnew.Properties.VariableNames = [ "Energy_a5", "Coefficient_of_Variance_a5", "Energy_d5", "Coefficient_of_Variance_d5", "Energy_d4", "Coefficient_of_Variance_d4", "Energy_d3", "Coefficient_of_Variance_d3", "InterQuartile", "MedianDeviation", "Detection"];

% the table is updated after each iteration and finally in the csv file
% where the table is being stored, in this way we increase our table length

 T=[T;  Tnew];
 
 
writetable(T, "E:\L-3,T-1\DSP project\practise codes\Dataset_new.csv")


    


   
%% Energy Function
function en = energy(x)
en = sum(x.^2);
end
%% Coefficients of Variation
function cof = Coefficirntofvariation(x)
s = std(x);
m = mean(x);
cof = s/m;
end
%% Interquartile Range
function iqr = Interquartilerange(x)
q = quantile(x,[.25,.75]);
iqr = q(2)-q(1);
end

%% Median Absolute Deviation
function meand = Medianabsolutedeviation(x)
meand = mad(x);
end

%% averager

function avg=average(vector)
 
avg=sum(vector)/length(vector);

end

%% sirs requirement
% precision
% recall
% F1 score
% confusion matrix 
% formal presentation hoite hobe 
% no codes in slide


%% for presentaiton

% intro with name and pics in beginning
% why the project is important
% procedure needs to be shown
% outputs needs to be shown
% interpretation of the outputs
% concluding remark
% 
% presentatinon in english and formal attire
% all needs to present;  total time 5-10 minutes




