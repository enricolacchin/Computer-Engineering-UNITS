function [] = plot_zp(zeri,poli,xlim)
%function [] = plot_zp(zeri,poli,xlim)
%zeri: vettore colonna con gli zeri
%poli: vettore collanna con i poli
%xlim: dimensione plot
dth=pi/24;
color=['r';'w'];
th=0:dth:2*pi+dth;
pl0=3*xlim;x0=abs(pl0)*cos(th); y0=abs(pl0)*sin(th);
fill(x0,y0,'g');
hold on
mpoli=reshape(abs(poli),1,length(abs(poli)));
mpoli=sort(mpoli);
mpoli=fliplr(mpoli);
spoli=mpoli(1);
for h=2:length(mpoli)
    if mpoli(h)~=spoli(length(spoli))
        spoli=[spoli,mpoli(h)];
    end
end
for h=1:length(spoli)
    pl0=spoli(h);x0=abs(pl0)*cos(th); y0=abs(pl0)*sin(th);
    fill(x0,y0,color(rem(h,2)+1,:));
end
zplane(zeri,poli);
set(gca,'XLim',[-xlim,xlim]);
set(gca,'YLim',[-xlim,xlim]);

end

