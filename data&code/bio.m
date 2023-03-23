%%%%%%%%%This is the part 1 of the codefor the subsector%%%%%%%%
%%%%%%%%%%%%%%%of Pharmaceuticals and biotech %%%%%%%%%%%%
load('matrix_bio.mat');
load('nodebio.mat');

for k=3:10      
    for t=1:30
        k
        t
        [Bgroup{k,t},BModel{k,t}]=wsbm(adjmbioloop,k,'W_Distr','Normal','E_Distr','Bernoulli');
        loglk(k,t)=BModel{k,t}.Para.LogEvidence;
     end
end 

llk=permute(loglk(:,:),[2,1]);
llk(llk==0)=-Inf;
mcol=max(llk);
[~,m]=max(mcol(3:10));
m=m+7;
[~,maxind]=max(llk(:,m));
figure
[bio,bio1]=plotWSBMsq(Bgroup{10,6},BModel{10,6},10,'log10',0,0);

 %%llk figure
figure('color',[1 1 1]);
engloglk=mcol(3:10);
ylab=engloglk/1000;
plot(3:10,ylab);
xlabel('Group number,K','FontSize',12,'FontWeight','bold','Color','r');
ylabel({'Log-Likelihood Values','(in thousand)'},'FontSize',12,'FontWeight','bold','Color','r');


%%creat WSBM figure
figure('color',[1 1 1]);
flb=Bgroup{m,maxind}; 
fmd=BModel{m,maxind};
ng=m;
[seq{ng},neworder,h]=plotWSBMsq(flb,fmd,ng,'log10',0,0);