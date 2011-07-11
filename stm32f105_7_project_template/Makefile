TARGET := blink
CSRC := main.c

CROSS_COMPILE := arm-none-eabi-

DEBUG         := 0
OPT           := 2
CSTANDARD     := gnu99
LINKER_SCRIPT := mkscripts/link.ld

INCDIRS := cmsis cmsis_boot Drivers/inc
LIBDIRS :=

# Address to place flash image in DFU file (by default 0x00000000)
DFU_ADDR := 0

include ./cmsis/cmsis.mk
include ./Drivers/stm32f10x_rcc.mk
include ./Drivers/stm32f10x_gpio.mk

include ./mkscripts/crules.mk
