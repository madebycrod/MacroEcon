% Matlab code for Midterm 2
% Cliff Rodriguez

clear; %clear memory

%initialize k and set parameters
    T=500;      %simulation horizon
    alpha=1/3   %capital's share
    beta=1/1.06 %discount factor
    sigma=0.7   %standard deviation of i.i.d. shock

%compute the deterministic steady state
    kk=(alpha*beta)^(1/(1-alpha));
    yy=kk^alpha;
    cc=(1-alpha*beta)*yy;
    
%initialize all endogenous variables as vectors
%of length T at their steady state values
    k=kk*ones(T,1);
    y=yy*ones(T,1);
    c=cc*ones(T,1);
    z=zeros(T,1);

    
%simulate stochastic economy for T periods
    zs=exp(sigma*randn(T+100,1));   %draw a random sample of size T
    z=zs(101:T+100);                 %drop burn-in period
    for t=1:T
        y(t)=z(t)*k(t)^alpha;       %output at time t
        c(t)=(1-alpha*beta)*y(t);   %consumption at time t
        k(t+1)=y(t)-c(t);           %investment at time t
    end

%auxiliary variables to plot
%steady state
    yyp=ones(T,1)*yy;
    kkp=ones(T,1)*kk;
    ccp=ones(T,1)*cc;

%plot grpahs of the log of all variables
    plot(log([y(1:T),yyp(1:T),k(1:T),kkp(1:T),c(1:T),ccp(1:T)]))
    
    %"beautify" graph a little
    title('Model Simulation');
    xlabel('Time');
    ylabel('Log Value');
    
    l=legend('ln(y_t)','ln(y^{ss})','ln(k_t)','ln(k^{ss})','ln(c_t)','ln(c^{ss})','Location','BestOutside');
    set(l,'Box','off');
    set(l,'FontName','Times')
    set(l,'Fontsize',12)
    set(l,'Interpreter','tex');
    
    pic_file=strcat(['hw4_yci.eps']);
    disp([strcat(['plotting to ' pic_file '...'])]);
    print('-depsc', pic_file);
    
%collect data in matrices
    vars=log([y(1:T),k(1:T),c(1:T),z(1:T)]); %collect all data in a matrix
    ss=[yy,kk,cc,1];                         %collect steady state values

%report some statistics
    lss=log(ss)             %display the log of the steady state
    mvars=mean(vars)        %display the means of the artifial data
    sdvars=sqrt(var(vars))  %display the standard deviation of the artificial data

    
%compute impulse response
    T=500;    

    %initialize with steady state
    k=kk*ones(T,1);
    y=yy*ones(T,1);
    c=cc*ones(T,1);
    z=ones(T,1);

    z(t+1)=p*z(t);


    %simulate stochastic economy for T periods
    for t=1:T
            y(t)=z(t)*k(t)^alpha;       %output at time t
            c(t)=(1-alpha*beta)*y(t);   %consumption at time t
            k(t+1)=y(t)-c(t);           %investment at time t
            z(t+1)=
    end   

%plot grpahs of the log of all variables
%plot impulse response
    subplot(2,2,1), plot(log(z))
    xlabel('t')
    ylabel('ln(z)')

    subplot(2,2,2),plot(log(y))
    xlabel('t')
    ylabel('ln(y)')

    subplot(2,2,3), plot(log(c))
    xlabel('t')
    ylabel('ln(c)')

    subplot(2,2,4), plot(log(k(1:T)))
    xlabel('t')
    ylabel('ln(k)')

    pic_file=strcat(['hw4_irf.eps']);
    disp([strcat(['plotting to ' pic_file '...'])]);
    print('-depsc', pic_file);
 