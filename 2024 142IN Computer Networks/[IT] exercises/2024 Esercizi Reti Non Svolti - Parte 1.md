# Reti di Calcolatori (parte 1\) \- Esercizi non svolti

# Preparatoria (molto facili)

## Pseudocodice A

Descrivere in forma di pseudo-codice le azioni eseguite da un server. Il server deve offrire il servizio sulla porta 423 del nodo 131.114.9.81

## Pseudocodice B

Si consideri un client sul nodo 131.47.46.82. Descrivere in forma di pseudo-codice le azioni eseguite da un client per aprire una connessione con il server dell'esercizio precedente.

## DNS A

Il vostro capo vi propone di realizzare un programma per migliorare l'accesso a DNS. Il programma proposto sostituisce il supporto "originario" sul client e si comporta come segue:

* Il programma contiene una lista di 40 elementi in cui ogni elemento identifica un name server.  
* Ogni volta che è necessario contattare un name server, contatta il primo della lista; se questo non risponde, dopo un pò contatta il secondo e così via.  
* Il primo elemento della lista è un indirizzo IP inserito dall'utente in fase di configurazione. Tutti gli elementi rimanenti sono nomi di name server "robusti e affidabili" e non possono venire modificati.

Discutere se questo programma ha senso ed, eventualmente, con quali estensioni.

## EMAIL A

Si consideri un mail server che ha appena aperto una connessione SMTP.

* Si specifichi, con il massimo dettaglio possibile, una ipotetica sequenza di richieste inviate da un client da questa connessione sino alla chiusura.  
* Si descrivano, con il massimo dettaglio possibile, le corrispondenti operazioni eseguite dal server.

## EMAIL B

Avete preparato un email indirizzato a thepresident@whitehouse.gov. Descrivere sinteticamente le operazioni effettuate dal vostro mail client per inviare quel messaggio.

## WEB A

Con riferimento al protocollo HTTP, descrivere formato e possibile utilizzo di almeno due request header e almeno due response header.

## WEB B

Scrivere (eventualmente in modo "approssimato") un semplice form HTML che richiede all'utente il proprio nome, cognome ed età e li invia al web server associati alle variabili Name, Surname, Age, rispettivamente.

Sia X l'URL del documento che contiene il form e sia S(X) il nome dns identificato da X. I dati devono essere elaborati dal programma /cgi-bin/pippo.exe sul nodo S(X).

## WEB C

Descrivere l'utilizzo dei Cookie per il mantenimento delle sessioni HTTP.

## WEB D

Pippo è collegato ad un servizio di Vendita Caffettiere On-Line. Il servizio opera su HTTP. Gambadilegno intercetta tutti i messaggi inviati da Pippo, ma nessun messaggio inviato dal servizio. Gambadilegno salva tutti i messaggi inviati da Pippo in un file binario Pippo.log.

Descrivere un algoritmo, in forma di pseudocodice, per analizzare quei messaggi ed evidenziare le linee del file Pippo.log che potrebbero contenere un numero di carta di credito, una password o altre informazioni “interessanti”. L’algoritmo deve basarsi solo su analisi della struttura delle richieste HTTP, deve cioè indicare quali elementi di una richiesta HTTP sono indicativi della possibile presenza in quella stessa richiesta di informazioni “interessanti” per Gambadilegno..

## WEB E

Scrivere un semplice form HTML che richiede all'utente il proprio nome, cognome e età; i dati forniti dall'utente devono essere elaborati dal server con il programma bonifico.asp.

## WEB F

Descrivere in dettaglio le azioni eseguite dal browser tra il momento in cui l’utente decide di inviare i dati del form ed il server risponde. Si indichino, in particolare:

1. Contenuto di HTTP Request e HTTP Response

2. Come fanno browser (e server) a capire quale programma deve elaborare i dati forniti dall’utente.

# Assegnati ad esami

## A

L'utente x@p.com invia un messaggio email diretto a y@q.com. L'infrastruttura DNS contiene gli RR indicati a fianco.

p.com                	MX     	mail.p.com

x.p.com             	A         	IP1

mail.p.com       	CNAME		mail.q.com

q.com                	MX     	mail.q.com

y.q.com             	A         	IP4

mail.q.com      		A         	IP5

1. Descrivere una possibile transazione SMTP originata dal mail client dell’utente mittente.  
2. Con riferimento al punto 1, elencare il traffico DNS trasmesso o ricevuto dal mail client del mittente.  
3. Descrivere una possibile transazione POP originata dal mail client dell’utente ricevente.  
4. Con riferimento al punto 3, elencare il traffico DNS trasmesso o ricevuto dal mail client del ricevente.

## C

Un utente desidera inviare un messaggio email. Il mittente ha indirizzo anastasi@cs.acm.org, il destinatario ha indirizzo gregori@cnuce.cnr.it.

Si descriva l’interazione SMTP eseguita dal mail client del mittente per inviare il messaggio. La descrizione deve specificare anche il mail server che partecipa a questa interazione ed il modo con il quale il mail client ottiene l’indirizzo IP di questo server.

## D

Gli esercizi seguenti fanno riferimento a programmi client (mail client, browser) in esecuzione su di un nodo C con indirizzo IP 131.114.9.252 configurati come segue:

![][image1]

Configurazione del nodo

![][image2]![][image3]

Configurazione del mail client

![][image4] ![][image5]

Configurazione del browser

L’utente X prepara un email E il cui contenuto consiste di 4 linee di testo. Gli header di E includono i seguenti:

![][image6]

1. Descrivere i messaggi che il nodo C scambia con il DNS tra il momento in cui X preme il tasto “Send” ed il momento in cui il mail client visualizza l’indicazione “Message sent”.

2. Descrivere la transazione SMTP iniziata dal mail client di X per inviare E, in particolare, indicando quale entità si trova all’altra estremità della connessione TCP.

3. Determinare il numero di RR presenti nel name server della zona kelys.com che contengono la stringa “Cirello”, motivando brevemente la risposta.

4. Si scriva un possibile form HTML che viene visualizzato dal browser come nella figura in basso (**omettere l’elemento HTML contenente il menu drop-down: non abbiamo visto come si fa**).

5. Si descriva il contenuto della HTTP Request inviata dal browser quando l’utente preme il bottone “Log in” (dopo avere inserito la password, non visualizzata in figura).

6. Si descriva una possibile HTTP Response inviata dal server.

7. La casella “Use a proxy server” nella figura in alto è selezionata. Ripetere gli esercizi 2 e 3, assumendo che la casella “Use a proxy server” **non** sia selezionata.

![][image7]

## E

![][image8]

1. Si scriva un form HTML che descriva (anche in maniera approssimata) l’immagine qui sopra.

2. Si descriva in dettaglio una possibile HTTP Request inviata dal browser coerente con il form descritto al punto precedente. Si assuma che l’utente inserisca come web account “pippo” e come password “cevapcici”.

3. Assumendo che, nel caso in cui l’autenticazione abbia successo, il server inserisca nella sessione “authenticated=yes”, si descriva una possibile HTTP response inviata dal server nel caso in cui l’autenticazione abbia successo.

## F

Il web server di nome www3.oup.co.uk esporta i propri documenti nello scenario seguente:

* L’amministratore del web server desidera proteggere l’accesso alle proprie risorse in questo modo: i documenti con estensione htm oppure html devono essere leggibili da chiunque; i documenti con estensione pdf devono essere leggibili solo agli utenti Crespo e Ronaldo; i documenti con estensione doc devono essere leggibili solo agli utenti Crespo e Luigi.

* Tutti gli utenti di questo web server navigano su web attraverso un proxy http di nome x.company.com (lo stesso proxy per tutti gli utenti)

1. Si descriva un insieme di realm in grado di soddisfare i requisiti precedenti (eventuali ipotesi necessarie per la formulazione della risposta devono essere descritte in modo esplicito).  
2. L’utente Crespo accede alle risorse nuovo.htm, prova.doc, nuovo.doc in quest’ordine (tutte le risorse si trovano sul web server in esame). Si descriva la sequenza di richieste e risposte http ricevute e trasmesse, rispettivamente, dal web server relativamente a questi accessi.  
3. Ripetere il punto 2 per l’utente Ronaldo e la stessa sequenza di accessi.

Ripetere l’intero esercizio sostituendo l’ultimo requisito con: L’utente Crespo naviga su web attraverso un proxy di nome x.company.com, tutti gli altri utenti del web server navigano su web attraverso un altro proxy di nome y.someothercompany.com.

Ripetere l’intero esercizio sostituendo  l’ultimo requisito con: L’utente Crespo naviga su web attraverso un proxy di nome x.company.com, nessuno degli altri utenti del web server naviga su web attraverso proxy.

## G

La società company ha un web server di nome www.company.uk. Questa società ha inserito delle immagini pubblicitarie nella home page index.html dei web server di altre società: www.c1.it, www.c2.it, www.c3.it. Tali immagini sono inserite sotto forma di link (cioè, clickando sulla immagine viene prelevata la home page di [www.company.uk](http://www.company.uk)). Ognuna di queste immagini risiede sul sito [www.company.uk](http://www.company.uk).

1. Descrivere come può essere realizzato, nei documenti index.html citati, il link descritto.

2. Descrivere se, ed eventualmente come, il web server www.company.uk può determinare una classifica dei migliori investimenti pubblicitari (cioè, come può contare il numero di accessi al sito “provocati” dai siti sui quali si è fatta della pubblicità).

3. Descrivere se, ed eventualmente come, il web server www.company.uk può determinare se un utente che ha visitato il sito in seguito ad una immagine pubblicitaria torni a visitarlo entro un periodo di due settimane.

## H

Il web server www.pravettoni.com associa la risorsa /offerte.html alla ACL "pippo è l’unico utente che può accedere a questa risorsa; utenti autenticati con BASIC". Il web server contiene una tabella delle credenziali in cui non è definito l'utente pluto; l'utente pippo è definito con password "minni".

Si supponga che un utente riesca a visualizzare con il proprio browser il documento con URL http://www.pravettoni.com/offerte.html

Si descriva la sequenza di messaggi HTTP scambiati tra browser e web server (assumendo che il browser conosca già l'indirizzo IP del web server)

## I

Il server HTTP di OrgY ha nome www.org-y.net. Questo server gestisce i realm indicati di seguito:

| Nome | Risorse | ACL | Autentication method |
| :---- | :---- | :---- | :---- |
| Pubblico | /a/\* | Pippo | BASIC |
| Semipubblico | /b/\* | Pippo | BASIC |
| Default | ogni altra risorsa | Chiunque |  |

1. Indicare l’URL di una risorsa nel realm “Pubblico”; la risorsa **NON** deve essere un documento html. Ripetere per una risorsa nel realm “Semipubblico”. Ripetere per una risorsa nel realm Default.

2. L’utente Pippo sul nodo C1 deve accedere alle 3 risorse sopra indicate, in quell’ordine. Descrivere la sequenza di richieste e risposte HTTP inviate e ricevute dal browser.

3. Ripetere l’esercizio 2, assumendo che:

   * Il metodo di autenticazione per entrambi i realm è FORM invece di BASIC.

   * Quando il server riceve una richiesta HTTP da un utente non ancora autenticato risponde con un documento login.html. Questo contiene un form HTML i cui dati sarano inviati ad auth.exe.

Si consideri adesso la figura seguente:

![][image9]

4. Ripetere l’esercizio 2, assumendo che:

   * Il router R2 è configurato in modo che da applicare ad ogni pacchetto uscente da OrgX la regola seguente:

     Se (indirizzo IP sorgente ≠ indirizzo IP P) Allora butta via pacchetto

   * Sul nodo P è in esecuzione un proxy HTTP

   * Ogni browser interno a OrgX è configurato per passare attraverso il proxy su P.

   In dettaglio, è richiesto di:

1) elencare e motivare le eventuali differenze (ad esempio, se una richiesta HTTP inviata dal browser cambia, indicare le differenze ed il motivo).

2) elencare e motivare le modifiche eventualmente introdotte dal proxy HTTP (ad esempio, se una risposta ricevuta dal proxy è diversa dalla risposta che sarà ricevuta dal browser, indicare le differenze ed il motivo).

3) qualora la presenza del proxy HTTP impedisca a Pippo di prelevare una o più delle risorse indicate, discuterne il motivo.

## K

Un utente X desidera prelevare i documenti con URL /index.html, /protetto/index.html, /protetto/torneo.gif, /torneo.gif, /protetto/altriRisultati/index.htm, nell’ordine indicato. Tutti questi URL sono inseriti manualmente dall’utente e sono relativi all’URL assoluto http://www.server.uk. Il server mantiene le sessioni per mezzo di cookie ed è configurato in modo da gestire i seguenti realm (il carattere “\*” significa “qualsiasi sequenza di caratteri che non contiene il carattere “/”” ):

| Nome | Risorse | Utenti | ModalitàAutenticazione |
| :---- | :---- | :---- | :---- |
| Default | Tutte le risorse non contenute negli altri realm | Chiunque | Nessuna |
| Risultati | /protetto/\* | Luigi | BASIC |
| Foto | /\*.gif | Giuseppe | BASIC |

1. Descrivere la sequenza di richieste e risposte HTTP inviate e ricevute dal browser nel caso in cui X è Luigi. Ripetere nel caso in cui X è Giuseppe.

2. Stimare il numero di connessioni TCP necessarie all’utente Luigi. Ripetere per l’utente Giuseppe.

Nei rimanenti esercizi si assuma quanto segue. Il realm Foto richiede autenticazione FORM invece di BASIC. Il server è configurato in modo che al primo tentativo di accesso ad un documento nel realm Foto il browser riceve una risposta HTTP con redirezione verso l’URL /form-foto.htm. Questo è un documento statico contenente un form HTML in cui l’utente deve inserire le proprie credenziali. Il codice che verifica se le credenziali sono corrette ha URL /auth.aspx.

3. Ripetere gli esercizi 1 e 2\.

## L

Si considerino 4 organizzazioni Org1, Org2, Org3, Org4. 

La home page di Org1 consiste di un file html molto grande (circa 250 KB) e contiene un link alla pagina di URL relativo secondIndex.htm, anch’essa molto grande (circa 125 KB). Ognuna delle due pagine contiene 4 immagini molto piccole (circa 2 KB ognuna). Una di queste immagini è memorizzata su www.org1.com, una su www.org2.com, una su www.org3.com ed una su www.org4.com. 

1. Indicare, con “dettaglio adeguato”, la porzione di codice html nella home page di Org1 che descrive le 4 immagini sopra citate.  
* Ripetere per secondIndex.htm.  
2. Indicare, con “dettaglio adeguato”, la sequenza di tutte le request e response HTTP inviate e ricevute da un client per visualizzare completamente la home page di Org1. La descrizione deve includere anche: per ogni request, a quale server viene trasmessa; per ogni response, da quale server è stata trasmessa.  
* Ripetere per secondIndex.htm.  
3. Stimare il numero di connessioni TCP aperte dal client per visualizzare completamente la home page di Org1.  
* Ripetere per secondIndex.htm.

## M

Il servizio http://track.com fornisce funzionalità di “analytics” ai siti web che sono clienti di questo servizio. Queste funzionalità consistono in:

a)       conteggio del numero di accessi;

b)       conteggio del numero di browser che hanno effettuato almeno un accesso nelle ultime 3 settimane;

c)       conteggio del numero di accessi effettuati da uno smartphone.

Questi 3 contatori sono mantenuti in modo separato per ogni singola pagina (“pagina”=documento html). Cioè, se un utente accede alla pagina P1 di un sito e poi alla pagina P2 dello stesso sito, allora il servizio mantiene tre contatori per P1 (contatore a, contatore b, contatore c) ed altri tre contatori per P2 (idem).

I siti web http://bayern.de e http://dinamokiev.ur sono clienti del servizio http://track.com. La home page di bayern.de ha URL relativo index.html, contiene un link alla pagina season.html e le immagini img1.jpg, img2.jpg. La pagina season.html contiene un link alla pagina index.html e le immagini img1.jpg, img3.jpg. La home page di dinamokiev.ur ha URL relativo index.html, contiene un link alla pagina season.html e le immagini img1.jpg, img2.jpg. La pagina season.html contiene un link alla pagina index.html e le immagini img1.jpg, img3.jpg

I siti bayern.de e dinamokiev.ur sono configurati come segue: generano una sessione ogni volta che ricevono una request non appartenente ad una sessione; permettono il mantenimento in cache delle immagini; proibiscono il mantenimento in cache dei documenti html.

Gli utenti Karl e Hans sono collegati ad Internet attraverso un Internet provider con sede in Danimarca. Karl, usando un PC, inserisce l’URL della home page di bayern.de, preleva quella pagina e preme il link verso season.html. Poi, inserisce l’URL della home page di dinamokiev.ur, preleva quella pagina e preme il link verso season.html. Dopo 5 minuti Hans, usando uno smartphone, esegue le stesse azioni che aveva eseguito Karl (cioè preleva la home page di bayern.de etc.). Dopo una settimana Karl, usando uno smartphone, esegue ancora le stesse azioni.

1. Descrivere le informazioni che devono essere, eventualmente, presenti nelle pagine di bayern.de e dinamokiev.ur per usufruire del servizio track.com.  
2. Descrivere un possibile contenuto HTML per la home page di bayern.de e per la home page di dinamokiev.ur.  
3. Descrivere, con un livello di dettaglio “adeguato”, tutto il traffico http generato da Karl. Una descrizione che non permetta di capire come il servizio track.com riesce a mantenere i contatori sopra descritti non è adeguata. Una descrizione che non permetta di capire come si soddisfino i requisiti sul caching sopra descritti non è adeguata.  
4. Ripetere 3 con riferimento ad Hans.  
5. Con riferimento al traffico sopra descritto, elencare tutti i contatori mantenuti da track.com e fornire per ogni contatore il valore corrispondente dopo tutti gli accessi di Karl e Hans (si assuma che il valore iniziale di ogni contatore sia zero e che non si sia verificato nessun accesso ai siti coinvolti in aggiunta a quello qui descritto).  
6. Con riferimento all’insieme di connessioni TCP del browser di Karl: stimare il numero di connessioni; fornire un insieme di possibili valori per i port number remoti; fornire un insieme di possibili valori per i port number locali.  
7. Ripetere 6 con riferimento ad Hans.  
8. Descrivere il traffico DNS trasmesso e ricevuto dal browser di Karl, assumendo risoluzione ricorsiva.  
9. Ripetere 8 con riferimento ad Hans.

## N

Si considerino i web server w1.org e w2.org. Entrambi sono configurati con la tabella dei realm descritta qui sotto (TdC \= Tabella delle Credenziali). Il form di autenticazione ha URL relativo /f.htm. La home page di w1.org contiene: un link ad ognuno dei seguenti URL: d1.html, d2.html, d3.html; l’immagine i2.jpg; lo script s2.js. Il documento http://w1.org/d1.html contiene un link a http://w2.org/d1.html; l’immagine i3.jpg. Il documento http://w2.org/d1.html contiene un link a http://w1.org/d1.html; l’immagine i4.jpg.

| Nome | Risorse | Utenti | Auth. method |
| :---- | :---- | :---- | :---- |
| listing | d1.html | Qualsiasi credenziale di TdC | FORM |
| default | Ogni altro documento | Qualsiasi utente |  |

L’utente Luis, presente in TdC, esegue le seguenti azioni: A) inserisce l’URL http://w1.org/ nella barra indirizzi del browser e preme “enter”; B) fa click sul link a d1.html ; C) fa click sul link a http://w2.org/d1.html . 

1. Scrivere, con un “sufficiente” livello di dettaglio, un possibile contenuto per: home page di w1.org;  documento http://w1.org/d1.html; form di autenticazione su w1.org; form di autenticazione su w2.org. Usare URL relativi ove possibile.  
2. Con riferimento all’azione A, descrivere, con un “sufficiente” livello di dettaglio: l’intera sequenza di richieste e risposte HTTP inviate e ricevute dal browser; l’intera sequenza di richieste e risposte DNS inviate e ricevute dal browser; l’intera sequenza di richieste e risposte DNS inviate e ricevute da w1.org e w2.org.  
3. Con riferimento all’azione B, fornire le informazioni richieste al punto 2\.  
4. Con riferimento all’azione C, stimare il numero di richieste HTTP inviate dal browser motivando la risposta.

## O

Descrivere cos’è un dominio DNS (NOTA BENE: una descrizione non è un esempio).

## P

L’organizzazione ORG gestisce la zona laser.uk ed il dominio mail laser.uk. Ha un name server, un mail server, un web server, tutti collegati a EthernetA, di nome rispettivamente dns.laser.uk, mx.laser.uk, www.laser.uk.

 

ORG offre un servizio di web hosting ed ospita 2 siti web di nome, rispettivamente, www.chip.es (custom domain), e chip.laser.uk (non-custom domain). Gli amministratori di questi siti web hanno una mailbox di nome, rispettivamente, admin@chip.es, admin.chip@laser.uk.

1. Elencare i RR necessari per realizzare lo scenario sopra descritto.  
2. Sia IP-B-E l’indirizzo IP di un nodo esterno ad ORG su cui è in esecuzione un browser. Quel browser preleva il documento http://www.chip.es e poi preleva il documento http://chip.laser.uk.

   Elencare i pacchetti che transitano da R1 e che trasportano traffico DNS o HTTP, specificando in dettaglio sia lo header sia il payload.

   Per semplicità, si assuma che i documenti non provochino il prelievo automatico di altre risorse o documenti web. Si suggerisce di numerare i pacchetti dell’elenco per semplificare lo svolgimento di un esercizio successivo. NB: per “descrizione di un pacchetto” qui si intende “indicare per ogni messaggio anche l’indirizzo IP mittente e l’indirizzo IP destinatario”.  
3. Sullo stesso nodo in cui è in esecuzione il browser indicato al punto precedente, è in esecuzione un mail client MC configurato per gestire la mailbox admin@chip.es. MC invia un email con destinatario admin.chip@laser.uk e l’email arriva nella mailbox di destinazione.

   Elencare i pacchetti che transitano da R1 e che trasportano traffico DNS o SMTP o POP. 

   Le eventuali transazioni SMTP/POP possono essere descritte specificando gli header IP solo una volta, senza cioè ripeterli in ogni singolo messaggio SMTP/POP.

## Q

L’organizzazione ORG utilizza indirizzi IP dinamici per ogni nodo ad eccezione dei router e dei server. Ha un mail server MS, un name server NS, un proxy PX collegati a Ethernet-C.

Il mail server MS gestisce il dominio email org.com. Un mail client in esecuzione su un nodo C2 collegato a SW2 invia, in una unica transazione SMTP, un email M1 con mittente [a@org.com](mailto:a@org.com), destinatario [b@org.com](mailto:b@org.com) ed un email M2 con mittente [a@org.com](mailto:a@org.com), destinatario [b@cornell.edu](mailto:b@cornell.edu).

1. Stimare, motivando brevemente la stima, il numero di invocazioni di bind(), accept(); connect() effettuate da C2 per la trasmissione di M1 ed M2 e per il deposito nelle mailbox di destinazione.  
   2. Ripetere il punto a per MS

## R

L’organizzazione ORG ha un mail server MS, un web server WS, un proxy PX collegati a Ethernet-A; un name server NS esterno all’organizzazione.

Il mail server MS gestisce il dominio email org.com ed il name server NS è il primario per la zona org.com (si assuma che questa zona non abbia name server secondari). Un mail client M2 è in esecuzione su un nodo C2 collegato a EthernetC. Si considerino gli eventi:

1. M2 invia, in una unica transazione SMTP, un email M1 con mittente [a@org.com](mailto:a@org.com), destinatario [b@org.com](mailto:b@org.com) ed un email M2 con mittente [a@org.com](mailto:a@org.com), destinatario [b@cornell.edu](mailto:b@cornell.edu);  
2. M1 ed M2 sono depositati nella mailbox di destinazione.

Con riferimento a questi eventi:

1. Elencare le connessioni TCP in cui è coinvolto MS. Per ogni connessione indicare chiaramente il nodo all’altra estremità e specificare i numeri di porta alle due estremità.

## S

Le organizzazioni futbol.es (OF) e vanbasten.nl (OV) hanno al proprio interno un mail server ed un web server. Ognuna delle due organizzazioni permette la navigazione web verso l’esterno solo attraverso un proxy di nome, rispettivamente, proxy.futbol.es e proxy.vanbasten.nl.

I siti web di entrambe le organizzazioni utilizzano il servizio di analytics http://visit-count.org.

La home page di www.vanbasten.nl contiene uno script ed un link di URL relativo gdpr.js e matches.html, rispettivamente. La pagina matches.html appartiene ad un realm al quale possono accedere solo gli utenti autenticati, con autenticazione FORM. La corrispondente pagina di login ha URL relativo auth-users.html.

Le mailbox andres@futbol.es e marco@vanbasten.nl appartengono alla mailing list [legendas@futbol.es](mailto:legendas@futbol.es).

* Elencare i RR che devono esistere affinché esistano i domini email, le mailbox, le mailing list sopra indicate.

## S-bis

Con riferimento allo scenario descritto in S:

* Sia UV l’utente proprietario della mailbox [marco@vanbasten.nl](mailto:marco@vanbasten.nl). UV gestisce la propria email con la webapp di Gmail, già configurata per usare la funzionalità “Send as” con indirizzo mittente marco@vanbasten.nl.   
* Sia UF l’utente proprietario della mailbox andres@futbol.es. UF possiede credenziali valide per il sito web www.vanbasten.nl.

Si considerino le azioni seguenti (UV usa un dispositivo interno a OV, UF un dispositivo interno a OF):

1. UV si collega alla webapp di Gmail, il cui URL è http://mail.google.com/mail/u/0/\#inbox  
2. UV invia un messaggio email con subject “Balón de Oro” al destinatario legendas@futbol.es.  
3. UF preleva la home page di www.vanbasten.nl  
4. UF clicca sul link in quella home page, si autentica, visualizza completamente la pagina corrispondente.

1. Per ognuna delle azioni A e B, elencare:  
   1. traffico DNS che il name server di OV scambia con i nodi interni a OV;  
   2. connessioni SMTP e connessioni POP che coinvolgono il mail server di OV;

NB a, b: “traffico DNS” \= richieste e risposte DNS, specificando chi è l’altra entità.  
NB c: “connessioni” \= solo chi è l’altra entità, specificando quale delle due opera da server  
NB Elenco separato per ogni azione-consegna: A-a, poi A-b, poi B-a, poi B-b.

2. Per ognuna delle azioni C e D, elencare:  
   1. traffico HTTP trasmesso e ricevuto dal browser di UF

NB Elenco separato per ogni azione: C-a, poi D-a.

[image1]: <data:image/png;base64,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>

[image2]: <data:image/png;base64,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>

[image3]: <data:image/png;base64,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>

[image4]: <data:image/png;base64,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>

[image5]: <data:image/png;base64,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>

[image6]: <data:image/png;base64,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>

[image7]: <data:image/png;base64,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>

[image8]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWcAAABcCAIAAAA9EOMAAAAFAklEQVR4Xu3csY4bNxDGcb9O3iFVSndO5zIw8gRXGulSufYruHTpFAFcBUiKAEpxwLmTS5UqrlCp7IXAYDzk7nCWkbTk/X8gDsMhlxaM5QcDd74X54g3P7+xLfTsxX9sF8/J4XA4B6927I0JHY3tIzVAagCIITUAxJAaAGJIDQAxpAaAGFIDQAypASCG1AAQQ2oAiLlNarT/cCE/oQjcCqkBIGZzqZHiwGyQzlwh9FMALmFbqVG8/7opS6bQ5EEAl7Ch1NB3vlinQtdmZ5pKDeASNpoaaWqKVJuwmHsKwIWQGgBiSA0AMTdLDSPvL2/OC9ksNYBL2FZq6CW1vZAReSE7pQZwCbdJjdVMRgC4vg5SIyWFsMsArquz1LBrAK6ug9QAsCmkBoAYUgNADKmB8/7rcRq7+z1j3Xj48nSLng9SA+fdP/uXr97aLqodH0+2NTRSw9LfrJmrjYUlUbPnVkiNRqSGK/bqh47egrmkWLj2C0uiZs//q/6PIzUakRqu2ncxCR29Eem+pXsut11fQmmaqW5qspo/taKjlxYKPZXHi0iNRqSGy3kFjdDRG7F890zfdKSppaZZzfdXdvSS3lOkH5lDajQiNVzOK2iEjt4IuWzFu6eLfKc0he5Ei1TPnaBXzU4papAajUgNV+27mISO3gi5eHNTTTp6NdVz+1NT73E7+YNymjk2b7pIjUakhqv2XUxCR29H8SrKVGrppGYqzGazX3bq6Vwhm+tX86aL1GhEarhq38UkdPR2FK+inopix2w2Hb2kV0Md6Uuha7NBHi8iNRqRGi7nFTRCR+MmSI1GpIaL1BgNqdGI1HCRGqMhNRqRGi5SYzSkRiNSw0VqjIbUaERquEiN0ZAajUgNF6kxGlKjEanhIjVGs7s/3P3y4eHLgbFuHI+khoPUGM2UGqfT+fTIWDlIDRepATxrpAaAGFIDQAypgafvofzw6u7l618Z68bp0f6Vjo3UAN95bcV3Xl2kRoH8z3T5/+k3V/8xSI1GpIar9l1MQkf3y4RF/Y29nPrPQGo0IjVcte9iEjq6X3Opkfpmabmjl4RezR/XG/JO8UCN1GhEaricV9AIHd2v4k2Wvl51O6YvtdmcpnlHprojm4tIjUakhst5BY3Q0f3Sd9XcUtPM9xQ70pepLhaaxf4yUqMRqeGqfReT0NH90te12NeXWSx05p5NxUKz2F9GajQiNVy172ISOrpf+rqavinEQiedpum+LvRTcxtcpEYjUsNV+y4moaP7NXdLU1/oTr7HdPJapqYjte7oE75ZzpAajUgNl/MKGqGjcROkRiNSw0VqjIbUaERquEiN0ZAajUgNF6kxGlKjEanhIjVGQ2o0IjVcpMZoSI1GpIaL1BgNqdGI1HCRGqPhd5Q3Dn7bsIvUAJ41UgNADKkBIIbUAHpyfDxdf5jPQGoAPXn77tPu/nDNMf2J5jOQGkBPSA0AMaQGgBhSA0AMqQEghtQAEBNKjfTLIvXUfC1uM4PUAPo23eE//97XjCkIdCFf9VQXc4PUAPo23eHPf+1rxhQHupibuoPUAPr2lBp/7GvGUy6oYm7qDlID6Nt0hz/9/lAzplzQhXzV05pBagB9m+7wx98eWsaUF3lzYZAaQN9Wp0b6V0Y0Mj6SGkDvVqfG6kFqAH0jNQDE7O4PP/70/prju+/vzGcgNQDEkBoAYkgNADGkBoAYUgNAzIrU+Bdip1Eia7txVQAAAABJRU5ErkJggg==>

[image9]: <data:image/png;base64,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>