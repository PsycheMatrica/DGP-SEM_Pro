%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Illustration for DGP-SEM Pro package                                    %
%   Author: Gyeongcheol Cho                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description:                                                            %
%    This code aims to illustrate how to use DGP-SEM_Pro package to       %
%      generate data from structural equation models with factors and/or  %
%      components.                                                        % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example. Structural equation models with higher-order constructs     %      
%   o This model was used in Baek, Cho, & Hwang's (submitted) simulation  %
%     study.                                                              %    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference                                                               %
%     * Baek, I., Cho, G., & Hwang, H. (submitted). TBA                   %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
help DGP_HigherOrderSEM

P_o2=4; Jp_o2=3;
list_Type_o2 = ones(1,P_o2); % construct proxy type (0 = factors; 1 = nomological components, 2 = canonical components)  
Sig_Zp_o2=[1 .12248 .2603
          .12248 1 .3369
          .2603 .3369 1]; % covariance matrix for an indicator block
Wp_o2 = []; % weight vector; you should specify this vector for canonical components;
Cp_o2 = [.6 .7 .8]; % loading vector for the common factor
Sig_Ezp_o2 = eye(Jp_o2); % covariance matrix of errors for the common factor

P_o1=12; Jp_o1=3;
list_Type_o1 = zeros(1,P_o1); % construct proxy type (0 = factors; 1 = nomological components, 2 = canonical components)
Sig_Zp_o1=[1 .12248 .2603
          .12248 1 .3369
          .2603 .3369 1]; % covariance matrix for an indicator block
Wp_o1 = []; % weight vector; you should specify this vector for canonical components;
Cp_o1 = [.6 .7 .8]; % loading vector for the common factor
Sig_Ezp_o1 = eye(Jp_o1); % covariance matrix of errors for the common factor

Bx = [.7  .5 -.3];
By = [ 0 -.3  .5;
       0  0  -.7;
       0  0    0];
Sig_CVx=1;
N = 50; % Sample size
N_rep = 100; % # of samples 
DistType = 0;
[Para,Dataset,Error] = DGP_HigherOrderSEM(list_Type_o1,Sig_Zp_o1,Sig_Ezp_o1,Cp_o1,Wp_o1,...
                                                   list_Type_o2,Sig_Zp_o2,Sig_Ezp_o2,Cp_o2,Wp_o2,...
                                                   Sig_CVx,Bx,By, ...
                                                   N,N_rep,DistType);
Para % Structure array including true parameter values
Para.o1
Para.o2
size(Dataset) % data matrix 
Error % 0 if no errors are found; positive integer otherwise.

