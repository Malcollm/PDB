# Humanoid Robot Power Distribution Board

This repository contains the power distribution board design for the Wiscohumanoids humanoid robot. The board distributes the main battery power to the robot’s high-current actuator system and generates regulated lower-voltage rails for compute, servos, sensors, and control electronics.

The PDB is designed around a 48 V main power system with onboard regulation for the robot’s auxiliary electronics.

## Project Overview

The power distribution board is responsible for taking the main battery input and safely distributing power throughout the robot. It includes high-current 48 V distribution, onboard buck converters, current sensing, precharge circuitry, and protection/disconnect circuitry.

The main goals of this board are:

- Distribute 48 V battery power to actuator rails
- Generate a 12 V compute rail
- Generate a 6 V servo rail for the robot hands
- Generate a 3.3 V rail for sensors and control electronics
- Monitor current on important power paths
- Limit inrush current during startup using precharge circuitry
- Separate actuator/servo power from compute/control power through protection and disconnect circuitry
- Protect the electrical system from voltage transients and fault conditions

## System Power Architecture

```text
Battery Input
    |
    |-- Precharge Circuit
    |
    |-- Main 48 V Power Rail
            |
            |-- Protection / Disconnect Circuitry
                    |
                    |-- Actuator / Servo Power Group
                    |       |
                    |       |-- 48 V Actuator Distribution
                    |       |
                    |       |-- 48 V to 6 V Buck Converter
                    |               |
                    |               |-- Hand Servos
                    |
                    |-- Compute / Control Power Group
                            |
                            |-- 48 V to 12 V Buck Converter
                            |       |
                            |       |-- Compute / Embedded Electronics
                            |
                            |-- 48 V to 3.3 V Buck Converter
                                    |
                                    |-- Sensors / Current Sensors / Control Logic
```

## Power Rails

| Rail | Purpose |
|---|---|
| 48 V | Main battery rail and actuator power distribution |
| 12 V | Compute and embedded electronics |
| 6 V | Servo motors in the robot hands |
| 3.3 V | Sensors, current sensors, and control logic |

## Major Board Features

### 48 V Actuator Distribution

The main power path distributes 48 V battery power to the robot’s actuator system. Because this rail carries the highest current on the board, the layout uses large copper pours, short current paths, and high-current connectors.

This section of the board is designed to minimize voltage drop and reduce heating under actuator load.

### Precharge Circuit

The board includes a precharge circuit to limit inrush current when the battery is connected. This is important because the board contains large bulk capacitance on the main 48 V rail.

During startup, the precharge path slowly charges the bulk capacitors before the main power path is fully enabled. This reduces stress on connectors, switches, relays, and other power components.

### Protection and Disconnect Circuitry

The PDB includes protection and disconnect circuitry that separates the main power system into two groups: the actuator/servo power group and the compute/control power group.

The actuator/servo group contains the 48 V actuator distribution and the 6 V hand servo rail. This group can be disconnected from the rest of the system so high-power motion components can be shut down independently.

The compute/control group contains the 12 V and 3.3 V rails. This allows the robot’s control electronics, sensors, and compute hardware to remain separated from the high-power actuator section.

This separation is important because it allows actuator power to be disabled while keeping control electronics available for monitoring, communication, and safe shutdown behavior.

Protection features include:

- Input transient voltage protection
- Precharge/inrush-current limiting
- Separation between actuator/servo power and compute/control power
- Reverse-current blocking where needed
- Current sensing for fault monitoring
- Support for external E-stop or main disconnect circuitry
- Bulk capacitance for load transients

### Current Sensing

Current sensors are included on important power paths so the robot can monitor how much current different parts of the system are drawing.

Current measurement is useful for:

- Detecting abnormal load conditions
- Debugging actuator behavior
- Estimating power usage
- Monitoring system health
- Adding future fault-detection logic

### Buck Converters

The PDB generates the lower-voltage rails from the main 48 V battery input using buck converters.

The onboard regulated rails are:

- 12 V for compute and embedded electronics
- 6 V for hand servos
- 3.3 V for sensors and control electronics

Each buck converter section includes the switching regulator circuit, input capacitance, output capacitance, feedback network, and supporting passives.

## Grounding

The board uses separate ground naming to keep high-current power paths and sensitive measurement/control paths organized.

Typical ground nets include:

| Net | Purpose |
|---|---|
| PGND | High-current power ground and switching converter return |
| AGND | Analog/sensor ground for feedback and current measurement circuits |

These grounds are not meant to be completely isolated systems. Instead, the separate names help control where large return currents flow and help keep sensor and feedback references cleaner.

## Design Status

This project is currently in development.
