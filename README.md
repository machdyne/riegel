# Riegel Computer

Riegel is an FPGA computer designed by Lone Dynamics Corporation.

![Riegel Computer](https://github.com/machdyne/riegel/blob/b3751f4ae0214ddb61edb550aa9f5bc8b70327ad/riegel.png)

This repo contains schematics, PCB layouts, pinouts, a 3D-printable case, example gateware and documentation.

Find more information on the [Riegel product page](https://machdyne.com/product/riegel-computer/).

## Blinky 

Building the blinky example requires [Yosys](https://github.com/YosysHQ/yosys), [nextpnr-ice40](https://github.com/YosysHQ/nextpnr) and [IceStorm](https://github.com/YosysHQ/icestorm).

Assuming they are installed, you can simply type `make` to build the gateware, which will be written to output/blinky.bin. You can then use [ldprog](https://github.com/machdyne/ldprog) to write the gateware to the device.

## Zucker

[Zucker](https://github.com/machdyne/zucker) is a RISC-V SOC designed specifically for Riegel hardware.

## USB Bootloader

Riegel supports updating the flash MMOD over its USB-C port with the USB DFU (Device Firmware Upgrade) protocol. When Riegel powers on (or restarts) the USB bootloader waits 5 seconds for a USB command and then continues the boot process, if it receives a command it will wait until the device is detached (with `dfu-util -e`) or rebooted (with `ldprog -r`).

In order to install the USB bootloader you will need to use the ISP header and [ldprog](https://github.com/machdyne/ldprog). Make sure you have first installed the software required to build the Blinky example above.

```
git clone https://github.com/machdyne/tinydfu-bootloader
cd tinydfu-bootloader/boards/riegel
make
make prog
```

Now you can program the flash MMOD over USB:

```
ldprog -r
sudo dfu-util -a 0 -D zucker/output/soc.bin
sudo dfu-util -a 1 -D zucker/apps/lix/lix.bin
```

Note: It may be necessary to remove the MicroSD card before programming with DFU.

Exit the bootloader and continue booting:

```
sudo dfu-util -e -a 0
```

## ISP Header

The ISP header can be used to program the FPGA SRAM as well as the MMOD flash memory. 

```
1 2
3 4
5 6
7 8
```

| Pin | Signal |
| --- | ------ |
| 1 | CSPI\_SS |
| 2 | CSPI\_SCK |
| 3 | CSPI\_SI |
| 4 | CSPI\_SO |
| 5 | CRESET |
| 6 | CDONE |
| 7 | GND |
| 8 | PWR3V3 (out) |

## Board Revisions

| Revision | Notes |
| -------- | ----- |
| V3B | Latest production board |
| V4 | Work in progress; improves USB routing  |

## License

The contents of this repo are released under the [Lone Dynamics Open License](LICENSE.md) with the following exceptions:

- The KiCad design files contain parts of the [kicad-pmod](https://github.com/mithro/kicad-pmod) library which is released under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.html).

- The KiCad design files may contain symbols and footprints released under other licenses; please contact us if we've failed to give proper attribution.

Note: You can use these designs for commercial purposes but we ask that instead of producing exact clones, that you either replace our trademarks and logos with your own or add your own next to ours.

