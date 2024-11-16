function [R2C,RMSEC,R2V,RMSEV]=LOOPCR(X,Y,n)

[s,v,d]=svd(X);
S=s*v;
Xsel=S(:,1:n);
Xsel=[ones(size(X,1),1) Xsel];
B=inv(Xsel'*Xsel)*(Xsel'*Y);
Yfit=Xsel*B;
[R2C,RMSEC]=myR2RMSE(Y,Yfit);

YLOO=zeros(size(Y));


for i=1:size(Y,1)

    Xcal=Xsel;
    Ycal=Y;
    Xval=Xcal(i,:);
    Xcal(i,:)=[];
    Ycal(i,:)=[];

    B=inv(Xcal'*Xcal)*(Xcal'*Ycal);

    Yhat=Xval*B;

    YLOO(i,:)=Yhat;


end


[R2V,RMSEV]=myR2RMSE(Y,YLOO);
