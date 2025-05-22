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
%% Example. Structural equation models with component interactions        %      
%   o This model was used in Shen, Cho, & Hwang's (2025) simulation       %
%     study.                                                              %     
%   o The population model has the following charateristics:              %
%     (1) The structural model correspond to a regression model with      %
%           two exogenous components and their product term               %
%             - C1, C2, C1 x C2 -> C3                                     % 
%     (2) It assumes all variables follow a normal distribution.          %  
%     (3) A single component is defined for each block of indicators.     %  
%     (4) All indicator blocks share the same covariance matrix.          %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference                                                               %
%     * Shen, Z., Cho, G., & Hwang, H. (2025). Comparison of              %
%         component-based structural equation modeling methods in testing %
%         component interaction effects. Structural Equation Modeling:    %
%         A Multidisciplinary Journal, Advance online publication,        %
%         https://doi.org/10.1080/10705511.2023.2272294                   %             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
help DGP_GSCA_Interact
cType = 1; % component type (1 = nomological/principal, 2 = canonical)
Sig_Zp=[0        0      0      0      0;
        .2786    0      0      0      0;
        .25     .25     0      0      0;
        .345    .345    .4645  0      0; 
        .345    .345    .4645  .5663  0];
Sig_Zp=Sig_Zp'+Sig_Zp+eye(5); % covariance matrix for an indicator block
Wp = []; % weight vector; you should specify this vector if cType = 1;
b = [.3;-.3;.5]; % path coeffcients from C1, C2, and C1 x X2 to C3
r_exo = .3; % correlation b/w the two exogenous components
N = 1000; % Sample size
N_rep = 10; % # of samples 
[Para,Dataset,Error] = DGP_GSCA_Interact(cType,Sig_Zp,Wp,r_exo,b,N,N_rep);
Para % Structure array including true parameter values
size(Dataset) % data matrix 
Error % 0 if no errors are found; positive integer otherwise.

