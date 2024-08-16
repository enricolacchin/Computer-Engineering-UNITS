# :gb: Final Project Advanced Programming 2023

## Introduction

**Project Description**  
This project involves the development of a Java server that receives mathematical expression computation requests and
returns the results to the client. The server is capable of handling operations such as `MIN`, `MAX`, `AVG`, and `COUNT`
on user-defined expressions.

**Objectives**

- Implement a multi-threaded server that handles multiple connections.
- Provide a text-based protocol for sending computation requests.
- Ensure the correctness and efficiency of the computations.

**System Requirements**

- **Java 8** or higher.
- **IntelliJ IDEA** for project management and execution.

## Project Architecture

### Overview

The project is organized into packages, each with a specific responsibility:

- **Math**: Contains the classes that perform mathematical computations.
    - `AvgComputation`: Calculates the average of the provided expressions.
    - `Computation`: Abstract base class for computation operations.
    - `ComputationEngine`: Manages the execution of computations and invokes the appropriate classes for the requested
      operation.
    - `CountComputation`: Counts the number of computed value tuples.
    - `ExpressionParser`: Analyzes and interprets mathematical expressions.
    - `MaxComputation`: Calculates the maximum value among the results of the expressions.
    - `MinComputation`: Calculates the minimum value among the results of the expressions.

- **Request**: Handles the parsing and processing of requests.
    - `Request`: Represents a generic request sent to the server.
    - `RequestHandler`: Manages the received requests and sends appropriate responses.
    - `RequestParser`: Converts request strings into `Request` objects.
    - `RequestType`: Enum that defines the various types of requests supported by the server.

- **Server**: Contains the server logic and connection management.
    - `ClientHandler`: Manages the connection and communication with a single client.
    - `Server`: Main class that starts the server, manages connections, and distributes requests to `ClientHandler`
      instances.

- **Utils**: Contains general utilities such as logging and annotations.
    - `LogExecutionTime`: Annotation for logging method execution time.
    - `LoggingUtils`: Provides methods for logging server operations.
    - `Response`: Models the responses sent by the server to the clients, both success and error responses.
    - `Statistics`: Collects and provides statistics on the requests processed by the server.

- **Test**: Contains unit and integration tests to verify the correctness of the code and the implemented
  functionalities.

## Installation and Configuration

### Installation

1. **Clone the Repository**: Clone the project repository using Git:
   ```bash
   git clone https://github.com/enricolacchin/advanced-programming-2023.git
   cd advanced-programming-2023/Final_Project
   ```

2. **Import the Project into IntelliJ IDEA**:
    - Open IntelliJ IDEA.
    - Select "Open" and navigate to the project folder you just cloned.
    - IntelliJ will automatically configure the project.

### Configuration

- **Starting the Server**:
  Run the server using the following command:
  ```bash
  java -jar build/libs/Final_Project.jar [PORT]
  ```
  Where `[PORT]` is the port on which the server will listen for requests (optional, default is 10000).

## Usage

### Starting the Server

Run the server with:

```bash
java -jar build/libs/Final_Project.jar 10000
```

### Request and Response Examples

- **Computation Request**:
  ```plaintext
  MAX_GRID;x0:-1:0.1:1,x1:-10:1:20;((x0+(2.0^x1))/(21.1-x0));(x1*x0)
  ```

- **OK Response**:
  ```plaintext
  OK;0.040;52168.009950
  ```

- **Statistics Request**:
  ```plaintext
  STAT_REQS
  ```

- **Statistics Response**:
  ```plaintext
  OK;0.000;42.000
  ```

- **Quit Request**:
  ```plaintext
  BYE
  ```

## Logging and Debugging

### Logging Configuration

Logging is managed through the `LoggingUtils` class. Messages are printed to the console with timestamps.

### Debugging

- Use the built-in debugging tools in IntelliJ IDEA to step through the project.
- Set breakpoints in key classes like `Server` and `ComputationEngine` to trace the execution flow.

## Maintenance and Extensibility

### Adding New Features

1. **New Operations**: To add a new computation operation, create a new class that implements the `Computation`
   interface and register it in `ComputationEngine`.
2. **Protocol Modification**: If the protocol needs to be extended, update `RequestHandler` and `RequestParser`.

### Refactoring

- Maintain a high level of cohesion within classes.
- Use inheritance or composition where appropriate to improve code reusability.

## Conclusions

### Current Status

The project is functional and meets the assigned requirements. It is ready for distribution or further extension.