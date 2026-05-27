% ============================================================
%  IEEE-Format Bar Chart: Jain Fairness Index on AoI
%  Four scheduling policies at B* = 5 (greedy optimal)
%  K=4/cell, T=200, N_mc=500, R_th=12 Mbps, C=12
% ============================================================

close all; clear; clc;

% ── Data ─────────────────────────────────────────────────────
policies = {'Greedy','Round Robin','Periodic','Random'};
jfi_vals = [0.9908, 0.9490, 0.9786, 0.9513];

% ── Colors — matched to line figure ──────────────────────────
% Greedy   → blue
% RR       → teal-green  (swapped from orange)
% Periodic → vermillion  (swapped from yellow)
% Random   → purple
col_greedy   = [0,   114, 178] / 255;   % blue
col_rr       = [0,   158, 115] / 255;   % teal-green  #009E73
col_periodic = [213,  94,   0] / 255;   % vermillion  #D55E00
col_random   = [150,  60, 180] / 255;   % purple
bar_colors   = [col_greedy; col_rr; col_periodic; col_random];

% ── Figure: IEEE single-column 3.5 x 2.8 inches ─────────────
fig = figure('Units','inches', ...
             'Position',[1 1 3.5 2.8], ...
             'Color','white');

ax = axes('Parent', fig, ...
          'Position', [0.14, 0.15, 0.82, 0.76]);
hold(ax, 'on');

% ── Draw bars ────────────────────────────────────────────────
nb = numel(jfi_vals);
for i = 1:nb
    bar(ax, i, jfi_vals(i), ...
        0.52, ...
        'FaceColor',   bar_colors(i,:), ...
        'EdgeColor',   bar_colors(i,:) * 0.55, ...
        'LineWidth',   0.8, ...
        'FaceAlpha',   0.88);
end

% ── Perfect fairness reference line ──────────────────────────
yline(ax, 1.0, ...
    'Color',     [0.30 0.30 0.30], ...
    'LineStyle', '--', ...
    'LineWidth', 0.9, ...
    'Label',     '', ...
    'LabelHorizontalAlignment', 'left', ...
    'LabelVerticalAlignment',   'bottom', ...
    'FontName',  'Times New Roman', ...
    'FontSize',  7, ...
    'Interpreter','latex');

% ── Value labels on top of each bar ──────────────────────────
y_offset = 0.0008;
for i = 1:nb
    text(ax, i, jfi_vals(i) + y_offset, ...
        sprintf('%.4f', jfi_vals(i)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment',   'bottom', ...
        'FontName',  'Times New Roman', ...
        'FontSize',  7.5, ...
        'FontWeight','normal', ...
        'Interpreter','none', ...
        'Color', bar_colors(i,:) * 0.55);
end

hold(ax, 'off');

% ── Axes formatting ──────────────────────────────────────────
ax.FontName             = 'Times New Roman';
ax.FontSize             = 9;
ax.TickLabelInterpreter = 'latex';
ax.XLim                 = [0.5, 4.5];
ax.XTick                = 1:4;
ax.XTickLabel           = {'Greedy','RR','Periodic','Random'};
ax.YLim                 = [0.93, 1.005];
ax.YTick                = [0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00];
ax.YTickLabel           = {'0.93','0.94','0.95','0.96', ...
                            '0.97','0.98','0.99','1.00'};
ax.YMinorTick           = 'off';
ax.Box                  = 'on';
ax.LineWidth            = 0.9;
ax.XGrid                = 'off';
ax.YGrid                = 'on';
ax.GridLineStyle        = '-';
ax.GridAlpha            = 0.22;
ax.GridColor            = [0.60 0.60 0.60];
ax.TickDir              = 'in';
ax.TickLength           = [0.015 0.015];
ax.Layer                = 'top';
ax.XLimitMethod         = 'tight';

% ── Axis labels ──────────────────────────────────────────────
xlabel(ax, '', ...
    'Interpreter','latex', ...
    'FontName','Times New Roman', ...
    'FontSize',9);

ylabel(ax, '$\mathcal{J}$ (AoI)', ...
    'Interpreter','latex', ...
    'FontName','Times New Roman', ...
    'FontSize',9);

% ── Export ───────────────────────────────────────────────────
set(fig,'PaperUnits','inches','PaperSize',[3.5 2.8], ...
    'PaperPosition',[0 0 3.5 2.8]);

print(fig,'fig_JFI_AoI_bar','-dpdf','-r600');
print(fig,'fig_JFI_AoI_bar','-dpng','-r600');
print(fig,'fig_JFI_AoI_bar','-depsc','-r600');

fprintf('Saved: fig_JFI_AoI_bar.pdf / .png / .eps\n');
fprintf('\nJFI Summary:\n');
for i = 1:nb
    fprintf('  %-14s : %.4f\n', policies{i}, jfi_vals(i));
end
fprintf('  Best policy  : %s (%.4f)\n', ...
    policies{jfi_vals == max(jfi_vals)}, max(jfi_vals));
fprintf('  Greedy gain over worst: +%.4f\n', ...
    max(jfi_vals) - min(jfi_vals));