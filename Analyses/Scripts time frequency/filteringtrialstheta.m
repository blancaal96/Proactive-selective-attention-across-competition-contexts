%clear
%csvread('E:\Mi unidad\Experimento competition\Scripts\extracting time frequency\modelpredictRTthetawithoutNaN.csv');

%we count how many trials (%) we would filter using 2STD on RTs
%tablewithoutRToutliers= array2table(zeros(0,7));
clearvars -except modelpredictRTthetawithoutNaN
filtroOutlier=[];
for sub=1:36
    datossub= modelpredictRTthetawithoutNaN(modelpredictRTthetawithoutNaN.subject==sub,:);
    media= mean(datossub.RT);
    devEst = std(datossub.RT);
    limiteArrib = media + (devEst*2); % Threshold above outliers
    limiteAbajo = media - (devEst*2); % Threshold below outliers
    
    filtroOutlier = [filtroOutlier; datossub.RT > limiteAbajo & datossub.RT < limiteArrib];
    
end

% counter=1;
% for i= 1: length(filtroOutlier)
%     if filtroOutlier(i)==1
%         tablewithoutRToutliers(counter,:)= modelpredictRTthetawithoutNaN(i,:);
%         counter= counter+1;
%     end
% end

%% 
%Apply filter using 2STD on theta power
%clearvars -except modelpredictRTthetawithoutNaN
clear counter
filtroOutliertheta=[];
for sub=1:36
    datossub= modelpredictRTthetawithoutNaN(modelpredictRTthetawithoutNaN.subject==sub,:);
    media= mean(datossub.theta);
    devEst = std(datossub.theta);
    limiteArrib = media + (devEst*2); % Calcula limite por arriba de los outliers
    limiteAbajo = media - (devEst*2); % Calcula limite por abajo de los outliers
    
    filtroOutliertheta = [filtroOutliertheta; datossub.theta > limiteAbajo & datossub.theta < limiteArrib];
    
end

% counter=1;
% for i= 1: length(filtroOutliertheta)
%     if filtroOutliertheta(i)==1
%         tablewithoutRToutlierstheta(counter,:)= modelpredictRTthetawithoutNaN(i,:);
%         counter= counter+1;
%     end
% end

%% Combination of the 2 filters
clear counter
counter=1;
for i= 1: length(filtroOutliertheta)
    if filtroOutliertheta(i)==1 &&  filtroOutlier(i)==1
        tablewithoutRToutliergen(counter,:)= modelpredictRTthetawithoutNaN(i,:);
        counter= counter+1;
    end
end

%writetable(tablewithoutRToutliergen,'tablefiltered.csv','Delimiter',',');

%% Counting outliers by subjects

counter=zeros(36,1);
idx=0;
for sub=1:36
    countertr=0;
    datossub= modelpredictRTthetawithoutNaN(modelpredictRTthetawithoutNaN.subject==sub,:);
    
    idx= idx+ size(datossub,1);
    for i= (idx- size(datossub,1)+1): idx
        if filtroOutliertheta(i)==0 ||  filtroOutlier(i)==0 
            countertr= countertr+1;
            counter(sub)= countertr;
        end
    end
end
