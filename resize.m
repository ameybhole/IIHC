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
numberOfFolders = length(listOfFolderNames)
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
         
         for i = 1:numberOfImageFiles
                cd(thisFolder);
                T1 = imresize(imread(baseFileNames(i).name),[227 227]);
                fulldestination1 = fullfile(thisFolder, baseFileNames(i).name); 
                imwrite(T1,fulldestination1);
        end
	else
		fprintf('     Folder %s has no files in it.\n', thisFolder);
	end
end