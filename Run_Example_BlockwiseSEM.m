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
%% Example 1. Structural equation models with nomological components      %      
%   o This model was used in Cho and Choi's (2020) simulation study.      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference                                                               %
%     * Cho, G., & Choi, J. Y. (2020). An empirical comparison of         %
%         generalized structured component analysis and partial least     %
%         squares path modeling under variance-based structural equation  %
%         models. Behaviormetrika, 47(1), 243–272.                        %
%         https://doi.org/10.1007/s41237-019-00098-0                      % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Step 1. Specify basic information about the model                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = 7; % # of components
P_exo = 2; % # of exogenous components
Jp = 4; % # of indicators per component
list_Type = ones(1,P); % component type (1 = nomological/principal, 2 = canonical)
list_Jp = ones(1,P) * Jp; % every component has the same number of indicators  
[Info_construct,Info_model,Info_dataset] = DGP_BlockwiseSEM_Input(list_Type,list_Jp,P_exo);

% Step 2. Provide detailed information  
%         on the measurementand structural models
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sig_Zp = [1	0.5	0.43	0.3;
         0.5	1	0.47	0.23;
         0.43	0.47	1	0.45;
         0.3	0.23	0.45	1]; 
for p=1:P
    Info_construct(p).Sig_Zp=Sig_Zp; % covarince matrix of indicators for each component
end
Info_model.Bx = [.5  .15   .3    0    0; % path coefficients from exogenous components to endogenosu components
                  0   0     0   .5    0];
Info_model.By = [ 0  -.5   -.5   0    0; % path coefficients between endogenosu components
                  0   0    -.3   0    0;
                  0   0     0  -.5   .5;
                  0   0     0    0   .15;
                  0   0     0    0    0];  
Info_model.Sig_CVx = [1, .3; 
                    .3,  1]; % covarinace matrix of exogenous components

% Step 3.  Enter options for generating the data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Info_dataset.GenType  = 1; % 1 if you would like to generate data from the population model; 0 otherwise.
Info_dataset.N = 1000;  % Sample size 
Info_dataset.N_rep = 100; % # of samples

% Step 4. Derive the population covariance matrix and generate the data  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Para,Dataset,Error] = DGP_BlockwiseSEM(Info_construct,Info_model,Info_dataset);
Para % Structure array including true parameter values
size(Dataset) % data matrix 
Error % 0 if no errors are found; positive integer otherwise.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example 2. Structural equation models with canonical components        %      
%   o This model was used in Cho and Choi's (2020) simulation study.      %     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference                                                               %
%     * Cho, G., & Choi, J. Y. (2020). An empirical comparison of         %
%         generalized structured component analysis and partial least     %
%         squares path modeling under variance-based structural equation  %
%         models. Behaviormetrika, 47(1), 243–272.                        %
%         https://doi.org/10.1007/s41237-019-00098-0                      % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Step 1. Specify basic information about the model                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = 7; % # of components
P_exo = 2; % # of exogenous components
Jp = 4; % # of indicators per component
list_Type = ones(1,P) *2; % component type (1 = nomological/principal, 2 = canonical)
list_Jp = ones(1,P) * Jp; % every component has the same number of indicators  
[Info_construct,Info_model,Info_dataset] = DGP_BlockwiseSEM_Input(list_Type,list_Jp,P_exo);

% Step 2. Provide detailed information  
%         on the measurementand structural models
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sig_Zp = [1	0.5	0.43	0.3;
         0.5	1	0.47	0.23;
         0.43	0.47	1	0.45;
         0.3	0.23	0.45	1]; 
for p=1:P
    Info_construct(p).Sig_Zp=Sig_Zp; % covarince matrix of indicators for each component
    Info_construct(p).Wp=[.1, .3, .5, .7]'; % pre-scribed standardized weight vector for each indicator block
end
Info_model.Bx = [.5  .15   .3    0    0; % path coefficients from exogenous components to endogenosu components
                  0   0     0   .5    0];
Info_model.By = [ 0  -.5   -.5   0    0; % path coefficients between endogenosu components
                  0   0    -.3   0    0;
                  0   0     0  -.5   .5;
                  0   0     0    0   .15;
                  0   0     0    0    0];  
Info_model.Sig_CVx = [1, .3; 
                    .3,  1]; % covarinace matrix of exogenous components

% Step 3.  Enter options for generating the data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Info_dataset.GenType  = 1; % 1 if you would like to generate data from the population model; 0 otherwise.
Info_dataset.N = 1000;  % Sample size 
Info_dataset.N_rep = 100; % # of samples
Info_dataset.DistType = 0; % 0 for normal(default); 1 for log-normal; 2 for diff-normal

% Step 4. Derive the population covariance matrix and generate the data  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Para,Dataset,Error] = DGP_BlockwiseSEM(Info_construct,Info_model,Info_dataset);
Para % Structure array including true parameter values
size(Dataset) % data matrix 
Error % 0 if no errors are found; positive integer otherwise.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example 3. Structural equation models with factors and components      %      
%   o This model was used in Cho et al.'s (2022) simulation study.        %     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference                                                               %
%     * Hwang, H., Cho, G., Jung, K., Falk, C. F., Flake, J. K.,          %
%         Jin, M. J., & Lee, S. H. (2021). An approach to structural      %
%         equation modeling with both factors and components:             %
%         Integrated generalized structured component analysis.           %
%         Psychological Methods, 26(3), 273–294.                          %
%         https://doi.org/10.1037/met0000336                              %
%     * Cho, G., Schlaegel, C., Hwang, H., Choi, Y., Sarstedt, M.,        %
%         & Ringle, C. M. (2022). Integrated generalized structured       %
%         component analysis: On the use of model fit criteria in         %
%         international management research. Management International     %
%         Review, 62, 569–609. https://doi.org/10.1007/s11575-022-00479-w %   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Step 1. Specify basic information about the model                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = 3; % # of components
P_exo = 3; % # of exogenous components
Jp = 3; % # of indicators per component
list_Type = [0,0,1]; % component type (0 = factors; 1 = components)
list_Jp = ones(1,P) * Jp; % every component has the same number of indicators  
[Info_construct,Info_model,Info_dataset] = DGP_BlockwiseSEM_Input(list_Type,list_Jp,P_exo);

% Step 2. Provide detailed information  
%         on the measurementand structural models
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Cp=[.7, .8, .9];
for p = 1:2
    Info_construct(p).Cp = Cp; % Loading vector for the p-th common factor
    %Info_construct(p).Sig_Ezp = diag(diag(eye(Jp(p)) - Cp' * Cp)); 
        % Covariance matrix of errors for the p-th factor in the reflective measurement model
        % If not specified, the errors are set to be independent of each other by default
end

Sig_Zp=[0.0000 0.0000 0.0000
        .2685 0.0000 0.0000
        .4925 .6267 0.0000];
Info_construct(3).Sig_Zp=Sig_Zp + Sig_Zp'+ eye(length(Sig_Zp));

Info_model.Bx = zeros(P_exo,0); % path coefficients from exogenous components to endogenosu components
Info_model.By = zeros(0,0); % path coefficients between endogenosu components                 
Info_model.Sig_CVx = [1, .2 .2; 
                    .2  1  .2
                    .2  .2  1]; % covarinace matrix of exogenous components

% Step 3.  Enter options for generating the data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Info_dataset.GenType  = 1; % 1 if you would like to generate data from the population model; 0 otherwise.
Info_dataset.N = 1000;  % Sample size 
Info_dataset.N_rep = 100; % # of samples
Info_dataset.DistType = 0; % 0 for normal(default); 1 for log-normal; 2 for diff-normal

% Step 4. Derive the population covariance matrix and generate the data  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Para,Dataset,Error] = DGP_BlockwiseSEM(Info_construct,Info_model,Info_dataset);
Para % Structure array including true parameter values
size(Dataset) % data matrix 
Error % 0 if no errors are found; positive integer otherwise.