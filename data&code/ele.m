%%%%%%%%%This is the part 1 of the codefor the subsector%%%%%%%%
%%%%%%%%%%%%%%%of Technology hardware and equipment %%%%%%%%%%%%
load('matrix_ele.mat');
load('nodeele.mat');
for k=3:10      
    for t=1:30
        k
        t
        [Egroup{k,t},EModel{k,t}]=wsbm(adjmele,k,'W_Distr','Normal','E_Distr','Bernoulli');
        loglk(k,t)=EModel{k,t}.Para.LogEvidence;
     end
end 
llk=permute(loglk(:,:),[2,1]);
llk(llk==0)=-Inf;
mcol=max(llk);
[~,m]=max(mcol(3:10));
m=m+2;
[~,maxind]=max(llk(:,m));

elellk=llk
save('cmpresults.mat','Cgroup','CModel','cmpllk');
[ele,ele1]=plotWSBMsq(Egroup{7,14},EModel{7,14},7,'log10',0,0);
 %%llk figure
figure('color',[1 1 1]);
engloglk=mcol(3:10);
%%creat WSBM figure
figure('color',[1 1 1]);
flb=Egroup{m,maxind}; 
fmd=EModel{m,maxind};
ng=m;
[seq{ng},neworder,h]=plotWSBMsq(flb,fmd,ng,'log10',1,[2 3 4 5 6 7 1]);

ID1=G.Nodes.Name(seq{ng}(:,2));
ID=ID1;
set(gca,'YTick',1:76);
set(gca,'YTickLabel',ID(1:76,:));
set(gca, 'FontSize',10);
set(gca,'XTick',1:76);
set(gca,'XTickLabel',ID(1:76,:));
xticklabel_rotate([],45,[],'Fontsize',8);
group_table=table(ID,seq{ng}(:,3));
