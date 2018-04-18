close all;
clear all;
 
% Cobb Douglas Model
%baseline parameters
delta=0.1;          %depreciation rate
alpha = .33;        %paramter for Cobb-Douglas technology
s = 0.22;           %savings rate
n = 0;              %population growth
g = 0.02;           %technology growth
z = (1+n)*(1+g)-1;  %auxiliary expression for model
T=50;              %number of simulation periods
t0=10;              %time of change

s = [0.1, 0.2, alpha, 0.4, 0.5];

%re-compute steady state for these three values
kss = (s/(z+delta)).^(1/(1-alpha));
yss = kss.^alpha;
css = (1-s).*yss;

%create vector of length T with initial steady state values
kssv = kron(kss,ones(T,1)); 
yssv = kron(yss,ones(T,1)); 
cssv = kron(css,ones(T,1)); 

%initial conditions
k=kssv; %initialize the capital vector with the initial steady state
y=yssv; %initialize the output vector with the initial steady state

%Simulate T periods

for t=1:T
    y(t,:)=k(t,:).^alpha; %production
    c(t,:)=(1-s).*y(t,:); %production
    k(t+1,:)=(1/(1+z)).*((1-delta)*k(t,:) + s.*y(t,:)); %capital accumulation
end

%plot k and y
figure
    hold on

    plot(c(1:T,1),'-b')
    plot(c(1:T,2),'--b')
    plot(c(1:T,3),'-og')
    plot(c(1:T,4),'--r')
    plot(c(1:T,5),'-r')

   
    xlabel('Time');
    ylabel('Consumption Per Effective Worker');
    % Create Legend and choose location
    legend('s=0.1','s=0.2','s=0.33','s=0.4','s=0.5','Location', 'Best');
    
    %Save Figure 
    pic_file=strcat(['./golden_rule_sim.eps']);
    disp([strcat(['plotting to ' pic_file '...'])]);
    print('-depsc', pic_file);