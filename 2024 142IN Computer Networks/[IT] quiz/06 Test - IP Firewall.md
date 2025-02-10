# Test - Uso DNS

Link: https://forms.gle/V14xM8Dbv3GHeApH6

## Domande e Risposte

### Firewall di frontiera - NS, MS, WS, PX interni
Le domande seguenti sono requisiti per utenti interni all'organizzazione

#### Invio email verso altre organizzazioni

IP-src = IP-MS, port-dst=25 e IP-dst = IP-MS, port-src=25

- [x] NECESSARIO
- [ ] NON NECESSARIO

#### Invio email verso altre organizzazioni

IP-src = IP-NS, port-dst=53 e IP-dst = IP-NS, port-src=53

- [x] NECESSARIO
- [ ] NON NECESSARIO

#### Invio email verso altre organizzazioni

IP-src = IP-PX, port-src=80 e IP-dst = IP-PX, port-dst=80

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Navigazione web solo attraverso proxy

IP-src = IP-PX, port-src=80 e IP-dst = IP-PX, port-dst=80

- [ ] NECESSARIO
- [x] NON NECESSARIO

### Firewall di frontiera - NS esterno - MS, WS, PX interni
Le domande seguenti sono requisiti per utenti interni all'organizzazione

#### Navigazione web solo attraverso proxy

IP-src = IP-PX, IP-dst = IP-NS, port-src=80, port-dst=53 e IP-src = IP-NS, IP-dst = IP-PX, port-src=53, port-dst=80

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Navigazione web solo attraverso proxy

IP-src = IP-PX, IP-dst = IP-NS, port-dst=53 e IP-src = IP-NS, IP-dst = IP-PX, port-src=53

- [x] NECESSARIO
- [ ] NON NECESSARIO

#### Invio email verso altre organizzazioni

IP-src = IP-NS, port-dst=53 e IP-dst = IP-NS, port-src=53

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Navigazione web diretta (senza proxy)

IP-src = IP-NS, port-src=53 e IP-dst = IP-NS, port-dst=53

- [x] NECESSARIO
- [ ] NON NECESSARIO

#### Invio email verso altre organizzazioni

port-src=53 e port-dst=53

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Ricezione email da altre organizzazioni

IP-src = IP-NS, port-src=53 e IP-dst = IP-NS, port-dst=53

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Accesso al server web dall'esterno

IP-src = IP-NS, port-src=53 e IP-dst = IP-NS, port-dst=53

- [ ] NECESSARIO
- [x] NON NECESSARIO

### Firewall su endpoint
Le domande seguenti sono requisiti per l'endpoint su cui è installato il firewall

#### Accesso al server web dell'organizzazione

port-src=80 e port-dst=80

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Navigazione web solo attraverso proxy

IP-dst=IP-PX, port-dst=80 e IP-src=IP-PX, port-src=80

- [x] NECESSARIO
- [ ] NON NECESSARIO

#### Navigazione web solo attraverso proxy

IP-dst=IP-PX, port-src=80 e IP-src=IP-PX, port-dst=80

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Prelievo email (accesso alla propria mailbox)

IP-dst=IP-MS, port-dst=110 e IP-src=IP-MS, port-src=110

- [x] NECESSARIO
- [ ] NON NECESSARIO

#### Prelievo email (accesso alla propria mailbox)

IP-dst=IP-MS, port-dst=25 e IP-src=IP-MS, port-src=25

- [ ] NECESSARIO
- [x] NON NECESSARIO

#### Invio email 

IP-dst=IP-NS, port-dst=53 e IP-src=IP-NS, port-src=53

- [x] NECESSARIO
- [ ] NON NECESSARIO

#### Invio email 

IP-dst=IP-NS, port-src=53 e IP-src=IP-NS, port-dst=53

- [ ] NECESSARIO
- [x] NON NECESSARIO

### Firewall di frontiera
Indicare il nome delle tipologie di traffico da permettere 

#### MS interno - Invio email verso altre organizzazioni

- [x] SMTP uscente, solo da MS
- [ ] SMTP entrante, solo verso MS

#### MS esterno - Invio email verso altre organizzazioni

- [x] SMTP uscente, solo verso MS
- [ ] SMTP entrante, solo da MS

#### NS interno - Accesso dai NS esterni

- [x] DNS entrante, solo verso NS
- [ ] DNS uscente, solo da NS

#### WS interno - Accesso dai browser esterni

- [x] HTTP entrante, solo verso WS
- [ ] HTTP uscente, solo da WS

#### Navigazione web diretta

- [ ] HTTP entrante
- [x] HTTP uscente

### Firewall su endpoint
Indicare il nome delle tipologie di traffico da permettere

#### Navigazione web diretta

- [ ] HTTP entrante
- [x] HTTP uscente

#### Navigazione web attraverso proxy

- [ ] HTTP entrante, solo da proxy
- [x] HTTP uscente, solo verso proxy

##### Invio email

- [x] SMTP uscente, solo verso MS
- [ ] SMTP entrante, solo da MS

#### Navigazione web solo verso il web server dell'organizzazione WS

- [ ] HTTP entrante, solo da WS
- [x] HTTP uscente, solo verso WS