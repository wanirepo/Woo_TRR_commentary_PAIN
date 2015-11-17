%% SIMULATION IN Woo & Wager (2015) What reliability can and cannot tell us 
% about pain report and pain neuroimaging. PAIN. Figure 1

%% DEPENDENCIES:
% ICC.m from http://www.mathworks.com/matlabcentral/fileexchange/21501-intraclass-correlation-coefficients/content/ICC.m
% violinplot.m from CanlabCore (https://github.com/canlab/CanlabCore)

% NOTE THAT each time you run the code, you will get different figures 
% becuase the simulation results depend on randomly generated values. 

% Also run this code in the directory where you want to save the figures.
% This will save figures in the directory you're currently in.

%% SUBJECTS FROM ONE HOMOGENEOUS COMMUNICATIVE CULTURE

fprintf('SIMULATION FOR A HOMOGENEOUS GROUP, ITERATION 0000');
for iter = 1:1000
    
    fprintf('\b\b\b\b%04d', iter);
    
    btw_var = 5; % between-person variability
    x1 = normrnd(50, btw_var, 30, 1);
    
    within_var = 5; % within-person variability
    x2 = x1 + normrnd(0, within_var, 30, 1);
    
    icc1(iter,1) = ICC(2,'single', [x1 x2]); % ICC 
    
    if icc1(iter,1) > 0.65 && icc1(iter,1) < 0.66
        x11 = x1;
        x22 = x2;
    end
end

% Get the representative data (values close to mean icc)
icc_rep = 0;
while icc_rep < floor(mean(icc1)*100)/100 || icc_rep > ceil(mean(icc1)*100)/100
    x11 = normrnd(50, btw_var, 30, 1);
    x22 = x11 + normrnd(0, within_var, 30, 1);
    
    icc_rep = ICC(2,'single', [x11 x22]); % ICC 
end    

disp(' DONE.');

%% SUBJECTS FROM TWO HETEROGENEUOUS COMMUNICATIVE CULTURES: 
% STOIC VS. COMMUNICATORS

fprintf('SIMULATION FOR HETEROGENEOUS GROUPS, ITERATION 0000');
for iter = 1:1000
    
    fprintf('\b\b\b\b%04d', iter);
    
    btw_var = 5;
    comm = normrnd(55, btw_var, 15, 1);
    
    btw_var = 5;
    stoic = normrnd(45, btw_var, 15, 1);
    
    x3 = [comm; stoic];
    
    within_var = 5;
    x4 = x3 + normrnd(0, within_var, 30, 1);
    
    icc2(iter,1) = ICC(2,'single', [x3 x4]);

end

% Get the representative data (values close to mean icc)
icc_rep = 0;
while icc_rep < floor(mean(icc2)*100)/100 || icc_rep > ceil(mean(icc2)*100)/100
    comm = normrnd(55, btw_var, 15, 1);
    stoic = normrnd(45, btw_var, 15, 1);
    x33 = [comm; stoic];
    x44 = x33 + normrnd(0, within_var, 30, 1);
    
    icc_rep = ICC(2,'single', [x33 x44]); % ICC 
end    

disp(' DONE.');

%% PLOTS: HOMOGENEOUS GROUPS
close all;

figure('color', 'w');
col = [0.4392    0.6784    0.2784
    0.3569    0.6078    0.8353
    0.9294    0.4902    0.1922];
edgecol = col*.7;

r = normrnd(0,.07, 30,1);
scatter(1+r, x11, 80, col(1,:), 'filled', 'MarkerEdgeColor', edgecol(1,:), 'Linewidth', 1.5)
hold on;
for i = 1:numel(x11)
    line([1+r(i), 2+r(i)], [x11(i), x22(i)], 'color', [.6 .6 .6]);
end
scatter(1+r, x11, 80, col(1,:), 'filled', 'MarkerEdgeColor', edgecol(1,:), 'Linewidth', 1.5)
hold on;
scatter(2+r, x22, 80, col(1,:), 'filled', 'MarkerEdgeColor', edgecol(1,:), 'Linewidth', 1.5)

set(gca, 'fontsize', 20, 'xlim', [0.7 2.2], 'ylim', [20 80], ...
    'xtick', [1 2], 'xticklabel', [], 'tickDir', 'out', 'tickLength', [.02 .02], 'linewidth', 1.5);
set(gcf, 'position', [360   483   176   215]);

savename = 'sim_1group.pdf';

try
    pagesetup(gcf);
    saveas(gcf, savename);
catch
    pagesetup(gcf);
    saveas(gcf, savename);   
end

%% PLOTS: HETEROGENEOUS  GROUPS

close all;

figure('color', 'w');

col = [0.4392    0.6784    0.2784
    1.0000    0.7529         0
    0.9294    0.4902    0.1922];
edgecol = col*.7;
scatter(1+r(1:15), x33(1:15), 80, col(3,:), 'filled', 'MarkerEdgeColor', edgecol(3,:), 'Linewidth', 1.5)
hold on;
for i = 1:numel(x11)
    line([1+r(i), 2+r(i)], [x33(i), x44(i)], 'color', [.6 .6 .6]);
end
scatter(1+r(1:15), x33(1:15), 80, col(3,:), 'filled', 'MarkerEdgeColor', edgecol(3,:), 'Linewidth', 1.5)
hold on;
scatter(1+r(16:30), x33(16:30), 80, col(2,:), 'filled', 'MarkerEdgeColor', edgecol(2,:), 'Linewidth', 1.5)
scatter(2+r(1:15), x44(1:15), 80, col(3,:), 'filled', 'MarkerEdgeColor', edgecol(3,:), 'Linewidth', 1.5)
scatter(2+r(16:30), x44(16:30), 80, col(2,:), 'filled', 'MarkerEdgeColor', edgecol(2,:), 'Linewidth', 1.5)

set(gca, 'fontsize', 20, 'xlim', [0.7 2.2], 'ylim', [20 80], ...
    'xtick', [1 2], 'xticklabel', [], 'tickDir', 'out', 'tickLength', [.02 .02], 'linewidth', 1.5);
set(gcf, 'position', [360   483   176   215]);

savename = 'sim_2group.pdf';

try
    pagesetup(gcf);
    saveas(gcf, savename);
catch
    pagesetup(gcf);
    saveas(gcf, savename);   
end

save('sim_res.mat', 'x*', 'icc*');

%% ICC VIOLIN PLOTS

load('sim_res.mat');

col = [0.4392    0.6784    0.2784
    0.9294    0.4902    0.1922];
edgecol = col*.7;

close all;
create_figure('violin');
violinplot([icc1 icc2], 'facecolor',col, 'edgecolor', edgecol, 'facealpha', 1, ...
    'mc', 'k', 'medc', '', 'plotlegend', 0, 'nopoints', 'linewidth', 2); 
set(gcf, 'position', [360   483   234   217]);
set(gca, 'FontSize', 20, 'linewidth', 1.5, 'box', 'off', 'ylim', [0 1],...
    'TickDir', 'out', 'TickLength', [.02 .02], 'xticklabel', [], 'ytick', 0:.2:1);

savename = 'sim_violin.pdf';

try
    pagesetup(gcf);
    saveas(gcf, savename);
catch
    pagesetup(gcf);
    saveas(gcf, savename);
end

