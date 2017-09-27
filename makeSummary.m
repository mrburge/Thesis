%% makeSummary.m 


%% Load in cleaned employment series (monthly) 

load employmentSeries.mat

%% Set parameters 

numYears = size(employmentSeries,1)/12;

%% Create Coefficient of variation (Mean/Std Dev.) 

coefOfVariation = zeros(numYears,length(stateNames)); 

for ii=1:length(stateNames) 
   emp             = reshape(employmentSeries(:,ii),12,3);  
   coefOfVariation(:,ii) =  std(emp)./mean(emp); 
end

%% Sort states by (Avg.) Coefficient of Variation for All years 

[~,stateOrder] = sort(mean(coefOfVariation),'descend');

%% Calculate the ratio of the volatilities for the top decile (.90) and the bottom decile (.10)

ratio9010 = quantile(mean(coefOfVariation),.9)/quantile(mean(coefOfVariation),.1);

%% List the states in descending order

stateNames(stateOrder)

%% Plot Top 3 Volatile States (scaled by mean level) 

top3VolatileMarkets = employmentSeries(:,stateOrder(1:3))./repmat(mean(employmentSeries(:,stateOrder(1:3))),numYears*12,1); % scale by overall average
bottom3VolatileMarkets = employmentSeries(:,stateOrder(end-2:end))./repmat(mean(employmentSeries(:,stateOrder(end-2:end))),numYears*12,1); % scale by overall average

figure; 
plot(top3VolatileMarkets)                % Plot the top 3 states in terms of volatility
legend(stateNames(stateOrder(1:3)))      % Rip out state names to put in legend
title('Demand for Ready Mixed Concrete') % Create title 
box off                  % turn the box of the diagram off
set(gcf,'Color',[1 1 1]) % set background color to white 
set(gca,'XTick',[1:12:12*numYears])
set(gca,'XTickLabel',{'1990','1991','1992'})

figure; 
plot(bottom3VolatileMarkets)                % Plot the top 3 states in terms of volatility
legend(stateNames(stateOrder(end-2:end)))      % Rip out state names to put in legend
title('Demand for Ready Mixed Concrete') % Create title 
box off                  % turn the box of the diagram off
set(gcf,'Color',[1 1 1]) % set background color to white
set(gca,'XTick',[1:12:12*numYears])
set(gca,'XTickLabel',{'1990','1991','1992'})


