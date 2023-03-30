% plot_SDT.m
%close all

m1 = 0;
m2 = .6;
s1 = .2;
s2 = .4;
k = .3;
sf = 2.2; % scale factor

x = linspace(-1.2,1.8,1000);
ym1s1 = normpdf(x,m1,s1);
ym2s1 = normpdf(x,m2,s1);
ym1s2 = normpdf(x,m1,s2);
ym2s2 = normpdf(x,m2,s2);

xz = linspace(-1.2*sf,1.8*sf,1000);
dxz = xz(2)-xz(1);
zm1s1 = ym1s1./(sum(ym1s1*dxz));
zm2s1 = ym2s1./(sum(ym2s1*dxz));
kz = k*sf;

% dx = x(2)-x(1);
% z = y1.*y2;
% zs = z./sum(z*dx); % scaled by area

figure('Position',[200 100 1000 300])
colors = get(gca,'ColorOrder');
grey = [0.7 0.7 0.7];
hold on
p(1) = plot(x,ym1s1,'k','LineWidth',2);
p(2) = plot(x,ym2s1,'k','LineWidth',2);
%p(3) = plot(x,ym1s2,'Color','k','LineWidth',2);
%p(4) = plot(x,ym2s2,'Color','k','LineWidth',2);
ylim([0 2.2])
%vline(k,'Color',[0 0 0],'LineWidth',4);
%vline(k,'Color',grey,'LineWidth',4,'LineStyle','--');
p(6) = plot(x([1 end]), [0 0],'Color',[.5 .5 .5],'LineWidth',3);
axis off

%%
figure('Position',[200 100 1000 300])
hold on
p(1) = plot(x,ym1s1,'k','LineWidth',2);
p(2) = plot(x,ym2s1,'k','LineWidth',2);
ylim([0 2.2])
vline(k,'Color',[0 0 0],'LineWidth',4);
p(4) = plot(xz,zm1s1,'Color',colors(1,:),'LineWidth',2);
p(5) = plot(xz,zm2s1,'Color',colors(1,:),'LineWidth',2);
vline(kz,'Color',colors(1,:),'LineWidth',4);
p(7) = plot(xz([1 end]), [0 0],'Color',[.5 .5 .5],'LineWidth',3);
xlim([-2 3])
axis off

%% different things attention could do
% all unatt have same d' and c
ms = [1 1 .75 .5]; % [att unatt1 unatt2 unatt3]
ss = [.5 1 .75 .5];
% bs = [1 1 .75 .5]; % c = .5 for unatt
bs = [.5 .5 .375 .25]; % c = 0 for unatt
n = numel(ms);

cols = [0 0 0; colors(1:3,:)];

x = linspace(-3,4,1000);
xlims = [-3 4];
ylims = [0 1];

y0 = []; % noise
y = []; % signal
bline = [];
for i = 1:n
    y0(:,i) = normpdf(x,0,ss(i));
    y(:,i) = normpdf(x,ms(i),ss(i));
    bline(:,i) = [bs(i) bs(i)];
end

figure('Position',[200 100 1000 300])
hold on
for i = 2:3
    plot(x,y0(:,i),'LineWidth',2,'Color',cols(i,:))
    plot(x,y(:,i),'LineWidth',2,'Color',cols(i,:))
    plot(bline(:,i),ylims,'LineWidth',2,'Color',cols(i,:))
end
plot(x,y0(:,1),'LineWidth',2,'Color',cols(1,:),'LineStyle','-')
plot(x,y(:,1),'LineWidth',2,'Color',cols(1,:),'LineStyle','-')
plot(bline(:,1),ylims,'LineWidth',2,'Color',cols(1,:),'LineStyle','--')
legend('cued','uncued_1','uncued_2','uncued_3')
set(gca,'TickDir','out')

% separate subplots
figure('Position',[200 100 1000 1000])
for i = 1:n
    subplot(n,1,i)
    hold on
    plot(x,y0(:,i),'LineWidth',2,'Color',cols(i,:))
    plot(x,y(:,i),'LineWidth',2,'Color',cols(i,:))
    plot(bline(:,i),ylims,'LineWidth',2,'Color',cols(i,:))
end

% final - 2 panel
cols = [0 179 0; 102 51 153; 102 51 153]/255;
figure('Position',[200 100 1000 600])
for i = 2:3
    subplot(2,1,i-1)
    hold on
    plot(x,y0(:,1),'LineWidth',3,'Color',cols(1,:),'LineStyle','-')
    plot(x,y0(:,i),'LineWidth',3,'Color',cols(i,:))
    plot(x,y(:,1),'LineWidth',3,'Color',cols(1,:),'LineStyle','-')
    plot(x,y(:,i),'LineWidth',3,'Color',cols(i,:))
    plot(bline(:,1),ylims,'LineWidth',5,'Color',cols(1,:))
    plot(bline(:,i),ylims,'LineWidth',5,'Color',cols(i,:),'LineStyle','--')
    plot([ms(i) ms(i)],ylims,'k')
    set(gca,'TickDir','out','LineWidth',1)
    plot([-ss(i) 0], normpdf([-ss(i) -ss(i)],0,ss(i)),'LineWidth',3,'Color',cols(i,:))
end
legend('cued','uncued')

% final - 4 panel
cols = [0 179 0; 102 51 153; 102 51 153]/255;
figure('Position',[200 100 1000 600])
for i = 2:3
    subplot(2,2,(i-2)*2+1)
    hold on
    plot(x,y0(:,1),'LineWidth',3,'Color',cols(1,:),'LineStyle','-')
    plot(x,y0(:,i),'LineWidth',3,'Color',cols(i,:))
    plot(x,y(:,1),'LineWidth',3,'Color',cols(1,:),'LineStyle','-')
    plot(x,y(:,i),'LineWidth',3,'Color',cols(i,:))
    plot(bline(:,1),ylims,'LineWidth',5,'Color',cols(1,:))
    plot(bline(:,i),ylims,'LineWidth',5,'Color',cols(i,:),'LineStyle','--')
    set(gca,'TickDir','out','LineWidth',1)
    plot([-ss(i) 0], normpdf([-ss(i) -ss(i)],0,ss(i)),'LineWidth',3,'Color',cols(i,:))
    xlim(xlims)
    
    subplot(2,2,(i-2)*2+2)
    hold on
    plot(x,normpdf(x,0,1),'LineWidth',3,'Color',cols(i,:))
    plot(x,normpdf(x,1,1),'LineWidth',3,'Color',cols(i,:))
    plot([.5 .5],ylims,'LineWidth',5,'Color',cols(i,:))
    set(gca,'TickDir','out','LineWidth',1)
    plot([-1 0], normpdf([-1 -1],0,1),'LineWidth',3,'Color',cols(i,:))
    xlim(xlims)
end
legend('cued','uncued')

