% Name        : Janvi Patel
% Date        : 4/04/2018
% Program - 1
% Description : Face recognition

clc                       %for clearing theoraticaleoraticale command window
close all                 %for closing all theoraticaleoraticale window except command window
clear all                 %for deleting all theoraticaleoraticale variables from theoraticaleoraticale memory
 
cd 'S:\Study Sem\Sem 6\DIP (Digital image processing)\yalefaces'; %set current folder
imagefiles = dir('S:\Study Sem\Sem 6\DIP (Digital image processing)\yalefaces'); %database  
nfiles = length(imagefiles);    
% Number of files found
disp('***   Face recognition    ***');   

for l=1:nfiles-2    %excluding hidden files
    for j = 1:6768  
        L(j,l)=0;
    end
end

k=1;
for ii=3:nfiles
   currentfilename = imagefiles(ii).name;   %reading file name
   currentimage = imread(currentfilename);  %read image from graphics file
   imshow(currentfilename)      %display image
   currentimage = imresize(currentimage,[72 94]);   %resize big image into 72*94 size image
   nraw = length(currentimage(:,1));        %raw length
   ncol = length(currentimage(1,:));        %col length
   cnt=1;
   for j=1:ncol                    %converting matrix into vector
       for i = 1:nraw
           f(cnt) =  currentimage(i,j);
           cnt = cnt+1;
       end
   end
   f_t = transpose(f);  %transpose of vector of one matrix
   L(:,k) = f_t(:);     %Making matrix of all the images 
   k = k+1;
 end

[U,S,V]=svd(L);         %svd

% input Image name
imagefiles = input('Enter File Name for face recognition: ');   
currentimage = imread(imagefiles);  %reading image
currentimage = imresize(currentimage,[72 94]);  %resize the image
nraw = length(currentimage(:,1));   %raw length
ncol = length(currentimage(1,:));   %col length
cnt=1;
for j=1:ncol              %vector
       for i = 1:nraw
           f(cnt) =  currentimage(i,j);
           cnt = cnt+1;
       end
end
g = transpose(f);   %transpose of vector
for i=1:ncol
    gu(:,i)=double(g).*double(U(:,i));  
end 

imagefiles = dir('S:\Study Sem\Sem 6\DIP (Digital image processing)\yalefaces');
for ii=3:nfiles
    for i = 1:ncol
         fu(:,i)= double(L(:,ii-2)).*double(U(:,i));   
    end
    x  = fu-gu;        
    nx(ii-2)=norm(x);   %norm 

end
%finding minimum norm of image
mi=nx(1);
for i=1:length(nx)
    if(nx(i)<=mi)
        mi=nx(i);
        j=i;
    end
end
fprintf('Face is like image : %s \n',imagefiles(j+2).name); %display image name 
imshow(imagefiles(j+2).name)
