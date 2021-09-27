clear all; clc;
% [B, title2, ~] = xlsread ('/proenvironmental/temporal1.xlsx'); 
[B, title2, ~] = xlsread ('/Proenvironmental/Temporal2.xlsx'); 
m = size(B,1);
addpath('/Users/hashem/MATLAB-Drive/sigstar');
% labels = title1(2,77:89);
% labels{1} = 'Gender'; labels{2} = 'Age'; labels{3} = 'Marital Status'; labels{4} = 'Education';
%% Arizona color palette
AZred = [171,5,32]/256;
AZblue = [12,35,75]/256;
AZcactus = [92, 135, 39]/256;
AZsky = [132, 210, 226]/256;
AZriver = [7, 104, 115]/256;
AZsand = [241, 158, 31]/256;
AZmesa = [183, 85, 39]/256;
AZbrick = [74, 48, 39]/256;
%%
% 5:31 --> Temporal
% 32:38 --> Pro1: Never (1), 5 or more years ago (2), 1?4 years ago (3), In the last year (4)
%                 ? Installed insulation products in your home						
%                 ? Bought or built an energy-efficient home						
%                 ? Installed a more efficient heating system						
%                 ? Installed a renewable energy system (e.g., solar panels, wind turbine) in your home						
%                 ? Changed to a green energy tariff for your home						
%                 ? Bought a low-emission vehicle (e.g., hybrid, electric, biofuel, less than 1.4 L engine)						
%                 ? Bought a product to save water (e.g., water butt, water ?hippo?, low-flush toilet)
% 39:55 --> Pro2: Never (1), Occasionally (2), Often (3), Always (4)
%                 ? Turn off lights you?re not using						
%                 ? Drive economically (e.g., braking or accelerating gently)						
%                 ? Walk, cycle or take public transport for short journeys (i.e., trips of less than 3 miles)						
%                 ? Use an alternative to travelling (e.g., shopping online)						
%                 ? Share a car journey with someone else						
%                 ? Cut down on the amount you fly						
%                 ? Buy environmentally-friendly products						
%                 ? Eat food which is organic, locally-grown or in season						
%                 ? Avoid eating meat						
%                 ? Buy products with less packaging						
%                 ? Recycle						
%                 ? Reuse or repair items instead of throwing them away						
%                 ? Compost your kitchen waste						
%                 ? Save water by taking shorter showers						
%                 ? Turn off the tap while you brush your teeth						
%                 ? Write to your representative about an environmental issue						
%                 ? Take part in a protest about an environmental issue						
% 56:59 --> Pro3: Strongly disagree(1),Somewhat disagree(2),Neither agree nor disagree(3),Somewhat agree(4),Strongly agree(5)
%                 ? ?I think of myself as an environmentally-friendly consumer?							
%                 ? ?I think of myself as someone who is very concerned with environmental issues?							
%             (r) ? ?I would be embarrassed to be seen as having an environmentally friendly lifestyle?							
%             (r) ? ?I would not want my family or friends to think of me as someone who is concerned about environmental issues?							
% 60    --> How important is the issue of climate change to you personally?
%           Very important(1),Moderatelyimportant(2),Slightlyimportant(3),Notatall important(4)
% 61    --> Do you think climate change is something that is affecting or is going to affect you, personally?
%           Yes(1), No(2), I don't know (NaN)
% 62    --> How much, if anything, would you say you know about climate change?
%           A lot(1), A moderate amount(2), A little(3), Nothing, have never heard of it(4)
% 63    --> Do you think:
%           (1) Climate change is caused only by natural processes
%           (2) Climate change is caused only by human activity
%           (3) Climate change is caused by both natural processes and human activity
%           (4) There's no such thing as climate change
%           (5) I don't know what is causing climate change?
% 64    --> Gender: (1)Male; (2)Female
% 65    --> Age
% 66    --> Marital: (1)Single; (2)Married; (3)Separated/Divorced; (4)Widowed
% 67    --> Education: (1)Some high school or less
%           (2) High school diploma
%           (3) Some college (1 yr. to less than 2 yrs.)
%           (4) Two-year college degree (A.A.)
%           (5) Four-year college degree (B.A. or B.S.)
%           (6) MA/PhD, MD, MBA, Law Degree
% %% Reversing
% A(:,58:59) = 6 - A(:,58:59);
% A(:,60) = 5 - A(:,60);
% A(:,62) = 5 - A(:,62);
% A(A(:,61)==1, 61) = 3; % Yes
% A(A(:,61)==2, 61) = 1; % No
% A(isnan(A(:,61)), 61) = 1; % I don't know
% %% temporal
% A(:,5:31) = 2 - A(:,5:31);
% temporal = sum(A(:,5:31),2);
%% factor analysis
% for i=32:62
%     inx = ~isnan(A(:,i));
%     A = A(inx,:);
%     temporal = temporal (inx,:);
% end

% %%
% [Loadings1,specVar1,T,stats] = factoran(A(:,32:62),1);
% % scatter(32:62, Loadings1, 900)
% L1 = A(:,32:62) * Loadings1;
% %%
% [Loadings2,specVar2,T,stats] = factoran(A(:,32:62),2);
% L2 = A(:,32:62) * Loadings2;
% h = biplot(Loadings2, 'varlabels',num2str((32:62)'), 'Color', AZmesa, 'marker', 'o')
% %%
% [Loadings3,specVar3,T,stats] = factoran(A(:,32:62),3)
% L3 = A(:,32:62) * Loadings3;
% %% corr temporal and components
% [r,p]=corr(temporal, L3(:,1), 'rows', 'complete')
%% B
%% Reversing, recoding
B(:,32:55) = B(:,32:55)-1;
B(:,56:57) = B(:,56:57)-1;
B(:,58:59) = 5 - B(:,58:59);
B(:,60) = 4 - B(:,60);
B(:,62) = 4 - B(:,62);
B(B(:,61)==1, 61) = 3; % Yes
% B(B(:,61)==2, 61) = 1; % No
B(isnan(B(:,61)), 61) = 1; % I don't know
%% temporal
temporal2 = sum(B(:,5:31)==1,2);
%% PCA
[coeff,score,latent,tsquared,explained,mu] = pca(B(:,32:55)) % 28%, 11%, 8%, ...
plot(explained)
%% factor analysis
for i=32:62
    inx2 = ~isnan(B(:,i));
    B = B(inx2,:);
    temporal2 = temporal2 (inx2,:);
end

%%
[Loadings1,specVar1,T,stats] = factoran(B(:,32:55),1);
scatter(32:55, Loadings1, 900)
L1 = B(:,32:55) * Loadings1;
[r,p]=corr(temporal2, L1(:), 'rows', 'complete')
%%
[Loadings2,specVar2,T,stats] = factoran(B(:,32:55),2);
L2 = B(:,32:55) * Loadings2;
h = biplot(Loadings2, 'varlabels',num2str((32:55)'), 'Color', AZmesa, 'marker', 'o')
[r,p]=corr(temporal2, L2(:,1:2), 'rows', 'complete')
%%
[Loadings3,specVar3,T,stats] = factoran(B(:,32:55),3)
L3 = B(:,32:55) * Loadings3;
[r,p]=corr(temporal2, L3(:,1:3), 'rows', 'complete')
%%
[Loadings4,specVar4,T,stats] = factoran(B(:,32:55),4)
L4 = B(:,32:55) * Loadings4;
[r,p]=corr(temporal2, L4(:,1:4), 'rows', 'complete')
%%
[Loadings5,specVar5,T,stats] = factoran(B(:,32:55),5)
L5 = B(:,32:55) * Loadings5;
[r,p]=corr(temporal2, L5(:,1:5), 'rows', 'complete')
%%
[Loadings6,specVar6,T,stats] = factoran(B(:,32:55),6)
L6 = B(:,32:55) * Loadings6;
[r,p]=corr(temporal2, L6(:,1:6), 'rows', 'complete')
%%
[Loadings7,specVar7,T,stats] = factoran(B(:,32:55),7)
L7 = B(:,32:55) * Loadings7;
[r,p]=corr(temporal2, L7(:,1:7), 'rows', 'complete')

%% pro measures 
proo = sum(B(:,32:55),2);
pro1 = sum(B(:,32:38),2);
pro2 = sum(B(:,39:55),2);
%%
[r,p]=corr(k(:,1:5), proo(:), 'rows', 'complete')
%% K values
% temB = (1 - B(:,5:31))';
%%
[k, title2k, ~] = xlsread ('/proenvironmental/temporal-eng-k.xlsx'); 
%%
% [k2, title2k, ~] = xlsread ('/proenvironmental/temporal_FA_Ks.xlsx'); 
%%
[r,p]=corr(k(:,1:5), L7(:,1:7), 'rows', 'complete')
%%
[r,p]=corr(k(:,1:5), L2(:,1:2), 'rows', 'complete')
%% k and temporal
[r,p]=corr(k(:,1:5), temporal2, 'rows', 'complete')
%% log k and temporal
[r,p]=corr(log(k(:,1:5)), temporal2, 'rows', 'complete')
%%
[r,p]=corr(k(:,1:5), B(:,70:76), 'rows', 'complete')
%%
[r,p]=corr(k(:,1:5), L2(:,1:2), 'rows', 'complete')
%%
[r,p]=corr(k(:,1:5), A(:,70:76), 'rows', 'complete')
%% descriptive Histograms
label{1}='Gender';label{2}='Age';label{3}='Marital Status';label{4}='Education';
figure(1);
for i=64:67
    subplot(2,2,i-63)
    if i==65
        histogram(B(:,i),8,'Facecolor', AZsand)
    else
        histogram(B(:,i),'Facecolor', AZsand)
    end
    set(gca,'fontsize',15);
    xlabel(label{i-63}, 'FontSize', 20);
    if i == 64
        xticks([1 2]);
        xticklabels({'Male', 'Female'});
    end
    if i == 66
        xticks([1 2 3 4]);
        xticklabels({'S', 'M', 'D', 'W'});
    end
    if i == 67
        xticks([1 2 3 4 5 6]);
        xticklabels({'<H', 'H', '<2y', '2y', '4y', 'G'});
    end
    if i == 17
        xlim([0 100])
    end
end
%% pro
figure(2);
subplot(3,2,1)
histogram(proo,'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel('Pro-enviro behavior', 'FontSize', 20);

% subplot(3,2,1)
% histogram(L22(:,1),'Facecolor', AZsand)
% set(gca,'fontsize',15);
% xlabel('Pro-environmental behavior (scaled)', 'FontSize', 20);

subplot(3,2,2)
histogram(sum(B(:,56:59),2),6,'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel('Pro-enviro self-identity', 'FontSize', 20);

subplot(3,2,3)
histogram(B(:,60),'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel('Personal importance', 'FontSize', 20);
xticks([0 1 2 3]);
xticklabels({'nothing', 'a little', 'moderate', 'a lot'});

subplot(3,2,4)
histogram(B(:,61),'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel('Perceived risk', 'FontSize', 20);
xticks([1 2 3]);
xticklabels({'DK', 'No', 'Yes'});

subplot(3,2,5)
histogram(B(:,62),'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel('Self-assessed knowledge', 'FontSize', 20);
xticks([0 1 2 3]);
xticklabels({'nothing', 'a little', 'moderate', 'a lot'});

subplot(3,2,6)
histogram(B(:,63),'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel('causes of climate change', 'FontSize', 20);
xticks([1 2 3 4]);
xticklabels({'nature', 'human', 'both', 'NA'});

%% scatter pro-environmental behavior
figure(3); 

subplot(3, 2, 1)
scatter(proo, temporal2, 100, AZred, '.'); hold on 
p = polyfit(proo, temporal2,1);
f = polyval(p, proo);
plot(proo, f, 'color', AZblue, 'LineWidth',3)
% xlabel('pro-environmental behavior');
ylabel('# today items');
set(gca,'FontSize',20)
[r, p] = corr(proo, temporal2, 'rows', 'complete');
text(2,29,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)

lab ={'log k overall', 'log k small', 'log k  medium', 'log k large', 'log k geometric'};
for i =1:5
    subplot(3, 2, i+1)
    scatter(proo, log(k(:,i)), 100, AZred, '.'); hold on 
    p = polyfit(proo, log(k(:,i)),1);
    f = polyval(p, proo);
    plot(proo, f, 'color', AZblue, 'LineWidth',3)
    ylabel(lab{i});
    set(gca,'FontSize',20)
    [r, p] = corr(proo, log(k(:,i)), 'rows', 'complete');
    text(2,-.5,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)
    if i > 3
        xlabel('pro-environmental behavior');
    end
end
%% scatter Pro1
figure(31); 

subplot(3, 2, 1)
scatter(pro1, temporal2, 100, AZred, '.'); hold on 
p = polyfit(pro1, temporal2,1);
f = polyval(p, pro1);
plot(pro1, f, 'color', AZblue, 'LineWidth',3)
% xlabel('pro-environmental behavior');
ylabel('# today items');
set(gca,'FontSize',20)
[r, p] = corr(pro1, temporal2, 'rows', 'complete');
text(2,29,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)

lab ={'log k overall', 'log k small', 'log k  medium', 'log k large', 'log k geometric'};
for i =1:5
    subplot(3, 2, i+1)
    scatter(pro1, log(k(:,i)), 100, AZred, '.'); hold on 
    p = polyfit(pro1, log(k(:,i)),1);
    f = polyval(p, pro1);
    plot(pro1, f, 'color', AZblue, 'LineWidth',3)
    ylabel(lab{i});
    set(gca,'FontSize',20)
    [r, p] = corr(pro1, log(k(:,i)), 'rows', 'complete');
    text(2,-.5,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)
    if i > 3
        xlabel('pro-environmental behavior');
    end
end
%% scatter Pro2
figure(32); 

subplot(3, 2, 1)
scatter(pro2, temporal2, 100, AZred, '.'); hold on 
p = polyfit(pro2, temporal2,1);
f = polyval(p, pro2);
plot(pro2, f, 'color', AZblue, 'LineWidth',3)
% xlabel('pro-environmental behavior');
ylabel('# today items');
set(gca,'FontSize',20)
[r, p] = corr(pro2, temporal2, 'rows', 'complete');
text(2,29,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)

lab ={'log k overall', 'log k small', 'log k  medium', 'log k large', 'log k geometric'};
for i =1:5
    subplot(3, 2, i+1)
    scatter(pro2, log(k(:,i)), 100, AZred, '.'); hold on 
    p = polyfit(pro2, log(k(:,i)),1);
    f = polyval(p, pro2);
    plot(pro2, f, 'color', AZblue, 'LineWidth',3)
    ylabel(lab{i});
    set(gca,'FontSize',20)
    [r, p] = corr(pro2, log(k(:,i)), 'rows', 'complete');
    text(2,-.5,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)
    if i > 3
        xlabel('pro-environmental behavior');
    end
end
%% scatter pro-environmental behavior - scaled
figure(4); 

subplot(3, 2, 1)
scatter(L2(:,1), temporal2, 100, AZred, '.'); hold on 
p = polyfit(L2(:,1), temporal2,1);
f = polyval(p, L2(:,1));
plot(L2(:,1), f, 'color', AZblue, 'LineWidth',3)
% xlabel('pro-environmental behavior');
ylabel('# today items');
set(gca,'FontSize',20)
[r, p] = corr(L2(:,1), temporal2, 'rows', 'complete');
text(2,29,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)

lab ={'log k overall', 'log k small', 'log k  medium', 'log k large', 'log k geometric'};
for i =1:5
    subplot(3, 2, i+1)
    scatter(L2(:,1), log(k(:,i)), 100, AZred, '.'); hold on 
    p = polyfit(L2(:,1), log(k(:,i)),1);
    f = polyval(p, L2(:,1));
    plot(L2(:,1), f, 'color', AZblue, 'LineWidth',3)
    ylabel(lab{i});
    set(gca,'FontSize',20)
    [r, p] = corr(L2(:,1), log(k(:,i)), 'rows', 'complete');
    text(2,-.5,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)
    if i > 3
        xlabel('pro-environmental behavior');
    end
end
%% scatter pro-environmental self-identity
figure(5); 

subplot(3, 2, 1)
scatter(sum(B(:,56:59),2), temporal2, 100, AZred, '.'); hold on 
p = polyfit(sum(B(:,56:59),2), temporal2,1);
f = polyval(p, sum(B(:,56:59),2));
plot(sum(B(:,56:59),2), f, 'color', AZblue, 'LineWidth',3)
% xlabel('pro-environmental behavior');
ylabel('# today items');
set(gca,'FontSize',20)
[r, p] = corr(sum(B(:,56:59),2), temporal2, 'rows', 'complete');
text(6,29,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)

lab ={'log k overall', 'log k small', 'log k  medium', 'log k large', 'log k geometric'};
for i =1:5
    subplot(3, 2, i+1)
    scatter(sum(B(:,56:59),2), log(k(:,i)), 100, AZred, '.'); hold on 
    p = polyfit(sum(B(:,56:59),2), log(k(:,i)),1);
    f = polyval(p, sum(B(:,56:59),2));
    plot(sum(B(:,56:59),2), f, 'color', AZblue, 'LineWidth',3)
    ylabel(lab{i});
    set(gca,'FontSize',20)
    [r, p] = corr(sum(B(:,56:59),2), log(k(:,i)), 'rows', 'complete');
    text(6,-.5,strcat('r =', {' '}, num2str(round(r*100)/100),'; p = ' ,num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',17)
    if i > 3
        xlabel('pro-enviro self-identity');
    end
end
%% SELECTIVE N = 96 (was N=138); those who answered "yes" to 61
ind = B(:,61)==3;
L = L2; K = k; temp = temporal2; pr = proo;
L2 = L2(ind,:);
proo = proo(ind);
k = k(ind,:);
temporal2 = temporal2(ind,:);

%  now REPEAT figures 3-5
%% t-test
indd = ~(B(:,61)==3);
%% pro
[h, p,~, t] = ttest2(proo,pr(indd))
%% scaled
[h, p,~, t] = ttest2(L(ind,1),L(indd,1))
%% temporal
[h, p,~, t] = ttest2(temp(ind),temp(indd))
%% SELECTIVE N = 96 (was N=138); those who answered "a lot" or "moderate" to 60
ind2 = B(:,60)==3 | B(:,60)==2;
clear L22 k2 temporal2;
L2 = L(ind2,:);
k = K(ind2,:);
temporal2 = temp(ind2,:);

%  now REPEAT figures 3-5
%% t-test
indd2 = ~(B(:,60)==3 | B(:,60)==2);
%% pro
[h, p,~, t] = ttest2(proo(ind2),proo(indd2))
%% scaled
[h, p,~, t] = ttest2(L(ind2,1),L(indd2,1))
%% temporal
[h, p,~, t] = ttest2(temp(ind2),temp(indd2))
%% SELECTIVE N = 103 (was N=138); those who answered "a lot" or "oderate" to 62
ind3 = B(:,62)==3 | B(:,62)==2;
clear L22 k2 temporal2;
L2 = L(ind3,:);
k = K(ind3,:);
temporal2 = temp(ind3,:);

%  now REPEAT figures 3-5
%% t-test
indd3 = ~(B(:,62)==3 | B(:,62)==2);
%% pro
[h, p,~, t] = ttest2(proo(ind3),proo(indd3))
%% scaled
[h, p,~, t] = ttest2(L(ind3,1),L(indd3,1))
%% temporal
[h, p,~, t] = ttest2(temp(ind3),temp(indd33))
%% SELECTIVE N = 119 (was N=138); those who answered "human" or "both" to 63
ind4 = B(:,63)==3 | B(:,63)==2;
clear L22 k2 temporal2;
L2 = L(ind4,:);
k = K(ind4,:);
temporal2 = temp(ind4,:);

%  now REPEAT figures 3-5
%% SELECTIVE N = 89 males
ind5 = B(:,64)==1;
clear L22 k2 temporal2;
L2 = L(ind5,:);
k = K(ind5,:);
temporal2 = temp(ind5,:);

%  now REPEAT figures 3-5
%% SELECTIVE N = 49 females
ind6 = B(:,64)==2;
clear L22 k2 temporal2;
L2 = L(ind6,:);
k = K(ind6,:);
temporal2 = temp(ind6,:);

%  now REPEAT figures 3-5
%% t-test

%% pro
[h, p,~, t] = ttest2(proo(ind5),proo(ind6))
%% scaled
[h, p,~, t] = ttest2(L(ind5,1),L(ind6,1))
%% temporal
[h, p,~, t] = ttest2(temp(ind5),temp(ind6))
%% SELECTIVE N = 69 younger
ind7 = B(:,65)<34;
clear L22 k2 temporal2;
L2 = L(ind7,:);
k = K(ind7,:);
temporal2 = temp(ind7,:);

%  now REPEAT figures 3-5
%% SELECTIVE N = 69 older
ind8 = B(:,65)>=34;
clear L22 k2 temporal2;
L2 = L(ind8,:);
k = K(ind8,:);
temporal2 = temp(ind8,:);

%  now REPEAT figures 3-5
%% t-test
%% pro
[h, p,~, t] = ttest2(proo(ind8),proo(ind7))
%% scaled
[h, p,~, t] = ttest2(L(ind8,1),L(ind7,1))
%% temporal
[h, p,~, t] = ttest2(temp(ind8),temp(ind7))
%% correlation age and temporal; age and pro
[r,p] = corr(B(:,65), proo)
%%
[r,p] = corr(B(:,65), L(:,1))
%%
[r,p] = corr(B(:,65), temp)

%% SELECTIVE N = 68 single
ind9 = B(:,66)==1;
clear L22 k2 temporal2;
L2 = L(ind9,:);
k = K(ind9,:);
temporal2 = temp(ind9,:);

%  now REPEAT figures 3-5
%% SELECTIVE N = 58 married
ind10 = B(:,66)==2;
clear L22 k2 temporal2;
L2 = L(ind10,:);
k = K(ind10,:);
temporal2 = temp(ind10,:);

%  now REPEAT figures 3-5
%% t-test
%% pro **
[h, p,~, t] = ttest2(proo(ind10),proo(ind9))
%% scaled ***
[h, p,~, t] = ttest2(L(ind10,1),L(ind9,1))
%% temporal
[h, p,~, t] = ttest2(temp(ind10),temp(ind9))
%%
y = [mean(L(ind9,1)), mean(L(ind10,1))];
e1 = std (L(ind9,1)) / sqrt(length((L(ind9,1))));
e2 = std (L(ind10,1)) / sqrt(length((L(ind10,1))));
% X = categorical({'4y & more', '2y & less'});
h = bar([1 2], y); hold on;
h(1).FaceColor = AZmesa;
errorbar([1 2], y, [e1, e2], 'Color', 'b', 'LineWidth',3); box off;
sigstar({[1,2]},p)
set(gca, 'FontSize', 20)
xlabel('Marital Status')
ylabel('Pro-environmental behavior')
xticks([1 2])
xticklabels({'single','married'})

%% SELECTIVE N = 83 uni education
ind11 = B(:,67)==5 | B(:,67)==6;
clear L22 k2 temporal2;
L2 = L(ind11,:);
k = K(ind11,:);
temporal2 = temp(ind11,:);

%  now REPEAT figures 3-5
%% SELECTIVE N = 55 no uni education
ind12 = ~(B(:,67)==5 | B(:,67)==6);
clear L22 k2 temporal2;
L2 = L(ind12,:);
k = K(ind12,:);
temporal2 = temp(ind12,:);

%  now REPEAT figures 3-5
%% t-test
%% pro *
[h, p,~, t] = ttest2(proo(ind11),proo(ind12))
%% scaled **
[h, p,~, t] = ttest2(L(ind11,1),L(ind12,1))
%%
y = [mean(L(ind12,1)), mean(L(ind11,1))];
e1 = std (L(ind11,1)) / sqrt(length((L(ind11,1))));
e2 = std (L(ind12,1)) / sqrt(length((L(ind12,1))));
% X = categorical({'4y & more', '2y & less'});
h = bar([1 2], y); hold on;
h(1).FaceColor = AZmesa;
errorbar([1 2], y, [e2, e1], 'Color', 'b', 'LineWidth',3); box off;
sigstar({[1,2]},p)
set(gca, 'FontSize', 20)
xlabel('Higher Education')
ylabel('Pro-environmental behavior')
xticks([1 2])
xticklabels({'<=2y','>=4y'})

%% temporal
[h, p,~, t] = ttest2(temp(ind11),temp(ind12))