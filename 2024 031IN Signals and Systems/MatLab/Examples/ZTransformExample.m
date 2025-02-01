clear
%parametri A e B
%per la stabilità, condizione necessaria (ma non sufficiente) |B|<2
%poli reali disgiunti se A>-B^2/4, coincidenti se A=-B^2/4
%i poli sono reali e distinti e il sistema è stabile se -B^2/4<A<1-|B|
%complessi se A<-B^2/4; in quest'ultimo caso il modulo dei poli è (-A)^0.5

%A=-1; B=2/(1+(tan(2*pi/P))^2)^.5; %oscillatore di periodo P

%H(0)/H(pi)=1/5*(1+B-A)/(1-B-A); passa alto se B<0; 
%se B>0 passa basso se A>1-3/2B, dovendo comunque essere -B^2/4<A<1-|B| 

%Assegnare un valore ai parametri
B=1; A=-1/8;
N=30;       %N+1=lunghezza sequenza
dth=pi/64;  %risoluzione fase
Xlim=1.2;   %dimensione diagramma zeri-poli 

n=0:N;
x=zeros(1,N+1);
y=zeros(1,N+1);%
x(n==0)=1; %per il calcolo della risposta impulsiva 
y(n==0)=x(n==0);
y(n==1)=-6*x(n==0)+B*y(n==0);
for i=2:length(n), 
    y(n==i)=x(n==i)-6*x(n==i-1)+8*x(n==i-2)+B*y(n==i-1)+A*y(n==i-2); 
end
subplot(1,3,2);
hold off
stem(n,y,'k');
hold on
zeri=[2;4];
%calcolo dei poli
p1=(B+(B^2+4*A)^.5)/2;
p2=(B-(B^2+4*A)^.5)/2;
poli=[p1;p2];
subplot(1,3,1);
hold off
th=0:dth:2*pi+dth;
plot_zp(zeri,poli,Xlim);
%antitrasformata
y1=zeros(1,N+1);
y1(n==0)=1;
if A>-B^2/4
    a=((B-6)*p1+8+A)/(p1-p2);
    b=((B-6)*p2+8+A)/(p2-p1);
    y1(n>0)=a*p1.^(n(n>0)-1)+b*p2.^(n(n>0)-1);
else
    if A==-B^2/4
        y1(n>0)=(B-6)*p1.^(n(n>0)-1).*n(n>0)+(8+A)*p1.^(n(n>0)-2).*(n(n>0)-1);
    else
        a=((B-6)*p1+8+A)/(p1-p2);
        ma=abs(a); fa=angle(a); mp=abs(p1); fp=angle(p1);
        y1(n>0)=2*ma*cos(fa+(n(n>0)-1)*fp).*mp.^(n(n>0)-1);
    end
end
subplot(1,3,2);
stem(n,y1,'r');
%trasformata di Fourier
subplot(1,3,3);
hold off
plot(th,zeros(1,length(th)));
if max(abs(poli))<1
    subplot(1,3,3);
    z=exp(j*th);
    Hf=(z.^2-6*z+8)./(z-p1)./(z-p2);
    hold off
    ths= [th(th>=pi)-2*pi,th(th<pi)];
    Hs=[Hf(th>=pi),Hf(th<pi)];
    plot(ths,abs(Hs));
    set(gca,'Xlim',[0,pi]);
    hold on    
    for h=1:length(z),Hz(h)=sum((z(h).^-n).*y); end
    Hzs=[Hz(th>=pi),Hz(th<pi)];
    plot(ths,abs(Hzs),'k');
end

        
