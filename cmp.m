load('matrix_office&computer.mat');
load('nodecmp.mat');
for k=3:10      
    for t=1:30
        k
        t
        [Cgroup{k,t},CModel{k,t}]=wsbm(adjmcmp,k,'W_Distr','Normal','E_Distr','Bernoulli');
        loglk(k,t)=CModel{k,t}.Para.LogEvidence;
     end
end   
llk=permute(loglk(:,:),[2,1]);
llk(llk==0)=-Inf;
mcol=max(llk);
[~,m]=max(mcol(3:10));
m=m+2;
[~,maxind]=max(llk(:,m));
cmpllk=llk
save('cmpresults.mat','Cgroup','CModel','cmpllk');

[cmpsq,groupcmp]=plotWSBMsq(Cgroup1{5},CModel1{5},5,'log10',1,[3 2 5 4 1]);

%%llk figure
figure('color',[1 1 1]);
engloglk=mcol(3:10);
ylab=engloglk/1000;
plot(3:10,ylab);
xlabel('Group number,K','FontSize',12,'FontWeight','bold','Color','r');
ylabel({'Log-Likelihood Values','(in thousand)'},'FontSize',12,'FontWeight','bold','Color','r');
%%set(gca, 'FontSize', 16);

%%creat WSBM figure
figure('color',[1 1 1]);
flb=Cgroup{m,maxind}; 
fmd=CModel{m,maxind};
ng=m;
[seq{ng},neworder,h]=plotWSBMsq(flb,fmd,ng,'log10',1,[2 1 3 4 5]);

ID1=G.Nodes.Name(seq{ng}(:,2));
ID=ID1;
set(gca,'YTick',1:25);
set(gca,'YTickLabel',ID(1:25,:));
set(gca, 'FontSize',10);
set(gca,'XTick',1:25);
set(gca,'XTickLabel',ID(1:25,:));
xticklabel_rotate([],45,[],'Fontsize',8);
group_table=table(ID,seq{ng}(:,3));
