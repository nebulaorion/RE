function SPIOparams = setSPIOParams(Physicsparams, pos, tau_val)
    SPIOparams = struct;
    
    SPIOparams.diameter = [25]; % (nm)
    SPIOparams.tau = [2e-6, 4e-6, 3e-6]; % (S)
    
    % spio distribution in 2D
    SPIOparams.SPIOdistribution = zeros(501, 501, length(SPIOparams.diameter)); 
    SPIOparams.SPIOdistribution((251-20:251+20)+50, (101-30:101+30), 1) = 1;
    SPIOparams.SPIOdistribution((251-20:251+20)+10, (251-30:251+30), 2) = 1;
    SPIOparams.SPIOdistribution((251-20:251+20)+10, (401-30:401+30), 3) = 1;
%     SPIOparams.SPIOdistribution((512-20:512+20)+200, 512-20:512+20, 3) = 1;

    % extent of SPIO distribution 
    SPIOparams.image_FOV_x = 0.05; % (m) 
    SPIOparams.image_FOV_z = 0.05; % (m) 
    SPIOparams.dx = SPIOparams.image_FOV_x/size(SPIOparams.SPIOdistribution,1);  % distance between each pixel (m)
    SPIOparams.dz = SPIOparams.image_FOV_z/size(SPIOparams.SPIOdistribution,2);  

    SPIOparams.r_t = cell(1, length(SPIOparams.diameter));
    for k=1:length(SPIOparams.diameter)
        if (SPIOparams.tau(k) == 0)
            SPIOparams.r_t{k} = 1;
            SPIOparams.horizontalPrev{k} = 0;
            SPIOparams.verticalPrev{k} = 0;            
        else
            t = (0:1/Physicsparams.fs:SPIOparams.tau(k)*15);
            SPIOparams.r_t{k} = 1/SPIOparams.tau(k)*exp(-t./SPIOparams.tau(k));
            SPIOparams.horizontalPrev{k} = zeros(1, length(t));
            SPIOparams.verticalPrev{k} = zeros(1, length(t));       
        end
    end
end