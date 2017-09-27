%% GetCBPData.m 

clear all; close all; clc; 

%% Read in MSA Names file 

[numericCodes,stringCodes] = xlsread('msaNamesCodes.xlsx'); 
[estabData,estabStrings]   = xlsread('cbp12msa.xlsx'); 

%% Build Variables That Identify Proper Row 

msaNames     = stringCodes(2:end,2);
msaNumCodes  = numericCodes(:,1); 

[msaNamesNoDuplicates,uniqueRows] = unique(msaNames); 
msaNumCodes                       = msaNumCodes(uniqueRows); 

drop = [];
for ii=1:length(msaNamesNoDuplicates)
    tempName =   msaNamesNoDuplicates{ii};
    if strcmp(tempName(end-9:end-5),'Micro')
        drop = [drop; ii];
    else    
        tempName2 = [tempName(1:end-10) 'MSA'];
        msaNamesNoDuplicates{ii} = tempName2;
    end
end

msaNamesNoDuplicates(drop) = [];
msaNumCodes(drop)          = [];

save('..\..\matlabOutput\msaNamesNoDuplicates','msaNamesNoDuplicates','msaNumCodes') 

%% Loop Through All MSAs and Get Number of Hotels and HHI of Employment

hhiHotels        = [];
numberOfHotels   = [];
empBucketNumbers = diag([2; 7; 14; 34; 74; 174; 374; 749]);
for  ii = (1:length(msaNumCodes))
     temprow  =  find(msaNumCodes(ii)==estabData(:,1) & estabData(:,2)==721110);
         
      if ~isempty(temprow)   
         numEstab = estabData(temprow,10); 
         empNums  = estabData(temprow,11:18); 
         totEmp   = sum(empBucketNumbers*empNums');
         hhi      = empNums*((empBucketNumbers*repmat((1/totEmp),8,1)).^2);
         
         numberOfHotels   = [numberOfHotels; numEstab];
         hhiHotels        = [hhiHotels;  hhi];
      else 
         numberOfHotels   = [numberOfHotels; NaN(1,1)];
         hhiHotels        = [hhiHotels;  NaN(1,1)];
      end
end
 
%% Loop Through All MSAs and Get Number of Ready Mix Concrete Establishments and HHI of Employment

hhiRMC           = [];
numberOfRMC      = [];
empBucketNumbers = diag([2; 7; 14; 34; 74; 174; 374; 749]);
for ii = (1:length(msaNumCodes))
         temprow  =  find(msaNumCodes(ii)==estabData(:,1) & estabData(:,2)==327320);
         
      if ~isempty(temprow)   
         numEstab = estabData(temprow,10); 
         empNums  = estabData(temprow,11:18); 
         totEmp   = sum(empBucketNumbers*empNums');
         hhi      = empNums*((empBucketNumbers*repmat((1/totEmp),8,1)).^2);
    
         numberOfRMC   = [numberOfRMC; numEstab];
         hhiRMC        = [hhiRMC;  hhi];
      else 
         numberOfRMC = [numberOfRMC; NaN(1,1)];
         hhiRMC      = [hhiRMC;  NaN(1,1)];
      end
end


%% Output table to data directory

outTable = table(numberOfHotels,hhiHotels,numberOfRMC,hhiRMC);
save('..\..\matlabOutput\outcomes.mat','outTable')

 %% End of file