# Traffic Light Controller FPGA Project

This repository contains a VHDL implementation of a traffic light controller for an FPGA board. The project simulates a traffic intersection with traffic lights and implements the logic to control the sequence of traffic light phases.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Design Overview](#design-overview)

## Introduction

The Traffic Light Controller is a project developed using VHDL for an FPGA board. The project demonstrates the simulation of a traffic intersection with different traffic light phases. The logic implemented in VHDL controls the transitions between various states to simulate the behavior of traffic lights.

## Features

- Implements a complete traffic light controller for a traffic intersection.
- Supports states like RED, RED_YELLOW, GREEN.
- Includes an option for manual override and a reset function.
- Generates a 1Hz clock for timing purposes.
- Utilizes VHDL for hardware description and simulation.

## Getting Started

1. Clone this repository to your local machine using: github.com/michaelbabajide/traffic-light-controller.git
2. Ensure you have a VHDL synthesis tool (such as Quartus Prime for Intel FPGAs) installed.
3. Open the project in your synthesis tool.
4. Build and compile the VHDL code.
5. Load the generated bitstream onto your FPGA board.

## Usage

1. Power on your FPGA board.
2. Observe the simulation of a traffic light intersection with the displayed states.
3. Use the `override` input to manually control the traffic lights.
4. The system will automatically transition between different traffic light phases based on timings.

## Design Overview

The project is designed using VHDL and includes the following main components:

- State machine for managing traffic light phases.
- 1Hz clock generator for timing purposes.
- Input signals for manual override and reset functions.
- Output signals to control the display of traffic light states.

The VHDL code is organized into processes that handle state transitions, timing, and output logic. The state machine controls the sequence of traffic light phases, and the output logic maps each state to the corresponding display value.
