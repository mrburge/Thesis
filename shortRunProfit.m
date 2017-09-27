%% Megan's short run profit funcation calculation 
function [Qstar,Profit] = shortRunProfit(A,B,W,K) 


    Qstar = (A/2) - (B*W)/2;

    if Qstar > K
        Qstar = K;
    end

    Profit = ((A/B) - (1/B)*Qstar)*Qstar - W*Qstar;
end