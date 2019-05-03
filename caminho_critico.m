%% Algoritmo para cálculo do caminho critico
%% Autor: André Heidemann Iarozinski 
%% Data: 18/05/2016

%% limpando dados previamente armazenados
clear all     

%% Importando arquivos de entrada 
%% Importando arquivo de entrada "a"
filename = 'C:\Users\andre iarozinski\Desktop\entrada10a.txt';
%% definindo delimitador
delimiter = '{}';
%% pré processamento do arquivo de entrada 
formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
rawData = dataArray{1};
for row=1:size(rawData, 1);  
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData{row}, regexstr, 'names');
        numbers = result.numbers;
       
        
        invalidThousandsSeparator = false;
        if any(numbers==',');
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(thousandsRegExp, ',', 'once'));
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        
        if ~invalidThousandsSeparator;
            numbers = textscan(strrep(numbers, ',', ''), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch me
    end
end
I = ~all(cellfun(@(x) (isnumeric(x) || islogical(x)) && ~isnan(x),raw),2); 
raw(I,:) = [];
dados = cell2mat(raw(:, 1)); 
%% importando arquivo de entrada "b"
filename = 'C:\Users\andre iarozinski\Desktop\entrada10b.txt';
delimiter = '}';
formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
rawData = dataArray{1};
for row=1:size(rawData, 1);
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData{row}, regexstr, 'names');
        numbers = result.numbers;
        
     
        invalidThousandsSeparator = false;
        if any(numbers==',');
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(thousandsRegExp, ',', 'once'));
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
       
        if ~invalidThousandsSeparator;
            numbers = textscan(strrep(numbers, ',', ''), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch me
    end
end

R = cellfun(@(x) isempty(x) || (ischar(x) && all(x==' ')),raw);
raw(R) = {0.0}; 

I = ~all(cellfun(@(x) isnumeric(x) || islogical(x),raw),2); 
raw(I,:) = [];
relacao = cell2mat(raw);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fim da leitura dos arquivos de entrada 

for i=1:((size(dados))/2)
   
   duracao(i)=dados(2*i);   
%%%criando o vetor "duracao" com as suas duracoes
        
end
c=1;     
%%variavel temporaria para colunas
l=0;     
%%variavel temporaria para linhas
for k=1:(size(relacao))
if relacao(k)~=0
    l=l+1;
    ligacao(l,c)=relacao(k);
end
if relacao(k)==0
    c=c+1;
    l=0;
end

end
%%inverter termos do inicio
x=1;
for x=1:length(ligacao)
if (ligacao(2,x)==0 && x<(length(ligacao)/2))
ligacao(:,x)=flipud(ligacao(:,x));
end
end
%%matrizes de ligacao e duracao 

es=[duracao ];
ef=[duracao ];

for q=1:length(duracao)       %%%%%loop de ES e EF
z=find((ligacao(2,:)==q),1); 
z;
    if ligacao(1,z)==0;
    es(z)=0;
    ef(z)=duracao(z);
    
    elseif (ligacao(2,z)~=ligacao(2,z+1) && ligacao(2,z)~=0)
       
        es(q)=ef(ligacao(1,z));
        ef(q)=es(q)+duracao(q);
                
    else
        es(ligacao(2,z))= max( ef(ligacao(1,z)) , ef(ligacao(1,z+1)));
        ef(ligacao(2,z))= es(ligacao(2,z))+duracao(ligacao(2,z));
        
    end
end

lf=ef;
ls=es;

y=length(ligacao);              %%%%%loop de LS e LF 
 for x=length(duracao):-1:1
     mlf=max(ef);  
	 %%encontrando maior LF
     %%pos=find(ef==mlf); %% encontrando a posicao do maior valor
     z=find((ligacao(1,:)==x),1);
     
     if ligacao(2,z)==0
     lf(ligacao(1,z))=mlf;
     ls(ligacao(1,z))=lf(ligacao(1,z))-duracao(ligacao(1,z));
     elseif ligacao(1,z)==0
      ls(z)=0;
      lf(ligacao(2,z))= duracao(ligacao(2,z));
     else
                   
     lf(ligacao(1,z))=ls(ligacao(2,z));
     ls(ligacao(1,z))=lf(ligacao(1,z))-duracao(ligacao(1,z));   
     end
 end
   
%%caminha critico
disp('O caminho critico do projeto é:');
for q=1:length(duracao)
    if((es(q)-ls(q)==0))
       a=sprintf(' atividade %d',q);
       disp(a);  
	   %%imprimindo caminho critico
       
    end
     
end
