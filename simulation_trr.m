%% one communicative culture

fprintf('iteration 0000');
for iter = 1:1000
    
    fprintf('\b\b\b\b%04d', iter);
    
    btw_var = 5;
    x1 = normrnd(50, btw_var, 30, 1);
    
    within_var = 5;
    x2 = x1 + normrnd(0, within_var, 30, 1);
    
    icc1(iter,1) = ICC(2,'single', [x1 x2]);
    
    if icc1(iter,1) > 0.65 && icc1(iter,1) < 0.66
        x11 = x1;
        x22 = x2;
    end
end

disp('done');

%% two communicative cultures: stoic vs. communicators

fprintf('iteration 0000');
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
    
    if icc2(iter,1) > 0.79 && icc2(iter,1) < 0.80
        x33 = x3;
        x44 = x4;
    end
end

disp('done');

%% plots: 1 GROUP
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

savedir = '/Users/clinpsywoo/Dropbox/W_Letzen_commentary';
savename = fullfile(savedir, 'sim_1group.pdf');

try
    pagesetup(gcf);
    saveas(gcf, savename);
catch
    pagesetup(gcf);
    saveas(gcf, savename);   
end

%% 2 GROUPS
% 
% close all;
% 
% figure('color', 'w');
% col = cbrewer('seq', 'YlOrRd', 30); col = flipud(col);
% edgecol = col*.7;
% 
% r = normrnd(0,.05, 30,1);
% for i = 1:numel(x3)
%     scatter(1+r(i), x3(i), 80, col(i,:), 'filled')
%     hold on;
% end
% 
% hold on;
% for i = 1:numel(x11)
%     line([1+r(i), 2+r(i)], [x3(i), x4(i)], 'color', [.6 .6 .6]);
% end
% 
% for i = 1:numel(x3)
%     scatter(1+r(i), x3(i), 80, col(i,:), 'filled')
%     hold on;
%     scatter(2+r(i), x4(i), 80, col(i,:), 'filled')
% end

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

savedir = '/Users/clinpsywoo/Dropbox/W_Letzen_commentary';
savename = fullfile(savedir, 'sim_2group.pdf');

try
    pagesetup(gcf);
    saveas(gcf, savename);
catch
    pagesetup(gcf);
    saveas(gcf, savename);   
end

save(fullfile(savedir, 'sim_res.mat'), 'x*', 'icc*');

%% ICC for group 1 (run this on matlab 2015)

savedir = '/Users/clinpsywoo/Dropbox/W_Letzen_commentary';
load(fullfile(savedir, 'sim_res.mat'));

col = [0.4392    0.6784    0.2784
    0.9294    0.4902    0.1922];
edgecol = col*.7;

close all;
create_figure('violin');
violinplot([icc1 icc2], 'facecolor',col, 'edgecolor', edgecol, 'facealpha', 1, ...
    'mc', 'k', 'medc', '', 'plotlegend', 0, 'nopoints'); 
%set(gcf, 'position', [360   416   350   282], 'color', 'w'); 
set(gcf, 'position', [360   483   234   217]);
set(gca, 'FontSize', 20, 'linewidth', 1.5, 'box', 'off', 'ylim', [0 1],...
    'TickDir', 'out', 'TickLength', [.02 .02], 'xticklabel', [], 'ytick', 0:.2:1);

%%
savedir = '/Users/clinpsywoo/Dropbox/W_Letzen_commentary';
savename = fullfile(savedir, 'sim_violin.pdf');

try
pagesetup(gcf);
saveas(gcf, savename);
catch
pagesetup(gcf);
saveas(gcf, savename);
end

