clc;
clear;
close all;



%% dataread from the table made before
data = readtable('Dataset_new.csv');

%% handling missing data
% data.Epoch = categorical(data.Epoch);
% Fre_e = mode(data.Epoch);
% e = fillmissing(data.Epoch,'constant',Fre_e);
% data.Epoch = e;
% 
% data.Energy_a5 = categorical(data.Energy_a5);
% Fre_e = mode(data.Energy_a5);
% e = fillmissing(data.Energy_a5,'constant',Fre_e);
% data.Energy_a5 = e;

% data.Energy_d5 = categorical(data.Energy_d5);
% Fre_e = mode(data.Energy_d5);
% e = fillmissing(data.Energy_d5,'constant',Fre_e);
% data.Energy_d5 = e;

% data.Energy_d4 = categorical(data.Energy_d4);
% Fre_e = mode(data.Energy_d4);
% e = fillmissing(data.Energy_d4,'constant',Fre_e);
% data.Energy_d4 = e;
% 
% data.Energy_d3 = categorical(data.Energy_d3);
% Fre_e = mode(data.Energy_d3);
% e = fillmissing(data.Energy_d3,'constant',Fre_e);
% data.Energy_a5 = e;

% data.Coefficient_of_Variance_a5 = categorical(data.Coefficient_of_Variance_a5);
% Fre_e = mode(data.Coefficient_of_Variance_a5);
% e = fillmissing(data.Coefficient_of_Variance_a5,'constant',Fre_e);
% data.Coefficient_of_Variance_a5 = e;
% 
% data.Coefficient_of_Variance_d5 = categorical(data.Coefficient_of_Variance_d5);
% Fre_e = mode(data.Coefficient_of_Variance_d5);
% e = fillmissing(data.Coefficient_of_Variance_d5,'constant',Fre_e);
% data.Coefficient_of_Variance_d5 = e;
% 
% data.Coefficient_of_Variance_d4 = categorical(data.Coefficient_of_Variance_d4);
% Fre_e = mode(data.Coefficient_of_Variance_d4);
% e = fillmissing(data.Coefficient_of_Variance_d4,'constant',Fre_e);
% data.Coefficient_of_Variance_d4 = e;
% 
% data.Coefficient_of_Variance_d3 = categorical(data.Coefficient_of_Variance_d3);
% Fre_e = mode(data.Coefficient_of_Variance_d3);
% e = fillmissing(data.Coefficient_of_Variance_d3,'constant',Fre_e);
% data.Coefficient_of_Variance_d3 = e;
% 
% data.InterQuartile = categorical(data.InterQuartile);
% Fre_e = mode(data.InterQuartile);
% e = fillmissing(data.InterQuartile,'constant',Fre_e);
% data.InterQuartile = e;

% data.MedianDeviation = categorical(data.MedianDeviation);
% Fre_e = mode(data.MedianDeviation);
% e = fillmissing(data.MedianDeviation,'constant',Fre_e);
% data.MedianDeviation = e;

% Handling Outliers
% e = filloutliers(data.Energy_a5,'clip','mean');
% data.Energy_a5 = e;
% 
% e = filloutliers(data.Energy_d5,'clip','mean');
% data.Energy_d5 = e;
% 
% e = filloutliers(data.Energy_d4,'clip','mean');
% data.Energy_d4 = e;
% 
% e = filloutliers(data.Energy_d3,'clip','mean');
% data.Energy_d3 = e;
% 
% e = filloutliers(data.Coefficient_of_Variance_a5,'clip','mean');
% data.Coefficient_of_Variance_a5 = e;
% 
% e = filloutliers(data.Coefficient_of_Variance_d5,'clip','mean');
% data.Coefficient_of_Variance_d5 = e;
% 
% e = filloutliers(data.Coefficient_of_Variance_d4,'clip','mean');
% data.Coefficient_of_Variance_d4 = e;
% 
% e = filloutliers(data.Coefficient_of_Variance_d3,'clip','mean');
% data.Coefficient_of_Variance_d3 = e;
% 
% e = filloutliers(data.InterQuartile,'clip','mean');
% data.InterQuartile = e;
% 
% e = filloutliers(data.MedianDeviation,'clip','mean');
% data.MedianDeviation = e;


%%  Feature scalling
% all datas are standardized/normalized here


Stand_x = (data.Energy_a5 - mean(data.Energy_a5))/std(data.Energy_a5);
data.Energy_a5 = Stand_x;

Stand_x = (data.Energy_d5 - mean(data.Energy_d5))/std(data.Energy_d5);
data.Energy_d5 = Stand_x;

Stand_x = (data.Energy_d4 - mean(data.Energy_d4))/std(data.Energy_d4);
data.Energy_d4 = Stand_x;

Stand_x = (data.Energy_d3 - mean(data.Energy_d3))/std(data.Energy_d3);
data.Energy_d3 = Stand_x;

Stand_x = (data.Coefficient_of_Variance_a5 - mean(data.Coefficient_of_Variance_a5))/std(data.Coefficient_of_Variance_a5);
data.Coefficient_of_Variance_a5 = Stand_x;

Stand_x = (data.Coefficient_of_Variance_d5 - mean(data.Coefficient_of_Variance_d5))/std(data.Coefficient_of_Variance_d5);
data.Coefficient_of_Variance_d5 = Stand_x;

Stand_x = (data.Coefficient_of_Variance_d4 - mean(data.Coefficient_of_Variance_d4))/std(data.Coefficient_of_Variance_d4);
data.Coefficient_of_Variance_d4 = Stand_x;

Stand_x = (data.Coefficient_of_Variance_d3 - mean(data.Coefficient_of_Variance_d3))/std(data.Coefficient_of_Variance_d3);
data.Coefficient_of_Variance_d3 = Stand_x;

Stand_x = (data.InterQuartile - mean(data.InterQuartile))/std(data.InterQuartile);
data.InterQuartile = Stand_x;

Stand_x = (data.MedianDeviation - mean(data.MedianDeviation))/std(data.MedianDeviation);
data.MedianDeviation = Stand_x;

 writetable(data,'Data_Prepocessed.csv');
 writetable(data,'Data_Prepocessed.txt');
 
 
%% Classification & Result

classification_model = fitcdiscr(data,'Detection~MedianDeviation+Energy_a5');
% 
% classification_model_1 = fitcdiscr(data,'MedianDeviation~Epoch+Energy_a5','DiscrimType', 'quadratic');
%classification_model_1 = fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType', 'diagquadratic');
%classification_model_1 = fitcdiscr(data,'Purchased~Age+EstimatedSalary','DiscrimType', 'psuedoquadratic');


%% -------------- Test and Train sets ----------------------------
% ---------------------------- Code ---------------------------

cv = cvpartition(classification_model.NumObservations, 'HoldOut', 0.3);
cross_validated_model = crossval(classification_model,'cvpartition',cv); 

% cross_validated_model_1 = crossval(classification_model_1,'cvpartition',cv); 


%% -------------- Making Predictions for Test sets ---------------
% ---------------------------- Code ---------------------------

Predictions = predict(cross_validated_model.Trained{1},data(test(cv),1:end-1));

% Predictions_1 = predict(cross_validated_model_1.Trained{1},data(test(cv),1:end-1));



%% -------------- Analyzing the predictions ---------------------
% ---------------------------- Code ---------------------------
figure(1);
Results = confusionchart(cross_validated_model.Y(test(cv)),Predictions);
Results1 = confusionmat(cross_validated_model.Y(test(cv)),Predictions);
[validationPredictions, validationScores] = kfoldPredict(cross_validated_model);
validationAccuracy = 1 - kfoldLoss(cross_validated_model, 'LossFun', 'ClassifError');
str = validationAccuracy*100;
disp("The accuracy is "+num2str(str)+"%");

%
Results.NormalizedValues;
Results.Title = 'Epelipsy Classification Using LDA';
Results.RowSummary = 'row-normalized';
Results.ColumnSummary = 'column-normalized';

% prediction
cm = Results1';
diagonal = diag(cm);
sum_o_row = sum(cm,2);
precision = diagonal./ sum_o_row;
Overall_precision = mean(precision);

sum_o_col =  sum(cm, 1);
recall = diagonal./sum_o_col';
Overall_recall = mean(recall);

f1_score = 2*((Overall_precision*Overall_recall)/(Overall_precision+Overall_recall));


disp(['The Precision of Confusion Matrix is ' num2str(Overall_precision)]);
disp(['The Recall of Confusion Matrix is ' num2str(Overall_recall)]);
disp(['The F1_Score of Confusion Matrix is ' num2str(f1_score)]);
if validationAccuracy >=.7
    disp("The patient is epilepsy positive");
end
% Results_1 = confusionmat(cross_validated_model_1.Y(test(cv)),Predictions_1);


% %% -------------- Visualizing training set results --------------
% % ---------------------------- Code ---------------------------
 
labels = unique(data.Detection);
classifier_name = 'Linear Discriminant Analysis';
%  
Energy_a5_range = min(data.Energy_a5(training(cv)))-1:0.01:max(data.Energy_a5(training(cv)))+1;
MedianDeviation_range = min(data.MedianDeviation(training(cv)))-1:0.01:max(data.MedianDeviation(training(cv)))+1;

% 
figure(2);
[xx1, xx2] = meshgrid(Energy_a5_range,MedianDeviation_range);
XGrid = [xx1(:) xx2(:)];
%  
predictions_meshgrid = predict(cross_validated_model.Trained{1},XGrid);
%  
gscatter(xx1(:), xx2(:), predictions_meshgrid,'rgb');
%  
hold on
training_data = data(training(cv),:);
Y = ismember(training_data.Detection,labels{1});
%  
scatter(training_data.MedianDeviation(Y),training_data.Energy_a5(Y), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
scatter(training_data.MedianDeviation(~Y),training_data.Energy_a5(~Y), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');

 
 
xlabel('MedianDeviation');
%ylabel('Energy_a5e');
ylabel('Energy_a5');
 
title(classifier_name);
legend off, axis tight
 
legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
%Trueclass = ['Seizure' 'Non Seizure'];
%confusionchart(Results,);
 
%________________________________________________________________
%________________________________________________________________
 
 
% %% -------------- Visualizing training set results --------------
% % ---------------------------- Code ---------------------------
 
% labels = unique(data.InterQuartile);
% classifier_name = 'Discriminant Analysis (Modified options)';
%  
% Epoch_range = min(data.Epoch(training(cv)))-1:0.01:max(data.Epoch(training(cv)))+1;
% MedianDeviation_range = min(data.MedianDeviation(training(cv)))-1:0.01:max(data.MedianDeviation(training(cv)))+1;
% 
% [xx1, xx2] = meshgrid(Epoch_range,MedianDeviation_range);
% XGrid = [xx1(:) xx2(:)];
%  
% predictions_meshgrid = predict(cross_validated_model_1.Trained{1},XGrid);
% 
% figure
% gscatter(xx1(:), xx2(:), predictions_meshgrid,'rgb');
%  
% hold on
% training_data = data(training(cv),:);
% Y = ismember(training_data.InterQuartile,labels{1});
%  
% scatter(training_data.Epoch(Y),training_data.MedianDeviation(Y), 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'red');
% scatter(training_data.Epoch(~Y),training_data.MedianDeviation(~Y) , 'o' , 'MarkerEdgeColor', 'black', 'MarkerFaceColor', 'green');
%  
%  
% xlabel('Age');
% ylabel('Estimated Salary');
%  
% title(classifier_name);
% legend off, axis tight
%  
% legend(labels,'Location',[0.45,0.01,0.45,0.05],'Orientation','Horizontal');
 

   
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
 avg = zeros(1,1);
for i =1:length(vector)
    avg(i) = mean(vector(i,:));
end
end
