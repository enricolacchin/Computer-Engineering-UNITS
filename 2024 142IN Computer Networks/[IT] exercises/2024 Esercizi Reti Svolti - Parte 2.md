# Reti di Calcolatori (parte 2) - Esercizi svolti

# Indirizzi IP → Network number

## IP-NetNum 1

*Indicare il network number a cui appartiene 131.114.65.252/18*

L’informazione fornita è una coppia indirizzo IP-network number (è evidente che lo host number non è zero).

/18 implica che la partizione tra network number ed host number sia nel terzo byte. In particolare, i due bit più significativi del terzo byte appartengono al network number.

Quindi il terzo byte deve essere interpretato come segue (network number in rosso, base 10 tra parentesi): 0100 0001  (65)

La configurazione con il valore minimo per l’host number sarà quindi:  
01000000 00000000  (64.0)

Quindi il network number sarà 131.114.64.0/18

## IP-NetNum 2

*Indicare il network number a cui appartiene 117.61.33.9/25*

L’informazione fornita è una coppia indirizzo IP-network number (è evidente che lo host number non è zero).

/25 implica che la partizione tra network number ed host number sia nel quarto byte. In particolare, il bit più significativo del quarto byte appartiene al network number.

Quindi il quarto byte deve essere interpretato come segue (network number in rosso, base 10 tra parentesi): 00001001  (9)

La configurazione con il valore minimo per l’host number sarà quindi 00000000  (0)

Quindi il network number sarà 117.61.33.0/25

## IP-NetNum 3

*Indicare il network number a cui appartiene 172.19.0.0/12*

L’informazione fornita è una coppia indirizzo IP-network number (è evidente che lo host number non è zero: /12 significa che la partizione è nel secondo byte; il secondo byte è dispari, quindi il bit meno significativo del secondo byte non può essere zero).

/12 implica che la partizione tra network number ed host number sia nel secondo byte. In particolare, i quattro bit più significativi del secondo byte appartengono al network number.

Quindi il secondo byte deve essere interpretato come segue (network number in rosso, base 10 tra parentesi): 00010011  (19)

La configurazione con il valore minimo per l’host number sarà quindi  
00010000 00000000 00000000 (16.0.0)

Quindi il network number sarà 172.16.0.0/12

## IP-NetNum 4

*Indicare il network number a cui appartiene 192.168.7.3/17*

L’informazione fornita è una coppia indirizzo IP-network number (è evidente che lo host number non è zero).

/17 implica che la partizione tra network number ed host number sia nel terzo byte. In particolare, il bit più significativo del terzo byte appartiene al network number.

Quindi il terzo byte deve essere interpretato come segue (network number in rosso, base 10 tra parentesi): 00000111  (7)

La configurazione con il valore minimo per l’host number sarà quindi  
00000000 00000000 (0.0)

Quindi il network number sarà 192.168.0.0/17

# IP

## Routing 1

*Scrivere le tabelle di routing in formato simbolico per l’organizzazione in figura.*

![][image1]

Indichiamo le interfacce con i nomi convenzionali Up, Down, Left, Right.

I range sono gli stessi per i 3 router. Per comodità, invece di fornire 3 tabelle diverse si fornisce una unica tabella (ovviamente nella realtà ogni router sarà configurato con la colonna Range e con la sola colonna Azione corrispondente a quel router).

| Range | Azione RA | Azione RB | Azione RC |
| :---- | :---- | :---- | :---- |
| N1 | Down Direct | Up Direct | Up IP-RB-down |
| N2 | Down IP-RB-Up | Down Direct | Up Direct |
| N3 | Down IP-RB-Up | Down IP-RC-Up | Right Direct |
| N4 | Down IP-RB-Up | Right Direct | Up IP-RB-down |
| default | Left IP-R-ISP-Right  | Up IP-RA-Down | Up IP-RB-down |

### Osservazione

Ogni tabella di routing deve soddisfare questo requisito: La tabella di routing deve essere strutturata in modo che ogni indirizzo di destinazione sia gestito “correttamente” (non specifichiamo cosa significhi esattamente “correttamente”)..

Ogni tabella che soddisfa quel requisito è corretta. Realizzare una tabella di routing con una riga per ogni network della organizzazione ed una riga aggiuntiva "altrimenti" (default), come nella soluzione fornita sopra, facilita il soddisfacimento del requisito. Rende cioè meno probabile la realizzazione di una tabella errata.

E’ possibile realizzare una tabella di routing in cui alcune network dell'organizzazione sono gestite dalla riga "altrimenti" senza cioè essere associate ad una riga dedicata esclusivamente ad esse. Tabelle con questa struttura possono essere corrette o meno. Dipende.

Ad esempio, la tabella per RC potrebbe non avere le righe per N1 ed N4; in questo modo sarebbe corretta. La tabella per RB potrebbe non avere la riga per N3; in questo modo (la tabella per RB) non sarebbe corretta (RB instraderebbe i pacchetti indirizzati ad N3 verso IP-RA-down; RA instraderebbe nuovamente verso RB, quindi i pacchetti entrerebbero in un routing loop).

Ovviamente, realizzare una tabella di routing con righe che descrivono network non dell'organizzazione è certamente sbagliato; realizzare una tabella di routing senza riga "altrimenti" per una organizzazione collegata ad Internet  è certamente sbagliato

![][image2]

## Assegnazione network number

*I blocchi SW indicano switch, i blocchi AP indicano access point (le aree di copertura degli access point non sono indicate per semplicità). In ogni area di copertura possono trovarsi al più 16 nodi ed ogni switch ha 16 porte (comprese quelle indicate in figura).*

 

*Lo Internet Provider ISP è proprietario del range di indirizzi 131.116.128.0/255.255.224.0 che suddivide in 32 range di uguale dimensione. Org acquista il penultimo di questi range ed ha le seguenti caratteristiche:*

* *ha server email, server DNS, server web, web proxy collegati a SWC.*  
* *utilizza indirizzi privati nel range 192.168.0.0/16 per le network contenenti access point;*  
* *alloca indirizzi dinamicamente in ogni network per ogni nodo (ad eccezione dei router, dei server DHCP, email, web, web proxy e DNS);*

 

*Si determini un possibile assegnamento per i network number di tutte le network di Org (ad eccezione della network di collegamento con ISP). I network number devono essere commisurati alle esigenze effettive (esempio: in una network che può avere al più 2 nodi si deve usare un network number /30).*

Le network dell’organizzazione sono quelle indicate in figura (la network di collegamento con ISP non viene considerata in quanto assunta “a carico” dell’ISP). ![][image3]

La sovrapposizione tra le linee che indicano N1 ed N2 è solo un artefatto grafico: un frame inviato da un nodo collegato a SWE non può arrivare ad un nodo collegato a SWD o a SWC (nodo non router, ovviamente). Si noti che RC ha 5 interfacce ma è collegato a 4 network: ha infatto due collegamenti con N2. 

Per determinare l’intervallo di indirizzi acquistato dall’organizzazione occorre suddividere il range di ISP in 32 range di uguale dimensione. L’intervallo di ISP è 131.116.128.0/255.255.224.0 . Dalla subnet mask discende che il network number è /19 (224 in binario è 1110 0000; 8+8+3=19 bit) pertanto la lunghezza dell’intervallo a disposizione di ISP è 32-19=13 bit.

L’intervallo è suddiviso in 32 range, quindi i 13 bit sono suddivisi in 5-8 (5 bit per identificare il range e 8 bit interni al range). Ogni range corrisponde quindi ad un network number /24 (19 bit identificano l’intervallo dell’ISP \+ 5 bit identificano il range in questo intervallo):  
131.116.100 \-----.0/24  
(nel terzo byte, i 3 bit più significativi sono identici per tutti i range mentre i 5 meno significativi identificano il range).

Per l’ultimo range i 5 bit sono 11111 quindi per il penultimo sono 11110\. Il network number del penultimo range sarà pertanto:

131.116.100 11110.0/24 \= 131.116.158.0/24

Le network sono 4\. Il testo specifica che nelle network con AP devono essere usati indirizzi nel range 192.168.0.0/16 (indirizzi privati ma ciò è irrilevante). Queste network sono 2 quindi il network number acquistato da ISP deve essere partizionato in 4-2=2 network number: uno per N1 ed uno per N2. 

Network N1. Il numero di nodi che possono essere collegati a SWE è 14 (ogni switch ha 16 porte). Tenendo conto di RB ed RC occorrono 16 indirizzi. L’intervallo di N1 deve quindi essere lungo 5 bit (un intervallo di lunghezza 4 bit non è sufficiente in quanto in ogni intervallo ci sono 2 bit inutilizzabili), pertanto il network number avrà lunghezza /32-5=27.

Network N2. Con un ragionamento analogo si ottiene che l’intervallo di N2 deve essere lungo 5 bit (SWD 13 nodi, SWC 14 nodi; 27 nodi più 3 indirizzi per i router implica 30 indirizzi; quindi un intervallo di 5 bit è sufficiente). Il network number di N2 pertanto avrà lunghezza /32-5=27.

Suddividiamo l’intervallo acquistato in intervalli di dimensione identica all’intervallo più grande che è necessario (N1 ed N2 necessitano di intervalli della stessa lunghezza):

131.116.158.0/24	(intervallo acquistato)   
131.116.158.000\- \----/27 (intervalli lunghi 5 bit)  
131.116.158.001\- \----/27  
...

Utilizziamo il primo per N2, il cui network number quindi sarà 131.116.158.0/27.

Utilizziamo il secondo per N1, il cui network number quindi sarà 131.116.158.32/27.

Per N3 ed N4 il testo specifica di usare  indirizzi nel range 192.168.0.0/16

Network N3. Il numero di nodi che possono essere collegati è 15 (lo switch ha 16 porte, di cui una usata da AP che non ha indirizzo IP) \+ 16 (nodi nella cella di AP); quindi occorrono 31 indirizzi IP; un range di 32 indirizzi non è sufficiente, poiché occorre tenere presente che in ogni range ci sono sempre 2 indirizzi inutilizzabili (il primo e l’ultimo); quindi occorre un range di 64 indirizzi.  Quindi occorre un intervallo di 6 bit.

Network N4. Il numero di nodi è 14+16+16=46 (switch: 3 porte consumate, di cui 1 per il router e 2 per gli AP; ci posso collegare altri 13 nodi, quindi 13+1=14 indirizzi IP) e anche in questo caso occorre un intervallo di 6 bit. 

Suddividiamo l’intervallo in intervalli di lunghezza 6 bit:

192.168.0.0/16  
192.168.0.00\-- \----/26 (intervalli lunghi 6 bit)  
192.168.0.01\-- \----/26  
192.168.0.10\-- \----/26  
...

Utilizziamo il primo per N3 ed il secondo per N4. I network number saranno, rispettivamente, 192.168.0.0/26 e 192.168.0.64/26 (0100 0000 in binario corrisponde a 64).

### Osservazioni

Nel procedimento sopra descritto, i network number per N1 ed N2 sono stati ottenuti all’inizio dell’intervallo acquistato. Cioè, l’intervallo è stato suddiviso in 8 porzioni di eguale dimensione, ed N1 ed N2 sono stati inseriti nelle porzioni 000 e 001\. Di seguito viene mostrato uno dei procedimenti per inserire N1 ed N2 in altre porzioni:

131.116.158.10\-- \----/26  
131.116.158.11\-- \----/26

Ad esempio, suddividiamo il primo in due intervalli ed il secondo in quattro intervalli  
131.116.158.10**0**\- \----/27 (intervalli lunghi 5 bit)  
131.116.158.10**1**\- \----/27

131.116.158.11**00** \----/28 (intervalli lunghi 4 bit)  
131.116.158.11**01** \----/28  
131.116.158.11**10** \----/28  
131.116.158.11**11** \----/28

In notazione decimale puntata si ottiene (assegnando host number zero):

131.116.158.128/27  
131.116.158.160/27

131.116.158.192/28	(128+64=192)  
131.116.158.208/28	(128+64+16=208)  
131.116.158.224/28	(128+64+32=224)  
131.116.158.240/28	(128+64+32+16=240)

## Routing 2

*Con riferimento allo scenario dell’esercizio “[Assegnazione network number](#assegnazione-network-number)”, fornire la tabella di routing per RC in formato simbolico (esempio: “N3”, “IP-RA-left”) ed in formato numerico*

Le network sono 4\. Pertanto la tabella dovrà avere 5 righe.

Identifichiamo le interfacce con “i punti cardinali”: N, S, W, E, SW, SE, e così via. La tabella in formato simbolico sarà la seguente:

| Network | Azione |
| :---- | :---- |
| N1 | NW Direct |
| N2 | N Direct |
| N3 | SW Direct |
| N4 | SE Direct |
| Default | SW IP-RA-E |

RC ha due collegamenti con N2 (N e NE). Pertanto la riga corrispondente avrebbe potuto essere anche NE Direct.

La tabella in formato numerico sarà la seguente:

| Network | Azione |
| :---- | :---- |
| 131.116.158.64/27 | NW Direct |
| 131.116.158.0/2~~6~~7 | N Direct |
| 192.168.0.0/26 | SW Direct |
| 192.168.0.64/26 | SE Direct |
| Altrimenti | SW 192.168.0.1 |

Per IP-RA-E si è scelto host number 1 (il network number è quello di N3).

## Ping 1

*Con riferimento allo scenario dell’esercizio “[Assegnazione network number](#assegnazione-network-number)”,  si consideri un nodo C2 che si trova nell’area di copertura di AP2, viene acceso ed esegue il comando ping IP-RB-down.*

*Descrivere la sequenza di tutti i frame trasmessi e ricevuti da C2 dall’accensione fino al completamento dell’esecuzione di ping (chiarire, motivando la risposta, se l’esecuzione di ping termina con una trasmissione o con una ricezione).*

La sequenza di frame richiesta è la seguente:

|  | dst | src | type | payload |
| :---- | :---- | :---- | :---- | :---- |
| 1 | FFFFFFFF | Eth-C2 | DHCP | DHCPDISCOVER |
| 2 | Eth-C2 | Eth-DHCP | DHCP | DHCPOFFER \+ config info |
| 3 | FFFFFFFF | Eth-C2 | ARP | ARP-REQ(Eth-C2,IP-C2,?,IP-C2) |
| 4 | FFFFFFFF | Eth-C2 | ARP | ARP-REQ(Eth-C2,IP-C2,?,IP-RC-SE) |
| 5 | Eth-C2 | Eth-RC-SE | ARP | ARP-RESP(Eth-RC-SE,IP-RC-SE,Eth-C2,IP-C2) |
| 6 | Eth-RC-SE | Eth-C2 | IP | IP-C2 IP-RB-down ICMP | “echo request” |
| 7 | Eth-C2 | Eth-RC-SE | IP | IP-RB-down IP-C2 ICMP | “echo reply” |

Gli indirizzi sono allocati dinamicamente, quindi C2 deve innanzitutto ottenere le informazioni di configurazione (1,2). Poi C2 invia un gratuitous ARP per permettere la rilevazione di eventuali errori di configurazione ed aggiornare le tabelle degli switch (3). Prima di trasmettere e ricevere ping e risposta (6,7), deve acquisire l’indirizzo Ethernet del gateway di default (4,5).

L’esecuzione di ping termina con una ricezione in quanto la comunicazione tra C2 e RB è effettivamente possibile, pertanto RB riceve la echo request e C2 riceve la echo response.

### Osservazioni {#osservazioni}

* Il fatto che C2, nello scenario considerato, abbia indirizzo IP privato è irrilevante. La comunicazione tra C2 e RB è interna alla stessa organizzazione, pertanto gli indirizzi privati sono del tutto equivalenti agli indirizzi pubblici (svolgimenti quali “C2 non può comunicare con RB perché ha indirizzo privato” non hanno senso).  
* I frame 6 e 7 trasportano un payload IP. NON trasportano un payload ICMP. ICMP è trasportato da IP. Non è una regola da imparare a memoria. E’ una conseguenza necessaria. ICMP è un protocollo utilizzabile da nodi in network diverse. Pertanto, questi nodi possono comunicare solo attraverso pacchetti, non attraverso frame.  
* La colonna Type contiene un testo convenzionale. Nella realtà contiene dei valori predefiniti e specificati nel protocollo Ethernet. Non occorre ricordare questi valori a memoria.  
* La descrizione del payload Ethernet, cioè del pacchetto IP, è informale. L’obiettivo è convincere il lettore di avere capito. Ci sono molti modi diversi per ottenere questo obiettivo. Modi che certamente **non** raggiungono l’obiettivo sono questi: descrivere un pacchetto IP scrivendo solo il payload; scrivere prima il payload e poi lo header; scrivere una sequenza di informazioni senza una separazione evidente tra header e payload; scrivere una sequenza di informazioni mescolando ciò che sta nello header e ciò che sta nel payload. In generale, lo header deve contenere almeno mittente, destinatario e tipo del payload (protocollo); eventuali ulteriori informazioni dipendono dall’esercizio specifico (ad esempio, per descrivere il funzionamento di traceroute è essenziale mettere anche il TTL).  
* Il testo richiedeva di fornire la sequenza di frame trasmessi e ricevuti da C2. Pertanto è stata fornita solo tale sequenza. Gli altri frame necessari per l’esecuzione di ping (che comprendono, in questo caso, anche quelli per la comunicazione tra RC-NW e RB-down) non sono stati descritti. Descrivere anche quei frame sarebbe stato, ai fini di un esame, inutile e dannoso. Inutile, perché il testo non lo richiedeva: quindi non permettono di ottenere nessun incremento di voto. Dannoso, perché si perde tempo, si perde lucidità e si rischia di commettere errori (errori che ovviamente vengono tenuti in conto): quindi possono portare ad un decremento di voto.

## Traceroute 1

*Con riferimento allo scenario dell’esercizio “[Assegnazione network number](#assegnazione-network-number)”, sia IP-C3 l’indirizzo di un nodo C3 che si trova sotto l’area di copertura di AP3.*

*Descrivere la sequenza di tutti i frame trasmessi e ricevuti da RB per l’esecuzione di traceroute IP-C3.*

La sequenza di frame richiesta è la seguente:

|  | dst | src | type | payload |
| :---- | :---- | :---- | :---- | :---- |
| 1 | Eth-RC-NW | Eth-RB-down | IP | IP-RB-down IP-C3 TTL=1 ICMP | “echo request” |
| 2 | Eth-RB-down | Eth-RC-NW | IP | IP-RC-NW IP-RB-down ICMP | “TTL exceeded” |
| 3 | Eth-RC-NW | Eth-RB-down | IP | IP-RB-down IP-C3 TTL=2 ICMP | “echo request” |
| 4 | Eth-RB-down | Eth-RC-NW | IP | IP-C3 IP-RB-down ICMP | “echo reply” |

Non è presente traffico DHCP in quanto RB ha configurazione statica. Si è assunto che RB sia a conoscenza di Eth-RC-NW. Questa ipotesi è ragionevole in quanto RB ed RC sono dei router, pertanto è ragionevole assumere che il primo abbia già avuto in passato l’esigenza di ottenere l’indirizzo Ethernet del secondo. Svolgimenti contenenti il traffico ARP corrispondente, comunque, sarebbero stati considerati corretti.

Le [osservazioni](#osservazioni) riportate nell’esercizio “Ping 1” sono importanti anche per questo esercizio.

## Firewall 1

*Con riferimento allo scenario dell’esercizio “[Assegnazione network number](#assegnazione-network-number)”, Org desidera proibire ogni comunicazione con l'esterno ad eccezione di quanto segue: gli utenti di Org possono inviare email e ricevere email; possono navigare su web solo attraverso proxy.*

*Descrivere le corrispondenti regole di firewall da inserire su RA.*

|  | regola | commento |
| :---- | :---- | :---- |
| 1 | IP-src=IP-MS AND port-src=25 | SMTP entranteSolo verso mail server(ricezione email inviate dall’esterno) |
| 2 | IP-dst=IP-MS AND port-dst=25 |  |
| 3 | IP-src=IP-MS AND port-dst=25 | SMTP uscenteSolo da mail server(invio email verso l’esterno) |
| 4 | IP-dst=IP-MS AND port-src=25 |  |
| 5 | IP-src=IP-PX AND port-dst=80 | HTTP uscenteSolo da proxy |
| 6 | IP-dst=IP-PX AND port-src=80 |  |
| 7 | IP-src=IP-NS AND port-src=53 | DNS entranteSolo verso name server |
| 8 | IP-dst=IP-NS AND port-dst=53 |  |
| 9 | IP-src=IP-NS AND port-dst=53 | DNS uscenteSolo da name server |
| 10 | IP-dst=IP-NS AND port-src=53 |  |

Il traffico DNS di tipo server è quello in cui dall’esterno arrivano richieste al name server dell’organizzazione. Questo traffico deve essere permesso altrimenti non sarebbe possibile ricevere email dall’esterno.

Il traffico DNS di tipo client è quello in cui il name server dell’organizzazione interagisce con name server esterni. Questo traffico deve essere permesso altrimenti non sarebbe possibile inviare email verso l’esterno e neanche navigare su web.

### Osservazioni

* I firewall che consideriamo sono sempre del tipo Regole “permetti”-Default “blocca”. Quindi non occorre associare ogni regola all’azione “permetti” o “passa”. Inoltre, ogni tipologia di traffico non descritta dalle regole è bloccata.  
* In pratica oltre alle regole 5 e 6 ci sono sempre altre due regole con la stessa struttura e numero di porta 443\. Queste regole aggiuntive sono per il traffico HTTPS. In provette ed esami di solito si possono omettere, a meno di casi particolari evidenziati nel testo.  
* Nella realtà la configurazione dei firewall non ha una colonna “commento”. Talvolta una colonna “Nome” (come in Windows). In un esame non è obbligatorio mettere una colonna “commento” ma è altamente consigliabile (soprattutto per lo studente stesso).

### Osservazioni generali sui firewall

Ogni **regola** è una espressione logica (cioè un’espressione il cui risultato è un valore booleano) i cui operandi sono IP-src, IP-dst, port-src, port-dst.

Gli **operatori** non li abbiamo elencati esplicitamente ma sono, spero, ovvi: AND, OR, NOT più eventuali altri "operatori intuitivi" che sono utili per esprimere in maniera più compatta espressioni che con AND/OR/NOT sarebbero relativamente lunghe (ad esempio "IP-src in NetNum(N-x)").

L'**algoritmo** applicato dal firewall ha la forma:

IF regola1 THEN passa

ELSEIF regola2 THEN passa

ELSEIF regola3 THEN passa

…

ELSE blocca

Invece di scrivere l'algoritmo applicato dal firewall noi scriviamo l'**insieme delle regole**. Nel caso sopra descritto: (regola1, regola2, regola3,...)

Un procedimento molto comodo per costruire l'insieme delle regole a partire da una specifica testuale consiste nel creare una **tabella** con una riga per ogni regola ed una colonna per ognuno degli operandi. Ad esempio:

IP-src    IP-dst   port-src   port-dst

IP-C       IP-w      \-                 80

Ai fini degli esami, fornire la tabella o l'insieme delle regole è equivalente, poiché la traduzione dalla prima al secondo è meccanica (quindi se uno mi fornisce solo la tabella, mi fido che sappia costruire anche l'insieme delle regole).

E' però importante avere chiaro il procedimento di traduzione, altrimenti uno non riesce neanche a costruire la tabella.

Ad esempio, la riga sopra descritta permette il transito di pacchetti diretti verso la porta 80 dell'indirizzo IP-W, solo se originati dall'indirizzo IP-C. Ma se volessi permettere come origine IP-C oppure IP-A? Oppure se volessi permettere da qualunque origine diversa da IP-C?

Il primo caso si può gestire in questo modo:

IP-src                IP-dst   port-src   port-dst

IP-C or IP-A      IP-w      \-                 80

in quanto, dopo la traduzione, la regola è:

IF IP-src \= (IP-C or IP-A) and IP-dst=IP-w and port-dst=80 THEN passa

Il secondo caso si può gestire in questo modo:

IP-src               IP-dst   port-src   port-dst

not IP-C           IP-w      \-                 80

in quanto, dopo la traduzione, la regola è:

IF (IP-src diverso da IP-C) and IP-dst=IP-w and port-dst=80 THEN passa

Notate che, per semplicità, non abbiamo formalizzato il procedimento di traduzione ma lo abbiamo lasciato "intuitivo".

## Firewall 1-bis

*Si ripeta l’esercizio precedente assumendo che il server DNS non sia interno all’organizzazione e si trovi invece in ISP.*

Le regole di firewall 1-6 rimangono immutate in quanto indipendenti dalla posizione del name server (SMTP entrante solo verso il mail server, SMTP uscente solo dal mail server, HTTP uscente solo dal proxy).

Le regole di firewall 7-10 sono relative al traffico DNS e devono quindi essere rimosse in quanto il server DNS non è interno ma esterno. Le regole corrispondenti in questo nuovo scenario sono le seguenti:

|  | regola | commento |
| :---- | :---- | :---- |
| 7 | IP-dst=IP-NS AND port-dst=53 | DNS uscente Solo verso name server, da qualsiasi nodo interno |
| 8 | IP-src=IP-NS AND port-src=53 |  |

Non è necessario inserire regole per il traffico DNS entrante proprio perché il name server è esterno (inserire regole non necessarie è un errore importante). 

Osservazione

* Le regole 7 e 8 sono usate dal traffico originato dagli endpoint solo per risolvere il nome del proxy ed il nome del mail server.

## Routing 3

*I dispositivi "AP" sono access point per Ethernet wireless, i dispositivi "SW" sono switch Ethernet, i dispositivi "R" sono router, i blocchi "N" indicano network Ethernet. Tutti gli indirizzi sono allocati dinamicamente, ad eccezione degli indirizzi per i router ed i server. La sola network che usa indirizzi privati è N1.*

*L’organizzazione OrgB ha un name server NSB ed un mail server MSB; questi server sono esterni a OrgB e si trovano nella network NA di OrgA.*

*Fornire le tabelle di routing di RX ed RB indicando i network number e gli indirizzi IP dei router in un formato simbolico indicato chiaramente.*

Le network sono indicate nella figura a fianco (N2 è disegnata con due rettangoli smussati ma è una unica network).

La tabella di routing di RX contiene 2 righe: una per la sola network nota ad OrgA (N1) ed una per il range default.

La tabella di routing di RB contiene 3 righe: due per le sole network note a OrgB (N2, N3) ed una per il range default.

Usiamo per le interfacce dei router le indicazioni dei punti cardinali. Le tabelle di routing in formato simbolico sono le seguenti.

| RX |  | Tabella di RB |  |
| :---- | :---- | ----- | :---- |
| N1 | Direct S | N2 | Direct N |
| default | IP-R1-S N | N3 | Direct S |
|  |  | default | IP-RA-S N |

## Ping 2

*Con riferimento allo scenario dell’esercizio “[Routing 3](#firewall-1-bis)”, Un nodo C2 nell'area di copertura di AP2 viene acceso ed esegue il comando ping IP-1, dove IP-1 è l'indirizzo IP di un nodo C1 nell'area di copertura di AP1. Descrivere la sequenza di tutti i frame trasmessi e ricevuti da C2, dal momento della sua accensione fino alla terminazione del comando.*

*Dopo l’esecuzione del comando ping sopra indicato, il nodo C2 esegue il comando ping IP-NSB. Descrivere la sequenza di tutti i frame trasmessi e ricevuti da C2, sino sino alla terminazione del comando.*

Per l’esecuzione di ping IP-1, la sequenza di frame richiesta è la seguente:

|  | dst | src | type | payload |
| :---- | :---- | :---- | :---- | :---- |
| 1 | FFFFFFFF | Eth-C2 | DHCP | DHCPDISCOVER |
| 2 | Eth-C2 | Eth-DHCP | DHCP | DHCPOFFER \+ config info |
| 3 | FFFFFFFF | Eth-C2 | ARP | ARP-REQ(Eth-C2,IP-C2,?,IP-C2) |
| 4 | FFFFFFFF | Eth-C2 | ARP | ARP-REQ(Eth-C2,IP-C2,?,IP-RB-S) |
| 5 | Eth-C2 | Eth-RB-S | ARP | ARP-RESP(Eth-RB-S,IP-RB-S,Eth-C2,IP-C2) |
| 6 | Eth-RB-S | Eth-C2 | IP | IP-C2 IP-1 ICMP | “echo request” |
| 7 | Eth-C2 | Eth-RB-S | IP | IP-1  IP-C2 ICMP | “echo reply” |

Gli indirizzi sono allocati dinamicamente, quindi C2 deve innanzitutto ottenere le informazioni di configurazione (1,2). Poi C2 invia un gratuitous ARP per permettere la rilevazione di eventuali errori di configurazione ed aggiornare le tabelle degli switch (3). Prima di trasmettere e ricevere ping e risposta (6,7), deve acquisire l’indirizzo Ethernet del gateway di default (4,5).

Per l’esecuzione di ping-IP-NSB, si osserva che IP-NSB non appartiene alla network a cui appartiene C2 e che C2 ha già acquisito l’indirizzo Ethernet del gateway di default. Pertanto, la sequenza di frame richiesta sarà:

|  | dst | src | type | payload |
| :---- | :---- | :---- | :---- | :---- |
| 8 | Eth-RB-S | Eth-C2 | IP | IP-C2 IP-NSB ICMP | “echo request” |
| 9 | Eth-C2 | Eth-RB-S | IP | IP-NSB IP-C2 ICMP | “echo reply” |

## Firewall 2

*Con riferimento allo scenario dell’esercizio “[Routing 3](#routing-3)”:*

1. *OrgB desidera proibire ogni comunicazione con l'esterno ad eccezione di quanto segue: i propri utenti possono inviare email, ricevere email, prelevare email. Descrivere le corrispondenti regole di firewall da inserire su RA.*  
2. *Si assuma che al punto ~~4~~ 1 sia da permettere anche la navigazione web attraverso un proxy nella network N2. Se ciò è possibile allora descrivere le eventuali modifiche da apportare alle regole al punto 4, altrimenti descrivere brevemente il motivo della impossibilità.*

**Punto 1**

Le regole da inserire in RA (firewall di OrgB) sono le seguenti:

|  | regola | commento |
| :---- | :---- | :---- |
| 1 | IP-src=IP-MSB AND port-src=25 | SMTP uscente (solo verso MS) |
| 2 | IP-dst=IP-MSB AND port-dst=25 |  |
| 3 | IP-src=IP-MSB AND port-src=110 | POP uscente (solo verso MS) |
| 4 | IP-dst=IP-MSB AND port-dst=110 |  |
| 7 | IP-src=IP-NSB AND port-src=53 | DNS uscente (solo verso NS) |
| 8 | IP-dst=IP-NSB AND port-dst=53 |  |

Le [osservazioni](#osservazioni) riportate nell’esercizio “Ping 1” sono importanti anche per questo esercizio.

Si noti che non sono necessarie regole per la ricezione di email, cioè per permettere al mail server di inoltrare email ai mail server di altre organizzazioni. Tali regole, infatti, dovranno essere inserite nel firewall di OrgA, non nel firewall di OrgB.

Le regole 7 e 8 sono necessarie per permettere ai mail client interni ad OrgB di ottenere l’indirizzo IP del proprio mail client.

**Punto 2**

Non c’è alcuna ragione per la quale un proxy in N2 non possa accedere ad Internet, se le regole di firewall lo permettono. In particolare, il fatto che il tragitto da N2 ad ISP2 comprenda il passaggio attraverso una network che utilizza indirizzi IP privati (N1) è completamente irrilevante.

La nuova configurazione per il firewall su RA deve comprendere le stesse regole precedenti ed in più le seguenti:

|  | regola | commento |
| :---- | :---- | :---- |
| 1 | IP-src=IP-PX AND port-dst=80 | Navigazione web da proxy (uscente) |
| 2 | IP-dst=IP-PX AND port-src=80 | Navigazione web da proxy (entrante) |

## ARP

*Si consideri un nodo A con IP-A=131.114.119.147 ed SM-A=255.255.255.224.*  
*Il nodo A è configurato con gateway IP-GW=131.114.119.132 e name server IP-NS=131.114.119.222.*  
*Siano Eth-A=AA:17:23:F2:FF:64, Eth-GW=BB:F2:23:F2:FF:64, Eth-NS=CC:61:23:F2:FF:64.*

*All’istante t0, tutte le cache ARP di tutti i nodi si sono improvvisamente svuotate; immediatamente dopo l’istante t0, il nodo A invia una DNS request RQ e riceve successivamente la corrispondente DNS response RP.*

*Si descriva la sequenza di tutti i frame inviati e ricevuti da A per trasmettere RQ e ricevere RP, motivando la scelta della sequenza. La descrizione deve utilizzare valori simbolici. I messaggi DNS possono essere descritti come direttamente contenuti nel payload dei pacchetti IP.*

IP-A determina che IP-NS appartiene ad una network diversa dalla propria. Infatti:

IP-A, IP-GW ed IP-NS hanno i 3 byte più significativi identici; consideriamo per semplicità solo il byte meno significativo:

147 ≡ 1001 0011 (A)    
132 ≡ 1000 0100 (GW)  
222 ≡ 1101 1110 (NS)

224 ≡ 1110 0000 (SM)

147 AND SM \= 1000 0000  
132 AND SM \= 1000 0000	(= 147 AND SM; ovvio, altrimenti i dati sarebbero stati errati)  
222 AND SM \= 1100 0000	(≠ 147 AND SM; quindi NS ed A si trovano in network diverse)

Poiché A ed NS sono in network diverse, A deve inviare il pacchetto in un frame indirizzato al gateway di default. Per farlo deve prima ottenere il valore numerico di Eth-Gw. 

|  | Eth-SRC | Eth-DST | Eth-Type | Eth-payload |  |  |  |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| 1 | Eth-A | Broadcast | ARP | ARP-REQ(Ip-A, Eth-A, Ip-GW, ?) |  |  |  |
| 2 | Eth-GW | Eth-A | ARP | ARP-RESP(Ip-GW, Eth-Gw, Ip-A, Eth-A) |  |  |  |
|  |  |  |  | **IP-SRC** | **IP-DST** | **IP-proto** | **IP-payload** |
| 3 | Eth-A | Eth-GW | IP | IP-A | IP-DNS | UDP | RQ |
| 4 | Eth-Gw | Eth-A | IP | IP-DNS | IP-A | UDP | RP |

Osservazioni

* Quando GW invia il frame 4 non ha necessità di inviare una ARP request per ottenere il valore numerico di Eth-A in quanto ha ricevuto la ARP-REQ in precedenza.   
* In questo scenario non c’è nessun gratuitous ARP (i nodi non si sono “appena collegati”). Mettere il gratuitous ARP (o, peggio ancora, traffico DHCP) può essere una distrazione ma può anche essere un indizio di “applicare automaticamente il pattern dell’esercizio tipico senza avere capito cosa si sta facendo”.  
  * Un ragionamento del tipo “*il gratuitous ARP è presente perché è utile, in quanto gli altri nodi non hanno più l’associazione Eth-A/IP-A*” è sbagliato: primo, il fatto che qualcosa sia utile non implica che quel qualcosa accada; secondo, non è realistico assumere che un nodo venga automaticamente a conoscenza del contenuto della cache ARP di altri nodi..  
* Determinare che A ed NS appartengono a network diverse perché l’indirizzo IP-NS è numericamente superiore all’indirizzo massimo della network a cui appartiene A è un procedimento non adeguato (non sarebbe un errore grave, ma non è adeguato): il procedimento adeguato è quello realizzato dai nodi, cioè il confronto tra i risultati dell’AND logico con la subnet mask. Il confronto con il valore numerico massimo è una sorta di riprova utile per un operatore umano, per convincersi intuitivamente della correttezza dell’esito del confronto.

## Routing, Firewall (frontiera e locali)

*Con riferimento alla figura a fianco, OrgX ha queste caratteristiche: tutti gli indirizzi sono allocati dinamicamente, ad eccezione di quelli di router e server; in N1 utilizza indirizzi privati; in N2 ha un server web WS, un server email MS, un proxy PX; il name server NS si trova nella organizzazione ISP-X; su R1 è presente un modulo NAT.*

1. *Fornire le tabelle di routing di RX e di R3 in formato simbolico. I simboli devono essere indicati sul disegno in questo foglio, che dovrà essere consegnato. Per RX occorre, ovviamente, indicare le sole righe necessarie per permettere il collegamento di OrgX.*  
2. *OrgX desidera proibire ogni comunicazione con l'esterno ad eccezione di quanto segue: gli utenti di OrgX possono inviare e ricevere email; gli utenti di OrgX possono navigare sul web server WS e possono navigare sui web server esterni attraverso PX. Elencare le regole di firewall da inserire su R1.*  
3. *Ogni nodo collegato ad N3 ha un firewall locale (cioè in esecuzione sul nodo). OrgX desidera permettere a tali nodi solo queste tipologie di traffico: navigazione web su WS; navigazione web all’esterno attraverso il proxy; invio e prelievo di email. Descrivere le regole da inserire nei firewall locali.*  
4. *Ripetere l’esercizio precedente con riferimento ai nodi collegati ad N1. Qualora una o più tipologie di traffico desiderate non siano realizzabili con questi nodi, descrivere il motivo.*

**Punto 1**

| Tabella RX |  | Tabella R3 |  |
| ----- | :---- | ----- | :---- |
| Range | Action | Range | Action |
| NetNum-OrgX | RIGHT Instrada IP-R1-LEFT | N1 | LEFT Direct |
|  |  | N2 | UP Direct |
|  |  | N3 | DOWN Direct |
|  |  | R2-R3 | NW Direct |
|  |  | Default | LEFT Instrada IP-R1-UP |

Osservazioni:

* Mettere nella tabella di routing di RX righe relative alla network interne ad OrgX è un errore grave: ogni organizzazione infatti esegue il subnetting in maniera completamente autonoma, senza informare l’organizzazione (in questo caso lo ISP) dalla quale ha acquistato il proprio network number.   
* Omettere dalla tabella di routing di RX la riga per NetNum(OrgX) è un errore grave: se RX non sa come instradare i pacchetti indirizzati a NetNum(OrgX) allora OrgX è completamente scollegata da Internet.  
  * La riga di cui sopra non può essere specificata come “default” (“altrimenti”): ciò assumerebbe che ISP ha allocato tutti gli indirizzi IP che ha acquistato e può quindi instradare il network number di OrgX con una regola “altrimenti” (questa è una ipotesi poco realistica e comunque uno la potrebbe anche fare ma se la fa deve scriverla).  
  * Mettere DIRECT come azione del range NetNum(OrgX) è un errore: ciò significherebbe che RX può inviare direttamente un frame ad ogni nodo di OrgX.  
* La tabella di routing di R3 deve includere la network R1-R3: a lezione abbiamo detto che si può omettere la network di collegamento tra una organizzazione ed il proprio ISP (quindi, in questo caso, la network tra RX ed R1), non che si possono omettere tutte le network PPP.

  **Punto 2**

| IP-src \= IP-MS && port-src \= 25 | Ricezione email (SMTP entrante) |
| :---- | :---- |
| IP-dst \= IP-MS && port-dst \= 25 |  |
| IP-src \= IP-MS && port-dst \= 25 | Invio email (SMTP uscente) |
| IP-dst \= IP-MS && port-src \= 25 |  |
| IP-src \= IP-PX && port-dst \= 80 | Navigazione web solo proxy (HTTP uscente) |
| IP-dst \= IP-PX && port-src \= 80 |  |
| IP-dst \= IP-NS && port-dst \= 53 | DNS uscente |
| IP-src \= IP-NS && port-src \= 53 |  |


  Ho omesso https per semplicità.

  Mettere in questa configurazione delle regole “HTTP entrante verso WS” è un errore grave: l’accesso a WS per gli utenti dell’organizzazione non passa dal firewall sulla frontiera.

  **Punto 3**  

| IP-dst \= IP-MS && port-dst \= 110 | Prelievo email (POP uscente) |
| :---- | :---- |
| IP-src \= IP-MS && port-src \= 110 |  |
| IP-src \= IP-MS && port-src \= 25 | Invio email (SMTP uscente) |
| IP-dst \= IP-MS && port-dst \= 25 |  |
| IP-dst \= IP-WS && port-dst \= 80 | Navigazione web solo web server (HTTP uscente) |
| IP-src \= IP-WS && port-src \= 80 |  |
| IP-dst \= IP-PX && port-dst \= 80 | Navigazione web solo proxy (HTTP uscente) |
| IP-src \= IP-PX && port-src \= 80 |  |
| IP-dst \= IP-NS && port-dst \= 53 | DNS uscente |
| IP-src \= IP-NS && port-src \= 53 |  |

  Osservazioni

* Le due coppie di regole per HTTP uscente possono essere espresse in maniera più compatta con una sola coppia di regole, usando opportunamente l’operatore logico OR. La coppia di regole per il web server avrebbe potuto essere omessa in quanto il web server sarebbe stato raggiungibile attraverso il proxy.  
* Risolvere questo punto dicendo “le regole sui firewall locali sono le stesse di quelle sul firewall di frontiera” è un grave errore in quanto le tipologie di traffico che attraversano i due firewall sono completamente diverse. Per convincersene rapidamente basta osservare che nei due casi i server si trovano da parti opposte rispetto ai firewall (ad esempio MS è interno rispetto al firewall di frontiera ed esterno rispetto al firewall locale).  
  * Mettere nei firewall locali le stesse regole del firewall di frontiera con l’aggiunta di ulteriori regole non cambia l’osservazione precedente.

  **Punto 4** Svolgimento identico al punto precedente.

Dire che il solo traffico permesso è il traffico DNS (perché sui router interni non c’è NAT quindi da N1 che ha network number privato non si possono contattare i server in quanto essi hanno indirizzi pubblici) significa non avere capito gli indirizzi privati: all’interno di una organizzazione non c’è nessuna differenza tra indirizzi pubblici ed indirizzi privati.

## Firewall (frontiera e locali) - 1

*Un'organizzazione consiste di due sedi distinte e geograficamente lontane, collegate ad Internet attraverso Internet Provider diversi e strutturate come in figura (R=router, S=switch, A=access point). L’organizzazione ha un server DNS ed un mail server collegati ad S2, un proxy ed un web server collegati ad SB. Ogni switch ha 60 porte. La zona di copertura di ogni access point può contenere al massimo 47 nodi. Gli indirizzi sono allocati staticamente per i router ed i server (proxy compreso) e dinamicamente per tutti gli altri nodi.*

*L’amministratore desidera permettere **solo** le tipologie di traffico seguenti:*

1. *i nodi nella sede sinistra possono accedere direttamente al web server dell’organizzazione ed attraverso proxy ai web server esterni (solo HTTP);*  
2. *l’organizzazione può scambiare mail con altre organizzazioni.*

*Descrivere le regole di firewall da inserire su RA; su R1; sui desktop degli utenti nella parte sinistra; sui desktop degli utenti nella parte destra. Si assuma che tutti i desktop siano configurati con l’indirizzo IP del proxy (non con il suo nome).*

Le connessioni attraverso RA da permettere sono le seguenti:

* dal proxy verso qualsiasi web server esterno;   
* dai nodi della parte sinistra verso il name server  
  (necessario per risolvere il nome del web server e del mail server);  
* dai nodi della parte sinistra verso il mail server (SMTP, POP);

Le tabelle seguenti associano ad ogni coppia di regole un nome. Questo nome non ha alcun significato per i firewall ma può essere utile per la comprensione da parte degli operatori umani e per esprimere tali regole in maniera implicita e sintetica (solo tra operatori umani). Il nome è scelto in base alla convenzione più comune e più facilmente comprensibile, quella in cui la posizione del processo server è riferita alla porzione protetta dal firewall (“entrante” significa che il server si trova in tale porzione, “uscente” significa che si trova all’esterno e all’interno della porzione protetta c’è il client).

| IP-src | IP-dst | port-src | port-dst | nome |
| :---- | :---- | :---- | :---- | :---- |
| IP-PX |  |  | 80 | HTTP uscente, solo per il proxy |
|  | IP-PX | 80 |  |  |
|  | IP-NS |  | 53 | DNS uscente |
| IP-NS |  | 53 |  |  |
|  | IP-MS |  | 25 or 110 | SMTP/POP uscente |
| IP-MS |  | 25 or 110 |  |  |

Le connessioni attraverso R1 da permettere sono le seguenti:

* da qualsiasi nodo verso il mail server, SMTP  
  (necessario per potere ricevere email da altre organizzazioni);  
* da mail server verso qualsiasi mail server, SMTP  
  (necessario per potere inviare email da altre organizzazioni);  
* dai soli nodi della parte sinistra verso il mail server, POP  
  (necessario per potere prelevare email dalla mailbox);  
* da qualsiasi nodo verso il name server;  
* dal name server verso qualsiasi nodo  
  (necessario per potere risolvere nomi di altre organizzazioni);

| IP-src | IP-dst | port-src | port-dst | nome |
| :---- | :---- | :---- | :---- | :---- |
|  | IP-MS |  | 25 | SMTP entrante |
| IP-MS |  | 25 |  |  |
| IP-MS |  |  | 25 | SMTP entrante |
|  | IP-MS | 25 |  |  |
| IP in netnum(left) | IP-MS |  | 110 | POP entrante, solo per client nella parte sinistra |
| IP-MS | IP in netnum(left) | 110 |  |  |
|  | IP-NS |  | 53 | DNS entrante |
| IP-NS |  | 53 |  |  |
| IP-NS |  |  | 53 | DNS uscente, solo per il name server |
|  | IP-NS | 53 |  |  |

Le connessioni dai desktop della parte sinistra da permettere sono le seguenti:

* verso il name server;  
* verso il mail server (SMTP, POP);  
* verso il proxy;  
* verso il web server;

| IP-src | IP-dst | port-src | port-dst | nome |
| :---- | :---- | :---- | :---- | :---- |
|  | IP-NS |  | 53 | DNS uscente |
| IP-NS |  | 53 |  |  |
|  | IP-MS |  | 25 or 110 | SMTP/POP uscente |
| IP-MS |  | 25 or 110 |  |  |
|  | IP-PX or IP-WS |  | 80 | HTTP uscente, verso proxy e web server |
| IP-PX or IP-WS |  | 80 |  |  |

Le connessioni dai desktop della parte destra da permettere sono le seguenti:

* verso il name server;  
* verso il mail server (SMTP, POP);

| IP-src | IP-dst | port-src | port-dst | nome |
| :---- | :---- | :---- | :---- | :---- |
|  | IP-NS |  | 53 | DNS uscente |
| IP-NS |  | 53 |  |  |
|  | IP-MS |  | 25 or 110 | SMTP/POP uscente |
| IP-MS |  | 25 or 110 |  |  |

## Firewall (frontiera e locali) - 2

*Una organizzazione consiste di due sedi distinte e geograficamente lontane, collegate ad Internet attraverso Internet Provider diversi e strutturate come in figura (R=router, S=switch, A=access point). L’organizzazione ha un server DNS, un proxy ed un web server collegati ad S1; un mail server collegato a SB. Gli indirizzi sono allocati staticamente per i router ed i server (proxy compreso) e dinamicamente per tutti gli altri nodi.*![][image4]  
   
*L’amministratore desidera permettere solo le tipologie di traffico seguenti: i nodi nella sede destra possono accedere direttamente al web server dell’organizzazione; i nodi di entrambe le sedi possono navigare su web attraverso proxy (solo HTTP); l’organizzazione può scambiare mail con altre organizzazioni. Descrivere le regole di firewall da inserire su RC; su R1; sui desktop degli utenti nella parte sinistra; sui desktop degli utenti nella parte destra. I simboli devono fare riferimento al disegno in questo foglio, che deve essere consegnato.*

Premesse:

* “Scambiare email con altre organizzazioni” significa che deve essere possibile inviare email verso altre organizzazioni e ricevere email inviati da altre organizzazioni.  
* Ogni volta che viene creata una mailbox, l’utente che ne è proprietario deve avere una qualche possibilità per accedere al contenuto della mailbox. Pertanto una qualche forma di accesso via POP deve essere permessa (altrimenti la mailbox è inutilizzabile).

Si descrivono le sole connessioni da permettere con le convenzioni esposte nelle slide e ripetute nello svolgimento dell’esercizio precedente (in un esame occorre scrivere, per ognuna delle connessioni indicate, la corrispondente coppia di regole come indicato in vari esercizi svolti).

Le connessioni attraverso R1 da permettere sono le seguenti:

* dal proxy verso qualunque web server; (HTTP uscente, dal proxy)  
* dai nodi della parte sinistra verso il proxy (HTTP entrante, verso il proxy);  
* dai nodi della parte destra verso il mail server (POP uscente e SMTP uscente, verso il mail server);  
* da qualunque indirizzo IP verso il name server (DNS entrante, verso il name server);  
* dal name server verso qualsiasi name server (DNS uscente, dal name server);

Le connessioni attraverso RC da permettere sono le seguenti:

* dai nodi della parte sinistra verso il name server; (DNS uscente, verso il name server)  
* dai nodi della parte sinistra verso il proxy; (HTTP uscente, verso il proxy)  
* dai nodi della parte destra verso il mail server (POP ~~uscente~~ entrante, verso il mail server);  
* da qualunque mail server IP verso il mail server (SMTP entrante, verso il mail server);  
* dal mail server verso qualunque mail server (SMTP uscente, dal mail server);

Le connessioni sui desktop della parte sinistra da permettere sono le seguenti:

* verso il proxy; (HTTP uscente)  
* verso il mail server (POP uscente e SMTP uscente);  
* verso il name server (DNS uscente);

Le connessioni sui desktop della parte destra da permettere sono le stesse di quelle dei desktop della parte sinistra con in più:

* verso il web server (HTTP uscente)

# Security

## HTTPS 1

*Il documento https://xxx.com/i.html contiene l’immagine di URL relativo i1.gif, l’immagine di URL assoluto https://zzz.com/i2.gif, l’immagine di URL assoluto http://y.com/i1.gif. (si assuma che il prelievo di risorse http con referrer https sia effettivamente possibile).*

1. *Scrivere in dettaglio la sequenza di richieste e risposte http/https inviate e ricevute dal browser. Per ogni richiesta occorre indicare il nome del server ed il numero di porta del server a cui è inviata.*  
2. *Stimare, motivando la risposta, il numero di connessioni TCP necessarie per la visualizzazione completa di https://xxx.com/i.html ed il numero di chiavi private diverse utilizzate dal browser per effettuare questa visualizzazione.*  
3. *Con riferimento ad una connessione TLS scelta dallo studente, tra quelle nell’esecuzione qui considerata, descrivere la sequenza di messaggi trasmessi e ricevuti dal browser per la creazione della connessione TLS. La descrizione deve comprendere anche un possibile contenuto per KeySet e TrustSet di browser e server.*  
4. *Con riferimento ad una coppia request-response TLS scelta dallo studente, descrivere in dettaglio il pacchetto IP che trasporta la request ed il pacchetto IP che trasporta la response, indicando chiaramente le porzioni crittate e le porzioni non crittate.*

**Punto 1\.** I documenti da prelevare automaticamente quando si preleva  *https://xxx.com/i.html* sono tutti quelli il cui URL è indicato nel testo (si tratta infatti di immagini). Il corrispondente traffico è indicato nella tabella seguente. La colonna più a destra indica il nome del server ed il numero di porta corrispondente.

Si noti che la coppia 3-4, corrispondente all’URL relativo i1.gif, è prelevata con https, non con http. Infatti, un URL relativo all’interno di un documento D identifica un documento che deve essere prelevato con lo stesso protocollo con cui è stato prelevato D (il documento si trova inoltre sullo stesso server su cui si trova D).

| 1 | GET i.html Accept-Language: en,it User-Agent: … Host: xxx.com … \<L.V.\>  | xxx.com443 |
| :---- | :---- | :---- |
| 2 | 200 OK Content-Type: text/html Content-Length: l1 Set-Cookie: id=x-id … \<L.V.\> *Documento* |  |
| 3 | GET i1.gif Cookie: id=x-id … \<L.V.\> | xxx.com443 |
| 4 | 200 OK Content-Type: image/gif Content-Length: l2 … \<L.V.\> *Documento* |  |
| 5 | GET i2.gif … \<L.V.\> | zzz.com443 |
| 6 | 200 OK Content-Type: image/gif Content-Length: l3 Set-Cookie: id=z-id … \<L.V.\> *Documento* |  |
| 7 | GET i1.gif … \<L.V.\> | y.com80 |
| 8 | 200 OK Content-Type: image/gif Content-Length: l4 Set-Cookie: id=y-id … \<L.V.\> *Documento* |  |

**Punto 2**. La tabella seguente riassume i documenti prelevati dal browser.

| Nome server | Numero documenti prelevati con http(porta 80\) | Numero documenti prelevati con https(porta 443\) |
| :---- | :---- | :---- |
| xxx.com | 0 | 2 |
| zzz.com | 0 | 1 |
| y.com | 1 | 0 |

Pertanto il numero di connessioni TCP usate dal browser può essere stimato come segue:

* 1 o 2 verso xxx.com (i due documenti potrebbero essere prelevati nella stessa connessione o in due connessioni separate)  
* 1 verso zzz.com  
* 1 verso y.com

Totale 3 o 4 connessioni TCP. Questa stima non tiene conto delle eventuali connessioni TCP stabilite con il name server (eventuali perché il traffico DNS è in pratica effettuato su UDP).

Se volessimo (o dovessimo) tenere conto anche delle connessioni TCP con il name server, allora sarebbe necessario aggiungere alla stima anche un numero di connessioni da 1 a 3: il numero di nomi da risolvere è 3, quindi il massimo è 3; il minimo si ha quando tutti i RR necessari sono ottenuti con una sola connessione TCP.

Il numero di chiavi private diverse usate dal browser è uguale al numero di connessioni TCP verso la porta 443, quindi non può essere determinato con certezza. La stima è quindi un minimo di 2 e un massimo di 3\.

**Punto 3** Con riferimento alla coppia 1-2 il traffico tra browser e server per la creazione della connessione TLS sarebbe stato il seguente (sinistra inviato dal browser, destra inviato dal server), dove K indica la chiave privata scelta dal browser.

| xxx.com |  |
| :---- | :---- |
|  | \<subject \= “xxx.com”, KPUB= “kpub-x”, issuer \= “CA-X”, F’ \> |
| Encrypt\_kpub-x(K) |  |

Un possibile contenuto di KeySet e TrustSet (cioè un contenuto compatibile con il testo dell’esercizio) è il seguente:

|  | KeySet | TrustSet |
| :---- | :---- | :---- |
| Browser | \<subject \= “CA-X”,KPUB= “kpub-ca-x”,issuer \= “CA-X”, FX \> | \<subject \= “CA-X” KPUB= “kpub-ca-x” issuer \= “CA-X”, FX \> |
| Server | \<subject \= “CA-X”,KPUB= “kpub-ca-x”, issuer \= “CA-X”, FX \> | \<subject \= “CA-X”,KPUB= “kpub-ca-x” issuer \= “CA-X”, FX \> |

In altre parole, il browser deve potere utilizzare il certificato presentato dal server (il server deve ovviamente potere usare il certificato che presenta agli altri).  
**Punto 4\.** Consideriamo la coppia 1-2. I pacchetti IP corrispondenti hanno la forma seguente:

| *IP-src* | *IP-dst* | *protocol* | *TCP header* | *payload* |
| :---- | :---- | :---- | :---- | :---- |
| IP-browser | IP(xxx.com) | TCP | TCP header | GET i.htmlCR-LFAccept-Language: en,itCR-LFUser-Agent... |
| IP(xxx.com) | IP-browser | TCP | TCP header | 200 okCR-LFContent-type:text/htmlCR-LFCon... |

La prime 3 colonne sono una descrizione semplificata dello header IP (gli altri campi, come ad esempio TTL, non sono rilevanti ai fini di questo esercizio). Le altre 2 colonne descrivono il payload del pacchetto.

La sola parte crittata è la colonna payload, cioè il payload di TCP.

La colonna header TCP contiene informazioni che non sono parte del programma di questo corso ed avrebbe potuto essere omessa. Inserirla è meglio in quanto dimostra di avere capito che viene crittato non il payload di IP bensì il payload di TCP.

La colonna payload contiene il traffico HTTP. I simboli CR-LF indicano la coppia di byte che rappresentano la fine linea di testo: presenti nella realtà, nello svolgimento di un esame possono essere omesse.

### Osservazioni

* In questo esercizio la stima delle connessioni avrebbe potuto essere ottenuta sulla base del solo numero dei documenti prelevati da ogni server, senza tenere conto del protocollo. In generale, comunque, è necessario tenere conto anche del protocollo. Ad esempio, se i documenti prelevati da xxx.com fossero stati 2, come in questo esercizio, ma invece di essere prelevati entrambi con https fossero stati prelevati 1 con http e 1 con https, allora la stima basata solo sul numero di documenti sarebbe stata “1 o 2”; tale stima però non sarebbe stata sufficientemente accurata, in quanto il numero di connessioni con xxx.com  sarebbe stato certamente 2,   
* La stima minima delle connessioni con il name server avrebbe potuto essere anche 0, in caso di RR presenti nella cache del browser. Questa stima non sarebbe però stata molto realistica, in quanto il testo non menziona attività precedenti da parte del browser. Ipotizzare che proprio i RR di quei 3 nomi era presente sarebbe stato un pò forzato.  
* Il testo chiedeva di descrivere il traffico per la creazione della connessione TLS. Ciò si riferisce al traffico per lo scambio della chiave privata. Quindi una cosa banalissima e brevissima (almeno nella versione “idealizzata e semplificata” di TLS che vediamo noi). Non si riferisce al traffico HTTP successivo. Non si riferisce alle azioni eseguite dal browser per validare il certificato. Fornire informazioni non richieste raramente è utile; quasi sempre è una perdita di tempo; talvolta è un danno (quando si scrivono imprecisioni o errori).  
* KeySet e TrustSet di browser e server potrebbero contenere altri elementi. Il testo non fornisce informazioni sufficienti per determinare se ci sono e quali sono. Metterli non sarebbe stato sbagliato ma sarebbe stato inutile.  
* Nella realtà una parte del payload TCP non è crittato ma questo è un dettaglio che non si vede neanche a Reti II.

## Firma digitale 1

*L’Università intende dotarsi di una infrastruttura informatica per lo scambio di documenti con firma digitale. Gli utenti del sistema sono i dipendenti, i contrattisti, gli studenti. Ogni utente può fare certificare la propria chiave pubblica da una Certification Authority di proprio gradimento. Ogni utente ha a disposizione un certificato con Subject \= Issuer \= “Rettore Università di Trieste”.*

*Ogni utente deve essere in grado di apporre la propria firma ad un file e di verificare la firma apposta da un altro utente.*

*L’utente U1 riceve un file D firmato dall’utente U2 (cioè D ha una indicazione del fatto che è stato firmato da “U2”. U1 non possiede il certificato di U2 (cioè il certificato con Subject=”U2”).*

*Si considerino le situazioni seguenti (situazioni mutuamente esclusive, non situazioni che si verificano in sequenza).*

1. *U1 riceve da una persona mai vista prima una chiavetta USB contenente solo un certificato con \<Subject \= “U2”, KPUB \= “K1”, Issuer \= “U2”\>. La verifica della firma su D operata con questo certificato ha successo. U1 può concludere che D è stato firmato da U2 ? In caso affermativo elencare le ipotesi necessarie; in caso negativo motivare la risposta.*  
2. *Ripetere l’esercizio precedente nel caso in cui la chiavetta USB sia stata consegnata personalmente dal Direttore del Dipartimento che assicura verbalmente “la chiavetta contiene il certificato di U2”.*  
3. *U1 riceve da una persona mai vista prima una chiavetta USB contenente solo un certificato con \<Subject \= “U2”, KPUB \= “K1”, Issuer \= “Rettore Università di Trieste”\>. Si elenchino in dettaglio le operazioni necessarie per verificare la firma su D.*  
4. *U1 riceve da una persona mai vista prima una chiavetta USB contenente solo un certificato con \<Subject \= “U2”, KPUB \= “K3”, Issuer \= “Autorità Portuale”\>. Si elenchino le informazioni che devono essere note a U1 affinché per U1 sia possibile verificare la firma su D.*

*Si assuma che non esistano problemi di compatibilità sul formato dei documenti.*

**Punto 1** U1 verifica la firma con un certificato self-signed. Chiunque può generare un certificato self-signed per qualunque Subject. Pertanto, U1 non ha alcun elemento per garantire l’autenticità del certificato.

U1 può concludere che D è stato veramente firmato da U2 se e solo se il certificato è autentico (K1 è veramente la chiave pubblica di U2). 

**Punto 2** Esattamente identico al punto 1\.

L’identità di chi consegna il certificato self-signed è irrilevante ai fini delle delle ipotesi da effettuare e delle garanzie matematiche che discendono da tali ipotesi. Tale identità può essere utile ad U1 per decidere se assumere che l’ipotesi sia vera (certificato self-signed è autentico) o no. Se assume l’ipotesi vera, allora deve necessariamente concludere che D è stato firmato da U2. Se assume l’ipotesi falsa (certificato self-signed non è autentico), allora deve necessariamente concludere che D non è stato firmato da U2.

**Punto 3** Per verificare la firma su D è necessario potere utilizzare il certificato sulla chiavetta USB. Indichiamo tale certificato con C. Le operazioni da fare sono le seguenti:

1. Verificare che “Rettore Università di Trieste” sia presente nel KeySet e nel TrustSet di U1.  
2. Verificare che il certificato nella chiavetta USB sia autentico e integro. Tale verifica viene effettuata verificando la firma nel certificato con la KPUB di “Rettore Università di Trieste” (contenuta nel KeySet di U1).  
3. Verificare la firma su D, usando la KPUB in C.

Se una delle verifiche ai punti 1 e 2 non ha esito positivo allora U1 non può verificare la firma su D. In tal caso U1 non può concludere nulla sul Subject che ha firmato D: non ha elementi per concludere che abbia firmato U2 e non ha elementi per concludere che non abbia firmato U2.

**Punto 4** identico al punto 3, sostituendo “Rettore Università di Trieste” con “Autorità Portuale”.

L’eventuale presenza di “Autorità Portuale” nel TrustSet di U1 implica che U1 considera vere le associazioni Subject-KPUB certificate dal Subject “Autorità Portuale”.

L’eventuale presenza di “Autorità Portuale” nel KeySet di U1 implica che U1 considera autentico e integro il certificato self-signed con Subject=Issuer=“Autorità Portuale” nel proprio KeySet.

## HTTPS 2

*Un browser B è configurato come segue:*  
*PersonalSet \= \[ \<S=U, K=KPUBU, I=CAX\> \],*  
*KeySet \= TrustSet \= \[ \<S=I=CAX, K=KPUBX\> \<S=I=CAY, K=KPUBY\> \] (S significa Subject, I significa Issuer).*

*Il server a1.org è configurato per richiedere autenticazione mutua HTTPS (TLS) ed è certificato da CAX, il cui sito web è https://www.cax.com.*

*Il server a2.org è configurato per non richiedere autenticazione mutua HTTPS ed è certificato da CAY, il cui sito web è https://www.cay.com.*

*B visualizza il documento D1 https://a1.org/index.html. L’utente di B clicka su un link di D1 che riferisce il documento D2 https://a2.org/index.html e B visualizza D2.*

1. *Descrivere un possibile contenuto per PersonalSet, KeySet, TrustSet di a1.org, a2.org, www.cax.com, www.cay.com.*  
2. *Con riferimento alla interazione sopra descritta:*  
   * *Determinare il numero di verifiche di firma digitale effettuato da B, a1.org, a2.org, www.cax.com, www.cay.com, motivando brevemente il conteggio fornito.*  
   * *Elencare tutte le chiavi per crittografia a chiave privata utilizzate, specificando per ognuna per cosa è usata e da chi: B, a1.org, a2.org, www.cax.com, [www.cay.com](http://www.cay.com).*  
   * *Descrivere “con un sufficiente livello di dettaglio” il frame inviato da B per trasmettere la prima HTTP request. La descrizione dovrà evidenziare le porzioni crittate indicando quale delle chiavi precedentemente descritte è stata utilizzata.*

I server www.cax.com e www.cay.com non sono mai contattati durante l’interazione ed il testo non fornisce nessuna informazione utile per descrivere il contenuto degli insiemi in questi server (che può quindi essere specificato a piacere). Tali server, pertanto, saranno omessi in questa risposta ed in quelle seguenti.

**Punto 1**

a1.org:

* PersonalSet \[ KPriv-1, \<S=a1.org, K=Kpub-1, I=CAX\>  \] (è certificato da CAX)  
* KeySet \= TrustSet=\<S=I=CAX,K=KPUB-X\> (deve potere usare il certificato del client)

a2.org:

* PersonalSet \[ KPriv-2, \<S=a2.org, K=Kpub-2, I=CAY\> \] (è certificato da CAY)  
* KeySet \= TrustSet=\[ \<S=I=CAY,K=KPUB-Y\>

Osservazioni:

* Le chiavi pubbliche nei PersonalSet sono sempre memorizzate sotto forma di certificato (se a1.org avesse una chiave pubblica senza certificato, cosa invierebbe ai browser?). Da un altro punto di vista, una chiave pubblica è sempre associata ad un Subject e tali associazioni sono sempre memorizzate in un certificato.  
  * Il subject “www.cax.com” è diverso dal subject “cax” (sarebbe come dire che il web server “www.unicredit.it” può presentare un certificato con subject “unicredit”). Quindi specificare il PersonalSet di “www.cax.com” con un certificato per il subject “cax” è sbagliato.  
  * Specificare il PersonalSet di www.cax.com e www.cay.com lasciandone vuoti (non specificati) i KeySet e TrustSet sarebbe sbagliato. Almeno la CA che ha rilasciato il certificato nel PersonalSet deve essere inserita nel KeySet e TrustSet.  
  * Dire che a1.org e/o a2.org hanno PersonalSet vuoto è un errore molto grave: hanno un sito web https, quindi il loro PersonalSet deve contenere le rispettive coppie chiave privata-chiave pubblica.  
  * Mettere nel KeySet e TrustSet di B il certificato ricevuto da a1.org o a2.org significa non avere capito cosa sono questi due insiemi: ciò infatti corrisponderebbe ad utilizzare ogni certificato emesso da a1.org o a2.org, il che non ha senso (sarebbe come dire che ogni volta che visitiamo un sito web con https quel sito diventerebbe automaticamente una certification authority).  
    * Idem per mettere nei KeySet/TrustSet di a1.org il certificato ricevuto da B.  
    * Idem per mettere nei KeySet/TrustSet di a1.org un certificato con subject=”a1.org”.  
  * Anche se noi descriviamo i certificati senza esplicitare la presenza della firma apposta dallo Issuer, la firma è sempre presente (altrimenti sarebbe impossibile verificare autenticità ed integrità della associazione descritta nel certificato). Pertanto dire “ipotizzo che i certificati siano firmati” non ha senso: Un certificato senza firma non è un certificato. 

**Punto 2-a** B riceve due certificati, quindi deve verificare due firme digitali. a1.org riceve il certificato dell’utente quindi deve verificare una firma digitale. a2.org non verifica nessuna firma digitale.

Inoltre, B ed a1.org devono verificare anche le firme dei certificati autofirmati che utilizzano per verificare la firma dei certificati ricevuti. In dettaglio,

* quando B riceve il certificato di a1.org deve verificare la firma nel certificato autofirmato di CAX che possiede nei propri KeySet e TrustSet (conteggiare zero, una o due verifiche è equivalente, ai fini dell’esame);  
* quando B riceve il certificato di a2.org deve verificare la firma nel certificato autofirmato di CAY che possiede nei propri KeySet e TrustSet (conteggiare zero, una o due verifiche è equivalente, ai fini dell’esame);  
* quando a1.org riceve il certificato di B deve verificare la firma nel certificato autofirmato di CAX che possiede nei propri KeySet e TrustSet (idem).

Osservazioni:

* Omettere tutto ciò che segue “Inoltre” sarebbe stato considerato accettabile in un esame, a patto di avere fornito uno svolgimento corretto nel resto dell’esercizio. Ovviamente, tenere conto della parte che segue “Inoltre” solo per alcuni conteggi e non per tutti è sbagliato (o se ne tiene conto per tutti o non se ne tiene conto per nessuno).  
  * Includere nel conteggio i messaggi scambiati durante la fase iniziale della connessione TLS (per la scelta e scambio della chiave) è un errore grave: significa confondere la firma digitale con l’uso della crittografia a chiave pubblica per ottenere riservatezza.  
  * Includere nel conteggio uno dei documenti prelevati dal Browser è un errore molto grave: il traffico applicativo in una connessione TLS non ha firma digitale. Inoltre, non ha senso considerare firme solo nei documenti prelevati e non nelle richieste HTTP e header delle risposte HTTP.  
    * Quanto sopra vale anche se uno dice “assumo che D1 e D2 siano firmati”: la firma digitale non c’entra nulla con TLS; anche con quella ipotesi la verifica della firma non la farebbe il Browser ma un altro programma dopo che il Browser ha prelevato D1 e D2 (il testo richiedeva di contare le verifiche di firma fatte dal Browser).  
  * Rispondere con la sola descrizione dettagliata degli scambi TLS non è adeguato. Primo, la domanda non è “descrivere gli scambi TLS”; secondo, come fa il lettore a sapere quale subset del set di informazioni fornite contiene la risposta alla domanda? Il lettore (cioè io) sa già che la risposta è un certo subset S1, ma è impossibile sapere se per lo scrittore (cioè lo studente) la risposta è invece un subset S2 leggermente o profondamente diverso da S1.  
    * Questa osservazione è particolarmente importante anche per il punto successivo.

**Punto 2-b** Ci sono due connessioni TLS, quindi due chiavi private; una per l’interazione B-a1.org e l’altra per B-a2.org. Ognuna di queste chiavi private è utilizzata per crittare il traffico applicativo e calcolarne il MAC.

Osservazione

* Includere nel conteggio la chiave privata della coppia chiave privata-chiave pubblica è un grave errore: significa non avere letto con attenzione il testo. Le “chiavi per crittografia a chiave privata” non c’entrano nulla con la crittografia a chiave pubblica.  
  * Dire che non ci sono chiavi per la crittografia a chiave privata (perché viene usata solo la crittografia a chiave pubblica o anche senza altre spiegazioni) denota profonde ed inaccettabili lacune nella comprensione di TLS.

**Punto 2-c**

|  |  |  | Eth-Payload |  |  |  |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| **Eth-SRC** | **Eth-DST** | **Eth-Type** | **IP-SRC** | **IP-DST** | **IP-proto** | **IP-payload** |
| Eth-B | Eth-GW | IP | IP-B | IP-WS-A1 | TCP | HTTP Req |

Si sono scelti simboli auto-esplicativi e si è assunto che browser e web server appartengano a network diverse. La sola parte crittata è quella indicata come IP-payload (nella realtà lo IP-payload contiene uno header TCP ed un payload TCP, uno header TLS ed un payload TLS; la sola componente crittata è il payload TLS).

# Provetta completa

"AP" indica access point per Ethernet wireless, "SW" indica switch Ethernet, "R" indica router, "N" indica Ethernet wired. 

Org usa indirizzi pubblici solo in NA, NB, NC. In NA sono presenti un name server NS, un mail server MS, un web server WS. In ND è presente un proxy PX. Su RB è presente un modulo NAT ed un firewall.

Tutti gli indirizzi sono allocati dinamicamente, ad eccezione degli indirizzi per i router ed i server. Tutti gli applicativi client che necessitano di una configurazione sono configurati con il nome del server corrispondente (non con l’indirizzo IP).

In ogni cella wireless possono essere presenti fino a 40 nodi. Ad NA possono essere collegati fino a 40 nodi; ad NB fino a 400 (quattrocento) nodi; ad NC fino a 40 nodi; ad ND fino a 200 nodi. 

### Definizione network e tabella di routing

1. ***Disegnare su questo foglio (che dovrà essere consegnato) le network presenti in Org, assegnando un simbolo ad ognuna. Fornire la tabella di routing per RD in formato simbolico, riferendo i simboli utilizzati.***

Le network sono indicate in rosso. Le indichiamo con i simboli NA, NB, NC, ND ed NRR (per la network point-to-point tra RA ed RB). Indichiamo le interfacce dei router con i 4 simboli cardinali.

La tabella di routing per RD avrà quindi 6 righe:

| Range | Azione |
| :---- | :---- |
| NA | N IP-RB-S |
| NB | N direct |
| NC | N IP-RC-W |
| ND | S direct |
| NRR | N IP-RB-S |
| Default | N IP-RB-S |

Osservazioni:

* Omettere NRR è ovviamente un errore. Si potrebbe sostenere che la tabella di routing su RD sarebbe corretta anche senza NRR in quanto la regola di default avrebbe instradato correttamente i pacchetti destinati ad NRR. In tal caso, però, si sarebbe dovuto omettere anche NA. Mettere NA ma non NRR non convince il lettore che chi ha omesso NRR dalla tabella di routing ha capito.  
* “*E’ stata trascurata la network di collegamento con ISP e quindi la riga “altrimenti” è stata omessa*” non ha senso. Dove vanno a finire i pacchetti indirizzati verso network esterne a Org?

### Dimensione network number

2. ***Fornire la dimensione del network number che Org deve acquistare da ISP, motivando il calcolo effettuato (la dimensione deve essere la minima compatibile con lo scenario descritto).***

Gli indirizzi pubblici sono usati solo in NA, NB, NC. Per NA sono necessari 64 indirizzi IP, per NB ne sono necessari 512, per NC 64 (includere o meno i router nel conteggio è, in questo caso, irrilevante in quanto 40, 400, 40 sono “sufficientemente più piccoli” della potenza di 2 immediatamente superiore). Il totale è 64+512+64=640. Saranno quindi necessari 1024 indirizzi IP, corrispondenti ad un network number /22 (10 bit per host number).

Osservazioni:

* Un calcolo come il seguente “*40 per NA, 400 per NB, 40 per NC fanno 480; quindi ne prendo 512*” avrebbe fornito un risultato errato.  
* Il numero di nodi che possono essere presenti in ogni cella è irrilevante ai fini della determinazione della dimensione del network number pubblico da acquistare, in quanto le celle sono in una network con network number privato.  
* Il testo diceva “Org usa indirizzi pubblici solo in NA, NB, NC.”: perché usarli anche nella network tra RA ed RB? O in ND?  
* “*Ipotizzo che ISP sia proprietario di 131.114.0.0/16…il network number sarà 131.114.0.0/22*”. Io lo so che voi pensate che sono pignolo, il che è vero, ma se il testo dice “*fornire **la dimensione** del network number*” allora perché fornire un network number e fare ipotesi che sono inutili?

  Per lavorare in gruppo bisogna rispettare le specifiche. Il primo passo è comprenderle. Il passo zero è rendersi conto che la loro importanza è fondamentale.  
* Perché perdere tempo nel fare tanti calcoli e discorsi sulle network che hanno indirizzi IP privati? Sono completamente inutili ai fini dell’esercizio. Soprattutto sono dannosi: nel farli si perde tempo e lucidità. Risorse che nella vita lavorativa sono fondamentali.

### Sequenza frame trasmessi con ping

3. ***Un nodo C1 nell'area di copertura di AP1 viene acceso ed esegue il comando ping IP-NS. Descrivere la sequenza di tutti i frame trasmessi e ricevuti da C1, dal momento della sua accensione fino alla terminazione del comando.*** 

Il nodo C1 è configurato dinamicamente, quindi:

|  | dst | src | type | payload |
| :---- | :---- | :---- | :---- | :---- |
| 1 | FFFFFFFF | Eth-C1 | DHCP | DHCPDISCOVER |
| 2 | Eth-C1 | Eth-DHCP | DHCP | DHCPOFFER \+ config info |
| 3 | FFFFFFFF | Eth-C1 | ARP | ARP-REQ(Eth-C1,IP-C1,?,IP-C1) |
| 4 | FFFFFFFF | Eth-C1 | ARP | ARP-REQ(Eth-C1,IP-C1,?,IP-RD-S) |
| 5 | Eth-C1 | Eth-RD-S | ARP | ARP-RESP(Eth-RD-S,IP-RD-S,Eth-C1,IP-C1) |
| 6 | Eth-RD-S | Eth-C1 | IP | IP-C1 IP-NS ICMP | “echo request” |
| 7 | Eth-C1 | Eth-RD-S | IP | IP-NS IP-C1 ICMP | “echo reply” |

Si noti che il fatto che IP-C1 sia privato è irrilevante ai fini di questo esercizio.

Osservazioni:

* Non capisco proprio come si possa confondere ping con traceroute.  
* Omettere 3 può essere una dimenticanza, omettere 4 e 5 è un errore molto grave. Come caspita si ottiene Eth-RD-S? Uno potrebbe (forse) averli omessi assumendo che il server DHCP coincida con il default gateway (quindi l’indirizzo Ethernet del default gateway sarebbe stato il mittente del 2). Una ipotesi del genere avrebbe dovuto essere esplicitata e comunque sarebbe stata errata: C1 non avrebbe potuto sapere che il server DHCP coincide con il default gateway, quindi avrebbe dovuto fare la ARP request anche in questo caso.  
* Un Gratuitous ARP è una ARP request. Non è un altro tipo di messaggio ARP. Fare una sequenza di frame in cui il payload 3 è “Gratuitous (..” e il payload 4 è “Request (...” è sbagliato.  
* Il traffico ARP in una network che usa frame PPP non ha nessun senso.  
* Il traffico DHCP serve per ottenere la configurazione IP. L’indirizzo IP è una delle informazioni di configurazione.  
* Che senso ha una richiesta ARP “(phys-C1, IP-C1, ?, ?)” (usata come Gratuitous ARP ma questo è irrilevante)? Chi risponde a questa richiesta?  
* Indirizzare il frame 6 a Eth-Proxy e ricevere il 7 da Eth-Proxy non ha nessun senso. Per quale caspita di motivo C1 non può inviare pacchetti al name server? E per quale motivo il proxy dovrebbe instradare tali pacchetti, visto che non è un router ma un programma applicativo? E perché mai i pacchetti di risposta da NS verso C1 dovrebbero arrivare al proxy invece che a C1?

4. ***Con riferimento allo scenario del punto precedente, descrivere la sequenza di tutti i frame necessari per l’esecuzione del comando ping che non sono trasmessi o ricevuti da C1.*** 

I frame corrispondenti sono quelli in transito nelle network NB, NRR, NA. Assumendo che le cache ARP di tutti i nodi coinvolti contengano già le informazioni necessarie (ipotesi realistica in quanto i nodi in questione sono server e router, quindi nodi che molto probabilmente hanno già comunicato tra loro di recente), i frame sono i seguenti: 

|  | dst | src | type | payload |
| :---- | :---- | :---- | :---- | :---- |
| 1 | Eth-RB-S | Eth-RD-N | IP | IP-C1 IP-NS ICMP | “echo request” |
| 2 |  |  |  | IP-C1 IP-NS ICMP | “echo request” |
| 3 | Eth-NS | Eth-RA-S | IP | IP-C1 IP-NS ICMP | “echo request” |
| 4 | Eth-RA-S | Eth-NS | IP | IP-NS IP-C1 ICMP | “echo reply” |
| 5 |  |  |  | IP-NS IP-C1 ICMP | “echo reply” |
| 6 | Eth-RD-N | Eth-RB-S | IP | IP-NS IP-C1 ICMP | “echo reply” |

Nei frame 2 e 5 è stato riportato solo il payload in quanto tali frame hanno formato PPP, pertanto non contengono gli indirizzi mittente e destinatario (l’informazione di tipo è codificata in uno dei 3 byte dello header visto a lezione, ma questo dettaglio è irrilevante).

Payload indicati come identici in realtà differiscono per il valore del campo TTL nello header IP (puntualizzazione che può essere omessa).

Osservazioni:

* Non assumere che le cache ARP dei nodi coinvolti contengono già le informazioni necessarie è ugualmente corretto, ai fini dell’esame.  
* ...ma in tal caso fare inviare un Gratuitous ARP ai router non avrebbe nessun senso. Il Gratuitous ARP viene inviato non appena si acquisisce la configurazione IP; quindi, per i router, all’accensione.

  Fare uno svolgimento con router che inviano G-ARP è una dimostrazione lampante che uno fa le cose meccanicamente senza capire il perchè (“prima della ARP request devo inviare il gratuitous ARP”); il che è proprio uno dei motivi per i quali sono sempre stato riluttante nel diffondere esercizi svolti: la gente inizia a vedere gli esercizi ed “impara” il pattern delle cose da fare, senza capire il perché.  
* Se un nodo A invia una ARP request per ottenere indirizzo Ethernet di un nodo B, allora tutti i nodi della network, compreso B, inseriscono nella propria ARP cache la traduzione IP-A,Eth-A. Questo significa che se RD-UP chiede l’indirizzo Ethernet di RB-DOWN, dopo RB-DOWN non chiede l’indirizzo di RD-UP perché lo conosce già. Non ho tenuto conto di questo errore.  
* Nella network RA-RB i frame sono PPP, non Ethernet.  
* *“Non ci sono perché C1 ha indirizzo privato quindi il router scarta i suoi pacchetti”*: gravissimo, significa non avere capito gli indirizzi privati. Sono scartati solo alla frontiera, non all’interno.  
* Ormai non so più come dire che gli svolgimenti narrativi non sono adeguati per una materia come questa.

  “*i frame 1 e 2 dell’esercizio precedente non passano per il router RD; tutti gli altri frame devono invece passare per RD che trasmette frame identici modificando esclusivamente il campo Ethernet-Src ed eventualmente il campo Ethernet-Dst*”.

  “Eventualmente” in che senso? quando modifica il campo Ethernet-Dst? e cosa ci scrive?  “trasmette frame identici” a cosa? “identici” vuol dire identici, quindi il payload è immutato, quindi il TTL dello header IP non viene modificato. O no? RD invia altri frame che non c’entrano nulla con quelli dell’esercizio precedente?

### Firewall (con NAT)

5. ***Org desidera proibire ogni comunicazione con l'esterno ad eccezione di quanto segue:***  
   * ***la navigazione su web è permessa solo attraverso il proxy (http e https);***  
   * ***scambio di email con domini email esterni;***  
   * ***web server WS accessibile dall’esterno (http e https).***

   ***Descrivere le corrispondenti regole di firewall da inserire su RB.***

La prima tipologia di traffico è permessa dalle regole seguenti:

|  | IP-src | IP-dst | port-src | port-dst |
| :---- | :---- | :---- | :---- | :---- |
| 1 | IP-PX |  |  | 80 o 443 |
| 2 |  | IP-PX | 80 o 443 |  |
| 3 | IP-NS |  |  | 53 |
| 4 |  | IP-NS | 53 |  |

La seconda tipologia di traffico è permessa dalle seguenti regole (e dalle regole 3-4 sopra descritte):

|  | IP-src | IP-dst | port-src | port-dst |
| :---- | :---- | :---- | :---- | :---- |
| 5 | IP-MS |  | 25 |  |
| 6 |  | IP-MS |  | 25 |
| 7 | IP-MS |  |  | 25 |
| 8 |  | IP-MS | 25 |  |
| 9 | IP-NS |  | 53 |  |
| 10 |  | IP-NS |  | 53 |

La terza tipologia di traffico è permessa dalle regole seguenti (e dalle regole 9-10  sopra descritte):

|  | IP-src | IP-dst | port-src | port-dst |
| :---- | :---- | :---- | :---- | :---- |
| 11 |  | IP-WS |  | 80 o 443 |
| 12 | IP-WS |  | 80 o 443 |  |

Osservazioni:

* Il proxy può navigare su Internet pur avendo indirizzo IP privato grazie al modulo NAT su RB.  
* Il proxy è l’unico nodo con indirizzo privato che può comunicare con Internet, a causa dei vincoli imposti nello scenario.  
* Il testo diceva di permettere “scambio di email con domini email esterni”; molti hanno chiesto se il prelievo di email dalla mailbox rientrasse in questa tipologia di traffico; ho risposto, mi pare, a tutti chiarendo che non ci rientra; non avrei dovuto rispondere (solo che la mia rude interfaccia utente talvolta mette a disagio anche me) per un motivo molto semplice: cosa c’entra il prelievo di email dalla mailbox con i “domini email esterni”? E’ ovvio che non c’entra nulla: il prelievo di email dalla mailbox coinvolge solo utente e dominio email in cui quell’utente ha la mailbox.  
* Ovviamente, inserire una coppia di regole SMTP (invio o ricezione) ed una coppia di regole POP è sbagliatissimo.  
* Fare regole 1-2 strutturalmente identiche alle regole 11-12 è sbagliatissimo: il proxy genera traffico client, il web server genera traffico server.

#### Osservazioni su interazione NAT e firewall

Come sono disposti nel router di frontiera nat e firewall? esterno-nat-firewall-interno oppure esterno-firewall-nat-interno?

Nel primo caso i pacchetti uscenti arrivano al firewall con un indirizzo sorgente privato; nel secondo ci arrivano con un indirizzo sorgente pubblico (l'indirizzo pubblico è quello del collegamento esterno-firewall);

Nella realtà, a causa della implementazione del NAT (che non conosciamo) il caso corretto è il primo. La soluzione fornita si basa su questo caso. Il secondo caso non può funzionare (per motivi che non conosciamo; forse potrebbe funzionare con qualche accrocchio ma l'architettura corretta è la prima).

Anche se non conosciamo l'implementazione del NAT, comunque, è evidente che questo esercizio non è risolubile con il secondo caso, in quanto non si possono esprimere vincoli sugli indirizzi interni se tutti i pacchetti che passano dal firewall hanno lo stesso indirizzo per tutti i nodi interni:

* pacchetto entrante con IP-dst \= IP-router-pubblico; come distingue il firewall tra i numerosi possibili destinatari interni?  
* pacchetto uscente con IP-src \= IP-router-pubblico; come distingue il firewall tra i numerosi possibili sorgenti interni?

In parole povere, il firewall deve avere la visibilità del vero destinatario e del vero mittente (quindi non occorre imparare a memoria quale dei due casi è quello corretto; avendo capito questo punto, si disegnano i due casi e si capisce qual'è quello corretto).

### HTTPS

6. ***WS è accessibile su https con configurazione di default ed è associato al Subject “www.org-internal.it”. Un applicativo su un nodo C collegato a NC preleva con successo la home page di “www.org-internal.it” su https.***  
   * ***Descrivere un possibile contenuto per PersonalSet, KeySet, TrustSet su WS e su C.***  
   * ***Con riferimento alla richiesta DNS inviata da C per risolvere il nome “www.org-internal.it”, descrivere con il massimo dettaglio possibile il frame inviato da C che trasporta tale richiesta evidenziando chiaramente le parti crittate.***  
   * ***Con riferimento alla richiesta http inviata da C, descrivere con il massimo dettaglio possibile il frame inviato da C che trasporta tale richiesta evidenziando chiaramente le parti crittate.***

**Punto 1**. WS nella configurazione https di default significa che i client non si devono autenticare su TLS. Quindi PersonalSet su C può essere vuoto. PersonalSet su WS deve contenere la coppia chiave privata-chiave pubblica corrispondente al certificato che WS presenta a C.

Il fatto che C si colleghi con successo a WS implica che C può usare il certificato presentato da WS. Se indichiamo con CA-W la certification authority che ha emesso tale certificato, TrustSet e KeySet di CA-W devono quindi contenere un certificato self-signed di CA-W. TrustSet e KeySet di WS devono contenere lo stesso certificato.

Osservazioni:

* “*Il PersonalSet di WS potrebbe contenere il suo certificato*” è sbagliato. Non “potrebbe” ma “deve”. Inoltre, contiene anche la KPRIV.  
* Indicare la composizione dei set senza esplicitare che i certificati sono self-signed non è “pienamente corretto”.  
* Inserire nel KeySet il certificato inviato dal web server è sbagliatissimo. Il KeySet serve per verificare autenticità e integrità dei certificati ricevuti dall’esterno (contiene le chiavi pubbliche delle CA, sotto forma di certificato self-signed). Non contiene i certificati ricevuti dall’esterno.  
* ...mettere tale certificato anche nel TrustSet significa, oggettivamente, avere lacune molto estese e profonde in questa parte del programma. Lacune purtroppo non accettabili.

**Punto 2**.   
Eth-Src: Eth-CB, Eth-Dst: Eth-RC-S, Type: IP, Payload: *riga successiva*  
IP-Src: IP-C, IP-Dst: IP-NS, Type: TCP, Payload: *riga successiva*  
(header TCP omesso), Payload: www.org-internal.it A ?

Nessuna componente è crittata.

**Punto 3**.   
Eth-Src: Eth-CB, Eth-Dst: Eth-RC-S, Type: IP, Payload: *riga successiva*  
IP-Src: IP-C, IP-Dst: IP-WS, Type: TCP, Payload: *riga successiva*  
(header TCP omesso), Payload: GET / \\r\\n...Accept-Language: en,it\\r\\n\\r\\n

Il payload TCP è una richiesta HTTP. I caratteri \\r\\n indicano i caratteri che terminano una linea; la doppia ripetizione alla fine indica la linea vuota che rappresenta la terminazione della richiesta GET (ai fini degli esami la fine linea si può indicare in molti modi).

Il payload TCP è la sola componente crittata (nella realtà il payload TCP comprende uno header TLS ed un payload TLS. Solo il payload TLS è crittato).

Osservazioni

* Qualcuno è rimasto perplesso dal fatto che CB preleva la home page da WS anche se nel punto precedente si diceva che la navigazione web avveniva via proxy. Queste perplessità non avrebbero dovuto esserci perché il testo parlava di proxy con riferimento alle comunicazioni con l’esterno.  
* Svolgimento “*Il protocollo DNS generalmente non utilizza la crittografia*” senza scrivere il frame: significa non avere letto la domanda (descrivere il frame); inoltre, non è “generalmente” bensì “mai” (a meno che uno non si riferisca a cose che a lezione non abbiamo visto, sono sperimentali e conoscono pochissime persone).

# TEST

*Quando un nodo si sposta da una network ad un'altra network occorre riconfigurare le tabelle di routing nei suoi due gateway di default (quello precedente e quello successivo allo spostamento)*

La risposta corretta è Falso. Quando mai una tabella di routing dipende dalla posizione di un nodo? La tabella di routing descrive i network number, non i singoli nodi. Inoltre noi abbiamo visto il routing statico, in cui le tabelle sono immutabili.

*Un nodo con indirizzo IP privato può comunicare con nodi di altre network solo se almeno un router dai quali passano i pacchetti ha un modulo NAT*

La risposta corretta è Falso. Nodi con indirizzo privato all'interno di una stessa organizzazione comunicano "tranquillamente" tra di loro, senza necessità di NAT. Indirizzi IP privati e pubblici sono, all'interno di una stessa organizzazione, indistinguibili tra loro.

*131.114.9.128/25 può indicare sia un network number sia una coppia indirizzo IP-network number a cui appartiene quell'indirizzo IP*

La risposta corretta è falso. /25 significa che la suddivisione è nel quarto byte; 128 in binario è 1000 0000; quindi la suddivisione lascia 0 come host number; quindi non può essere un indirizzo IP.

*Un nodo che si collega ad Internet invia un frame "ARP Request" sia che abbia configurazione IP statica sia che abbia configurazione IP dinamica*

La risposta corretta è vero. Viene inviata sempre una ARP Request in cui il nodo chiede quale sia l'indirizzo Ethernet associato al proprio indirizzo IP (Gratuitous ARP), indipendente da come sia stato acquisito l'indirizzo IP.

*Condizione necessaria per potere verificare la firma digitale su un documento è che il Subject che ha firmato il documento sia compreso nell'elenco dei Subject dei certificati contenuti nel KeySet*

La risposta corretta è Falso. Tutto il marchingegno di certificati, certification authority, KeySet e TrustSet serve proprio per evitare di dovere avere già disponibile la chiave pubblica dei Subject. I Subject dei certificati contenuti nel KeySet sono solo le certification authorities.

*Condizione necessaria per potere utilizzare un certificato è che il Subject del certificato sia compreso nell'elenco dei Subject dei certificati contenuti nel TrustSet*

La risposta corretta è Falso, per gli stessi motivi di cui sopra.

[image1]: <data:image/png;base64,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>

[image2]: <data:image/png;base64,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>

[image3]: <data:image/png;base64,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>

[image4]: <data:image/png;base64,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>