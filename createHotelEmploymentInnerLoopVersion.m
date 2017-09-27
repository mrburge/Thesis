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

% stateNames = {'Alabama';'Alaska';'Arizona';'Arkansas';
%                'California'; 'Colorado';'Connecticut';
%                'Delaware';'Florida'; 'Georgia'; 'Hawaii';
%                'Idaho';'Illinois';'Indiana';'Iowa';'Kansas';
%                'Kentucky';'Louisiana';'Maine';'Maryland';'Massachusetts';
%                'Michigan';'Minnesota';'Mississippi';'Missouri';'Montana';
%                'Nebraska';'Nevada';'New Hampshire';'New Jersey';'New Mexico';'New York';
%                'North Carolina';'North Dakota';'Ohio';'Oklahoma';'Oregon';'Pennsylvania';
%                'Rhode Island';'South Carolina';'South Dakota';'Tennessee';'Texas';'Utah';
%                'Vermont';'Virginia';'Washington';'West Virginia';'Wisconsin';'Wyoming'};
             
load( '..\..\matlabOutput\msaNamesNoDuplicates')  
stateNames = msaNamesNoDuplicates;  
years = {'12'};                  
industryName = 'Leisure and hospitality';

%% Loop through each state listed in stateNames

employmentSeries = zeros(12*length(years),length(stateNames));

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

        % Find Quarter 1 Data for Leisure and hospitality 1990
        whereTheQ1DataIs = find( strcmp( qcew1locations,stateNames{ii}) & strcmp(qcew1industries, 'Leisure and hospitality')  );
        empq1        = qcew1data(whereTheQ1DataIs,2:4);
        % Find Quarter 2 Data for Leisure and hospitality 1990
        whereTheQ2DataIs = find( strcmp( qcew2locations,stateNames{ii}) & strcmp(qcew2industries, 'Leisure and hospitality')  );
        empq2        = qcew2data(whereTheQ2DataIs,2:4);
        % Find Quarter 3 Data for Leisure and hospitality 1990
        whereTheQ3DataIs = find( strcmp( qcew3locations,stateNames{ii}) & strcmp(qcew3industries, 'Leisure and hospitality')  );
        empq3        = qcew3data(whereTheQ3DataIs,2:4);
        % Find Quarter 4 Data for Leisure and hospitality 1990
        whereTheQ4DataIs = find( strcmp( qcew4locations,stateNames{ii}) & strcmp(qcew4industries, 'Leisure and hospitality')  );
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
xlswrite('leisureHospitalityEmploymentMSA.xlsx',outTable)

%% Set parameters 

numYears = length(years);

%% Create Coefficient of variation (Mean/Std Dev.) 

hotelsCoefOfVariation = zeros(length(stateNames),numYears); 
hotelsAvgDemand       = zeros(length(stateNames),numYears);

for ii=1:length(stateNames) 
   emp                         = reshape(employmentSeries(:,ii),12,[]);  
   hotelsCoefOfVariation(ii,:) =  std(emp)./mean(emp); 
   hotelsAvgDemand(ii,:)       =  mean(emp); 
end

save('..\..\matlabOutput\hotelsDemand.mat','hotelsCoefOfVariation','hotelsAvgDemand')

%% Calculate the ratio of the volatilities for the top decile (.90) and the bottom decile (.10)

hotelsRatio9010 = quantile(hotelsCoefOfVariation,.9)/quantile(hotelsCoefOfVariation,.1)

%% End of File