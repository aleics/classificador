function [mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train

dades_tots_grups = zeros(10,6,2);

grup1 = '11';
grup2 = '12';
grup3 = '21';
grup4 = '22';
grup5 = '31';
grup6 = '32';

fid1 = fopen(['train/' grup1 '.txt']);
fid2 = fopen(['train/' grup2 '.txt']);
fid3 = fopen(['train/' grup3 '.txt']);
fid4 = fopen(['train/' grup4 '.txt']);
fid5 = fopen(['train/' grup5 '.txt']);
fid6 = fopen(['train/' grup6 '.txt']);

valor_da1 = fscanf(fid1,'%s');
valor_da2 = fscanf(fid2,'%s');
valor_da3 = fscanf(fid3,'%s');
valor_da4 = fscanf(fid4,'%s');
valor_da5 = fscanf(fid5,'%s');
valor_da6 = fscanf(fid6,'%s');

s1 = size(valor_da1);
s2 = size(valor_da2);
s3 = size(valor_da3);
s4 = size(valor_da4);
s5 = size(valor_da5);
s6 = size(valor_da6);



i = 1;
for k = 5:5:s1(2)
    valors(1,i) = str2num(valor_da1(k));
    i=i+1;
end

i = 1;
for k = 5:5:s2(2)
    valors(2,i) = str2num(valor_da2(k));
    i=i+1;
end
    
i = 1;
for k = 5:5:s3(2)
    valors(3,i) = str2num(valor_da3(k));
    i=i+1;
end

i = 1;
for k = 5:5:s4(2)
    valors(4,i) = str2num(valor_da4(k));
    i=i+1;
end
i = 1;
for k = 5:5:s5(2)
    valors(5,i) = str2num(valor_da5(k));
    i=i+1;
end

i = 1;
for k = 5:5:s6(2)
    valors(6,i) = str2num(valor_da6(k));
    i=i+1;
end


for i = 0:9
    arxiu = strcat(grup1,'-',num2str(i));
    im = imread(['train/' arxiu],'jpg');
    I1(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup2,'-',num2str(i));
    im = imread(['train/' arxiu],'jpg');
    I2(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup3,'-',num2str(i));
    im = imread(['train/' arxiu],'jpg');
    I3(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup4,'-',num2str(i));
    im = imread(['train/' arxiu],'jpg');
    I4(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup5,'-',num2str(i));
    im = imread(['train/' arxiu],'jpg');
    I5(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup6,'-',num2str(i));
    im = imread(['train/' arxiu],'jpg');
    I6(:,:,:,(i+1)) = im;

end

for i = 1:10
    
    [green,prob] = verd(I1(:,:,:,i));
    dades_tots_grups(i,1,1) = prob;
    
    [numhor,numver] = detect(I1(:,:,:,i));
    dades_tots_grups(i,1,2)= numhor + numver;
        
end


for i = 1:10
    
    [green,prob] = verd(I2(:,:,:,i));
    dades_tots_grups(i,2,1) = prob;
    
    [numhor,numver] = detect(I2(:,:,:,i));
    dades_tots_grups(i,2,2)= numhor + numver;
        
end


for i = 1:10
    
    [green,prob] = verd(I3(:,:,:,i));
    dades_tots_grups(i,3,1) = prob;
    
    [numhor,numver] = detect(I3(:,:,:,i));
    dades_tots_grups(i,3,2)= numhor + numver;
        
end

for i = 1:10
    
    [green,prob] = verd(I4(:,:,:,i));
    dades_tots_grups(i,4,1) = prob;
    
    [numhor,numver] = detect(I4(:,:,:,i));
    dades_tots_grups(i,4,2)= numhor + numver;
        
end

for i = 1:10
    
    [green,prob] = verd(I5(:,:,:,i));
    dades_tots_grups(i,5,1) = prob;
    
    [numhor,numver] = detect(I5(:,:,:,i));
    dades_tots_grups(i,5,2)= numhor + numver;
        
end

for i = 1:10
    
    [green,prob] = verd(I6(:,:,:,i));
    dades_tots_grups(i,6,1) = prob;
    
    [numhor,numver] = detect(I6(:,:,:,i));
    dades_tots_grups(i,6,2)= numhor + numver;
        
end

% calculs finals

total_verd_natura = zeros(1,6);
total_verd_ciutat = zeros(1,6);

total_linia_natura = zeros(1,6);
total_linia_ciutat = zeros(1,6);
   

for j = 1:6
    cont=0;
    for i = 1:10
        if ( valors(1,i) == 1)
        cont=cont+1;
        end
    end
   
	for i = 1:10
    		if ( valors(j,i) == 1)
        		total_verd_natura(j) =total_verd_natura(j)+ dades_tots_grups(i,j,1)/cont;
			total_linia_natura(j) =total_linia_natura(j)+ dades_tots_grups(i,j,2)/cont;
    		elseif ( valors(j,i) == 0)
        		total_verd_ciutat(j) =total_verd_ciutat(j)+ dades_tots_grups(i,j,1)/(10-cont);
			total_linia_ciutat(j) =total_linia_ciutat(j)+dades_tots_grups(i,j,2)/(10-cont);
    		end
	end 
end       


    mitjana_verd_natura = sum(total_verd_natura(:))/6;
    mitjana_verd_ciutat = sum(total_verd_ciutat(:))/6;

    mitjana_linia_natura = sum(total_linia_natura(:))/6;
    mitjana_linia_ciutat = sum(total_linia_ciutat(:))/6;

    
    

  %Les diferents mitjanes ser�n els llindars perfectes que delimiten les imatges de ciutat o es imatges de natura
  
  %Ara ja sabem el llindar perfecte, mitjan�ant les imatges
  %d'aprenantatge.. Per tant, utilitzarem aquests llindars per classificar
  %les demes imatges.