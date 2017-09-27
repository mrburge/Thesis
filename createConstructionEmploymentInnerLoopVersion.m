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

load( '..\..\matlabOutput\msaNamesNoDuplicates')  
stateNames = msaNamesNoDuplicates;  
years = {'12';};                     
industryName = 'Construction';


%% Read in data

% THIS IS PERFECT FOR THE YEAR 1990, YOU'LL ALSO WANT TO ADD YEARS 91, AND
% 92 BY USEING THE SAME CONVENTION OF LABELING YY-Q NUMBERS TO DENOTE
% DIFFERENT SHEETS


%% Rip out nessary aspects of the data from the spreadsheets

employmentSeries = zeros(12*length(years),length(stateNames));

%%Loop through each state listed in stateNames
for jj = 1:length(years)
         sheetName = ['allhlcn' years{jj}];      
    
        [qcew1data,qcew1strings] = xlsread([sheetName '1.xlsx']);
        [qcew2data,qcew2strings] = xlsread([sheetName '2.xlsx']);
        [qcew3data,qcew3strings] = xlsread([sheetName '3.xlsx']);
        [qcew4data,qcew4strings] = xlsread([sheetName '4.xlsx']);

        qcew1locations = qcew1strings(2:end,10);
        qcew2locations = qcew2strings(2:end,10);
        qcew3locations = qcew3strings(2:end,10);
        qcew4locations = qcew4strings(2:end,10);
        
        qcew1industries = qcew1strings(2:end,12);
        qcew2industries = qcew2strings(2:end,12);
        qcew3industries = qcew3strings(2:end,12);
        qcew4industries = qcew4strings(2:end,12);        
    
    for  ii = (1:length(stateNames))     
        % Find Quarter 1 Data for Construction 1990
        whereTheQ1DataIs = find( strcmp( qcew1locations,stateNames{ii}) & strcmp(qcew1industries, 'Construction')  );
        empq1        = qcew1data(whereTheQ1DataIs,2:4);
        % Find Quarter 2 Data for Construction 1990
        whereTheQ2DataIs = find( strcmp( qcew2locations,stateNames{ii}) & strcmp(qcew2industries, 'Construction')  );
        empq2        = qcew2data(whereTheQ2DataIs,2:4);
        % Find Quarter 3 Data for Construction 1990
        whereTheQ3DataIs = find( strcmp( qcew3locations,stateNames{ii}) & strcmp(qcew3industries, 'Construction')  );
        empq3        = qcew3data(whereTheQ3DataIs,2:4);
        % Find Quarter 4 Data for Construction 1990
        whereTheQ4DataIs = find( strcmp( qcew4locations,stateNames{ii}) & strcmp(qcew4industries, 'Construction')  );
        empq4        = qcew4data(whereTheQ4DataIs,2:4);
        
        
        if ~isempty(empq1) && ~isempty(empq2) && ~isempty(empq3) && ~isempty(empq4)  
        
            employmentSeries((jj-1)*12+1:jj*12,ii) = [empq1';
                empq2';
                empq3';
                empq4'];
        else
            employmentSeries((jj-1)*12+1:jj*12,ii) = NaN(12,1);  
        end
                          
    
    end 
end
outTable = [stateNames'; num2cell(employmentSeries)];
xlswrite('constructionEmploymentMSA.xlsx',outTable)

%% Set parameters 

numYears = length(years);

%% Create Coefficient of variation (Mean/Std Dev.) 

rmcCoefOfVariation = zeros(length(stateNames),numYears); 
rmcAvgDemand       = zeros(length(stateNames),numYears);

for ii=1:length(stateNames) 
   emp                      = reshape(employmentSeries(:,ii),12,[]);  
   rmcCoefOfVariation(ii,:) =  std(emp)./mean(emp); 
   rmcAvgDemand(ii,:)       =  mean(emp); 
end

save('..\..\matlabOutput\rmcDemand.mat','rmcCoefOfVariation','rmcAvgDemand')

%% Calculate the ratio of the volatilities for the top decile (.90) and the bottom decile (.10)

rmcRatio9010 = quantile(rmcCoefOfVariation,.9)/quantile(rmcCoefOfVariation,.1)

%% End of File