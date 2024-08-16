# Lab 5

## Control Systems

Is required to model the concept of a control system.
A control system is a set of components that manage the behaviour of other systems using feedback.

![](img/controlsystem.jpeg)

## Structure

In my design I wanted to develop the task as follows:

* `ControlSystem`: is a functional interface representing a generic control system with a `process()` method that takes
  an input and gives an output.
* `GenericControlSystem`: is a class that implements `ControlSystem` and uses response to control the system. In this
  class, the control logic must be implemented according to the user needs.
