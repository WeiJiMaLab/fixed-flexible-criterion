close all
clear
clc
%% plot_embedded_cat

figure('Position',[200 100 900 800])

set(0,'DefaultAxesFontSize', 24)
set(0,'DefaultLineLineWidth', 3)

color1 = [27,158,119]./255;
color2 = [217,95,2]./255;
color3 = [117,112,179]./255;

colors = [color3;color1;color2];

%% different things attention could do

mu = 0;
sig_2 = 12;
sig_1 = 3;

sig_val = 5;
sig_2_val = sqrt(sig_2^2 + sig_val^2);
sig_1_val = sqrt(sig_1^2 + sig_val^2);
fixed = sqrt(log((sig_val^2 + sig_2^2)/(sig_val^2 + sig_1^2)) * (sig_val^2 + sig_2^2)*(sig_val^2 + sig_1^2)/(sig_1^2+sig_2^2));

sig_inv = 10;
sig_2_inv = sqrt(sig_2^2 + sig_inv^2);
sig_1_inv = sqrt(sig_1^2 + sig_inv^2);
subopt = 9.5;
opt = sqrt(log((sig_inv^2 + sig_2^2)/(sig_inv^2 + sig_1^2)) * (sig_inv^2 + sig_2^2)*(sig_inv^2 + sig_1^2)/(sig_1^2+sig_2^2));


ss = [sig_2 sig_1 sig_2_val sig_1_val sig_2_inv sig_1_inv];


x = linspace(-30,30,1000);
%%
i_s = 1;
for i_plot = 1:3    
    subplot(3,1,i_plot)
    hold on
    set(gca,'ytick',[])
    ax = gca;
    
    sig_cond2 = ss(i_s);
    sig_cond1 = ss(i_s+1);

    y0 = normpdf(x,mu,sig_cond2); % category 1
    y = normpdf(x,mu,sig_cond1); % category 2

    plot(x,y0,'LineWidth',3,'Color',[0.5 0.5 0.5],'LineStyle','-'); hold on;
    plot(x,y,'LineWidth',3,'Color', 'k','LineStyle','-'); hold on
    
    if i_s == 1
        ymax = 0.15;
        ylim([0 ymax])
        xlabel('Stimulus orientation ({\circ})')
        
        ylabel('Stimulus                    ')
        set(get(gca,'YLabel'),'Rotation',0)

    elseif i_s == 3
        ymax = 0.1;
        ylim([0 ymax])
        plot([fixed fixed],[0 ymax/3],'LineWidth',7,'Color',color1, 'LineStyle','-'); hold on;
        plot([fixed fixed],[ymax/3 2*ymax/3],'LineWidth',7,'Color',color2, 'LineStyle','-'); hold on;
        plot([fixed fixed],[2*ymax/3 3*ymax/3],'LineWidth',7,'Color',color3, 'LineStyle','-');
        
        plot([-fixed -fixed],[0 ymax/3],'LineWidth',7,'Color',color1, 'LineStyle','-'); hold on;
        plot([-fixed -fixed],[ymax/3 2*ymax/3],'LineWidth',7,'Color',color2, 'LineStyle','-'); hold on;
        plot([-fixed -fixed],[2*ymax/3 3*ymax/3],'LineWidth',7,'Color',color3, 'LineStyle','-')
        
        ylabel('Valid                      ')
        set(get(gca,'YLabel'),'Rotation',0)
        text(-32,0.01,'Probability', 'Rotation', 90, 'FontSize',22)
    elseif i_s == 5
        ymax = 0.08;
        ylim([0 ymax])
        plotfix = plot([fixed fixed],[0 ymax],'LineWidth',7,'Color',color3, 'LineStyle','-'); hold on;
        plotflex = plot([subopt subopt],[0 ymax],'LineWidth',7,'Color',color2, 'LineStyle','-'); hold on;
        plotopt = plot([opt opt],[0 ymax],'LineWidth',7,'Color',color1, 'LineStyle','-')
        
        plot([-fixed -fixed],[0 ymax],'LineWidth',7,'Color',color3, 'LineStyle','-'); hold on;
        plot([-subopt -subopt],[0 ymax],'LineWidth',7,'Color',color2, 'LineStyle','-'); hold on;
        plot([-opt -opt],[0 ymax],'LineWidth',7,'Color',color1, 'LineStyle','-')
        
        
        legend([plotfix, plotflex, plotopt],{'fixed', 'flex', 'opt'});
        legend boxoff
        
        ylabel('Invalid                      ')
        set(get(gca,'YLabel'),'Rotation',0)

        xlabel('Internal measurement ({\circ})')
    end
    i_s = i_s + 2;
end

