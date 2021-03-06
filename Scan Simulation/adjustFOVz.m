function MPIparams = adjustFOVz(MPIparams)

    zSpeed = 1/(MPIparams.Gzz*(1/MPIparams.Rsz)); % speed in z-axis
    zPeriods = floor(MPIparams.FOV_z*MPIparams.f_drive/zSpeed); % integer number of periods in the whole fov (this changes the FOV_z distance slightly)
    zPeriods = zPeriods-mod(zPeriods, MPIparams.numTrianglePeriods*2); % now number of periods is for sure properly divisible, this operation adjusts FOV_z
    MPIparams.zPeriods = zPeriods; % save in the parameter structure
    
    FOV_z_a = zPeriods/MPIparams.f_drive*zSpeed; % adjusted z-FOV accordingly
    MPIparams.FOV_z = FOV_z_a;
    tf = FOV_z_a/zSpeed; % adjusting z-FOV adjusts time as well
    MPIparams.time = tf;

    MPIparams.Rsx = 2*MPIparams.FOV_x*MPIparams.numTrianglePeriods./tf*MPIparams.Gxx; % calculate corresponding Rsx
end