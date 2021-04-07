function [OutTable] = EventTimestamps(EventDirectory)

%Step 1: Change directory to location of event files
%Step 2: Create file repo of available event files
%Step 3: Loop through and access first timestamp of event files
%Step 4: Output table that will list date and time of 1st timestamp

cd(EventDirectory)
EventFiles=dir('*.nev');
EventFiles2={EventFiles.name};
Timestamps = NaT(size(EventFiles2),'TimeZone','America/Denver'); %create datetime array

for j=1:length(EventFiles2)
 tempEV=EventFiles2{j};
  [TempStamps,~,~,~,~,~] =...
                Nlx2MatEV(tempEV, [1 1 1 1 1], 1, 1, [] );      %convert event file into matlab info
  timeREcord = datetime(TempStamps(1)/1000000,'ConvertFrom',...
                    'posixtime','TimeZone','America/Denver');  
  Timestamps(j)=timeREcord;  
end  

OutTable=table(transpose(EventFiles2),transpose(Timestamps),'VariableNames',{'EventFileNames','Timestamp'});
end

