# :it: Progetto Finale Programmazione Avanzata 2023

## Introduzione

**Descrizione del Progetto**  
Questo progetto consiste nello sviluppo di un server in Java che riceve richieste di calcolo di espressioni matematiche
e restituisce i risultati al client. Il server è in grado di gestire operazioni come `MIN`, `MAX`, `AVG`, e `COUNT` su
espressioni definite dall'utente.

**Obiettivi**

- Implementare un server multi-thread che gestisca connessioni multiple.
- Fornire un protocollo basato su testo per l'invio di richieste di calcolo.
- Garantire la correttezza e l'efficienza dei calcoli.

**Requisiti di Sistema**

- **Java 8** o superiore.
- **IntelliJ IDEA** per la gestione del progetto e l'esecuzione.

## Architettura del Progetto

### Panoramica

Il progetto è organizzato in pacchetti, ciascuno con una specifica responsabilità:

- **Math**: Contiene le classi che eseguono i calcoli matematici.
    - `AvgComputation`: Calcola la media delle espressioni fornite.
    - `Computation`: Classe base astratta per le operazioni di calcolo.
    - `ComputationEngine`: Gestisce l'esecuzione dei calcoli e invoca le classi appropriate per il tipo di operazione
      richiesto.
    - `CountComputation`: Conta il numero di tuple di valori calcolate.
    - `ExpressionParser`: Analizza e interpreta le espressioni matematiche.
    - `MaxComputation`: Calcola il valore massimo tra i risultati delle espressioni.
    - `MinComputation`: Calcola il valore minimo tra i risultati delle espressioni.

- **Request**: Gestisce il parsing e l'elaborazione delle richieste.
    - `Request`: Rappresenta una richiesta generica inviata al server.
    - `RequestHandler`: Gestisce le richieste ricevute e invia le risposte appropriate.
    - `RequestParser`: Converte le stringhe delle richieste in oggetti `Request`.
    - `RequestType`: Enum che definisce i vari tipi di richieste supportate dal server.

- **Server**: Contiene la logica del server e la gestione delle connessioni.
    - `ClientHandler`: Gestisce la connessione e la comunicazione con un singolo client.
    - `Server`: Classe principale che avvia il server, gestisce le connessioni e distribuisce le richieste
      ai `ClientHandler`.

- **Utils**: Contiene utility generali come logging e annotazioni.
    - `LogExecutionTime`: Annotazione per il logging del tempo di esecuzione dei metodi.
    - `LoggingUtils`: Fornisce metodi per il logging delle operazioni del server.
    - `Response`: Modella le risposte che il server invia ai client, sia di successo che di errore.
    - `Statistics`: Raccoglie e fornisce statistiche sulle richieste processate dal server.

- **Test**: Contiene i test unitari e d'integrazione per verificare la correttezza del codice e delle funzionalità
  implementate.

## Installazione e Configurazione

### Installazione

1. **Clona il Repository**: Clona il repository del progetto usando Git:
   ```bash
   git clone https://github.com/enricolacchin/advanced-programming-2023.git
   cd advanced-programming-2023/Final_Project
   ```

2. **Importa il Progetto in IntelliJ IDEA**:
    - Apri IntelliJ IDEA.
    - Seleziona "Open" e naviga fino alla cartella del progetto che hai appena clonato.
    - IntelliJ configurerà automaticamente il progetto.

### Configurazione

- **Avvio del Server**:
  Esegui il server utilizzando il comando seguente:
  ```bash
  java -jar build/libs/Final_Project.jar [PORT]
  ```
  Dove `[PORT]` è la porta su cui il server ascolterà le richieste (opzionale, default 10000).

## Utilizzo

### Avvio del Server

Esegui il server con:

```bash
java -jar build/libs/Final_Project.jar 10000
```

### Esempi di Richieste e Risposte

- **Richiesta di Calcolo**:
  ```plaintext
  MAX_GRID;x0:-1:0.1:1,x1:-10:1:20;((x0+(2.0^x1))/(21.1-x0));(x1*x0)
  ```

- **Risposta OK**:
  ```plaintext
  OK;0.040;52168.009950
  ```

- **Richiesta Statistiche**:
  ```plaintext
  STAT_REQS
  ```

- **Risposta Statistiche**:
  ```plaintext
  OK;0.000;42.000
  ```

- **Richiesta di Chiusura**:
  ```plaintext
  BYE
  ```

## Log e Debug

### Configurazione del Logging

Il logging è gestito tramite la classe `LoggingUtils`. I messaggi vengono stampati sulla console con timestamp.

### Debug

- Usa gli strumenti di debug integrati in IntelliJ IDEA per eseguire il progetto passo-passo.
- Aggiungi punti d'interruzione nelle classi principali come `Server` e `ComputationEngine` per tracciare il flusso di
  esecuzione.

## Manutenzione ed Estendibilità

### Aggiunta di Nuove Funzionalità

1. **Nuove Operazioni**: Per aggiungere una nuova operazione di calcolo, crea una nuova classe che implementa
   l'interfaccia `Computation` e registrala in `ComputationEngine`.
2. **Modifica del Protocollo**: Se è necessario estendere il protocollo, aggiorna `RequestHandler` e `RequestParser`.

### Refactoring

- Mantieni un alto livello di coesione nelle classi.
- Utilizza l'ereditarietà o la composizione dove appropriato per migliorare la riusabilità del codice.

## Conclusioni

### Stato Attuale

Il progetto è funzionante e soddisfa i requisiti assegnati. È pronto per essere distribuito o ulteriormente esteso.
