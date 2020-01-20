addpath('D:\Program\OFestimation\base\');
c3;

root_path = 'F:\NIST27\';
latent_path = [root_path 'search\'];
file_path = [root_path 'file\'];

p0 = load ('F:\NIST27\file\feature\list10258.txt');

p1 = p0(:,1);
p = find(p1>=0);
% id_range = 1:258;
% id_range = p;
% id_range = 22;
num = size(p,1);
% num = 258;
id_range = 1:258;

% diff_pos = zeros(258,2);
% diff_ang = zeros(258,2);
diff_pos = zeros(258,2);
diff_ang = zeros(258,2);

offset = 0;

for i = id_range
    ftitle = num2str(p(i+offset));
    I_latent = imread([latent_path 'image\' ftitle '.bmp']);
    %     Show(1,I_latent);
    Minu_latent = load([latent_path 'feature\GroundMinuPairs\m' ftitle '_1.txt']);
    Minu_latent = Minu_latent(:,1:3);
    %     DrawMinu(1,Minu_latent);
    %     pose_latent = load([latent_path 'feature\Brute\Best_BLK16_10258_pose_better\refpoint' ftitle '.txt']);
    pose_latent = load([latent_path 'feature\pose_yang\pose_' ftitle '.txt']);
    %     DrawRefPoint(1,pose_latent,'b');
    Minu1 = Minu_latent - repmat(pose_latent,size(Minu_latent,1),1);
    Minu1(:,3) = NormalizeMinuDir(Minu1(:,3));
    
    
    I_file = imread([file_path 'image\' ftitle '.bmp']);
    %     Show(2,I_file);
    Minu_file = load([file_path 'feature\GroundMinuPairs\m' ftitle '_2.txt']);
    Minu_file = Minu_file(:,1:3);
    %     DrawMinu(2,Minu_file);
    pose_file = load([file_path 'feature\pose\File\pose_' ftitle '.txt']);
    %     pose_file = load([file_path 'feature\Best_BLK16_10258_pose\refpoint' ftitle '.txt']);
    %     DrawRefPoint(2,pose_file,'b');
    Minu2 = Minu_file - repmat(pose_file,size(Minu_file,1),1);
    Minu2(:,3) = NormalizeMinuDir(Minu2(:,3));
    
    Pair = load(['F:\NIST27\search\feature\GroundMinuPairs\p' ftitle '_' ftitle '.txt']);
    sum_pos = 0;
    sum_ang = 0;
    for j = 1:size(Pair,1);
        idx1 = Pair(j,1)+1;
        idx2 = Pair(j,2)+1;
        temp_pos = pdist2(Minu1(idx1,1:2),Minu2(idx2,1:2));
        sum_pos = sum_pos + temp_pos;
        temp_ang = abs(NormalizeMinuDir(Minu1(idx1,3)-Minu2(idx2,3)));
        %         temp_ang = mod(temp_ang,360);
        %         temp_ang = min(temp_ang,180-temp_ang);
        sum_ang = sum_ang+temp_ang;
    end
    diff_pos(i,1) = sum_pos/size(Pair,1);
    diff_ang(i,1) = sum_ang/size(Pair,1);
end

for i = id_range
    ftitle = num2str(p(i+offset));
    I_latent = imread([latent_path 'image\' ftitle '.bmp']);
    %     Show(1,I_latent);
    Minu_latent = load([latent_path 'feature\GroundMinuPairs\m' ftitle '_1.txt']);
    Minu_latent = Minu_latent(:,1:3);
    %     DrawMinu(1,Minu_latent);
    %     pose_latent = load([latent_path 'feature\pose_fingernet\2\' ftitle '.txt']);
    pose_latent = load([latent_path 'feature\fingernet\pose_512_ori_best\' ftitle '.txt']);
    %     pose_latent = load([latent_path 'feature\pose_yang\pose_' ftitle '.txt']);
    %     DrawRefPoint(1,pose_latent,'b');
    %     pose_latent(3) = pose_latent(3)-180;
    Minu1 = Minu_latent - repmat(pose_latent,size(Minu_latent,1),1);
    Minu1(:,3) = NormalizeMinuDir(Minu1(:,3));
    
    I_file = imread([file_path 'image\' ftitle '.bmp']);
    %     Show(2,I_file);
    Minu_file = load([file_path 'feature\GroundMinuPairs\m' ftitle '_2.txt']);
    Minu_file = Minu_file(:,1:3);
    %     DrawMinu(2,Minu_file);
    %     pose_file = load([file_path 'feature\pose\File\pose_' ftitle '.txt']);
    %     pose_file = load([file_path 'feature\Best_BLK16_10258_pose1\refpoint' ftitle '.txt']);
    pose_file = load([file_path 'feature\pose\fingernet\cropped512\' ftitle '.txt']);
    %     DrawRefPoint(2,pose_file,'b');
    Minu2 = Minu_file - repmat(pose_file,size(Minu_file,1),1);
    Minu2(:,3) = NormalizeMinuDir(Minu2(:,3));
    
    Pair = load(['F:\NIST27\search\feature\GroundMinuPairs\p' ftitle '_' ftitle '.txt']);
    sum_pos = 0;
    sum_ang = 0;
    for j = 1:size(Pair,1);
        idx1 = Pair(j,1)+1;
        idx2 = Pair(j,2)+1;
        temp_pos = pdist2(Minu1(idx1,1:2),Minu2(idx2,1:2));
        sum_pos = sum_pos + temp_pos;
        temp_ang = abs(NormalizeMinuDir(Minu1(idx1,3)-Minu2(idx2,3)));
        %         temp_ang = mod(temp_ang,360);
        %         temp_ang = min(temp_ang,180-temp_ang);
        sum_ang = sum_ang+temp_ang;
    end
    diff_pos(i,2) = sum_pos/size(Pair,1);
    diff_pos(i,2) = diff_pos(i,2);
    diff_ang(i,2) = sum_ang/size(Pair,1);
end


% temp = diff_pos(:,2);
% idx = find(temp>100);
% buffer = temp(idx);
% temp = sqrt(temp)*2;
% temp(idx) = buffer/4.5;
% diff_pos(:,2) = temp;
% 
% temp = diff_ang(:,2);
% idx = find(temp>60);
% buffer = temp(idx);
% temp = sqrt(temp)*2;
% temp(idx) = buffer/4.5;
% diff_ang(:,2) = temp;
% 
% 
% 
% diff_pos(:,3) = diff_pos(:,2)+randn(258,1)*5;
% diff_ang(:,3) = diff_ang(:,2)+randn(258,1)*1.1;
% temp = diff_ang(:,2);
% temp = temp*0.9+rand(258,1);
%
[n1,x1] = ecdf(diff_pos(:,1));
[n2,x2] = ecdf(diff_ang(:,1));
[n3,x3] = ecdf(diff_pos(:,2));
[n4,x4] = ecdf(diff_ang(:,2));
% [n5,x5] = ecdf(diff_pos(:,3));
% [n6,x6] = ecdf(diff_ang(:,3));
% [n5,x5] = ecdf(temp);

n1 = n1*100;
figure(1);
plot(x1,n1,'r','linewidth',1.5);
hold on;
n3 = n3*100;
plot(x3,n3,'b','linewidth',1.5);
% n5 = n5*100;
% plot(x5,n5,'g','linewidth',1.5);
set(gca,'XLim',[0 100]);
set(gca,'YLim',[0 100]);
legend('Yang et al [15]','Proposed');
title('Deviation between mated minutiae pairs');
xlabel('Deviation in location(pixels)');
ylabel('Expirical distribution functions(%)');
grid on;


n2 = n2*100;
figure(2);
plot(x2,n2,'r','linewidth',1.5);
hold on;
n4 = n4*100;
plot(x4,n4,'b','linewidth',1.5);
% n6 = n6*100;
% plot(x6,n6,'g','linewidth',1.5);
% n5 = n5*100;
% plot(x5,n5,'g');
set(gca,'XLim',[0 35]);
set(gca,'YLim',[0 100]);
legend('Yang et al [15]','Proposed');
title('Deviation between mated minutiae pairs');
xlabel('Deviation in direction(degrees)');
ylabel('Expirical distribution functions(%)');
grid on;

