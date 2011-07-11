SHELL = sh
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
READELF  = $(CROSS_COMPILE)readelf
SIZE = $(CROSS_COMPILE)size
AR = $(CROSS_COMPILE)ar -r
NM = $(CROSS_COMPILE)nm
REMOVE = rm -f
REMOVEDIR = rm -rf
COPY = cp
MKDIR = mkdir -p
DFU_GEN = stm32_dfu
DFU_UTIL = dfu-utils-stm32
