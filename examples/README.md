# Ada_Drivers_Library examples

In this directory you will find instructions and examples to start your first
Ada_Drivers_Library project.

The goals of the examples are:
 - Offer a simple way to start a project
 - Demonstrate the supported features of the boards
 - Demonstrate the supported drivers of a micro-controller family

The examples are sorted by boards but some of them are working on multiple
boards, in that case the code is stored in the [shared](shared/) directory.

# Getting started

## Download and install the tools

### Compiler and IDE

Most of the boards/micro-controller supported are based on the ARM Cortex-M
architecture. If you have a GNAT Pro subscription, you can download the
compiler (GNAT) and IDE (GNAT Programming Studio) from your account. Otherwise,
there are GNAT FSF and GPRbuild releases from the Alire project that you can
download [here](https://github.com/alire-project/GNAT-FSF-builds/releases).

A public release of GNAT Studio is also available
[here](https://github.com/AdaCore/gnatstudio/releases).

### stlink

For the STM32 board we recommend to use the open-source probe interface
[stlink](https://github.com/texane/stlink).

On Windows, you can get it from the [Msys2 package
manager](https://packages.msys2.org/package/mingw-w64-x86_64-stlink).

On Linux, you have to download the source and compile the tool:

```Shell
$ git clone https://github.com/texane/stlink.git
$ cd stlink
$ make release
```

### Miscellaneous

Some boards require a specific tool or configuration, in that case you will
find the additional instructions in the example directory dedicated to this
board (for instance [Micro:bit](MicroBit/)).

## Clone the repository

If you are on Windows, we recommend to use the 
[GitHub Desktop application](https://desktop.github.com/).

Otherwise, from the command line:
```shell
git clone --recursive https://github.com/AdaCore/Ada_Drivers_Library.git
```

## Open an example project

Start GNAT Programming Studio and open one of the project supported by the
board you have:

 - [HiFive1](HiFive1)
 - [MicroBit](MicroBit)
 - [OpenMV2 ](OpenMV2)
 - [STM32F429_Discovery](STM32F429_Discovery)
 - [STM32F469_Discovery](STM32F469_Discovery)
 - [STM32F4_DISCO](STM32F4_DISCO)
 - [STM32F746_Discovery](STM32F746_Discovery)
 - [STM32F769_Discovery](STM32F769_Discovery)

## Compile the project

Use the "Build all" button in GNAT Programming Studio tool bar.

##  Run the project

For the STM32 board, use the "Flash to board" button in the tool bar.

#
### We need your help

If you notice an error in these instructions, or if you want to improve them,
please go to [Ada_Drivers_Library GitHub
repository](https://github.com/AdaCore/Ada_Drivers_Library). Thank you in
advance.

