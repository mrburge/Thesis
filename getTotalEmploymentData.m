%% getTotalEmploymentData.m 

clear all; close all; clc; 

%% Read in MSA Names file 

load('..\..\matlabOutput\msaNamesNoDuplicates.mat')
[empData,empStrings]   = xlsread('ssamatab1.xlsx'); 
msaLabels = empStrings(5:128448,3); 
msaYear   = empStrings(5:128448,5);

%% Loop Through All MSAs and Get Personal Income, Population, PI per capita

emp         = NaN(length(msaNumCodes),1); 
unem        = NaN(length(msaNumCodes),1);
emp5YearChg = NaN(length(msaNumCodes),1);

for  ii = (1:length(msaNumCodes))
     temprows     =  find(strcmp(num2str(msaNumCodes(ii)),msaLabels) & strcmp(num2str(2012),msaYear));
     temprowsLag  =  find(strcmp(num2str(msaNumCodes(ii)),msaLabels) & strcmp(num2str(2007),msaYear));
     
      if ~isempty(temprows)   
         emp(ii)   = mean(empData(temprows,2)); 
         
         if ~isempty(temprowsLag)
            emp5YearChg(ii) = mean(empData(temprows,2))-mean(empData(temprowsLag,2));
         end
         
      end
      if ~isempty(temprows)   
         unem(ii)  = mean(empData(temprows,4)); 
      end
end

%% Output table to data directory

empTable = table(emp,unem,emp5YearChg);
save('..\..\matlabOutput\totalEmployment.mat','empTable')

 %% End of file