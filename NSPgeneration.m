%% Figure 1A - Generation of NSPs

n           = 30;                       % desired number of spikes
rate        = 0.5;                      % rate in spikes per second
randNumbers = rand(n,10000);            % n random numbers, uniform distribution

ISIs        = -log(randNumbers)/rate;   % ISIs in seconds
ISIs        = ISIs*1000;                % ISIs in milliseconds

SpikeTimes  = cumsum(ISIs,1);           % Convert ISIs to SpikeTimes
SpikeTimes  = SpikeTimes - repmat(SpikeTimes(1,:),30,1); % Set the first time to zero

% Check howmany of the generated patterns has 30 pulses in 60s
[N,C]       = hist(SpikeTimes(30,:),(20000:2000:120000)); 
fprintf('%d patterns have exactly 30 pulses spanning 60s\n', N(C==60000))

% Select NSPs which has 30 pulses spanning 60s
selectedSpikeTimes = SpikeTimes(:,SpikeTimes(30,:)>59000 & SpikeTimes(30,:)<61000);

% Figure 1A - Argunsah and Israely, iScience, 2023.
figure;
hist(ISIs(:),100); hold on; plot([2000 2000],[0 4*10e3],'--r','Linewidth',3);
ax = gca;
ax.FontSize = 24; 
set(ax,'box','off','color','none');

set(gca,'TickDir','out');
xticks([0 0.2 0.4 0.6 0.8 1 1.5 2 2.5 3]*10e3);
xticklabels({'0','2','4','6','8','10','15','20','25','30'});
xlabel('Inter Pulse Interval (s)','FontSize',24,'Color','k');
ylabel('Frequency','FontSize',24,'Color','k');
axis([0 2*10e3 0 4*10e3]);

% Figure 1A inset - Argunsah and Israely, iScience, 2023.
figure;
hist(SpikeTimes(30,:),(20000:2000:120000));
ax = gca;
ax.FontSize = 24; 
set(ax,'box','off','color','none');

set(gca,'TickDir','out');
xticks([0 1 2 3 4 5 6 7 8 9 10]*10e3);
xlabel('End of 30pulse Stimulation (ms)','FontSize',24,'Color','k');
ylabel('Frequency','FontSize',24,'Color','k');

% Example NSPs
figure; hold on;
for i = 1:50
    plot(selectedSpikeTimes(:,i),i*ones(1,30),'k.','LineStyle','none');
end
ax = gca;
ax.FontSize = 24; 
set(ax,'box','off','color','none');

set(gca,'TickDir','out');
xlabel('Time (ms)','FontSize',24,'Color','k');
ylabel('Pulse Trains','FontSize',24,'Color','k');
title('Example NSPs','FontSize',24,'Color','k');
