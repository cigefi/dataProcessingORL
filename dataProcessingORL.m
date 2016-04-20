% Function dataProcessingORL
%
% Prototype: dataProcessingORL(dirName,phases_summer,phases_winter)
%            dataProcessingORL(dirName)
%
% data = daysxlatxlong cube which contains the raw data
% phases_summer = 8-dimensional vector which contains the lengths of the
%                   phases for summer months (DJF)
% phases_winter = 8-dimensional vector which contains the lenght of the
%                   phases for winter months (MJ)
function [] = dataProcessingORL(data,phases_summer,phases_winter)
    if nargin < 1
        error('dataProcessingORL: data is a required input')
    end
    if nargin < 2
        phases_summer = [11,11,11,12,11,11,11,12]; % Default values
    end
    if nargin < 3
        phases_winter = [7,8,8,7,8,8,7,8]; % Default values
    end
    months = [31,28,31,30,31,30,31,31,30,31,30,31]; % Reference to the number of days per month
    monthsName = {'January','February','March','April','May','June','July','August','September','October','November','December'};
    
    cm = 6; % Current Month (Initial condition)
    cy = 1974; % Current Year (Initial condition
    lPos = 0;
    
    [data,err] = readNC(data,'olr');
    if ~isnan(err)
        disp(strcat('[ERROR]',{' '},char(err)));
        return;
    end
    % Phases for summer months
    p1_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p2_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p3_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p4_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p5_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p6_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p7_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p8_s = zeros(length(data(1,:,1)),length(data(1,1,:)));
    
    % Phases for winter months
    p1_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p2_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p3_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p4_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p5_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p6_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p7_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    p8_w = zeros(length(data(1,:,1)),length(data(1,1,:)));
    q = 1;
    while q <= length(data)
        disp(strcat('Current month: ',monthsName(cm),' - Year: ',num2str(cy)));
        fPos = lPos + 1;
        if(leapyear(cy)&& cm ==2)
            lPos = months(cm) + fPos; % Leap year
        else
            lPos = months(cm) + fPos - 1;
        end
        if(cm == 5)
            fPos1 = fPos;
            lPos1 = fPos1 + phases_summer(1);
            fPos2 = lPos1 + 1;
            lPos2 = fPos2 + phases_summer(2);
            fPos3 = lPos2 + 1;
            lPos3 = fPos3 + phases_summer(3);
            fPos4 = lPos3 + 1;
            lPos4 = fPos4 + phases_summer(4);
            fPos5 = lPos4 + 1;
            lPos5 = fPos5 + phases_summer(5);
            fPos6 = lPos5 + 1;
            lPos6 = fPos6 + phases_summer(6);
            fPos7 = lPos6 + 1;
            lPos7 = fPos7 + phases_summer(7);
            fPos8 = lPos7 + 1;
            lPos8 = fPos8 + phases_summer(8);
        elseif cm == 12
            if (q+months(12) <= length(data)) % If the current year is not the latest (raw data)
                fPos1 = fPos;
                lPos1 = fPos1 + phases_winter(1);
                fPos2 = lPos1 + 1;
                lPos2 = fPos2 + phases_winter(2);
                fPos3 = lPos2 + 1;
                lPos3 = fPos3 + phases_winter(3);
                fPos4 = lPos3 + 1;
                lPos4 = fPos4 + phases_winter(4);
                fPos5 = lPos4 + 1;
                lPos5 = fPos5 + phases_winter(5);
                fPos6 = lPos5 + 1;
                lPos6 = fPos6 + phases_winter(6);
                fPos7 = lPos6 + 1;
                lPos7 = fPos7 + phases_winter(7);
                fPos8 = lPos7 + 1;
                lPos8 = fPos8 + phases_winter(8);
            else % Last December in the raw data
                fPos1 = fPos;
                lPos1 = fPos1 + 4;
                fPos2 = lPos1 + 1;
                lPos2 = fPos2 + 4;
                fPos3 = lPos2 + 1;
                lPos3 = fPos3 + 4;
                fPos4 = lPos3 + 1;
                lPos4 = fPos4 + 4;
                fPos5 = lPos4 + 1;
                lPos5 = fPos5 + 3;
                fPos6 = lPos5 + 1;
                lPos6 = fPos6 + 4;
                fPos7 = lPos6 + 1;
                lPos7 = fPos7 + 4;
                fPos8 = lPos7 + 1;
                lPos8 = fPos8 + 4;
            end
        end
        if (cm==1)||(cm==5)||(cm==6)||(cm==12)
            for i=1:length(data(1,:,1)) % Lat
                for j=1:length(data(1,1,:)) % Lon
                    if(q == 1)
                        if(cm == 1) 
                            p1_s(i,j) = nanmean(data(q:8,i,j)); % 8 values
                            p2_s(i,j) = nanmean(data(9:15,i,j)); % 7 values
                            p3_s(i,j) = nanmean(data(16:23,i,j)); % 8 values
                            p4_s(i,j) = nanmean(data(24:30,i,j)); % 7 values
                            p5_s(i,j) = nanmean(data(31:38,i,j)); % 8 values
                            p6_s(i,j) = nanmean(data(39:45,i,j)); % 7 values
                            p7_s(i,j) = nanmean(data(46:52,i,j)); % 7 values
                            p8_s(i,j) = nanmean(data(53:lPos,i,j)); % 7 or 8 values
                        elseif(cm == 6)
                            p1_w(i,j) = nanmean(data(q:4,i,j)); % 4 values
                            p2_w(i,j) = nanmean(data(5:8,i,j)); % 4 values
                            p3_w(i,j) = nanmean(data(9:11,i,j)); % 3 values
                            p4_w(i,j) = nanmean(data(12:15,i,j));
                            p5_w(i,j) = nanmean(data(16:19,i,j));
                            p6_w(i,j) = nanmean(data(20:22,i,j));
                            p7_w(i,j) = nanmean(data(23:26,i,j));
                            p8_w(i,j) = nanmean(data(27:lPos,i,j));
                        end
                    elseif(cm == 5)
                        p1_w(i,j) = nanmean([nanmean(p1_w(i,j)),nanmean(data(fPos1:lPos1,i,j))]);
                        p2_w(i,j) = nanmean([nanmean(p2_w(i,j)),nanmean(data(fPos2:lPos2,i,j))]);
                        p3_w(i,j) = nanmean([nanmean(p3_w(i,j)),nanmean(data(fPos3:lPos3,i,j))]);
                        p4_w(i,j) = nanmean([nanmean(p4_w(i,j)),nanmean(data(fPos4:lPos4,i,j))]);
                        p5_w(i,j) = nanmean([nanmean(p5_w(i,j)),nanmean(data(fPos5:lPos5,i,j))]);
                        p6_w(i,j) = nanmean([nanmean(p6_w(i,j)),nanmean(data(fPos6:lPos6,i,j))]);
                        p7_w(i,j) = nanmean([nanmean(p7_w(i,j)),nanmean(data(fPos7:lPos7,i,j))]);
                        p8_w(i,j) = nanmean([nanmean(p8_w(i,j)),nanmean(data(fPos8:lPos8,i,j))]);
                    elseif(cm == 12)
                        p1_s(i,j) = nanmean([nanmean(p1_s(i,j)),nanmean(data(fPos1:lPos1,i,j))]);
                        p2_s(i,j) = nanmean([nanmean(p2_s(i,j)),nanmean(data(fPos2:lPos2,i,j))]);
                        p3_s(i,j) = nanmean([nanmean(p3_s(i,j)),nanmean(data(fPos3:lPos3,i,j))]);
                        p4_s(i,j) = nanmean([nanmean(p4_s(i,j)),nanmean(data(fPos4:lPos4,i,j))]);
                        p5_s(i,j) = nanmean([nanmean(p5_s(i,j)),nanmean(data(fPos5:lPos5,i,j))]);
                        p6_s(i,j) = nanmean([nanmean(p6_s(i,j)),nanmean(data(fPos6:lPos6,i,j))]);
                        p7_s(i,j) = nanmean([nanmean(p7_s(i,j)),nanmean(data(fPos7:lPos7,i,j))]);
                        p8_s(i,j) = nanmean([nanmean(p8_s(i,j)),nanmean(data(fPos8:lPos8,i,j))]);
                    end
                end
            end
        end
        if cm == 5
            q = q + months(5)+months(6);
            cm = cm + 2;
        elseif cm == 6
            q = q + months(6);
            cm = cm + 1;
        elseif cm == 12
            q = q + months(12) + months(1) + months(2);
            cm = cm + 3;
        else
            q = q + months(cm);
            cm = cm + 1;
        end
        if cm > 12
            cm = 3;
            cy = cy + 1;
        end
    end
    % Save data
    if not(exist('Summer','dir'))
        mkdir Summer
    end
    if not(exist('Winter','dir'))
        mkdir Winter
    end
%     save 'Summer/[CIGEFI] Phase 1.mat' p1_s
%     save 'Summer/[CIGEFI] Phase 2.mat' p2_s
%     save 'Summer/[CIGEFI] Phase 3.mat' p3_s
%     save 'Summer/[CIGEFI] Phase 4.mat' p4_s
%     save 'Summer/[CIGEFI] Phase 5.mat' p5_s
%     save 'Summer/[CIGEFI] Phase 6.mat' p6_s
%     save 'Summer/[CIGEFI] Phase 7.mat' p7_s
%     save 'Summer/[CIGEFI] Phase 8.mat' p8_s
%     
%     save 'Winter/[CIGEFI] Phase 1.mat' p1_w
%     save 'Winter/[CIGEFI] Phase 2.mat' p2_w
%     save 'Winter/[CIGEFI] Phase 3.mat' p3_w
%     save 'Winter/[CIGEFI] Phase 4.mat' p4_w
%     save 'Winter/[CIGEFI] Phase 5.mat' p5_w
%     save 'Winter/[CIGEFI] Phase 6.mat' p6_w
%     save 'Winter/[CIGEFI] Phase 7.mat' p7_w
%     save 'Winter/[CIGEFI] Phase 8.mat' p8_w

    save 'Summer/[CIGEFI] Phase 1.dat' p1_s -ascii
    save 'Summer/[CIGEFI] Phase 2.dat' p1_s -ascii
    save 'Summer/[CIGEFI] Phase 3.dat' p1_s -ascii
    save 'Summer/[CIGEFI] Phase 4.dat' p1_s -ascii
    save 'Summer/[CIGEFI] Phase 5.dat' p1_s -ascii
    save 'Summer/[CIGEFI] Phase 6.dat' p1_s -ascii
    save 'Summer/[CIGEFI] Phase 7.dat' p1_s -ascii
    save 'Summer/[CIGEFI] Phase 8.dat' p1_s -ascii
    
    save 'Winter/[CIGEFI] Phase 1.dat' p1_w -ascii
    save 'Winter/[CIGEFI] Phase 2.dat' p1_w -ascii
    save 'Winter/[CIGEFI] Phase 3.dat' p1_w -ascii
    save 'Winter/[CIGEFI] Phase 4.dat' p1_w -ascii
    save 'Winter/[CIGEFI] Phase 5.dat' p1_w -ascii
    save 'Winter/[CIGEFI] Phase 6.dat' p1_w -ascii
    save 'Winter/[CIGEFI] Phase 7.dat' p1_w -ascii
    save 'Winter/[CIGEFI] Phase 8.dat' p1_w -ascii

    % Plot data
%     contour(p1_s);
%     contour(p2_s);
%     contour(p3_s);
%     contour(p4_s);
%     contour(p5_s);
%     contour(p6_s);
%     contour(p7_s);
%     contour(p8_s);
%     
%     contour(p1_w);
%     contour(p2_w);
%     contour(p3_w);
%     contour(p4_w);
%     contour(p5_w);
%     contour(p6_w);
%     contour(p7_w);
%     contour(p8_w);
end

function [data,error] = readNC(path,var2Read)
    var2Readid = 99999;
	error = NaN;
    try
        % Catching data from original file
        ncid = netcdf.open(char(path));%,'NC_NOWRITE');
        [~,nvar,~,~] = netcdf.inq(ncid);
        for i=0:1:nvar-1
            [varname,~,~,~] = netcdf.inqVar(ncid,i);
            switch(varname)
                case var2Read
                    var2Readid = i;
            end
        end
        %data = netcdf.getVar(ncid,var2Readid,'double');
        data = permute(netcdf.getVar(ncid,var2Readid,'double'),[2 1 3]);
        if isempty(data)
            error = 'Empty dataset';
        end
        netcdf.close(ncid);
    catch exception
        data = [];
        try
            netcdf.close(ncid)
        catch
            error = 'I/O ERROR';
            return;
        end
        error = exception.message;
    end
end