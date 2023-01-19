%% Get the data from Excel
clc; clear; close all;

selR = [3,4,8,13]; % pitch rate limits: this cannot be changed here
tableForPlotMPC = cell(3,1);
for idxE = 1:3
    spreadsheet = sprintf('MPC_CPC_%02d',selR(idxE+1));
    tableForPlotMPC{idxE} = readtable('NREL5MW_NTW18.xlsx','FileType','spreadsheet','Sheet',spreadsheet);
end

tableForPlotPI = cell(3,1);
for idxE = 1:3
    spreadsheet = sprintf('PI_CPC_%02d',selR(idxE+1));
    tableForPlotPI{idxE} = readtable('NREL5MW_NTW18.xlsx','FileType','spreadsheet','Sheet',spreadsheet);
end

%% Plot MPC first
figDir = 'figDir';
testCaseStrMPC =  'qLMPC CPC Rate Constraints [deg/s]';
testCaseCell = {'standard (8) ','high (13) ', 'low (4) '};
axPlotAllMPC = plotOutTable(tableForPlotMPC{1},tableForPlotMPC{2},tableForPlotMPC{3},...
   testCaseStrMPC,testCaseCell,[],figDir);
figMPC = gcf;

%% Plot PI
tableForPlotPI{1}.Time = tableForPlotMPC{1}.Time;
testCaseStr =  'PI CPC Rate Constraints [deg/s]';
figNo2 = 2;
strFig = 'testConstrPI';
axPlotAll = plotOutTable(tableForPlotPI{1},tableForPlotPI{2},tableForPlotPI{3},...
   testCaseStr,testCaseCell,figNo2,figDir,strFig);

%% Set the axes limits equal for easier comparison
for idx = 1:length(axPlotAllMPC)
    limPI = get(axPlotAll(idx),'YLim');
    limMPC = get(axPlotAllMPC(idx),'YLim');
    newLim =[min(limPI(1),limMPC(1)), max(limPI(2),limMPC(2))];
    set(axPlotAllMPC(idx),'YLim',newLim ); 
    set(axPlotAll(idx),'YLim',newLim ); 
end

%% 
strFig = 'MPCNewLim';
saveas(figMPC, fullfile(figDir,['cmpNewLimits_',strFig]), 'png');

strFig = 'PINewLim';
saveas(gcf, fullfile(figDir,['cmpNewLimits_',strFig]), 'png');

