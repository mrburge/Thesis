%% createAvgWageLeisureHospitality.m 
% createAvgWageLeisureHospitality.m is a matlab script that will read in 
% the quarterly census of employment and wages data and the county mappings
% and build the average salaray of hotel employees for each particular 
% metro area and year (2006--2009). 
%
%
%
%     % see also: createSTRseries.m 
%
%
%

clear all; close all; clc; 


stateNames = {'Alabama';'Alaska';'Arizona';'Arkansas';
               'California'; 'Colorado';'Connecticut';
               'Deleware';'Florida'; 'Georgia'; 'Hawaii';
               'Idaho';'Illinois';'Indiana';'Iowa';'Kansas';
               'Kentucky';'Louisiana';'Maine';'Maryland';'Massachusetts';
               'Michigan';'Minnesota';'Mississippi';'Missouri';'Montana';
               'Nebraska';'Nevada';'New Hampshire';'New Jersey';'New Mexico';'New York';
               'North Carolina';'North Dakota';'Ohio';'Oklahoma';'Oregon';'Pennsylvania';
               'Rhode Island';'South Carolina';'South Dakota';'Tennessee';'Texas';'Utah';
               'Vermont';'Virginia';'Washington';'West Virginia';'Wisconsin';'Wyoming'};
             

%% Read in data

[qcew901data,qcew901strings] = xlsread('allhlcn901.xlsx');
[qcew902data,qcew902strings] = xlsread('allhlcn902.xlsx');
[qcew903data,qcew903strings] = xlsread('allhlcn903.xlsx');
[qcew904data,qcew904strings] = xlsread('allhlcn904.xlsx');


%% Rip out nessary asepcts/Remove unnecessary aspects of data sheet 

locationMatchesStrings(1,:) = [];

qcew901locations = qcew901strings(2:end,10);
qcew902locations = qcew902strings(2:end,10);
qcew903locations = qcew903strings(2:end,10);
qcew904locations = qcew904strings(2:end,10);

qcew901industries = qcew901strings(2:end,12);
qcew902industries = qcew902strings(2:end,12);
qcew903industries = qcew903strings(2:end,12);
qcew904industries = qcew904strings(2:end,12);

employmentSeries = zeros(12*3,length(stateNames));

%% Example 

for  ii = 1:length(stateNames)


 whereTheDatais = find( strcmp( qcew901locations,[stateNames(ii) 'Alabama--Statewide']) & strcmp(qcew901industries, 'Construction')  );
     emp90q1           = qcew901data(whereTheDatais,1:3);
     
     
 employmentSeries(:,ii) = [emp90q1'; 
                           ];

end 
 
%% Pre-allocate storage vectors for each variable being constructed 

numObs    = length(msyYear_it); 
wage_it   = NaN(numObs,1); 
labor_it  = NaN(numObs,1); 

[strLabel,ind] = unique(locationMatchesStrings(:,1));

for ii = 1: length(strLabel)

strName      =   strLabel(ii);  
locMatchRows =  strmatch(strName,locationMatchesStrings(:,1));   
     
itind      = [find( msyYear_it' == 2006 & strncmp( strName,msyStrings_it',length(char(strName)) ) );    
              find( msyYear_it' == 2007 & strncmp( strName,msyStrings_it',length(char(strName)) ) ); 
              find( msyYear_it' == 2008 & strncmp( strName,msyStrings_it',length(char(strName)) ) ); 
              find( msyYear_it' == 2009 & strncmp( strName,msyStrings_it',length(char(strName)) ) )]; 


% Find each of the MSA or Metro divisions comprising this STR location
[msa_t,~,counties2msa_t]   = unique(locationMatchesStrings(locMatchRows,2),'stable');
% Find each of the MSA or Metro divisions comprising this STR location
[mdiv_t,~,counties2mdiv_t] = unique(locationMatchesStrings(locMatchRows,3),'stable');
% Identify if the MSA locations are in fact divisions or standard MSAs
metrodiv_t = sum(metrodivFlag(locMatchRows));
% Determine the number of countries in this particular STR location
ncounties_t = length(locMatchRows);

numMSAs_t = length(msa_t);

if metrodiv_t == 0 
    
    units_t      = msa_t; 
    count2unit_t = counties2msa_t; 
    numUnits_t   = numMSAs_t; 
    
else 
    units_t      = mdiv_t; 
    count2unit_t = counties2mdiv_t;
    numUnits_t   = ncounties_t; 
    
end
    
    wages      = NaN(4,numUnits_t); 
    popWeights = NaN(4,numUnits_t); 
    labor      = NaN(4,numUnits_t); 
    
    for jj = 1:numUnits_t
        
        qcew06row = find(strncmp(units_t(jj),qcew06locations,length(char(units_t(jj)))) & strcmp('Leisure and hospitality',qcew06industries));
        qcew07row = find(strncmp(units_t(jj),qcew07locations,length(char(units_t(jj)))) & strcmp('Leisure and hospitality',qcew07industries));
        qcew08row = find(strncmp(units_t(jj),qcew08locations,length(char(units_t(jj)))) & strcmp('Leisure and hospitality',qcew08industries));
        qcew09row = find(strncmp(units_t(jj),qcew09locations,length(char(units_t(jj)))) & strcmp('Leisure and hospitality',qcew09industries));
        
        wages(1,jj) = qcew06data(qcew06row,3);
        wages(2,jj) = qcew07data(qcew07row,3);
        wages(3,jj) = qcew08data(qcew08row,3);
        wages(4,jj) = qcew09data(qcew09row,3);
        
        labor(1,jj) = qcew06data(qcew06row,2);
        labor(2,jj) = qcew07data(qcew07row,2);
        labor(3,jj) = qcew08data(qcew08row,2);
        labor(4,jj) = qcew09data(qcew09row,2);    
        
    end
    
    wage_it(itind)  = sum(wages,2)./sum(labor,2); 
    labor_it(itind) = sum(labor,2);
end

logWage_it  = log(wage_it); 
logLabor_it = log(labor_it);  

%% Save wage_it

save('wage_it','wage_it')

%% Save labor_it

save('labor_it','labor_it')

%% Save logWage_it

save('logWage_it','logWage_it')

%% Save logLabor_it

save('logLabor_it','logLabor_it')

%% End of File