%set up function
inputs = [0: pi/64:2*pi];
targets = sin(inputs) + sin( 2* inputs.^2);
numRuns = 100;
numBins = 50;
allRMSE =zeros(0, 5000);
RMSESum=0;
%first loop
num=0;

trainPct= .8;
ValPct= .1;
testPct= 1-ValPct-trainPct;

Outputs = net(inputs);
mdl = fitlm( Outputs, targets);
mdl.Residuals.Raw
plotResiduals(mdl)
disp ('rSquared: ');
disp( mdl.Rsquared.Ordinary);


i=0;
MaxRMSE= 0;
MinRMSE= 1;


RMSEhisto(targets, 50, 'Histogram of Sin(x)','Inputs',' Occurence');
 
for j=0:numRuns-1
    %Create a fitting Network
    hiddenLayerSize = 5;
    net= fitnet (hiddenLayerSize);
    %set up division for data training, Validation, Testing
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio = 20/100;
    net.divideParam.testRatio = 60/100;
    % Train the network
    [net,tr] = train(net,inputs,targets);
    %test the network
    outputs = net(inputs);
    TestOutputs = outputs(tr.testInd);
    TrainOutputs = outputs(tr.trainInd);
    testedTargets = targets(tr.testInd);
    errors = gsubtract(outputs,targets);
    performance = perform(net,targets,outputs);
    
    %Errors
    perror = (outputs - targets);
    % Root Mean Squared Error
    RMSE = sqrt(mean((sum(perror)).^2));
    
    allRMSE( j+1) = RMSE;
    RMSESum= RMSESum+RMSE;
    
    %saving RMSE value
    if (RMSE < MinRMSE)
        MinRMSE=RMSE;
        minRMSEPred = TestOutputs;
        minRMSETargets = testedTargets;
        minRMSETO = outputs(tr.trainInd);
        minRMSETT = targets(tr.trainInd);
    end
    if (RMSE > MaxRMSE)
        MaxRMSE=RMSE;
        maxRMSEPred = TestOutputs;
        maxRMSETargets = testedTargets;
        maxRMSETO = outputs(tr.trainInd);
        maxRMSETT = targets(tr.trainInd);
    end
end
    %RMSE values
    disp('RMSE average: ');
    avgRMSE = RMSESum/numRuns;
    disp(avgRMSE);
    
    disp('RMSE std. Dev: ');
    RMSEdev = std(allRMSE);
    disp(RMSEdev);
    
    disp('min RMSE: ');
    disp(min(allRMSE));
    disp('max RMSE: ');
    disp(max(allRMSE));
    
    %Deviation Values
    Dev = std(outputs);
    avgOutput = mean(outputs);
    disp('Mean Y-value: ');
    disp(avgOutput);
    disp('std Dev. of Outputs: ');
    disp(Dev);
    
    %cross validation tests
    %ploterrhist(error, 'bin',number_of_bins);
    %(targets,outputs,'Predicted vs.Actual Data','Actual Sin(x)','Predicted Sin(x)');
    RMSEhisto( allRMSE , 50, 'histogram of RMSE', 'RMSE values',' number of occurences');
    scatterplot(maxRMSEPred, maxRMSETargets, maxRMSETO, maxRMSETT, sprintf(' Predicted vs. Actual with Largest RMSE(%5)[95]', MaxRMSE, trainPct*100), 'Predicted sin(x)', 'sin(x)');
    %Min RMSE Scatterplot
    scatterplot(minRMSEPred, minRMSETargets, minRMSETO, minRMSETT, sprintf('Predicted Vs Actual with smallest RMSE(%d)(95)', MinRMSE, trainPct*100), 'Predicted sin(x)','sin(x)');
    dispHistogram(allRMSE, numBins, sprintf('RMSE Histogram [%.2g%%]', trainPct*100), 'RMSE', 'Occurence');
    fitobject = fit(inputs,targets,'poly1')
    %switching between test ranges
    switch(num)
        case 0
            trainPct = .20;
            num= 1;
        case 1
            trainPct = .05;
 normA = avgRMSE-min(avgRMSE(:));
    normA = normA / max(normA(:));
 NormRows = sqrt(sum(avgRMSE.*avgRMSE,2));
   Ynorm = bsxfun(@rdivide,abs(Ypred),NormRows);

 
            
  ValPct=trainPct/2;
  TestPct= 1-ValPct-trainPct;
    end 
    
            
            
   
           
    
    
   
    
