TARGET := blink
CSRC := main.c

CROSS_COMPILE := arm-none-eabi-

DEBUG         := 0
OPT           := 0
CSTANDARD     := gnu99
LINKER_SCRIPT := mkscripts/link.ld

INCDIRS := cmsis cmsis_boot Drivers/include
LIBDIRS :=
LIB_SRC :=

include ./cmsis/cmsis.mk
include ./Drivers/lpc17xx_gpio.mk
include ./Drivers/lpc17xx_clkpwr.mk
include ./Drivers/lpc17xx_systick.mk

include ./mkscripts/crules.mk
