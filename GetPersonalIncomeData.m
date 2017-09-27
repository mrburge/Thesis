%% GetPersonalIncomeData.m 

clear all; close all; clc; 

%% Read in MSA Names file 

load('..\msaNamesNoDuplicates.mat')
[piData,piStrings]   = xlsread('personalIncome.xls'); 
msaLabels = piStrings(7:1152,1); 
msaLines  = piStrings(7:1152,3);

%% Loop Through All MSAs and Get Personal Income, Population, PI per capita

pi   = NaN(length(msaNumCodes),1); 
pop  = NaN(length(msaNumCodes),1);
pipc = NaN(length(msaNumCodes),1);

for  ii = (1:length(msaNumCodes))
     temprowA  =  find(strcmp(num2str(msaNumCodes(ii)),msaLabels) & strcmp(num2str(1),msaLines));
     temprowB  =  find(strcmp(num2str(msaNumCodes(ii)),msaLabels) & strcmp(num2str(2),msaLines));
     temprowC  =  find(strcmp(num2str(msaNumCodes(ii)),msaLabels) & strcmp(num2str(3),msaLines));
         
      if ~isempty(temprowA)   
         pi(ii)   = piData(temprowA,1); 
      end
      if ~isempty(temprowB)   
         pop(ii)  = piData(temprowB,1); 
      end
      if ~isempty(temprowC)   
         pipc(ii) = piData(temprowC,1); 
      end
end

%% Output table to data directory

piTable = table(pi,pop,pipc);
save('..\personalIncome.mat','piTable')

 %% End of file