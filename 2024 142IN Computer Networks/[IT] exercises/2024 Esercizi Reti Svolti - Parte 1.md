# Reti di Calcolatori (parte 1\) \- Esercizi svolti

*Aprire la Table of Contents (click sul simbolo qui a sinistra)*

* Nel 2024/2025 ho tolto alcuni argomenti del corso. Ho modificato il testo e lo svolgimento degli esercizi in modo da togliere ogni riferimento alle parti di programma non più svolte. E’ possibile che mi sia sfuggito qualcosa. In caso di dubbi non esitate a chiedermi.  
* Alcuni esercizi hanno la forma “*Elencare i RR necessari per l’esistenza di…*”. Nello svolgimento si possono omettere gli RR necessari per l’esistenza della root zone e dei TLD.

# WEB

## Web 1

*L’URL del documento indicato sotto a sinistra è http://a.com/index.htm. Un browser sul nodo C preleva e visualizza completamente il documento. L’utente esegue un click sul link associato con “testo 1”. Il browser preleva e visualizza completamente il documento corrispondente, il cui contenuto è indicato sotto a destra. Tutti i server coinvolti mantengono le sessioni con i cookie.*

| *…\<a href=”/doc/i.html”\>testo1\</a\>\<a href=”http://c.com/doc/i.html”\>testo2\</a\>\<img src=”pic/img.jpg”\>\<img src=”http://b.com/pic/img.jpg”\>\<script src=”js/jquery1-4.js”\>\</script\>\<script src=”http://c.com/js/jquery1-4.js”\>\</script\>…* | *… \<script src=”mylib.js”\>\</script\> \<script src=”http://c.com/mylib.js”\>\</script\> \<img src=”pic/yesterday.jpg”\> \<img src=”http://b.com/pic/yesterday.jpg”\> …*  |
| :---- | :---- |

1. *Descrivere, con un “ragionevole livello di dettaglio”, la sequenza di http request e response trasmesse e ricevute da C per visualizzare i due documenti.*  
2. *Descrivere la sequenza di DNS request e response **trasmesse e ricevute da C** per visualizzare i due documenti.*  
3. *Stimare il numero di connessioni TCP utilizzate da C, motivando la risposta.*

Il traffico per prelevare e visualizzare http://a.com/index.htm è il seguente (la seconda colonna indica l’indirizzo IP del web server che riceve o che trasmette il messaggio HTTP):

| GET /index.htmHost: a.com Accept-Language: it, en, es…\<L.V.\> | IP(a.com) |
| :---- | :---- |
| HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza doc. tabella a sinistra\> Set-Cookie: a-id…\<documento tabella a sinistra\> | IP(a.com) |
| GET /pic/img.jpgHost: a.comReferrer: http://a.com/index.htm Cookie: a-id…\<LV\> | IP(a.com) |
| HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\>…\<immagine\> | IP(a.com) |
| GET /pic/img.jpgHost: b.comReferrer: http://a.com/index.htm…\<LV\> | IP(b.com) |
| HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\> Set-Cookie: b-id…\<immagine\> | IP(b.com) |
| GET /js/jquery1-4.jsHost: a.comReferrer: http://a.com/index.htm Cookie: a-id…\<LV\> | IP(a.com) |
| HTTP 200 OKContent-Type: application/javascriptContent-Length: \<lunghezza script\>…\<script\> | IP(a.com) |
| GET /js/jquery1-4.jsHost: c.comReferrer: http://a.com/index.htm…\<LV\> | IP(c.com) |
| HTTP 200 OKContent-Type: application/javascriptContent-Length: \<lunghezza script\> Set-Cookie: c-id…\<script\> | IP(c.com) |

Dopo il click sul link, il traffico per visualizzare il documento successivo è il seguente:

| GET /doc/i.htmlHost: a.com Referer: http://a.com/index.htm Cookie: a-id…\<L.V.\> | IP(a.com) |
| :---- | :---- |
| HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza doc. tabella a destra\>…\<documento tabella a sinistra\> | IP(a.com) |
| GET /doc/mylib.jsHost: a.comReferrer: http://a.com/doc/i.html Cookie: a-id…\<LV\> | IP(a.com) |
| HTTP 200 OKContent-Type: application/javascriptContent-Length: \<lunghezza script\>…\<script\> | IP(a.com) |
| GET /mylib.jsHost: c.comReferrer: http://a.com/doc/i.htmlCookie: c-id …\<LV\> | IP(c.com) |
| HTTP 200 OKContent-Type: application/javascriptContent-Length: \<lunghezza script\>…\<script\> | IP(c.com) |
| GET /doc/pic/yesterday.jpgHost: a.comReferrer: http://a.com/doc/i.html Cookie: a-id…\<LV\> | IP(a.com) |
| HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\>…\<immagine\> | IP(a.com) |
| GET /pic/yesterday.jpgHost: b.comReferrer: http://a.com/doc/i.html Cookie: b-id…\<LV\> | IP(b.com) |
| HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\>…\<immagine\> | IP(b.com) |

Il browser si collega con i web server in esecuzione sui nodi di nome a.com, b.com, c.com. Il traffico DNS in cui è coinvolto il browser è quello necessario per risolvere questi nomi, quindi (in ogni messaggio il server che trasmette o riceve è quello dell’organizzazione a cui appartiene il browser):

| a.com A ? |  |
| :---- | :---- |
|  | a.com A IP(a.com) |
| b.com A ? |  |
|  | b.com A IP(b.com) |
| c.com A ? |  |
|  | c.com A IP(c.com) |

Il numero di connessioni TCP usate da C per il traffico DNS può essere 1,2 o 3 (tutte le connessioni sono con il name server dell’organizzazione a cui appartiene C). Il testo dell’esercizio non permette di discriminare tra questi casi.

C preleva 6 documenti da a.com. Il numero di connessioni TCP usate da C per il traffico HTTP con a.com è quindi compreso tra 1 (tutte le interazioni HTTP nella stessa connessione) e 6 (una interazione HTTP per connessione). Il testo non permette di essere più precisi.

C preleva 2 documenti da b.com. Con lo stesso ragionamento precedente si ottiene che il numero di connessioni TCP usate da C per il traffico HTTP con b.com è 1 o 2\. C preleva 2 documenti da c.com. Con lo stesso ragionamento precedente si ottiene che il numero di connessioni TCP usate da C per il traffico HTTP con c.com è 1 o 2\.

Il numero di connessioni TCP usate da C è quindi compreso tra 1 (DNS)+1+1+1(HTTP)=4 e 3(DNS)+6+2+2(HTTP)=13.

### Osservazioni

* **I server che trasmettono o ricevono un messaggio devono essere sempre resi espliciti**. A volte il server è lo stesso per tutto il traffico quindi lo si può esplicitare testualmente (come nel traffico DNS di questo esercizio), altre volte no quindi deve essere esplicitato in ogni singolo messaggio (come nel traffico HTTP). In quest’ultimo caso, può essere usata una notazione a piacere purché chiara e non ambigua. Talvolta indicare il nome del server è chiaro e non ambiguo, talvolta può non esserlo (ad esempio in esercizi in cui nomi diversi sono associati con lo stesso indirizzo IP). Usare l’indirizzo IP è sempre la scelta migliore. Se l’indirizzo IP non è specificato, come in questo caso, basta inventarsi una qualche notazione appropriata (come in questo caso).  
* **Quando si introducono dei simboli, è ovviamente indispensabile usare lo stesso simbolo per tutto l’esercizio**. Ad esempio, poiché in questo caso si è usato il simbolo “IP(a.com)” nel punto HTTP, si è usato lo stesso simbolo nel punto DNS.  
* Quando si mescolano keyword del protocollo o valori dell’esercizio con termini descritti in modo intuitivo (ad esempio la linea vuota nelle richieste HTTP, oppure la lunghezza di un documento trasportato da una risposta HTTP), è preferibile evidenziare tali termini con qualche formato convenzionale. Ad esempio, racchiudendoli tra i caratteri \< e \>, come nello svolgimento qui sopra.  
* Quando una richiesta HTTP trasporta un cookie, la risposta corrispondente può avere lo header Set-Cookie oppure può non averlo (nella realtà di solito ce l’ha). Ai fini dei nostri esercizi vanno bene entrambe le scelte. Di solito non ce la mettiamo. Negli esercizi possiamo omettere i parametri di Set-Cookie a meno che non sia specificata esplicitamente una durata “particolarmente lunga”, nel qual caso è preferibile inserire il parametro Expires nello header Set-Cookie.  
* Dopo gli header di una risposta HTTP è sempre presente una linea vuota, sia che la risposta trasporti un documento sia che non lo trasporti. Quando lo trasporta, di solito nella descrizione si omette per semplicità.

## Web 2

*Ripetere l’esercizio precedente assumendo che il browser sul nodo C navighi attraverso il proxy di nome proxy.carega.it.*

Il traffico HTTP è identico al precedente, con l’osservazione che tutte le connessioni TCP sono con il proxy, quindi l’indirizzo IP nell’ultima colonna della tabella è sempre IP-X (indirizzo IP del proxy).

Il traffico DNS in cui è coinvolto il browser è diverso in quanto il browser deve risolvere solo il nome del proxy (il browser si collega comunque sempre con il name server della propria organizzazione):

| proxy.carega.it A ? |  |
| :---- | :---- |
|  | proxy.carega.it A IP-X |

Il numero di connessioni TCP usate da C per il traffico DNS è 1\.

Il numero di documenti prelevati da C via HTTP è 10\. C preleva tutti questi documenti dal proxy. Quindi il numero di connessioni TCP usate da C per il traffico HTTP è compreso tra 1 e 10\.

Il numero di connessioni TCP usate da C è quindi compreso tra 1+1=2 e 1+10=11.

## Web 3

*Il sito conta.org realizza un servizio di conteggio degli accessi: fornisce, per ogni pagina, il numero di accessi alla pagina ed il numero di client che hanno effettuato almeno un accesso. Il servizio associa un’immagine diversa ad ogni sito che desidera contare gli accessi alle proprie pagine; questa immagine deve essere inclusa in ogni pagina del sito. I siti www.spritz.it e www.engine.org sfruttano il servizio e le immagini ad essi associate sono, rispettivamente, http://conta.org/xS.jpg e http://conta.org/xE.jpg.*  
   
*Il documento http://www.spritz.it/ contiene un tag A con attributo HREF=”i1.htm”, un tag SCRIPT con attributo SRC=”s.js” e le immagini: http://flickr.com/a.jpg, http://www.spritz.it/a.jpg. Il documento riferito dal tag A contiene le stesse immagini ed un IFRAME con attributo SRC=”http://www.engine.org/”. Tutti i server mantengono le sessioni.*

*Un browser B preleva il documento di URL http://www.spritz.it/ e, dopo 30 secondi, preleva con successo il documento indicato nel tag A.* 

1. *Descrivere la sequenza di richieste e risposte HTTP trasmesse e ricevute da B per il prelievo e la visualizzazione dei documenti indicati.*  
2. *Fornire, motivando la risposta, i conteggi forniti da conta.org al termine dell'esecuzione per ognuno dei 3 documenti html citati nell'esercizio: www.spritz.it/, www.spritz.it/i1.html, www.engine.org/ (si assuma che tutti i contatori abbiano inizialmente valore zero).*

*La descrizione deve indicare in modo non ambiguo quale sia il server coinvolto in ogni messaggio.*

Punto 1\. I documenti che il browser preleva automaticamente dopo avere prelevato http://www.spritz.it/ sono:

* [http://www.spritz.it/s.js](http://www.spritz.it/s.js)	(script)  
* [http://flickr.com/a.jpg](http://flickr.com/a.jpg)		(immagine)  
* [http://www.spritz.it/a.jpg](http://www.spritz.it/a.jpg)	(immagine)  
* [http://conta.org/xE.jpg](http://conta.org/xE.jpg)		(immagine per analytics)

Il traffico corrispondente è il seguente (la seconda colonna indica l’indirizzo IP del web server che riceve o che trasmette il messaggio HTTP):

| 1 | GET /Host: www.spritz.it Accept-Language: it, en, es…\<L.V.\> | IP(www.spritz.it) |
| :---- | :---- | :---- |
| 2 | HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza doc.\> Set-Cookie: s-id…\<documento /\> | IP(www.spritz.it) |
| 3 | GET /s.jsHost:  www.spritz.itReferrer: http://www.spritz.it Cookie: s-id…\<LV\> | IP(www.spritz.it) |
| 4 | HTTP 200 OKContent-Type: application/javascriptContent-Length: \<lunghezza script /s.js\>…\<script\> | IP(www.spritz.it) |
| 5 | GET /a.jpgHost: flickr.comReferrer: http://www.spritz.it…\<LV\> | IP(flickr.com) |
| 6 | HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\> Set-Cookie: f-id …\<immagine /a.jpg\> | IP(flickr.com) |
| 7 | GET /a.jpgHost:  www.spritz.itReferrer: http://www.spritz.it Cookie: s-id…\<LV\> | IP(www.spritz.it) |
| 8 | HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\>…\<immagine /a.jpg\> | IP(www.spritz.it) |
| 9 | GET /xS.jpgHost:  conta.orgReferrer: http://www.spritz.it…\<LV\> | IP(conta.org) |
| 10 | HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\> Set-Cookie: c-id…\<immagine /xS.jpg\> | IP(conta.org) |

Quando l’utente effettua un click sul tag con attributo A, il browser preleva il documento di URL http://www.spritz.it/i1.htm. I documenti che il browser preleva automaticamente dopo avere prelevato questo documento sono:

* [http://flickr.com/a.jpg](http://flickr.com/a.jpg)		(immagine)  
* [http://www.spritz.it/a.jpg](http://www.spritz.it/a.jpg)	(immagine)  
* [http://conta.org/xE.jpg](http://conta.org/xE.jpg)		(immagine per analytics)  
* [http://www.engine.org](http://www.engine.org)		(documento contenuto nell’IFRAME)  
* [http://conta.org/xS.jpg](http://conta.org/xE.jpg)		(immagine per analytics di quest’ultimo documento)

Il traffico corrispondente è il seguente (il fatto che il click avvenga dopo 30 secondi non ha alcun effetto sul traffico generato):

| 11 | GET /i1.htmHost: www.spritz.it Referrer: http://www.spritz.it Cookie: s-id…\<L.V.\> | IP(www.spritz.it) |
| :---- | :---- | :---- |
| 12 | HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza doc.\>…\<documento /i1.htm\> | IP(www.spritz.it) |
| 13 | GET /a.jpgHost: flickr.comReferrer: http://www.spritz.it/i.htm Cookie: f-id …\<LV\> | IP(flickr.com) |
| 14 | HTTP 200 OKContent-Type: img/jpgContent-Length:\<lunghezza immagine\>…\<immagine richiesta\> | IP(flickr.com) |
| 15 | GET /a.jpgHost:  www.spritz.itReferrer: http://www.spritz.it/i.htm Cookie: s-id…\<LV\> | IP(www.spritz.it) |
| 16 | HTTP 200 OKContent-Type: img/jpgContent-Length:\<lunghezza immagine\>…\<immagine richiesta\> | IP(www.spritz.it) |
| 17 | GET /xS.jpgHost:  conta.orgReferrer: http://www.spritz.it/i.htm Cookie: c-id…\<LV\> | IP(conta.org) |
| 18 | HTTP 200 OKContent-Type: img/jpgContent-Length:\<lunghezza immagine\>…\<immagine richiesta\> | IP(conta.org) |
| 19 | GET /Host: www.engine.org Referrer: http://www.spritz.it/i.htm…\<L.V.\> | IP(www.engine.org) |
| 20 | HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza doc.\> Set-Cookie: e-id…\<documento /\> | IP(www.engine.org) |
| 21 | GET /xE.jpgHost:  conta.orgReferrer: http://www.engine.org Cookie: c-id …\<LV\> | IP(conta.org) |
| 22 | HTTP 200 OKContent-Type: img/jpgContent-Length: \<lunghezza immagine\> …\<immagine /xE.jpg\> | IP(conta.org) |

Punto 2 Il conteggio richiesto è il seguente (si basa sulle richieste 9, 17, 21):

| Documento | Numero accessi | Numero client che hanno effettuato almeno un accesso |
| :---- | :---- | :---- |
| www.spritz.it/ | 1 | 1 |
| www.spritz.it/i1.html | 1 | 1 |
| www.engine.org | 1 | 1 |

### Osservazioni

* Rispondere al punto 3 con “*il valore del contatore è 1*” significa non avere risposto. Più precisamente, significa essersi inventati una domanda ed avere risposto alla domanda inventata. La domanda nel testo indicava chiaramente che occorre fornire 2 contatori per ogni documento ed i documenti sono 3; totale 6 contatori.

## Web 4

*Un servizio di web hosting gratuito supporta nomi di siti web della forma [http://nome.webhosting.org](http://nome.webhosting.org) sul server di nome wserver.webhosting.org ed indirizzo IP IP-W. Il servizio di web hosting mantiene sessioni con cookie; crea una sessione ogni volta che riceve una richiesta non appartenente a nessuna sessione.*

*L’organizzazione forsberg crea un sito web su tale servizio di web hosting. Il sito ha una home page di url relativo / che contiene: un tag A con attributo HREF=”a.htm”, un tag A con attributo HREF=”b.htm”, un tag SCRIPT con attributo SRC=”a.js”, un tag IMG con attributo SRC=”f.jpg”. I documenti con url relativo a.htm e b.htm: contengono un tag A con attributo HREF=”/”; contengono tag SCRIPT e IMG identici a quelli contenuti nella home page; sono accessibili agli utenti autenticati, con FORM authentication; non sono accessibili agli utenti non autenticati.*

*L’utente Karl esegue questa sequenza di operazioni su un browser:*

1. *inserisce manualmente l’url corrispondente alla home page della organizzazione forsberg;*  
2. *preleva la home page;*  
3. *dopo 5 minuti, preleva con successo il documento con url relativo a.htm (quindi con autenticazione).*

1. *Descrivere la sequenza di richieste e risposte HTTP trasmesse e ricevute dal browser per eseguire A-B-C. Si suggerisce di numerare ogni richiesta e ogni risposta per facilitare lo svolgimento degli esercizi successivi.*

*L’organizzazione forsberg decide di passare alla versione a pagamento del servizio di web hosting per assegnare il nome [http://www.forsberg.se](http://www.forsberg.se) al proprio sito web.* 

2. *Descrivere: i RR da modificare nel DNS (aggiungere, modificare, rimuovere) indicando in maniera non ambigua il nome dell’organizzazione che deve realizzare la modifica; le configurazioni da modificare nei browser; le configurazioni da modificare nel web server wserver.webhosting.org.*  
3. *L’utente John usa un browser diverso da quello usato da Karl e naviga su web attraverso un proxy. John esegue la stessa sequenza di operazioni A-B-C eseguita da Karl. Descrivere la sequenza di richieste e risposte HTTP trasmesse e ricevute dal browser di John per eseguire A-B-C, limitandosi ad elencare le eventuali differenze rispetto allo svolgimento del punto 6\.*

Punto 1\. La home page dell’organizzazione forsberg ha URL http://forsberg.webhosting.org/. I documenti che il browser preleva automaticamente dopo avere prelevato questa home page sono:

* http://forsberg.webhosting.org/a.js	(script)  
* http://forsberg.webhosting.org/f.jpg	(immagine, da prelevare due volte)

Il traffico corrispondente quindi è il seguente (la seconda colonna indica l’indirizzo IP del web server che riceve o che trasmette il messaggio HTTP):

| 1 | GET /Host: forsberg.webhosting.org Accept-Language: it, en, es…\<L.V.\> | IP-W |
| :---- | :---- | :---- |
| 2 | HTTP 200 OK Content-type: text/html Content-length: 3476 Set-Cookie: f-id …. \<documento /\> | IP-W |
| 3 | GET /a.jsHost: forsberg.webhosting.org Referer: http://forsberg.webhosting.org Cookie: f-id…\<L.V.\> | IP-W |
| 4 | HTTP 200 OK Content-type: application/javascript Content-length: 750 …. \<documento /a.js\> | IP-W |
| 5 | GET /f.jpgHost: forsberg.webhosting.org Referer: http://forsberg.webhosting.org Cookie: f-id…\<L.V.\> | IP-W |
| 6 | HTTP 200 OK Content-type: img/jpg Content-length: 7540 …. \<documento /a.js\> | IP-W |
| 7 | GET /f.jpgHost: forsberg.webhosting.org Referer: http://forsberg.webhosting.org Cookie: f-id…\<L.V.\> | IP-W |
| 6 | HTTP 200 OK Content-type: img/jpg Content-length: 7540 …. \<documento /a.js\> | IP-W |

Il documento da prelevare al click è http://forsberg.webhosting.org/a.htm; i documenti che il browser dovrà prelevare automaticamente sono gli stessi di quelli prelevati automaticamente nel caso precedente (gli URL assoluti corrispondenti agli URL relativi contenuti in http://forsberg.webhosting.org/a.htm sono identici a quelli corrispondenti agli URL relativi contenuti in [http://forsberg.webhosting.org/](http://forsberg.webhosting.org/)).

Il click avviene dopo 5 minuti. Assumendo che il cookie abbia una scadenza successiva a questo istante, la richiesta inviata a seguito del click appartiene alla sessione già esistente.

Il documento http://forsberg.webhosting.org/a.htm richiede autenticazione FORM. L’esercizio non specifica l’URL della pagina di login e neanche l’URL a cui sono validate le credenziali. Assumiamo che questi URL siano, rispettivamente, http://forsberg.webhosting.org/login.htm e http://forsberg.webhosting.org/validate.asp.

Pertanto, il traffico successivo al click dell’utente sarà:

| 7 | GET /a.htmHost: forsberg.webhosting.org Referer: [http://forsberg.webhosting.org](http://forsberg.webhosting.org) Cookie: f-id…\<L.V.\> | IP-W |
| :---- | :---- | :---- |
| 8 | HTTP 301 Found Location: http://forsberg.webhosting.org/login.htm …. \<L.V.\> | IP-W |
| 9 | GET /login.htm Host: forsberg.webhosting.org Referer: [http://forsberg.webhosting.org](http://forsberg.webhosting.org) Cookie: f-id … \<L.V.\> | IP-W |
| 10 | HTTP 200 OK Content-type: text/html Content-length: lunghezza documento … \<L.V.\> Documento HTML con FORM per inserimento credenziali | IP-W |
| 11 | POST [http://forsberg.webhosting.org/validate.asp](http://forsberg.webhosting.org/validate.asp) Content-type: x-www-form-urlencoded Content-length: lunghezza stringa con dati form Cookie: f-id … \<L.V.\> user=Karl\&password=pass-di-karl | IP-W |
| 12 | HTTP 200 ok Content-type: text/html Content-length: 3500 …. \<documento /a.htm/\> | IP-W |
| 13 | GET /a.jsHost: forsberg.webhosting.org Referer: http://forsberg.webhosting.org/a.htm Cookie: f-id…\<L.V.\> | IP-W |
| 14 | HTTP 200 OK Content-type: application/javascript Content-length: 750 …. \<documento /a.js\> | IP-W |
| 15 | GET /f.jpgHost: forsberg.webhosting.org Referer: http://forsberg.webhosting.org Cookie: f-id…\<L.V.\> | IP-W |
| 16 | HTTP 200 OK Content-type: img/jpg Content-length: 7540 …. \<documento /a.js\> | IP-W |

La risposta 12 contiene il documento richiesto nella richiesta 7 perché la richieste 7, 9, 11 appartengono alla stessa sessione (quindi quando il server costruisce la risposta 12, sa quale era il documento atteso dal browser).

**Punto 2** Deve essere aggiunto il RR seguente:

www.forsberg.se	CNAME	wserver.webhosting.org

Questa aggiunta deve essere fatta dalla organizzazione proprietaria del dominio [www.forsberg.es](http://www.forsberg.es), non dalla organizzazione di web hosting (potrebbe essere fatta da quest’ultima solo se quest’ultima fosse anche proprietaria del dominio [www.forsberg.es](http://www.forsberg.es), ovviamente).

Nel browser non occorre inserire nessuna configurazione, ovviamente.

Nel web server  *wserver.webhosting.org* occorre inserire una informazione di configurazione che specifichi che Host: www.forsberg.se corrisponde ai documenti associati al sito forsberg.webhosting.org (cioè a Host: forsberg.webhosting.org).

**Punto 3** Il traffico 1-6 generato da Karl sarà generato anche da John, con le differenze seguenti:

* l’indirizzo IP con cui comunica il browser non è IP-W ma è quello del proxy, IP-X;  
* l’identificatore della sessione di John (valore degli header Set-Cookie e Cookie) sarà diverso da quello della sessione di Karl;  
* Il valore dello header Host non sarà forsberg.webhosting.org ma www.forsberg.se.

Il traffico 7-12 generato da Karl sarà generato anche da John (assumendo che John abbia il diritto di visualizzare a.htm), con la stesse differenze già elencate. 

## Web 5

*Il web server di org.com ha una tabella delle credenziali TdC e gestisce i seguenti realm (“credenziale”=\<username, password\>):*

 

| *Nome* | *Risorse* | *Utenti* | *Authentication method* |
| :---- | :---- | :---- | :---- |
| *listing* | *list-a.html list-b.html \*.doc* | *Qualsiasi credenziale di TdC* | *FORM* |
| *default* | *Ogni altro documento* | *Qualsiasi utente* |   |

 

*Quando un utente non autenticato richiede una risorsa in un realm che necessita autenticazione, la risposta contiene una redirection verso un documento contenente un form in cui l’utente deve inserire le proprie credenziali. (NB: “\*” significa “qualsiasi sequenza di caratterI”).*

*La home page di org.com contiene un link a list-a.html, un link a list-b.html, 2 link a documenti con estensione doc memorizzati su org.com, 1 immagine a.jpg memorizzata su org.com., 2 script Javascript a.js e b.js memorizzati su org.com. I documenti list-a.html e list-b.html contengono entrambi l’immagine a.jpg memorizzata su org.com e 3 script Javascript: a.js, b.js e c.js tutti memorizzati su org.com.*

*1\.   Descrivere, con un “sufficiente” livello di dettaglio, un possibile contenuto per la home page e per il documento con il form di autenticazione.*

*2\.   L’utente Pippo, presente in TdC, preleva la home page e la visualizza completamente. Descrivere, con un “sufficiente” livello di dettaglio, l’intera sequenza di richieste e risposte HTTP.*

*3\. Dopo avere visualizzato completamente la home page, l’utente Pippo preleva list-a.html attraverso il link nella home page e lo visualizza completamente. Descrivere, con un “sufficiente” livello di dettaglio, l’intera sequenza di richieste e risposte HTTP (tale sequenza deve essere coerente con il documento contenente il form al punto 1).*

*Qualora le informazioni fornite non siano sufficienti per lo svolgimento dell’esercizio, indicare chiaramente le ipotesi effettuate.*

Punto 1 Un possibile contenuto per la home page ed il form di autenticazione è il seguente (sinistra e destra, rispettivamente):

| \<html\> … \<A href=“list-a.html”\>List 1\</A\> \<A href=“list-b.html”\>List 2\</A\> \<IMG src=”a.jpg”\>\</IMG\> \<A href=“list-a.doc”\>Doc 1\</A\> \<A href=“list-b.doc”\>Doc 2\</A\> \<SCRIPT src=“a.js”\> \<SCRIPT src=“b.js”\> ... \</html\> | \<html\> … \<FORM METHOD= “POST”  ACTION= “validate”\> Username: \<INPUT type= “text” NAME= “user”\> Password:\<INPUT type= “password”  NAME= “password”\> \</FORM\> ... \</html\> |
| :---- | :---- |

Il valore dell’attributo ACTION nel form è stato scelto arbitrariamente in quanto non fornito nel testo dell’esercizio. Tale valore è l’URL al quale il browser deve inviare i dati che l’utente ha inserito nel form. In questo caso specifico, i dati inseriti nel form sono le credenziali di autenticazione ed il valore dell’attributo ACTION identifica un programma che verifica la presenza delle credenziali nella TdC del web server.

Punto 2 I documenti da prelevare per visualizzare la home page sono, oltre alla home page, quelli il cui URL è nell’attributo SRC dei tag IMG e SCRIPT (un’immagine e due script). Nessuno dei documenti appartiene ad un realm che richiede autenticazione. Il traffico per prelevare la home page sarà quindi il seguente:

| 1 | GET /Host: org.com Accept-Language: it, en …\<L.V.\> | IP(org.com) |
| :---- | :---- | :---- |
| 2 | HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza doc.\> Set-Cookie: id-org …\<documento\> | IP(org.com) |
| 3 | GET /a.jpgHost: org.com Cookie: id-org Referrer: http://org.com …\<L.V.\> | IP(org.com) |
| 4 | HTTP 200 OKContent-Type: img/jpgContent-Length:\<lunghezza immagine\> Cache-control: public max-age=604800 …\<immagine\> | IP(org.com) |
| 5 | GET /a.jsHost: org.com Cookie: id-org Referrer: http://org.com …\<L.V.\> | IP(org.com) |
| 6 | HTTP 200 OKContent-Type: application/javascriptContent-Length:\<lunghezza script\> Cache-control: public max-age=604800 …\<script\> | IP(org.com) |
| 7 | GET /b.jsHost: org.com Cookie: id-org Referrer: http://org.com …\<L.V.\> | IP(org.com) |
| 8 | HTTP 200 OKContent-Type: application/javascriptContent-Length:\<lunghezza script\> Cache-control: public max-age=604800 …\<script\> | IP(org.com) |

Punto 3 Il documento list-a.html appartiene al realm listing, pertanto il documento sarà inviato dal server solo dopo che l’utente si sarà autenticato.

Il prelievo di questo documento provoca il prelievo di immagini e di script contenuti nella cache del browser (in quanto sono le stesse immagini e script prelevati per visualizzare la home page, ed il web server org.com specifica di mantenere queste risorse in cache per una settimana). I documenti in cache non provocano traffico HTTP, pertanto il traffico sarà solo quello necessario per prelevare list-a.html, come segue.

| 9 | GET list-a.htmlHost: org.com Cookie: id-org Referrer: http:/org.com …\<L.V.\> | IP(org.com) |
| ----- | :---- | :---- |
| 10 | HTTP 301 FoundLocation: http://org.com/login.html …\<L.V.\> | IP(org.com) |
| 11 | GET login.htmlHost: org.com Cookie: id-org Referrer: http://org.com …\<L.V.\> | IP(org.com) |
| 12 | HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza login page\> …\<documento HTML indicato al punto 1, lato destro\> | IP(org.com) |
| 13 | POST validateHost: org.com Cookie: id-org Referrer: [http://org.com](http://www.org.com) Content-type: x-www-form-urlencoded Content-length: *lunghezza-stringa* …\<L.V.\> user=Pippo\&password=pass-di-Pippo | IP(org.com) |
| 14 | HTTP 200 OKContent-Type: text/htmlContent-Length:\<lunghezza documento\> …\<documento list-a.html\> | IP(org.com) |
| *traffico analogo a 3-8 della tabella precedente,per prelevare immagine e script* |  |  |
| 15 | GET /c.jsHost: org.com Cookie: id-org Referrer: http://org.com**/list-a.html** …\<L.V.\> | IP(org.com) |
| 16 | HTTP 200 OKContent-Type: application/javascriptContent-Length:\<lunghezza script\> Cache-control: public max-age=604800 …\<script\> | IP(org.com) |

Alla response 10 si è ipotizzato che il documento contenente il form di autenticazione abbia URL [http://org.com/login.html](http://www.org.com/login.html).

La request 10 è una POST che contiene uno header Referer mentre nell’esercizio Web 4 c’era una POST senza header Referer (request numero 11). Entrambe le possibilità sono corrette. Infatti, ci sono alcuni casi nei quali la specifica del protocollo HTTP non descrive come costruire lo header Referer. L'invio di una richiesta POST successiva ad una risposta unauthorized o con redirection è uno di quei casi. Poiché il protocollo non ha specificato questi casi, il comportamento dei browser non è uniforme; possono assegnare come valore del referer "l'ultimo URL richiesto", oppure "il penultimo URL richiesto", oppure possono addirittura omettere il referer.

## Web 6

*Il web server di org.com ha una tabella delle credenziali TdC, utilizza i servizi di analytics del sito count.com, gestisce i realm descritti di seguito. La home page di org.com contiene: un link a d/a.html, un link a d/b.html, un link a c.pdf, una immagine i.jpg, le informazioni necessarie per il servizio di analytics. I tre link sono visualizzati con il testo “Uno”, “Due” e “Tre”, rispettivamente. I documenti d/a.html e d/b.html contengono entrambi una immagine i.jpg, le informazioni necessarie per il servizio di analytics.*

| *Nome* | *Risorse* | *Utenti* | *Auhtentication method* |
| :---- | :---- | :---- | :---- |
| *reserved* | */d/\*.html* | *Qualsiasi credenziale di TdC* | *BASIC* |
| *pdfs* | *\*.pdf* | *Qualsiasi credenziale di TdC* | *BASIC* |
| *default* | *Ogni altro documento* | *Qualsiasi utente* |   |

*L’utente Marco, presente in TdC, usa un browser B che accede al web attraverso un proxy P. Marco esegue questa sequenza di eventi:*

1. *Preleva la home page di org.com.*  
2. *Clicka sul testo “Tre” e preleva il documento corrispondente.*  
3. *Clicka sul testo “Uno” e preleva il documento corrispondente.*  
4. *Apre un tab in incognito.*  
5. *Nel tab in incognito, preleva la home page di org.com.*  
6. *Nel tab in incognito, clicka sul testo “Tre” e preleva il documento corrispondente.*

*1\. Descrivere, con un “sufficiente” livello di dettaglio, un possibile contenuto per la home page di org.com.*  
*2\. Descrivere la sequenza di richieste e risposte HTTP inviate e ricevute dal browser*  
*per eseguire A e B.*  
*3\. Descrivere la sequenza di richieste e risposte HTTP inviate e ricevute dal browser*  
*per eseguire C.*  
*4\. Descrivere la sequenza di richieste e risposte HTTP inviate e ricevute dal browser*  
*per eseguire E e F.*  
*5\.  Descrivere la sequenza di richieste e risposte DNS inviate e ricevute dal browser*  
*per eseguire A e B.*

*Una sequenza può essere descritta sotto forma di differenze rispetto ad una sequenza omologa precedente*

**Punto 1** Un possibile contenuto è il seguente:

	\<A HREF= “d/a.html”\> Uno \</A\>  
	\<A HREF= “d/b.html”\> Due \</A\>  
	\<A HREF= “c.pdf”\> Tre \</A\>  
	\<IMG SRC= “i.jpg\>\</A\>  
	\<IFRAME SRC= “[http://count.com/?wid=ccc](http://count.com/?wid=ccc) width=“1px” height=“1px” \>

L’ultimo elemento HTML è per le informazioni di analytics. E’ accettabile l’uso di un elemento IMG invece di un elemento IFRAME. L’uso di un URL per le informazioni di analytics senza query string, o comunque che non contenga un identificatore univoco di org.com è accettabile (nella realtà è sempre presente perché semplifica la realizzazione del servizio di analytics ma da un punto di vista strettamente tecnico non è necessario).

**Punto 2** Una possibile sequenza è la seguente (tutto il traffico è tra browser e proxy; richiesta a sinistra, risposta a destra; evento A: 1-3, evento B: 4-5):

| 1 | GET / Host: org.com … L.V. | 200 OK Content-type: text/html Content-length: N1 Set-Cookie: c1 … L.V. \<doc\> |
| :---- | :---- | :---- |
| 2 | GET i.jpg Host: org.com Referrer: [http://org.com/](http://org.com/) Cookie:c1 L.V.  | 200 OK Content-type: img/jpg Content-length: N2 Cache-control: public max-age=3600 … L.V. \<img\> |
| 3 | GET ?wid=ccc Host: count.com Referrer: [http://org.com/](http://org.com/) L.V. | 200 OK Content-type: text/html Content-length: N3 Set-Cookie: c1-c … L.V. \<doc\> |
| 4 | GET c.pdf Host: org.com Referrer: [http://org.com/](http://org.com/) Cookie:c1 … L.V. | 401 Unauthorized WWW-Authenticate: Basic realm= “pdfs” ... |
| 5 | GET c.pdf Host: org.com Referrer: [http://org.com/](http://org.com/) Cookie:c1 Authorization: Basic *u:p* … L.V. | 200 OK Content-type: application/pdf Content-length: N4 … L.V. \<pdf-doc\> |

La coppia u:p nella richiesta 5 sono username e password codificate in Base64.

**Punto 3**: una possibile sequenza di accessi è la seguente:

| 1 | GET d/a.html Host: org.com Referrer: [http://org.com/](http://org.com/) Cookie:c1 … L.V. | 200 OK Content-type: text/html Content-length: N5 … L.V. \<pdf-doc\> |
| :---- | :---- | :---- |
| 2 | GET d/i.jpg Host: org.com Referrer: http://org.com/d/a.html Cookie:c1 L.V.  | 200 OK Content-type: img/jpg Content-length: N6 Cache-control: public max-age=3600 … L.V. \<img\> |
| 3 | GET ?wid=ccc Host: count.com Referrer: http://org.com/d/a.html Cookie: c1-c L.V. | 200 OK Content-type: text/html Content-length: N3 … L.V. \<doc\> |

Richiesta 1: Il documento d/a.html appartiene ad un realm che richiede autenticazione. La sessione è già stata autenticata quindi non occorre una ulteriore autenticazione. Il fatto che questo documento appartenga al realm pdfs per il quale è stata effettuata l’autenticazione in precedenza è irrilevante, in quanto entrambi i realm sono associati allo stesso protocollo di autenticazione (la prova di identità da fornire è quindi la stessa per i due realm).

Richiesta 3: L’elemento HTML per le informazioni di analytics deve essere lo stesso in ogni pagina di org.com (quindi è lo stesso prelevato con la richiesta 3 del punto precedente).

Usare un elemento diverso per ogni pagina non ha senso: complica inutilmente la costruzione del sito org.com e non fornisce nessuna funzionalità utile per il servizio di analytics. In particolare, ciò non ha nulla a che vedere con la possibilità per il servizio di analytics di mantenere il conteggio con granularità di pagina (il valore dello header Referrer è sufficiente a tale scopo).

**Punto 4** Traffico identico a quello sopra descritto al punto 2, in quanto il tab in incognito usa una tabella dei cookie inizialmente vuota (i valori dei cookie assegnati dai server saranno ovviamente diversi da quelli assegnati prima).

**Punto 5** Poiché la navigazione avviene attraverso il proxy, il solo nome risolto dal browser è quello del proxy. Ciò avviene inviando una richiesta di tipo A al default name server.

Errori relativamente comuni:

* Browser risolve i nomi org.com e count.com (molto grave).

  Questo errore implica seri problemi di comprensione delle basi della comunicazione client-server. Nella primissima lezione è stato descritto il comportamento dei client: ottiene indirizzo IP del server, apre connessione TCP verso quell’indirizzo IP. Se il browser risolve il nome org.com allora significa che il browser apre una connessione con IP(org.com), il che non ha senso proprio perché il browser, in questo esercizio, naviga su web attraverso proxy.

  Uno potrebbe confusamente pensare che “il browser ottiene l’indirizzo IP di org.com e poi lo passa al proxy”. Avere questo in testa è ancora peggio: innanzitutto per “passare” qualcosa al proxy occorre una connessione con il proxy, quindi come prima cosa il browser deve avere l’indirizzo IP del proxy e quindi deve averne risolto il nome. Dopo avere aperto la connessione con il proxy, quale protocollo usa il browser per “passare l’indirizzo IP di org.com”? Non può che usare HTTP perché con il proxy si può comunicare solo con HTTP. Esiste una qualche richiesta HTTP con la quale si trasmette un indirizzo IP? L’unico modo sarebbe POST verso un URL del proxy predisposto a ricevere informazioni dal browser. Abbiamo mai discusso procedimenti di questo genere? Ancora: il proxy potrebbe chiudere la connessione con il browser dopo avere ricevuto la POST; a questo punto cosa ne fa dell’indirizzo IP? E’ ovvio che questo procedimento è enormemente complicato e non ha senso.  
* Come sopra, in maniera iterativa. Stessa gravità del punto precedente, aggravata dal fatto che il browser risolve i nomi attraverso il name server, quindi in maniera ricorsiva.  
* Come sopra, con traffico DNS non con il name server ma con il proxy (gravità tendente a infinito per motivi che non vale neanche la pena di approfondire: con il proxy si comunica solo HTTP. Che senso ha inviargli richieste in un altro protocollo?)

## Web 7

### *Parte A*

*Il sito web nameA.org utilizza il servizio di analytics count.com ed il servizio di tracking track.org. La home page del sito contiene le immagini “img1.jpg”, “img2.jpg”, un link con valore dell’attributo HREF “dir”, un link con valore dell’attributo HREF “http://www.units.it/dir”. Tutte le pagine del sito includono uno script (lo stesso script per tutte le pagine) ed il foglio di stile “bellissimo.css”.*

*Un browser B1 visualizza la home page del sito web attraverso il proxy P. Un browser B2 visualizza la home page del sito web direttamente, senza passare da un proxy. Sia W la pagina del sito identificata dal primo dei link indicati.*

1. *Fornire un possibile codice HTML per la home page del sito e per W.*  
2. *Descrivere il traffico DNS trasmesso e ricevuto da B1, da B2, da P, da track.org.*  
3. *Descrivere il traffico HTTP trasmesso e ricevuto da B1, da B2, da P.*  
4. *Con riferimento al solo traffico HTTP, stimare il numero di invocazioni delle procedure socket e listen effettuate da B1, da B2, da P, motivando brevemente la risposta.*

### *Parte B*

*La pagina W appartiene al realm “protected”, al quale è permesso l’accesso solo agli utenti autenticati. Gli utenti non autenticati sono rediretti verso una pagina di login il cui URL relativo rispetto alla home page è “whoareyou”. L’autenticazione avviene con modalità FORM ed il web server si attende di ricevere i valori di username e password associati ai nomi, rispettivamente, x ed y.*

*Quando B1 ha visualizzato la home page, l’utente clicca sul link che provoca la visualizzazione di W (l’utente possiede credenziali di autenticazione valide). Lo stesso accade per B2.*

1. *Descrivere le modifiche al codice HTML fornito al punto precedente per la home page e per W.*  
2. *Descrivere un possibile contenuto per il form contenuto nella pagina di login.*  
3. *Descrivere il traffico HTTP trasmesso e ricevuto da B1, da B2, da P per visualizzare W.*

## Svolgimento

### Parte A

**Punto 1**  
Un possibile codice HTML per la home page, limitato alle sole informazioni specificate nel testo, è:  
…  
\<LINK HREF=”bellissimo.css”\>  
\<IMG src=”img1.jpg”\>\</IMG\>  
\<IMG src=”img2.jpg”\>\</IMG\>  
\<A href=”dir”\>qualche testo\</A\>  
\<A href=”http://www.units.it/dir”\>qualche altro testo\</A\>  
\<SCRIPT src=”script.js\>\</SCRIPT\>  
…  
\<IFRAME src=”[http://count.com/a.jpg](http://count.com/a.jpg)”\>\</IFRAME\>  
\<IFRAME src=”[http://track.org/a.jpg](http://track.org/a.jpg)”\>\</IFRAME\>  
…

Un possibile codice HTML per W, limitato alle sole informazioni specificate nel testo, è:  
…  
\<LINK HREF=”bellissimo.css”\>  
\<SCRIPT src=”script.js\>\</SCRIPT\>  
…  
\<IFRAME src=”[http://count.com/a.jpg](http://count.com/a.jpg)”\>\</IFRAME\>  
\<IFRAME src=”[http://track.org/a.jpg](http://track.org/a.jpg)”\>\</IFRAME\>  
…

**Punto 2**  
B1 accede al web attraverso il proxy P, quindi il solo traffico DNS che genera è quello necessario a risolvere il nome del proxy. Assumiamo che tale nome sia px.someorg.com. Per risolvere i nomi, B1 comunica esclusivamente con il name server della propria organizzazione:  
px.someorg.com A ?  
px.someorg.com A IP-px

B2 accede al web direttamente. Deve quindi risolvere i nomi nameA.org, count.com, track.org. Per risolvere i nomi, B2 comunica esclusivamente con il name server della propria organizzazione (nel testo non è specificato se è la stessa di B1 o no, ma è un dettaglio irrilevante):  
nameA.org A ?			  
nameA.org A IP-1			  
count.com A ?			  
count.com A IP-2  
track.org A ?			  
track.org A IP-3

P genera lo stesso traffico DNS generato da B2 (P comunica con il name server della propria organizzazione).

**Punto 3**  
Il traffico HTTP trasmesso da B1 è quello necessario per prelevare i documenti/risorse seguenti:

1. http://nameA.org  
2. http://nameA.org/bellissimo.css  
3. http://nameA.org/img1.jpg  
4. http://nameA.org/img2.jpg  
5. http://nameA.org/script.js  
6. http://count.com/a.jpg  
7. http://track.org/a.jpg

Sono necessarie 6 coppie richiesta/risposta HTTP. Si omette il traffico in questo svolgimento **(ma in un esame è indispensabile metterlo)**. 

Il traffico HTTP trasmesso da B2 e da P è identico a quello sopra descritto. La sola differenza è nel web server coinvolto nelle interazioni (quindi nei valori dei cookie): B1 contatta sempre P, B2 e P contattano sempre i web server specificati negli URL.

**Punto 4**  
Per le invocazioni di socket e listen, occorre notare che socket viene invocato sia dai client sia dai server mentre listen viene invocato solo dai server. Quindi socket viene invocato da B1, B2, P mentre listen viene invocato solo da P.

Il numero di invocazioni di listen su B1 e B2 è zero (B1 e B2 operano solo da client). Per quanto riguarda P, P opera da server e crea un welcoming socket quindi invoca socket, poi bind, poi listen. Indipendentemente dal numero di client che si collegheranno a P, P non invocherà più nessuna di queste 3 procedure (invocherà solo accept, una volta per ogni client). Pertanto il numero di invocazioni di listen su P è 1\.

Il numero di invocazioni di socket su B1 è uguale al numero di connessioni TCP tra B1 e P. Questo numero può variare tra 1 ed il numero di risorse prelevate da B1 (che si deriva dal traffico HTTP già scritto: 7).

Il numero di invocazioni di socket su B2 è uguale al numero di connessioni TCP tra B2 ed ognuno dei 3 web server con i quali si collega (nameA.org per la pagina web, count.com per analytics e track.org per tracking). Per nameA.org questo numero può variare tra 1 e il numero di risorse prelevate su nameA.org (che si deriva dal traffico HTTP già scritto: 5); per count.com questo numero è 1; per track.org questo numero è 1\. Quindi il numero di invocazioni di socket su B2 varia tra 1+1+1=3 e 5+1+1=7.

Il numero di invocazioni di socket su P si determina come segue:

* Per la comunicazione con B1 opera da server; quindi invoca socket solo una volta (come già osservato più sopra, invoca socket solo per creare il welcoming socket);  
* Per la comunicazione con i web server per prelevare le risorse richieste da B1 opera da client; quindi il numero di invocazioni di socket è uguale al numero di connessioni TCP tra P ed ognuno dei 3 web server con i quali si collega. Questa quantità si determina con lo stesso ragionamento fatto per B2, quindi varia tra 3 e 7\. Il numero di invocazioni di socket su P varia quindi tra 1+3=4 e 1+7=8.

Ricapitolando:

|  | Inv. Socket min | Inv. Socket max | Inv. Listen min | Inv. Listen max |
| :---- | :---- | :---- | :---- | :---- |
| B1 | 1 | 7 | 0 | 0 |
| B2 | 3 | 7 | 0 | 0 |
| P | 4 | 8 | 1 | 1 |

### Osservazioni

* Un proxy si comporta da web server nei confronti dei browser e si comporta da browser nei confronti dei web server. Questo significa che i browser comunicano con il proxy **solo su HTTP**. I browser **non** inviano richieste DNS al proxy ed il proxy non “risolve nomi per conto dei browser”. Non capisco quale slide o mia affermazione possa avere fatto pensare il contrario (non è una affermazione polemica: se ci sono stati malintesi fatemi sapere). Ho ribadito questo punto anche in un email inviato in mailing list il giorno prima dell’esame.  
* Un proxy non ha nessuno status particolare dal punto di vista della risoluzione dei nomi. Esattamente come ogni altro processo (ad eccezione dei name server), invia le proprie richieste DNS al name server della propria organizzazione e riceve sempre il RR che ha richiesto senza necessità di navigare nel domain tree (risoluzione iterativa). Non capisco quale slide o mia affermazione possa avere fatto pensare il contrario (non è una affermazione polemica: se ci sono stati malintesi fatemi sapere).  
* Il testo non diceva che nella parte A veniva prelevato il documento W. Quindi non c’è, in questa parte, traffico HTTP per il prelievo di W. Ho fatto finta di nulla.

### Osservazioni importanti sulla comprensione del testo

Pochissime persone hanno fornito una risposta appropriata alla domanda “*stimare il numero di invocazioni delle procedure socket e listen effettuate da B1, da B2, da P, motivando brevemente la risposta”.* Non mi riferisco al valore numerico della stima o al ragionamento fatto sull’utilizzo delle procedure. Questi errori si possono risolvere studiando meglio. Mi riferisco alla **enorme differenza** tra ciò che è stato chiesto e ciò che è stato fornito. Questo è un problema molto più profondo e che non si può risolvere studiando meglio. Occorre cambiare il proprio modo di leggere e di riflettere.

Leggendo il testo è evidente che occorre fornire 2 stime per B1, 2 stime per B2, 2 stime per P. Quindi almeno 6 informazioni. Ogni stima è una coppia di numeri, eventualmente identici se la stima è certa. Pertanto, in parole povere, erano richiesti “qualche numero per B1”, “qualche numero per B2” e “qualche numero per P”. E’ ovvio che uno svolgimento in cui non siano presenti queste informazioni è inadeguato.

Non è detto che uno debba fornire necessariamente una tabella come nello svolgimento qui sopra, si può rispondere in tanti modi, in questo caso anche narrativi. Ma non si può rispondere alla richiesta di un chilo di mandarini con una scatola da scarpe:

1. “Invocazioni di socket e listen N” (senza differenziare tra B1/B2/P).  
   2. “Numero di connessioni TCP N” (senza differenziare tra B1/B2/P, senza spiegare che relazione c’è tra il numero di connessioni ed il numero di invocazioni).  
   3. “Bind la invocano i server mentre socket la invocano i client” (senza nessuna stima, senza differenziare tra B1/B2/P)  
   4. “P è l’unico che invoca accept/bind/listen almeno 1 volta” (valore massimo della stima? Invocazioni di socket? B1 e B2?).  
   5. “Bind è presente solo sul server” (tralasciando il significato di “presente”, come sopra).  
   6. “Analogo al traffico DNS” (che analogia ci può essere tra una sequenza di messaggi applicativi ed una stima del numero di invocazioni?).  
   7. ...

Questo è un esempio lampante dell’importanza di due suggerimenti che ho dato più e più volte a lezione ma che probabilmente sono sembrati ovvi, inutili o una mia fissazione:

1. Capire cosa chiede esattamente un esercizio.  
2. Distinguere in maniera immediata ed istintiva tra entità di tipo diverso.

Il punto 1, in particolare, è enormemente importante. Non tanto per il superamento di questo esame, ma per la vostra vita professionale. E’ una “challenge” enormemente più semplice di quelle che si affrontano ogni volta che si deve lavorare in un gruppo su tematiche di carattere tecnologico. Se ti dicono di fare X e tu fai Y, allora fai perdere tempo e di conseguenza crei problemi al tuo gruppo. Se non ti rendi neanche conto della differenza tra X ed Y e ti sembra normale o comunque accettabile consegnare Y è anche peggio. Estremizzo e sintetizzo brutalmente per essere più comprensibile, ma il mondo funziona così. Prima uno se ne convince e meglio è.

Riuscire a mettere in pratica 1 e 2 richiede un lungo allenamento mentale. Qualcuno ci riesce prima e meglio, qualcuno impiega più tempo e ci riesce solo in parte. Il punto fondamentale è che non si tratta di studiare di più o di studiare meglio. Si tratta di cambiare il proprio modo di riflettere di fronte ad un problema.

Spero sia evidente che non ho scritto questa noiosissima sezione per mia fissazione o perché sono il classico docente fissato che vuole vedere le cose fatte come vuole lui e non accetta altre impostazioni (moltissimi errori che ho segnalato hanno impatto nullo e moltissimi altri errori non li ho neanche segnalati). Ho scritto queste cose perché credo che siano molto importanti per la vostra formazione. Scrivere questi pistolotti soporiferi richiede molto tempo.

### Parte B

**Punto 1**  
Non sono necessarie modifiche al codice HTML già fornito.

**Punto 2**  
Un possibile contenuto per il form di autenticazione nella pagina di login (il cui URL relativo è whoareyou) è:  
..  
\<FORM ACTION=”validation” METHOD=”POST”\>  
Username:\<INPUT TYPE=”TEXT” NAME=”x”\>  
Password:\<INPUT TYPE=”PASSWORD” NAME=”y”\>  
\</FORM\>  
…

**Punto 3**  
Il traffico generato da B1 sarà il seguente (il server è il proxy):

GET dir  
Host: nameA.org  
Cookie: ID=897682465  
…  
LV  
					301 Found  
					Location: [http://nameA.org/whoareyou](http://nameA.org/whoareyou)  
					…  
					LV  
GET whoareyou  
Host: nameA.org  
Cookie: ID=897682465  
…  
LV  
					200 ok  
					Content-type: text/html  
					Content-length: 2780  
					…  
					LV  
					Documento HTML contenente FORM

POST validation  
Host: nameA.org  
Cookie: ID=897682465  
Content-type: x-www-form-urlencoded  
Content-length: 40  
…  
LV  
x=zlatan\&y=rosenborg  
					200 ok  
					Content-type: text/html  
					Content-length: 4356  
					…  
					LV  
					Documento W

Il valore dell’URL nella richiesta POST deve essere coerente con il contenuto fornito per il form al punto precedente (deve cioè essere identico al valore dell’attributo ACTION).

Il browser dovrà poi prelevare le risorse contenute in W. Dal testo dell’esercizio si rileva che queste risorse sono il foglio di stile, lo script, le risorse per analytics e tracking (il server è ancora il proxy):  
http://nameA.org/bellissimo.css  
http://nameA.org/script.js  
http://count.com/a.jpg  
http://track.org/a.jpg  
Si omette il traffico in questo svolgimento **(ma in un esame è indispensabile metterlo)**. 

Il traffico generato da B2 sarà identico a quello sopra descritto, con le differenze seguenti:

* Il valore dei cookie è diverso;  
* il server non è il proxy ma è quello su cui risiedono le risorse;

Il traffico generato da P sarà identico a quello sopra descritto per B1, con le differenze seguenti:

* il server non è il proxy ma è quello su cui risiedono le risorse;

### Osservazioni

* Rendere un documento accessibile solo tramite autenticazione non richiede **nessuna** modifica al contenuto di quel documento. E’ sufficiente configurare in maniera opportuna i realm sul web server, in modo che il web server sappia quali documenti possono essere inviati solo in sessioni autenticate (l’aggiunta della autorizzazione, cioè di vincoli sugli username in questo contesto è irrilevante). Non capisco quale slide o mia affermazione possa avere fatto pensare il contrario (non è una affermazione polemica: se ci sono stati malintesi fatemi sapere).

* Sono rimasto stupefatto dalla enorme quantità di persone che hanno fatto l’errore al punto precedente. In estrema sintesi, hanno inserito il FORM all’interno della pagina da proteggere, come “aggiunta al codice HTML”. Questo è un errore gravissimo: Se il documento da proteggere fosse stata una immagine, o un file audio, o un file eseguibile, cosa sarebbe successo? Un FORM dentro ad un file audio?

  Un errore di questo genere fornisce anche al lettore l’impressione di un approccio sbagliato: svolgimento “automatico”, senza pensare a ciò che sta scrivendo. Se il browser preleva un testo HTML X concatenato con un FORM HTML, allora X è già arrivato al browser. Cosa si può proteggere in questa situazione? Non certo X. Inoltre, perché l’utente dovrebbe inserire delle credenziali ed inviarle al web server per prelevare informazioni che ha già prelevato?

  Ciò che mi ha reso ancora più perplesso è il fatto che molti di questi errori sono stati accompagnati da una descrizione corretta del traffico. Il browser chiede il documento protetto (in cui è stato detto che viene inserito un FORM) ed il web server risponde con una redirection verso una pagina di login: allora a che serve il FORM che è stato inserito? Il browser preleva poi la pagina di login, invia le credenziali verso la locazione corretta e riceve dal server il documento protetto: questo è il solo momento in cui il browser vede il FORM che è stato inserito nel codice HTML di quel documento. Il web server ha già inviato quel documento ed il browser non fa nulla con quel FORM.

## Web 8

*Il sito web williams.es ha un realm di nome Fortissimo al quale appartengono tutti i documenti con estensione html. Questo realm richiede autenticazione FORM e permette l’accesso solo all’utente nico. Tutti i documenti con estensione html hanno lo stesso contenuto. Il sito web usa il servizio adsense.com per effettuare il conteggio delle visite, con granularità sulla singola pagina e con conteggi differenziati per tipologia di browser (es: pc vs smartphone).*

*Il documento https://williams.es/i.html contiene: uno script che si trova su williams.es ed ha URL relativo sc.js; due immagini che si trovano su williams.es ed hanno URL relativo i.jpg, k.jpg; 3 link a documenti html che si trovano su williams.es ed hanno URL relativo b1.htm, b2.html, b3.html.*

*L’utente nico possiede un PC ed uno smartphone; entrambi navigano su web attraverso un proxy. Con riferimento a questo utente, si consideri la sequenza di eventi:*

*A) preleva il documento https://williams.es/i.html con successo da PC;*  
*B) effettua un click sul link verso b2.html e preleva il documento corrispondente con successo;*  
*C) preleva il documento https://williams.es/i.html con successo da smartphone.*

1. *Descrivere un possibile contenuto del documento i.html ricevuto dal browser nell’evento A e quello ricevuto dal browser nell’evento C. Dove è possibile usare URL relativi devono essere usati URL relativi.*  
2. *Descrivere con un livello di dettaglio “adeguato” tutto il traffico HTTP trasmesso e ricevuto dal browser, indicando chiaramente la separazione tra i 3 eventi A, B, C. Eventuali form html contenuti nel traffico devono essere descritti per esteso.*  
3. *Ripetere il punto 1 assumendo che PC e smartphone navighino su web direttamente (non attraverso un proxy). E’ sufficiente elencare chiaramente le differenze rispetto al punto 1\.*

**Punto 1** Un possibile contenuto è indicato di seguito (**identico** per i due eventi)

\<html\>  
Some text here and there….  
\<script src= “sc.js”\>\</src\>  
\<img src= “i.jpg”\>\</img\>  
\<img src= “k.jpg”\>\</img\>

\<a href= “b1.html”\>link 1\</a\>  
\<a href= “b2.html”\>link 2\</a\>  
\<a href= “b3.html”\>link 3\</a\>

\<iframe src= “[adsense.com/w=hgs](https://adsense.com/w=hgs)” height= “1px” width= “1px”\>\</iframe\>  
\</html\>

**Punto 2**

Evento A

| GET /i.html Host: williams.es Accept-Language: en User-Agent: … LV | 301 found Location: [https://williams.es/login.html](https://pioli.it/login.html) Set-Cookie: id=id-p LV |
| :---- | :---- |
| GET login.html Host: williams.es Cookie: id=id-p … LV | 200 ok Content-type: text/html Content-length: 500 … LV \<html\> … \<FORM action= “validate.jsp” method= “post”\> Username: \<input type= “text” name= “u”\> Password: \<input type= “password” name= “p”\> \</FORM\> \</html\> |
| POST validate.jsp Content-type: application/x-www-form-urlencoded Content-length: 32 Cookie: id=id-p Host: williams.es LV u=nico\&p=somepassword | 200 OK Content-type: text/html Content-length: 2500 … LVdocumento descritto al punto 1 |
| *più 4 coppie request-response qui omesse: 3 verso williams.es, per prelevare script ed immagini, con il cookie id-p; 1 verso adsense.com per prelevare iframe, senza cookie o con un altro cookie; se senza cookie allora la risposta deve contenere un cookie  evento B analogo, con browser già autenticato evento C analogo all’evento A* |  |

Evento B

| GET /b2.html Host: williams.es Accept-Language: en User-Agent: … Referrer: https://williams.es/i.html Cookie: id=id-p LV | 200 OK Content-type: text/html Content-length: 2500 … LVdocumento b2.html |
| :---- | :---- |
| *più 4 coppie request-response qui omesse: 3 verso williams.es, per prelevare script ed immagini, con il cookie id-p; 1 verso adsense.com per prelevare iframe, con il cookie di adsense.com* |  |

Evento C

Identico all’evento A, con queste differenze: il valore dello User-Agent sarà diverso (la tipologia di browser dello smartphone è diversa da quella del PC); il valore dei cookie sarà diverso.

**Punto 3**

Identico al punto 1

# EMAIL

## EMAIL 1

*L'utente john@lecarre.uk invia un messaggio email diretto a jo@nesbo.no. L'infrastruttura DNS contiene i RR indicati di seguito:*

*lecarre.uk MX mail.lecarre.uk*  
 	*nesbo.no MX mail.lecarre.uk*  
 	*mail.lecarre.uk A IPC*

1. *Elencare i RR che, eventualmente, devono essere aggiunti ai RR qui sopra affinché siano possibili invio, ricezione e prelievo del messaggio email.*  
2. *Elencare le richieste e risposte inviate dal mail client del mittente all'infrastruttura DNS per l'invio del messaggio (si assuma che il messaggio sia effettivamente inviato). Per ogni messaggio indicare l'indirizzo IP del DNS server che invia o riceve quel messaggio.*

**Punto 1**. I mail client sono configurati con il nome del mail server. Il mail server del mittente è quello del dominio email lecarre.uk. I RR presenti permettono di ottenere il nome del mail server e l’indirizzo IP del mail server. Quindi l’invio è possibile.

Il messaggio deve essere recapitato ad un utente del mail server del dominio nesbo.no; i RR presenti permettono di ottenere nome ed indirizzo IP del mail server (il mail server è lo stesso per i domini mittente e ricevente, ma ciò è irrilevante). Quindi la ricezione è possibile.

Il mail server del destinatario è quello del dominio nesbo.no. I RR presenti permettono di ottenere nome ed indirizzo IP del mail server quindi anche il prelievo è possibile.

**Punto 3\.** I mail client sono configurati con il nome del mail server. Occorre determinare il nome di questo server.

Poiché il mittente è john@lecarre.uk, il mail client deve essere configurato con il nome del mail server responsabile per il dominio email lecarre.uk; quindi occorre considerare il RR con nome lecarre.uk e type MX; il valore di quell'RR è mail.lecarre.uk. Il mail client quindi conosce quel nome in configurazione; per collegarsi con il server che ha quel nome dovrà fare una richiesta di tipo A per quel nome. Il mail client del mittente invia quindi una sola request e riceve una sola response:

→	mail.lecarre.uk	 A ?			IP-NS  
←	mail.lecarre.uk A IPC			IP-NS

Ogni mail client (come ogni dispositivo utente) è configurato per collegarsi con il name server della propria organizzazione. Si è indicato con IP-NS l’indirizzo IP di tale name server.

### Osservazioni

* Notare che il mail client del mittente **non** contatta il mail server del destinatario.  
* Notare che il testo **non** richiedeva il traffico tra i name server; richiedeva solo il traffico tra mail client e name server.  
* E’ possibile che un mail client sia configurato, invece che con il nome del proprio mail server, con il nome del dominio email della propria mailbox oppure con l’indirizzo IP del mail server. Nel primo caso, ci sarebbero state due request e la prima sarebbe stata lecarre.uk MX ?; nel secondo caso non ci sarebbe stata nessuna request. In ogni caso, sarebbe stato necessario esplicitare come ipotesi che si sono assunte queste configurazioni alternative.

## EMAIL 2

*Un utente desidera inviare un messaggio email. Il mittente ha indirizzo anastasi@cs.acm.org, il destinatario ha indirizzo gregori@cnuce.cnr.it.*

*Si descrivano:*

1. *Tutti i RR con suffisso cs.acm.org contenenti la stringa “anastasi”.*  
2. *Tutti i RR con suffisso cnuce.cnr.it contenenti la stringa “gregori”.*  
3. *Tutti i RR che devono essere presenti nel DNS affinché il messaggio sia inviato ed arrivi a destinazione (i RR necessari per descrivere zone e name server possono essere omessi).*  
4. *Le interazioni eseguite dal mail client del mittente per inviare il messaggio e dal mail client del ricevente per prelevare il messaggio. La descrizione deve specificare anche il mail server che partecipa a questa interazione ed il modo con il quale il mail client ottiene l’indirizzo IP di questo server.*

Punto 1\. Non è possibile rispondere alla domanda in quanto non sono fornite informazioni sufficienti. In particolare, il fatto che esista una mailbox di nome anastasi nel dominio email di nome cs.acm.org non ha **nessuna** relazione con il numero di RR contenenti la stringa “anastasi” (le mailbox non sono descritte nel DNS).

Punto 2\. Come il punto 1\.

Punto 3\. Occorre che siano descritti il dominio email mittente e ricevente, i mail server corrispondenti. Un possibile insieme di RR è quindi il seguente:

cs.acm.org 		MX	mail.cs.acm.org  
mail.cs.acm.org	A	IP-1  
cnuce.cnr.it 		MX	mail.cnuce.cnr.it  
mail.cnuce.cnr.it	A	IP-2

Si è qui ipotizzato che i nomi dei mail server appartengano alla stessa zona a cui appartengono i nomi dei domini email.

Punto 4\. Ogni mail client si collega con il mail server della propria organizzazione di appartenenza. Quindi il mail client del mittente si collega con il server di indirizzo IP-1 mentre il mail client del ricevente si collega con il server di indirizzo IP-2. In entrambi i casi, il mail client ottiene l’indirizzo IP in base alle informazioni di configurazione, come segue.

Interazioni DNS:

| → | Mail client mittente | cs.acm.org MX ? | Name server della organizzazione a cui appartiene il mail client mittente |
| :---- | :---- | :---- | :---- |
| ← | Idem | cs.acm.org MX mail.cs.acm.org | Idem |
| → | Idem | mail.cs.acm.org A ? | Idem |
| ← | Idem | mail.cs.acm.org A IP-1 | Idem |
|  |  |  |  |
| → | Mail client ricevente | cnuce.cnr.it MX ? | Name server della organizzazione a cui appartiene il mail client ricevente |
| ← | Idem | cnuce.cnr.it A mail.cnuce.cnr.it | Idem |
| → | Idem | mail.cnuce.cnr.it A ? | Idem |
| ← | Idem | mail.cnuce.cnr.it A IP-2 | Idem |

Interazioni SMTP:

| *Mail client mittente* | *IP-1* |
| :---- | :---- |
|  | 220 mail server ready |
| HELO cs.acm.org |  |
|  | 250 |
| MAIL FROM: \<anastasi@cs.acm.org\> |  |
|  | 250 |
| RCPT TO: \<gregori@cnuce.cnr.it\> |  |
|  | 250 |
| DATA |  |
|  | 354 |
| *Trasmissione messaggio* |  |
| *.* |  |
|  | 250 |
| QUIT |  |
|  | 221 |

| *Mail client ricevente* | *IP-2* |
| :---- | :---- |
|  | \+OK server ready |
| USER gregori |  |
|  | \+OK |
| PASS password-di-gregori |  |
|  | \+OK |
| LIST |  |
|  | \+OK |
|  | 1 7500 |
|  | . |
| RETR 1 |  |
|  | \+OK |
|  | *Trasmissione messaggio* |
|  | . |
| DELE 1 |  |
|  | \+OK |
| QUIT |  |
|  | \+OK |

## EMAIL 3

*La mailbox mitici@googlegroups.com è configurata da mailing list. Le mailbox appartenenti alla mailing list sono ricky@kaka.br, andriy@sheva.ua, ruud@ruud.gullit.nl.*  
*1\.  Elencare gli RR che devono esistere nel DNS per permettere l’esistenza di tutte queste mailbox.*  
*2\. Si consideri un mail client configurato per il prelievo della email dalla mailbox ricky@kaka.br; elencare le DNS request inviate da tale mail client e le corrispondenti DNS response per:*  
*a)   	il prelievo della email;*  
*b)   	la trasmissione di un email destinato alla mailbox carlo@ancelotti.it.*

**Punto 1** Per permettere l’esistenza delle mailbox elencate è necessario che nel DNS esistano i RR di tipo MX che descrivono i domini email corrispondenti ed i RR di tipo A che descrivono i mail server responsabili per quei domini email.

Una possibilità è quella indicata di seguito, in cui si assume che i mail server abbiano nome mx.*nomedominioemail*

googlegroups.com		MX	mx.googlegroups.com  
mx.googlegroups.com	A	IP-1

kaka.br			MX	mx.kaka.br  
mx.kaka.br			A	IP-2

sheva.ua			MX	mx.sheva.ua  
mx.sheva.ua			A	IP-3

ruud.gullit.nl			MX	mx.ruud.gullit.nl  
mx.ruud.gullit.nl		A	IP-4

(si omettono i RR corrispondenti ai domini che separano ognuno dei domini qui elencati dalla root del DNS)

Osservazioni

* Inserire indirizzi email nel DNS, nel campo nome oppure nel campo valore, di un RR di un qualsiasi tipo significa non avere capito nulla della architettura email.  
* La coppia MX/A per googlegroups.com è necessaria perché altrimenti sarebbe impossibile inviare email ad una mailing list (una mailing list è una mailbox con una configurazione particolare specificata nel mail server).  
* Associare un dominio email di mailbox appartenente alla mailing list al mail server della mailing list non ha senso (ad esempio kaka.br MX mx.googlegroups.com): in quel modo tutte le connessioni verso quel dominio email andrebbero verso il mail server che gestisce la mailing list.  
* Rispondere con (qualche variante di) “le mailbox non sono descritte nel DNS” significa non avere compreso il testo. Quella frase è vera, ma non è ciò che viene chiesto nel testo dell’esercizio.

**Punto 2** Se il mail client è configurato con il nome del dominio email allora il traffico DNS per il prelievo della email sarà:

→	kaka.br	MX	?	  
	←	kaka.br	MX	mx.kaka.br  
		mx.kaka.br	A	IP-2

La richiesta è inviata dal mail client al name server dell’organizzazione alla quale appartiene il mail client e la risposta è inviata da quel name server. Se invece il mail client è configurato con il nome del mail server allora la richiesta sarà mx.kaka.br A ?

Non c’è traffico DNS per la trasmissione email: i RR necessari sono sempre quelli sopra indicati, quindi il mail client li troverà nel DNS resolver del proprio nodo (ripetere quel traffico comunque è corretto in quanto il mail client invia le richieste).

Osservazioni

* Descrivere traffico DNS per localizzare la mailbox di destinazione è gravemente sbagliato: è richiesto il traffico originato dal mail client ed un mail client non contatta mai il mail server di destinazione, contatta sempre e solo il mail server per il quale è configurato (quello della “propria mailbox”).  
* Descrivere traffico che abbia a che fare con googlegroups.com è gravemente sbagliato: il mail client che preleva il contenuto della mailbox ricky@kaka.br deve collegarsi sempre e solo con il mail server in cui si trova quella mailbox: primo, perché gli email inviati alla mailing list proseguono fino ad essere depositati in ogni mailbox della mailing list; secondo, perché quella mailbox può ovviamente ricevere email che non erano stati indirizzati alla mailing list.  
* Dire che non è possibile trasmettere perché il testo dice che il mail client è configurato per il prelievo non ha senso. Capisco il “ragionamento” ma non posso considerarlo corretto. Sarebbe come dire che il mail client deve essere in esecuzione su un PC acceso e collegato alla rete elettrica e la rete elettrica deve avere la tensione corretta (oppure collegato alla batteria e deve essere carica). La descrizione di uno scenario di esercizio non può mai descrivere lo scenario per intero: assumere che quello che non è descritto non esiste o impedisce la situazione ovviamente attesa è eccessivo.  
* Descrivere il dettaglio delle interazioni SMTP e/o POP è inutile e dannoso: fa perdere tempo, non risponde alla domanda, trasmette al lettore l’impressione di avere le idee molto confuse. Usare tali interazioni come sostitutive del traffico DNS è uno degli errori peggiori in assoluto che si possono commettere: equivale a scegliersi il testo dell’esame da solo (provate nella vita professionale a fare una cosa completamente diversa da quella che vi viene richiesta e poi mi raccontate l’effetto).

# SOCKET \+ WEB / EMAIL

## Socket 1

*Un nodo D ... esegue un browser ed un mail client. Elencare i socket esistenti su D, in un istante in cui:*

* *il browser ha un tab su www.corriere.it,*  
* *un tab su www.facebook.com (con HTTPS),*  
* *un tab su www.units.it;*  
* *il mail client sta trasmettendo email e prelevando email.*

*Per ogni socket, indicare:*

* *indirizzo IP locale, numero di porta locale*  
* *indirizzo IP remoto, numero di porta remoto*  
* *protocollo usato (TCP o UDP).*

Browser e mail client sono programmi client. Su D non ci sono programmi server (più precisamente non sono menzionati nell’esercizio).

Browser: All’istante considerato ha 3 tab aperti, consideriamo che abbia una connessione per ogni tab. Mail client: trasmissione e prelievo di email avvengono su connessioni TCP diverse, quindi due connessioni.

I socket sono quindi 3+2=5. Le informazioni richieste per ogni socket sono 5\. IP-locale è lo stesso per tutti i socket: IP-D; protocol è lo stesso per tutti i socket: TCP; port-local è scelto dal sistema operativo in modo che sia superiore a 1024 e diverso da ogni altro numero di porta su D.

Le altre 2 informazioni per ogni socket sono:

* Socket verso www.corriere.it: port-remote: 80, IP-remote: indirizzo IP del server di nome www.corriere.it.  
* Socket verso www.facebook.com: port-remote: 443, IP-remote: indirizzo IP del server di nome www.facebook.com  
* Socket verso www.units.it: port-remote: 80, IP-remote: indirizzo IP del server di nome www.units.it  
* Socket per trasmissione email: port-remote: 25, IP-remote: indirizzo IP del mail server usato dal mail client.  
* Socket per prelievo email: port-remote: 110, IP-remote: indirizzo IP del mail server usato dal mail client.

### Osservazioni

* Come ogni esercizio, anche questo ha qualche inevitabile ambiguità. Ad esempio, i tab del browser sono aperti ma è già presente la visualizzazione del contenuto prelevato? Oppure il browser sta ancora prelevando i contenuti? Oppure il browser non ha ancora iniziato a prelevare i contenuti? Oppure il browser ha già prelevato, visualizzato e poi ha deciso di chiudere la connessione anche se il tab è ancora aperto? Questa è solo una lista non esaustiva di tali possibili ambiguità (ce ne sono altre: un browser potrebbe usare più connessioni simultaneamente verso lo stesso server per tentare di velocizzare il prelievo del contenuto? La risposta è si, ma noi a lezione non lo vediamo).  
* In generale, si deve assumere l’interpretazione “più ragionevole” e “più aderente” allo “scopo evidente” dell’esercizio (che in questo caso è verificare se lo studente ha chiaro come sono gestiti i socket lato client). Purtroppo queste indicazioni non sono formalizzabili e generalizzabili. Eventualmente si chiede al docente.  
* Lo svolgimento qui descritto non comprende il traffico DNS. Nella realtà c’è anche il traffico DNS e negli esami occorre tenerne conto.

## Socket 2

*PC1 di indirizzo IP1. Su PC1 sono in esecuzione un mail client MC1 ed un browser B1. Si consideri questa sequenza di eventi:*

1. *MC1 preleva un email inviato da p@orgA.uk, poi un email inviato da q@orgB.uk*  
2. *MC1 invia un email con destinatario z@orgC.uk;*  
3. *B1 preleva il documento http://orgC.uk/news-today.html; in un altro tab, B1 preleva il documento http://orgC.uk/malamente.html; in un altro tab, B1 visualizza il contenuto della inbox GMail https://mail.google.com/mail/u/0/\#inbox ed invia un email con destinatario w@orgD.uk  (si assuma che B1 sia già autenticato su GMail).*

*Con riferimento alla sequenza A-B-C:*

1. *Elencare la sequenza di connessioni TCP utilizzata da PC1, specificando per ognuna: server all’altra estremità (in una qualche forma non ambigua), numero di porta su PC1, numero di porta sul server.*

Si parla di sequenza di eventi.

Il **primo** evento consiste nel prelievo di due email. Quindi una connessione c1 in cui le informazioni richieste sono: IP-mail-server, port-client-1, 110 (per “port-client” si intende un numero di porta scelto dal sistema operativo in modo che sia superiore a 1024 e diverso da ogni altro numero di porta su PC1).

Il **secondo** evento consiste nell’invio di un messaggio email. Quindi una connessione c2 caratterizzata da IP-mail-server, port-client-2, 25 (port-client-2 significa che questo numero è diverso da port-client-1).

Il **terzo** evento consiste di:

* Prelievo di due documenti dal server di nome orgC.uk. Ciò può avvenire in due modi:  
  * con una connessione c3 caratterizzata da IP-web-server-nome-orgC.uk, port-client-3, 80; oppure,  
  * con due connessioni c3 e c3’ caratterizzate rispettivamente da IP-web-server-nome-orgC.uk, port-client-3, 80 e IP-web-server-nome-orgC.uk, port-client-3’, 80 (un browser preleva N documenti da uno stesso server web con un numero di connessioni che può variare da 1 a N);  
* Prelievo di inbox Gmail dal server di nome mail.google.com ed invio di email attraverso Gmail. Come vedremo più avanti studiando il web, ciò può avvenire in due modi:  
  * con una connessione c3 caratterizzata da IP-web-server-nome-mail.google.com, port-client 4, 443; oppure,  
  * con due connessioni c3 e c3’ caratterizzate rispettivamente da IP-web-server-nome-mail.google.com, port-client-4, 443 e IP-web-server-nome-mail.google.com, port-client-4’, 443;

La sequenza è quindi c1-c2-c3-c4 (assumendo il caso con una sola connessione per ognuno dei due web server del terzo evento).

### Osservazioni

* La connessione a Gmail avviene con un browser. Quindi i numeri di porta remoti sono quelli di HTTP o HTTPS (80, 443). I numeri di porta remoti usati dai mail client (25 per il protocollo SMTP, 110 per il protocollo POP) non c’entrano nulla.  
* Il testo è ambiguo nel dire “*sequenza di connessioni TCP*” poiché non specifica il criterio con cui ordinare le connessioni in sequenza”: ci si riferisce al solo istante di creazione oppure all’intero tempo di vita della connessione? Cioè, due connessioni create ad istanti diversi ma che esistono in intervalli di tempo sovrapposti che ordinamento devono avere? Anche in questo caso, come per l’esercizio precedente, si assume un criterio di ordinamento “intuitivo”.  
* Nel testo dell’esercizio non ci sono elementi sufficienti per dire quale sia l’ordinamento nella sequenza di c3 e c4 (prima c3, poi c4; oppure al contrario; oppure sovrapposte temporalmente). Possiamo solo dire che avvengono dopo c1-c2.

# DNS \+ WEB

Il DNS provider dns-names.it permette la creazione di domini di secondo livello nei TLD it, eu, com. 

Il servizio di web hosting sitibelli.it ha il web server serverbello.it ed usa per tutti i propri nomi il DNS provider dns-names.it; offre un servizio custom domain ed un servizio non-custom domain con nomi della forma *nome*.sitibelli.it; usa lo stesso web server sia per i siti custom domain sia per quelli non-custom domain.

L’organizzazione Org usa il DNS provider dns-names.it per la gestione dei propri nomi DNS ed il servizio di web hosting sitibelli.it per i propri siti web. Org ha un sito web non-custom domain di nome acciughe.sitibelli.it ed un sito web custom domain di nome www.sarde.it. La home page del primo contiene una immagine di URL relativo img.jpg, la home page del secondo contiene un’immagine con lo stesso URL relativo. Entrambi i siti sono configurati per permettere il mantenimento delle immagini in cache per 24 ore.

1. Elencare i RR necessari per l’esistenza del servizio di web hosting.  
2. Aggiungere all’elenco 1 gli RR necessari per l’esistenza di acciughe.sitibelli.it.  
3. Aggiungere all’elenco 2 gli RR necessari per l’esistenza di www.sarde.it.  
4. Si consideri il sito http://acciughe.sitibelli.it.  
   1. Descrivere la configurazione necessaria ad un browser per prelevare la home page del sito.  
   2. Elencare il traffico DNS ed il traffico HTTP trasmesso o ricevuto dal browser per prelevare la home page del sito. La descrizione del traffico deve includere il nome del server coinvolto.  
5. Ripetere il punto 4 per il sito http://www.sarde.it.

### Svolgimento

#### Punto 1

*serverbello.it		A		IP-1*  
*ns1.dns-names.it	A		IP-0*

#### Punto 2

*acciughe.sitibelli.it	CNAME	serverbello.it*

#### Punto 3

*www.sarde.it		CNAME	serverbello.it*

#### Punto 4 a

*Nessuna configurazione specifica richiesta.*

#### Punto 4 b

*DNS: Richiesta acciughe.sitibelli.it A ? indirizzata al nameserver della organizzazione a cui appartiene il browser. Risposta ed eventuali richieste successive identiche a mille casi visti.*  
*HTTP: identico a mille casi visti*

#### Punto 5

*a identico a 4a;*

*b in traffico DNS cambia nome richiesto (www.sarde.it invece di acciughe.sitibelli.it) in traffico HTTP cambia valore header Host (idem) e valore cookie; c cambiamento analogo a b;*

# DNS \+ WEB \+ EMAIL I

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

### Svolgimento

#### Punto 1

| *Home page di w1.org* | *Documento http://w1.org/d1.htm* |
| :---- | :---- |
| *\<html\> \<a HREF=”d1.html”\> link1 \</a\> \<a HREF=”d2.html”\> link2 \</a\> \<a HREF=”d3.html”\> link3 \</a\> \<img SRC=”i2.jpg”\>\</img\> \<script SRC=”s2.js”\>\</script\> \</html\>* | *\<html\> \<a HREF=”http://w2.org/d1.html”\> link1 \</a\> \<img SRC=”i3.jpg”\>\</img\> \</html\>* |

|  *form di autenticazione su w1.org* |  *form di autenticazione su w2.org* |
| :---- | :---- |
| *\<html\> \<FORM ACTION=”check.asp” METHOD=”POST”\> Username: \<INPUT TYPE= “TEXT” NAME=”u”\> Password: \<INPUT TYPE= “Password” NAME=”p”\> \</FORM\> \</html\>* | *Identico a quello su w1.org* |

#### Punto 2

| *Traffico HTTP* |  |
| :---- | :---- |
| *GET / User-Agent:... Host: w1.org … LV* | *HTTP 200 OK Content-type: text/html Content-length:... Set-Cookie: ID=x1 … LVdocumento richiesto (home page)*  |
| *GET i2.jpg Host:w1.org Cookie: ID=x1 Referrer: [http://w1.org/](http://w1.org/) … LV* | *HTTP 200 OK Content-type: img/jpg Content-length:... … LVdocumento richiesto (immagine)*  |
| *GET i3.js Host:w1.org Cookie: ID=x1 Referrer: [http://w1.org/](http://w1.org/) … LV* | *HTTP 200 OK Content-type: application/javascript Content-length:... … LVdocumento richiesto (script)* |
| *Traffico DNS browser* |  |
| *w1.org A ?* | *w1.org A IP-w1* |
| *Traffico DNS w1.org e w2.org* |  |
| *Nessuno* |  |

#### Punto 3

| *Traffico HTTP* |  |
| :---- | :---- |
| *GET d1.html User-Agent:... Host: w1.org Cookie: ID=x1 Referrer: [http://w1.org/](http://w1.org/) … LV* | *HTTP 200 OK Location: http//w1.org/f.htm … LV*  |
| *GET f.htm Host: w1.org Cookie: ID=x1 Referrer: [http://w1.org/](http://w1.org/)d1.html … LV* | *HTTP 200 ok Content-type: text/html Content-length:... … LVdocumento richiesto (pagina html con form di autenticazione)*  |
| *POST check.asp Host: w1.org Cookie: ID=x1 Referrer: [http://w1.org/](http://w1.org/)d1.html Content-type: application/x-www-formurlencoded Content-length:... … LV u=Luis\&p=qualchepassword* | *HTTP 200 ok Content-type: text/html Content-length:... … LVdocumento richiesto (d1.html)* |
| *GET i3.jpg Host:w1.org Cookie: ID=x1 Referrer: [http://w1.org/](http://w1.org/)d1.html … LV* | *HTTP 200 OK Content-type: img/jpg Content-length:... … LVdocumento richiesto (immagine)*  |
| *Traffico DNS browser* |  |
| *w1.org A ?Può essere omesso in quanto già presente in cache DNS del nodo su cui è il browser* | *w1.org A IP-w1* |
| *Traffico DNS w1.org e w2.org* |  |
| *Nessuno* |  |

#### Punto 4

*Il browser invia una richiesta HTTP a w2.org per il prelievo di  [http://w2.org/d1.html](http://w2.org/d1.html). Questo documento è nel realm “listing”, accessibile solo agli utenti autenticati. Il browser non ha nessuna session attiva su w2.org e, quindi, non è autenticato.*

*Si verifica quindi tra il browser e w2.org un traffico HTTP analogo a quello mostrato per il punto 3 (tra browser e w1.org): totale 4 richieste HTTP.*

# DNS \+ WEB \+ EMAIL II

Il DNS provider dns-names.it permette la creazione di domini di secondo livello nei TLD it, eu, com.

L’organizzazione Org usa il DNS provider dns-names.it per la gestione dei propri nomi DNS. Org ha un mail server interno e un web server interno. Il mail server ha nome mx.org.it e gestisce due domini email: covid-research.com e org.it. Le mailbox a@covid-research.com, a@org.it appartengono alla mailing list org@python-programmers.org. Il web server ha nome ws.org.it e gestisce due siti web: www1.org.it, www2.org.it. La home page del primo contiene una immagine di URL relativo img.jpg, la home page del secondo contiene un’immagine con lo stesso URL relativo. 

Sia MC il mail client del proprietario della mailbox a@covid-research.com. MC invia un email M1 indirizzato a b@org.it, un email M2 indirizzato a org@python-programmers.org, un email M3 indirizzato b@cornell.edu. Sia C il nodo su cui è in esecuzione MC e sia BC un browser in esecuzione su C.

1. Elencare i RR necessari per l’esistenza della infrastruttura email indicata.  
2. Aggiungere all’elenco indicato al punto 1 gli RR necessari per l’esistenza dei siti web.  
3. Si consideri il sito [http://www1.org.it](http://acciughe.sitibelli.it). Elencare il traffico DNS ed il traffico HTTP trasmesso o ricevuto da BC per prelevare la home page del sito. La descrizione del traffico deve includere il nome del server coinvolto.  
4. Descrivere le informazioni di configurazione di MC  
5. Per ognuno dei 3 email indicati nel testo (M1, M2, M3):  
   1. Elencare tutto il traffico DNS trasmesso e ricevuto da MC e da mx.org.it. La descrizione del traffico deve includere il nome del server coinvolto.  
   2. Elencare le connessioni SMTP e POP usate da MC e da mx.org.it specificando per ognuna il nome del server coinvolto. Per “elencare le connessioni” non si intende “elencare il traffico”; si intende quante connessioni, verso quali server, con quali numeri di porta locali e remoti.  
6. Si assuma adesso che gli utenti di Org navighino su web solo attraverso proxy.  
   1. Ripetere il punto 1  
   2. Ripetere il punto 3  
   3. Ripetere il punto 6

### Svolgimento

#### Punto 1

*covid-research.com		MX	mx.org.it*  
*org.it				MX	mx.org.it*  
*python-programmers.org	MX	somemx.someprov-m.com*

*Per le mailbox, ovviamente, non occorre nessun RR.*

*Servono poi i RR di tipo A per i mail server*  
*mx.org.it			A	IP-MS*	  
*somemx.someprov-m.com	A	IP-5*	

#### Punto 2

*ws.org.it		A		IP-a*  
*www1.org.it		CNAME	ws.org.it*  
*www2.org.it		CNAME	ws.org.it*

#### Punto 3

*DNS: Richiesta www.org1.it A ? indirizzata al nameserver della organizzazione a cui appartiene BC; questo nameserver invia una risposta a BC contenente il RR richiesto.*

*HTTP: identico a mille casi visti*

#### Punto 4

*Mailbox [a@covid-research.com](mailto:a@covid-research.org) e password della mailbox; eventualmente anche nome del mail server (ottenibile comunque con richiesta di tipo MX per il dominio email)*

#### Punto 5-a

*M1*

* *MC invia una richiesta “covid-research.com MX ?” al name server della propria organizzazione; sia “covid-research.com MX M” il RR di risposta; se la risposta DNS non contiene anche il RR “M A IP-M”, allora MC invia anche una richiesta “M A ?” allo stesso name server.*  
* *mx.org.it non invia nessuna richiesta DNS a causa del recapito di M1 (perché la mailbox destinazione di M1 è su mx.org.it)*

*M2*

* *MC necessita degli stessi RR già ottenuti al punto precedente.*  
* *mx.org.it deve inoltrare M2 al mail server su cui si trova la mailbox*  org@python-programmers.org. *Deve pertanto inviare una richiesta “python-programmers.org MX ?” al name server della propria organizzazione;* *sia “python-programmers.org MX M1” il RR di risposta; se la risposta DNS non contiene anche il RR “M1 A IP-M1”, allora mx.org.it invia anche una richiesta “M1 A ?” allo stesso name server.*  
* *come sopra*

*M3*

* *MC come sopra*  
* *mx.org.it come sopra, sostituendo cornell.edu a python-programmers.org*

#### Punto 5-b

*MC usa da una a tre connessioni SMTP, tutte verso il mail server mx.org.it (dipende da quanti messaggi email invia in ogni connessione). Il numero di porta locale è superiore a 1024, assegnato dal sistema operativo e non usato da altri processi; il numero di porta remoto è 25\. MC non usa connessioni POP per l’invio di M1, M2, M3.*

*mx.org.it usa le connessioni SMTP sopra specificate. Inoltre:*

* *M1: nessuna ulteriore connessione SMTP;*  
* *M2 usa altre 2 connessioni SMTP:*  
  * *una per inviare M2 al mail server che gestisce [org@python-programmers.org](mailto:org@python-programmers.org); in questa connessione si comporta da client (quindi numero di porta locale superiore a 1024 etc, numero di porta remoto 25);*  
  * *un’altra per ricevere (da quel mail server) le copie di M2 indirizzate alle mailbox a@covid-research.com, a@org.it in questa connessione si comporta da server, quindi numero di porta locale 25, numero di porta remoto superiore a 1024 etc; (queste due copie possono essere inviate in una o due connessioni SMTP, dipende dal comportamento del mail server che gestisce la mailing list; entrambe le possibilità sono corrette).*  
* *M3 usa un’altra connessione SMTP per inviare M3 al mail server responsabile per il dominio email cornell.edu. In questa connessione si comporta da client  (quindi numero di porta locale superiore a 1024 etc, numero di porta remoto 25);*

*Nesssuna connessione POP*

#### Punto 6-a

*Nessuna modifica*

#### Punto 6-b

*DNS: Richiesta nomeproxy A ? indirizzata al nameserver della organizzazione a cui appartiene BC; questo nameserver invia una risposta a BC contenente il RR richiesto.*

*HTTP: immutato*

#### Punto 7-c

*Nessuna modifica*  
