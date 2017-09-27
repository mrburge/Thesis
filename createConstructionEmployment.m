%% createConstructionEmployment.m 
% createConstructionEmployment.m is a matlab script that will read in 
% the quarterly census of employment and wages data and build the monthly 
% employment series for each state over the three years 1990-1992. 
%
%
%
%   % Copyright: Megan Burge (2017)
%
%

clear all; close all; clc; 

%% Set up 50 state names

stateNames = {'Alabama';'Alaska';'Arizona';'Arkansas';
               'California'; 'Colorado';'Connecticut';
               'Delaware';'Florida'; 'Georgia'; 'Hawaii';
               'Idaho';'Illinois';'Indiana';'Iowa';'Kansas';
               'Kentucky';'Louisiana';'Maine';'Maryland';'Massachusetts';
               'Michigan';'Minnesota';'Mississippi';'Missouri';'Montana';
               'Nebraska';'Nevada';'New Hampshire';'New Jersey';'New Mexico';'New York';
               'North Carolina';'North Dakota';'Ohio';'Oklahoma';'Oregon';'Pennsylvania';
               'Rhode Island';'South Carolina';'South Dakota';'Tennessee';'Texas';'Utah';
               'Vermont';'Virginia';'Washington';'West Virginia';'Wisconsin';'Wyoming'};
             
%% Read in data

% THIS IS PERFECT FOR THE YEAR 1990, YOU'LL ALSO WANT TO ADD YEARS 91, AND
% 92 BY USEING THE SAME CONVENTION OF LABELING YY-Q NUMBERS TO DENOTE
% DIFFERENT SHEETS


[qcew901data,qcew901strings] = xlsread('allhlcn901.xlsx');
[qcew902data,qcew902strings] = xlsread('allhlcn902.xlsx');
[qcew903data,qcew903strings] = xlsread('allhlcn903.xlsx');
[qcew904data,qcew904strings] = xlsread('allhlcn904.xlsx');



[qcew911data,qcew911strings] = xlsread('allhlcn911.xlsx');
[qcew912data,qcew912strings] = xlsread('allhlcn912.xlsx');
[qcew913data,qcew913strings] = xlsread('allhlcn913.xlsx');
[qcew914data,qcew914strings] = xlsread('allhlcn914.xlsx');



[qcew921data,qcew921strings] = xlsread('allhlcn921.xlsx');
[qcew922data,qcew922strings] = xlsread('allhlcn922.xlsx');
[qcew923data,qcew923strings] = xlsread('allhlcn923.xlsx');
[qcew924data,qcew924strings] = xlsread('allhlcn924.xlsx');

%% Rip out nessary aspects of the data from the spreadsheets

qcew901locations = qcew901strings(2:end,10);
qcew902locations = qcew902strings(2:end,10);
qcew903locations = qcew903strings(2:end,10);
qcew904locations = qcew904strings(2:end,10);

qcew901industries = qcew901strings(2:end,12);
qcew902industries = qcew902strings(2:end,12);
qcew903industries = qcew903strings(2:end,12);
qcew904industries = qcew904strings(2:end,12);


qcew911locations = qcew911strings(2:end,10);
qcew912locations = qcew912strings(2:end,10);
qcew913locations = qcew913strings(2:end,10);
qcew914locations = qcew914strings(2:end,10);

qcew911industries = qcew911strings(2:end,12);
qcew912industries = qcew912strings(2:end,12);
qcew913industries = qcew913strings(2:end,12);
qcew914industries = qcew914strings(2:end,12);


qcew921locations = qcew921strings(2:end,10);
qcew922locations = qcew922strings(2:end,10);
qcew923locations = qcew923strings(2:end,10);
qcew924locations = qcew924strings(2:end,10);

qcew921industries = qcew921strings(2:end,12);
qcew922industries = qcew922strings(2:end,12);
qcew923industries = qcew923strings(2:end,12);
qcew924industries = qcew924strings(2:end,12);

employmentSeries = zeros(12*3,length(stateNames));

%%Loop through each state listed in stateNames

for  ii = (1:length(stateNames))

% Find Quarter 1 Data for Construction 1990
 whereThe90Q1DataIs = find( strcmp( qcew901locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew901industries, 'Construction')  );
 emp90q1        = qcew901data(whereThe90Q1DataIs,2:4);
% Find Quarter 2 Data for Construction 1990
 whereThe90Q2DataIs = find( strcmp( qcew902locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew902industries, 'Construction')  );
 emp90q2        = qcew902data(whereThe90Q2DataIs,2:4);
% Find Quarter 3 Data for Construction 1990
 whereThe90Q3DataIs = find( strcmp( qcew903locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew903industries, 'Construction')  );
 emp90q3        = qcew903data(whereThe90Q3DataIs,2:4);
% Find Quarter 4 Data for Construction 1990
 whereThe90Q4DataIs = find( strcmp( qcew904locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew904industries, 'Construction')  );
 emp90q4        = qcew904data(whereThe90Q4DataIs,2:4); 
 
 
 
 % Find Quarter 1 Data for Construction 1991
 whereThe91Q1DataIs = find( strcmp( qcew911locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew911industries, 'Construction')  );
 emp91q1        = qcew911data(whereThe91Q1DataIs,2:4);
% Find Quarter 2 Data for Construction 1991
 whereThe91Q2DataIs = find( strcmp( qcew912locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew912industries, 'Construction')  );
 emp91q2        = qcew912data(whereThe91Q2DataIs,2:4);
% Find Quarter 3 Data for Construction 1991
 whereThe91Q3DataIs = find( strcmp( qcew913locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew913industries, 'Construction')  );
 emp91q3        = qcew913data(whereThe91Q3DataIs,2:4);
% Find Quarter 4 Data for Construction 1991
 whereThe91Q4DataIs = find( strcmp( qcew914locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew914industries, 'Construction')  );
 emp91q4        = qcew914data(whereThe91Q4DataIs,2:4); 

 
 
 % Find Quarter 1 Data for Construction 1992
 whereThe92Q1DataIs = find( strcmp( qcew921locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew921industries, 'Construction')  );
 emp92q1        = qcew921data(whereThe92Q1DataIs,2:4);
% Find Quarter 2 Data for Construction 1992
 whereThe92Q2DataIs = find( strcmp( qcew922locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew922industries, 'Construction')  );
 emp92q2        = qcew922data(whereThe92Q2DataIs,2:4);
% Find Quarter 3 Data for Construction 1992
 whereThe92Q3DataIs = find( strcmp( qcew923locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew923industries, 'Construction')  );
 emp92q3        = qcew923data(whereThe92Q3DataIs,2:4);
% Find Quarter 4 Data for Construction 1992
 whereThe92Q4DataIs = find( strcmp( qcew924locations,[stateNames{ii} ' -- Statewide']) & strcmp(qcew924industries, 'Construction')  );
 emp92q4        = qcew924data(whereThe92Q4DataIs,2:4); 
     

 
 employmentSeries(:,ii) =    [emp90q1'; 
                              emp90q2';
                              emp90q3';
                              emp90q4';
                              emp91q1'; 
                              emp91q2';
                              emp91q3';
                              emp91q4';
                              emp92q1'; 
                              emp92q2';
                              emp92q3';
                              emp92q4'];
end 
 


outTable = [stateNames'; num2cell(employmentSeries)];
xlswrite('constructionEmployment.xlsx',outTable)

save('employmentSeries.mat','employmentSeries','stateNames')

%% End of File