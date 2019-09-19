clc;
clear;

%Variaveis de acerto
acertou = 1;
errou = 1;

%abrir os arquivos
filesNormals = dir('Normals/*.wav');
filesEdema = dir('Edema/*.wav');

tamInicial = 1000;
tamFinal = 15000;

TamanhoDeAmostras = 1000;

vetorNormals = zeros(length(filesNormals),TamanhoDeAmostras + 1);


%ler os arquivos
for i=1:length(filesNormals)
   Inicio =  tamInicial + (tamFinal - tamInicial)*rand(1,1);
   Fim = Inicio + TamanhoDeAmostras;
   amostras = wavread(strcat('Normals/',filesNormals(i).name));
   vetorNormals(i,:) = amostras(Inicio:Fim);  
end

for i=1:length(filesEdema)
   Inicio =  tamInicial + (tamFinal - tamInicial)*rand(1,1);
   Fim = Inicio + TamanhoDeAmostras;
   amostras = wavread(strcat('Edema/',filesEdema(i).name))';
   vetorEdema(i,: ) = amostras(Inicio:Fim);  
end



% 
% kernel(1) = 2.47;
% kernel(2) = 2.13;
% 
% 
% %%validação 1
% for i=1:10
%     for j=11:20
%         teste = [vetorNormals(i,:);vetorNormals(j,:)]';
%         teste = zscore(teste)';
%         eta(j) = abs(correncoef(teste(1,:)',teste(2,:)',kernel(2)));        
%     end
%     for k=11:20
%         teste = [vetorNormals(i,:);vetorEdema(k,:)]';
%         teste = zscore(teste)';
%         eta2(k) = abs(correncoef(teste(1,:)',teste(2,:)', kernel(1)));
%     end
%     aa = sum(eta);
%     bb = sum(eta2);
%     if(aa > bb)
%         acertou = acertou + 1
%     else
%         errou = errou + 1
%     end
% end
% 
% for i=11:20
%     for j=1:10
%         teste = [vetorNormals(i,:);vetorNormals(j,:)]';
%         teste = zscore(teste)';
%         eta(j) = abs(correncoef(teste(1,:)',teste(2,:)',kernel(2)));        
%     end
%     for k=1:10
%         teste = [vetorNormals(i,:);vetorEdema(k,:)]';
%         teste = zscore(teste)';
%         eta2(k) = abs(correncoef(teste(1,:)',teste(2,:)',kernel(1)));
%     end
% 
%     aa = sum(eta);
%     bb = sum(eta2);
%     
%     if(aa > bb)
%         acertou = acertou + 1
%     else
%         errou = errou + 1
%     end
% end
% 
% %%validação 2
% % for i=1:10
% %     for j=11:20
% %         teste = [vetorEdema(i,:);vetorEdema(j,:)]';
% %         teste = zscore(teste)';
% %         eta(j) = abs(correncoef(teste(1,:)',teste(2,:)',kernel(1)));        
% %     end
% %     for k=11:20
% %         teste = [vetorEdema(i,:);vetorNormals(k,:)]';
% %         teste = zscore(teste)';
% %         eta2(k) = abs(correncoef(teste(1,:)',teste(2,:)', kernel(2)));
% %     end
% %     aa = sum(eta);
% %     bb = sum(eta2);
% %     if(aa > bb)
% %         acertou = acertou + 1
% %     else
% %         errou = errou + 1
% %     end
% % end
% % 
% % for i=11:20
% %     for j=1:10
% %         teste = [vetorEdema(i,:);vetorEdema(j,:)]';
% %         teste = zscore(teste)';
% %         eta(j) = abs(correncoef(teste(1,:)',teste(2,:)',kernel(1)));        
% %     end
% %     for k=1:10
% %         teste = [vetorEdema(i,:);vetorNormals(k,:)]';
% %         teste = zscore(teste)';
% %         eta2(k) = abs(correncoef(teste(1,:)',teste(2,:)',kernel(2)));
% %     end
% % 
% %     aa = sum(eta);
% %     bb = sum(eta2);
% %     
% %     if(aa > bb)
% %         acertou = acertou + 1
% %     else
% %         errou = errou + 1
% %     end
% % end
% 
% val = -(1.0*errou)/(errou+acertou)
% end
% 
