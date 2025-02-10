# Test - IP Incapsulamento

Link: https://forms.gle/45nVsZJz2S8gC4CS7

## Domande e Risposte

Le domande seguenti si riferiscono a questo frame. E' stato inserito uno spazio ogni 4 byte, per facilitare la visualizzazione. La parte finale del frame non è mostrata.

```bash
52540012 35000800 271e364a 08004500 003ad43b 40004011 6ecf0a00 0207ac1e 3f839ea2 00350026 f7dff0b2 01000001 00000000 00000377 ...
```

#### L'indirizzo Ethernet mittente è  52:54:00:12:35:00

- [ ] VERO
- [x] FALSO

#### Il payload è un pacchetto IP

- [x] VERO
- [ ] FALSO

#### L'indirizzo IP destinatario ha come byte meno significativo il valore 131 (in base 10), ha cioè la forma X.X.X.131

- [x] VERO
- [ ] FALSO

#### L'indirizzo IP mittente ha come byte meno significativo il valore 7 (in base 10), ha cioè la forma X.X.X.7

- [x] VERO
- [ ] FALSO

#### Il frame trasporta una risposta DNS

- [x] VERO
- [ ] FALSO

Le domande seguenti si riferiscono a questo frame. E' stato inserito uno spazio ogni 4 byte, per facilitare la visualizzazione. La parte finale del frame non è mostrata.

```bash
0800271e 364a5254 00123500 08060001 08000607 40002525 40012350 00a00020 10800271 e364a0a0 ...
```

#### Il payload è un pacchetto IP

- [ ] VERO
- [x] FALSO

#### Il frame trasporta una richiesta ARP

- [x] VERO
- [ ] FALSO

Le domande seguenti si riferiscono a questo frame. Gli header dei vari livelli sono stati separati in linee diverse per facilitarne la visualizzazione (la prima linea è lo header Ethernet). La parte finale del frame non è mostrata.

```bash
5254001235000800271e364a0800
450000735f6340004006435e0a00020782ba0903
a99a00502448b43d0000f4fc50187d7898290000
474554202f20485454502f312e31 ...
```

#### L'indirizzo Ethernet mittente è  08:00:27:1e:36:4a

- [x] VERO
- [ ] FALSO

#### Il frame trasporta un pacchetto IP in cui l'indirizzo IP mittente ha la forma 10.X.X.X

- [x] VERO
- [ ] FALSO

#### Il frame trasporta una richiesta DNS (NB  i numeri di porta sono nei primi 4 byte del payload IP, prima mittente e poi destinatario)

- [ ] VERO
- [x] FALSO

#### Il frame trasporta una richiesta HTTP  (NB  i numeri di porta sono nei primi 4 byte del payload IP, prima mittente e poi destinatario)

- [x] VERO
- [ ] FALSO

#### Il frame trasporta una richiesta HTTP POST

- [ ] VERO
- [x] FALSO