close all;
clear all;


% Baseline Equations and assignments 

% ct = 
% uct = ln(ct);
% uprime = 1/uct;
alpha = 1/3;        %paramter 
beta = 1/1.06;       %parameter
%baseline parameters

T=500;              %number of simulation periods
% t0=10;              %time of change

% Initialize a vector with 500 random values drawn from a 
% normal distribution with a mean of 0 and a variance of .3^2.

    a = (.7);      % std dev
    b = 0;          % mean
    lnz_bar = a.*randn(500,1) + b;    % 500 observation vector lnz_bar
    errorvec = a.*randn(500,1) + b;    % 500 observation vector errorvec

    stats = [mean(lnz_bar) std(lnz_bar) var(lnz_bar)];    %stats for vector

    meanlnzbar = mean(lnz_bar);

    zbar = expm(meanlnzbar);
    et = log(zbar);
    
    % 500 observation vector named etv
    etv = log(lnz_bar);
    
    %vector for part c
    cetv = etv;
    % Set initial values for steady state

ytss_c = cetv*(zbar*(alpha*beta*zbar)^(alpha/(1-alpha)));    %steady state for y
ktss_c = cetv*((alpha*beta*zbar)^(1/(1-alpha)));    %steady state for kt
ctss_c = cetv*(((1-alpha*beta)*zbar*(alpha*beta*zbar))^(alpha/(1-alpha)));  %steady state for ct

    
    
   
% Set initial values for steady state

ytss = zbar*(alpha*beta*zbar)^(alpha/(1-alpha));    %steady state for y
ktss = (alpha*beta*zbar)^(1/(1-alpha));    %steady state for kt
ctss = ((1-alpha*beta)*zbar*(alpha*beta*zbar))^(alpha/(1-alpha));  %steady state for ct
ztss = (ytss/ktss);

% Set k0, c0, y0 for initialization 
    
    k0 = ktss;
    c0 = ctss;
    y0 = ytss;
    z0 = ztss;
    
%yt kt ct


% calculate steady state values using k0 as an input
% ytss, ktss, ctss calculations over T 


%create vector of length T with initial steady state values
ktssv = kron(ktss,ones(T,1)); 
ytssv = kron(ytss,ones(T,1)); 
ctssv = kron(ctss,ones(T,1)); 
ztssv = kron(ctss,ones(T,1)); 
itssv = kron(ctss,ones(T,1));

%initial conditions
k=ktssv; %initialize the capital vector with the initial steady state
y=ytssv; %initialize the output vector with the initial steady state
c=ctssv; %initialize the comsumption vector with the initial steady state
z = ztssv; %initialize the z vector with the initial steady state
i = itssv; %initialize the interest vector with the initial steady state


for t=1:T
    k(t,:)=(alpha*beta*zbar)^(1/(1-alpha)); %capital accumulation
    y(t,:)= zbar*(alpha*beta*zbar)^(alpha/(1-alpha)); %production
    c(t,:)=(1-alpha*beta)*zbar*(alpha*beta*zbar)^(alpha/(1-alpha)); %consumption
    %i
    z(t,:)=((alpha*beta*zbar)^(1/(1-alpha)))/((zbar*(alpha*beta*zbar)^(alpha/(1-alpha))));
end

    
   
   
