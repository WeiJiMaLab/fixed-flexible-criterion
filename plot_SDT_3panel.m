%close all

set(0,'DefaultAxesFontSize', 22)
set(0,'DefaultLineLineWidth', 3)

color1 = [27,158,119]./255;
color2 = [217,95,2]./255;
color3 = [117,112,179]./255;

colors = [color3;color1;color2];

%% different things attention could do
% all unatt have same d' and c
ms = [1 1 1];
m_unatt = [2 2 2];%[1 2 sqrt(2)];%[1 1 .75 .5]; % [att unatt1 unatt2 unatt3]

ss = [1 1 1]; %[.5 1 .75 .5];
ss_unatt = [2 2 2];

bs = (ms-0)/2;
bs_unatt = [0.5 1 0.5*sqrt(2)];%[1 1 .75 .5]; % c = .5 for unatt
%bs = [.5 .5 .375 .25]; % c = 0 for unatt
n = numel(ss);

cols = [0 0 0; colors(1:3,:)];

x = linspace(-3,4,1000);
xlims = [-3 4];
ylims = [0 1];

y0 = []; % noise
y = []; % signal

y_unatt = [];
y0_unatt = [];

bline = [];
bline_unatt=[];
for i = 1:n
    y0(:,i) = normpdf(x,0,ss(i));
    y(:,i) = normpdf(x,ms(i),ss(i));
    bline(:,i) = [bs(i) bs(i)];
    
    y0_unatt(:,i) = normpdf(x,0,ss_unatt(i));
    y_unatt(:,i) = normpdf(x,m_unatt(i),ss_unatt(i));
    bline_unatt(:,i) = [bs_unatt(i) bs_unatt(i)];
end


% final - 4 panel
cols = [0 179 0; 102 51 153; 102 51 153]/255;
grey1 = [169,169,169]/255;
figure('InnerPosition',[200 100 600 650])

noiselvl = 0;
for i = 1:2
    switch i 
        case 1
            subplot(2,1,i)
            hold on
            set(gca,'ytick',[])
            ax = gca;

            plot(x,y0(:,1),'LineWidth',3,'Color','k','LineStyle','-')
            plot(x,y(:,1),'LineWidth',3,'Color','k','LineStyle','-')
            plot(bline(:,1),[0 1/6],'LineWidth',7,'Color',color1, 'LineStyle','-')
            plot(bline(:,1),[1/6 2/6],'LineWidth',7,'Color',color2, 'LineStyle','-')
            plot(bline(:,1),[2/6 3/6],'LineWidth',7,'Color',color3, 'LineStyle','-')
            [~,midpt] = max(y0(:,1));
            plot([0,0],[0 y0(midpt,1)],'LineWidth',2,'Color','k', 'LineStyle','--')
            [~,midpt] = max(y(:,1));
            plot([1,1],[0 y(midpt,1)],'LineWidth',2,'Color','k', 'LineStyle','--')   
            set(gca,'TickDir','out','LineWidth',1)
            %plot([-ss(i) 0], normpdf([-ss(i) -ss(i)],0,ss(i)),'LineWidth',3,'Color',cols(i,:))
            xlim(xlims)
            ylim(ylims)

            %// Place axis 2 below the 1st.
            ax1=gca;
            a1Pos = ax1.Position; % position of first axes
            ax2 = axes('Position',[a1Pos(1) a1Pos(2)-.07 a1Pos(3) a1Pos(4)],'Color','none','YTick',[],'YTickLabel',[]);
            %// Adjust bounds for relative "c" scale
            clims = (xlims-1/2)/1;
            xlim(clims)
            ax2.YAxis.Visible = 'off';
            
        case 2
            subplot(2,1,i)
            set(gca,'TickDir','out','LineWidth',1)
            set(gca,'ytick',[])
            hold on
            noiselvl = noiselvl+1;
            plot(x,y0_unatt(:,noiselvl),'LineWidth',3,'Color','k')
            plot(x,y_unatt(:,noiselvl),'LineWidth',3,'Color','k')
            [~,midpt] = max(y0_unatt(:,noiselvl));
            plot([0,0],[0 y0_unatt(midpt,noiselvl)],'LineWidth',2,'Color','k', 'LineStyle','--')
            [~,midpt] = max(y_unatt(:,noiselvl));
            plot([2,2],[0 y_unatt(midpt,noiselvl)],'LineWidth',2,'Color','k', 'LineStyle','--')
            for i_b = 1:3
                hold on
                plot(bline_unatt(:,i_b),ylims,'LineWidth',5,'Color',colors(i_b,:))
            end
            xlim(xlims)
            ylim(ylims)
            
            
            %// Place axis 2 below the 1st.
            ax1=gca;
            a1Pos = ax1.Position; % position of first axes
            ax2 = axes('Position',[a1Pos(1) a1Pos(2)-.07 a1Pos(3) a1Pos(4)],'Color','none','YTick',[],'YTickLabel',[]);
            %// Adjust bounds for relative "c" scale
            clims = (xlims-2/2)/2;
            xlim(clims)
            ax2.YAxis.Visible = 'off';
            
    end
    
    %%
%     subplot(2,3,(i-2)*2+2)
%     hold on
%     plot(x,normpdf(x,0,1),'LineWidth',3,'Color',cols(i,:))
%     plot(x,normpdf(x,1,1),'LineWidth',3,'Color',cols(i,:))
%     plot([.5 .5],ylims,'LineWidth',5,'Color',cols(i,:))
%     set(gca,'TickDir','out','LineWidth',1)
%     plot([-1 0], normpdf([-1 -1],0,1),'LineWidth',3,'Color',cols(i,:))
%     xlim(xlims)
end
%legend('cued','uncued')