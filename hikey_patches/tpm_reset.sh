#!/bin/bash

# Based on secure96 schematics. The SLB9670's nRST(Reset) pin is connected to GPIO_D which is connected
# to pin 26 of the Low Speed expansion slot. pin26 maps to pin number 491. see
# http://wiki.lemaker.org/HiKey(LeMaker_version):How_to_control_the_GPIO_on_the_board for the magic behind
# the conversion. Reset pin is active low. See slb9670 spec sheet and tpm_reset.c example from the bringup
# of secure96 on the dragonboard410c.
echo 491 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio491/direction
echo 1 > /sys/class/gpio/gpio491/value
sleep 1
echo 0 > /sys/class/gpio/gpio491/value
sleep 1
echo 1 > /sys/class/gpio/gpio491/value
rmmod tpm_tis_spi.ko
modprobe tpm_tis_spi
