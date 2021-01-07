function [] = initPeterCorkeToolboox()

    tb = false;
    rvcpath = 'E:\MARIANO\Escuela\Upiita\10mo Semestre\Biorobotica\rvctools\';
    robotpath = fullfile(rvcpath, 'robot');
    if exist(robotpath,'dir')
        addpath(robotpath);
        tb = true;
        startup_rtb
    end
    visionpath = fullfile(rvcpath, 'vision');
    if exist(visionpath,'dir')
        addpath(visionpath);
        tb = true;
        startup_mvtb
    end
    if tb
        addpath(fullfile(rvcpath, 'common'));
        addpath(fullfile(rvcpath, 'simulink'));
    end

end