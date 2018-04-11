close all;
clear all;


% Baseline Equations and assignments 

% ct = 
% uct = ln(ct);
% uprime = 1/uct;
alpha = .33;        %paramter 
beta = 1/1.03;       %parameter
%baseline parameters

T=200;              %number of simulation periods
% t0=10;              %time of change

% Initialize a vector with 200 random values drawn from a 
% normal distribution with a mean of 0 and a variance of .3^2.

    a = (.3);      % std dev
    b = 0;          % mean
    lnz_bar = a.*randn(200,1) + b;    % 200 observation vector lnz_bar

    stats = [mean(lnz_bar) std(lnz_bar) var(lnz_bar)];    %stats for vector

    meanlnzbar = mean(lnz_bar);

    zbar = expm(meanlnzbar);
    et = log(zbar);
    
    % 200 observation vector named et
    etv = log(lnz_bar);
    
    %vector for part c
    cetv = lnz_bar; 
    cetv (4) = .5;
    cetv (5) = .4;
    cetv (6) = .3;
    for t=7:T
        cetv(t)=0;
    end
    % Set initial values for steady state

ytss_c = cetv*(zbar*(alpha*beta*zbar)^(alpha/(1-alpha)));    %steady state for y
ktss_c = cetv*((alpha*beta*zbar)^(1/(1-alpha)));    %steady state for kt
ctss_c = cetv*(((1-alpha*beta)*zbar*(alpha*beta*zbar))^(alpha/(1-alpha)));  %steady state for ct

    
    
   
% Set initial values for steady state

ytss = zbar*(alpha*beta*zbar)^(alpha/(1-alpha));    %steady state for y
ktss = (alpha*beta*zbar)^(1/(1-alpha));    %steady state for kt
ctss = ((1-alpha*beta)*zbar*(alpha*beta*zbar))^(alpha/(1-alpha));  %steady state for ct

% Set k0, c0, y0 for initialization 
    
    k0 = ktss;
    c0 = ctss;
    y0 = ytss;
    
% answer to part B    
    % get log deviation values      
    logdevyt = log((ytss-zbar)^2);  
    logdevkt = log((ktss-zbar)^2);
    logdevct = log((ctss-zbar)^2);

    
logdevytss = log((zbar*(alpha*beta*zbar))^((alpha/(1-alpha)-et)))^2;
logdevktss = log((alpha*beta*zbar)^(1/(1-alpha)));    %steady state for kt
logdevctss = log(((1-alpha*beta)*zbar*(alpha*beta*zbar))^(alpha/(1-alpha)));  %steady state for ct

logdevitss = logdevytss - log(((1-alpha*beta)*zbar*(alpha*beta*zbar))^(alpha/(1-alpha)));  %steady state for ct


% What is the standard deviation of (the log deviation from SS of) 
% consumption relative to output?  


 statsSScy = [mean(logdevytss) std(logdevytss) var(logdevytss)];

display(std(logdevytss))
%What isthe standard deviation of (the log deviation from SS of) 
% investment relative to output?
statsSSiy = [mean(logdevitss) std(logdevitss) var(logdevitss)];
display(std(logdevitss))
%yt kt ct


% calculate steady state values using k0 as an input
% ytss, ktss, ctss calculations over T = 200 


%create vector of length T with initial steady state values
ktssv = kron(ktss,ones(T,1)); 
ytssv = kron(ytss,ones(T,1)); 
ctssv = kron(ctss,ones(T,1)); 

%initial conditions
k=ktssv; %initialize the capital vector with the initial steady state
y=ytssv; %initialize the output vector with the initial steady state
c=ctssv; %initialize the comsumption vector with the initial steady state

for t=1:T
    k(t,:)=(alpha*beta*zbar)^(1/(1-alpha)); %capital accumulation
    y(t,:)= zbar*(alpha*beta*zbar)^(alpha/(1-alpha)); %production
    c(t,:)=(1-alpha*beta)*zbar*(alpha*beta*zbar)^(alpha/(1-alpha)); %consumption
  
end

    
   
   
