function [Kstar,Lstar,TotalProfit] = LongRunProfit(A,B,W,R)

timePeriods = length(A); 

possibleK = linspace(0,60,7000); 

profitAtK = zeros(timePeriods,length(possibleK)); 

for jj=1:length(possibleK)
    for ii=1:timePeriods
        [Qstar,Profit]   = shortRunProfit(A(ii),B,W,possibleK(jj));
        profitAtK(ii,jj) = Profit;   
    end
end


[TotalProfit,KstarIndex] = max(sum(profitAtK) - timePeriods*R*possibleK);
Kstar                    = possibleK(KstarIndex);

Lstar = zeros(timePeriods,1); 
for ii=1:timePeriods
    [Lstar(ii),Profit]   = shortRunProfit(A(ii),B,W,Kstar);
end



end