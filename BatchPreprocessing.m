% Define a starting folder.
start_path = fullfile(matlabroot, '\toolbox');
if ~exist(start_path, 'dir')
	start_path = matlabroot;
end
% Ask user to confirm or change.
uiwait(msgbox('Pick a folder for to be processed'));
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
	return;
end
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames);
% Process all image files in those folders.
for k = 1 : numberOfFolders
	% Get this folder and print it out.
	thisFolder = listOfFolderNames{k};
	fprintf('Processing folder %s\n', thisFolder);
	
	% Get ALL files.
	filePattern = sprintf('%s/*.jpg', thisFolder);
	baseFileNames = dir(filePattern);
	
	numberOfImageFiles = length(baseFileNames);
	if numberOfImageFiles >= 1
		% Go through all those files.
        for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
			fprintf('     Processing file %s\n', fullFileName);
        end
         
         for i = 1:+3:numberOfImageFiles
                cd(thisFolder);
                [RGB,RGB1, im4, im8] = preprocessing(imread(baseFileNames(i+2).name) ,imread(baseFileNames(i+1).name), imread(baseFileNames(i).name));
                BaseName='Sample_';
                FileName=[BaseName,num2str(i)];
                Filedest = fullfile(thisFolder, FileName);
                mkdir(Filedest);
                fulldestination1 = fullfile(Filedest, 'SegRGB1-1.jpg'); 
                fulldestination2 = fullfile(Filedest, 'SegRGB1-2.jpg'); 
                fulldestination3 = fullfile(Filedest, 'SegMask1-1.jpg'); 
                fulldestination4 = fullfile(Filedest, 'SegMask1-2.jpg');
                imwrite(RGB,fulldestination1);
                imwrite(RGB1,fulldestination2);
                imwrite(~im4,fulldestination3);
                imwrite(~im8,fulldestination4);
        end
	else
		fprintf('     Folder %s has no files in it.\n', thisFolder);
	end
end