# Generic makefile rules

include ./mkscripts/locale.mk
include ./mkscripts/defs.mk
include ./mkscripts/cflags.mk

all: $(TARGET).elf $(TARGET).hex $(TARGET).bin

ALL_CSRC = $(CSRC) $(LIB_SRC)

OBJ =	$(ALL_CSRC:%.c=%.o) \
	$(CPPSRC:%.cpp=%.o) \
	$(ASRC:%.S=%.o)

DEPS =	$(ALL_CSRC:%.c=%.d) \
	$(CPPSRC:%.cpp=%.d) \
	$(ASRC:%.S=%.d)

ALL_INCDIRS = $(foreach i, $(INCDIRS), -I$(i))
ALL_LIBDIRS = $(foreach i, $(LIBDIRS), -L$(i))

-include $(DEPS)

%.o : %.c
	@echo $(MSG_COMPILING) $<
	@$(CC) -c $(ALL_CFLAGS) $< -o $@

$(TARGET).elf: $(OBJ)
	@echo $(MSG_LINKING) $@
	@$(LD) -T $(LINKER_SCRIPT) $(ALL_CFLAGS_LINKER) $(LDFLAGS) -o $@ $^
	@-$(SIZE) $@

$(TARGET).hex: $(TARGET).elf
	@echo $(MSG_FLASH) $@
	@$(OBJCOPY) -O ihex $< $@

$(TARGET).bin: $(TARGET).elf
	@echo $(MSG_FLASH) $@
	@$(OBJCOPY) -O binary $< $@

$(TARGET).dfu: $(TARGET).bin
	@echo $(MSG_DFU) $@
	@$(DFU_GEN) -b $(DFU_ADDR):$< $@

program: $(TARGET).bin
	@echo $(MSG_PROGRAM) $<
	@$(DFU_UTIL) -s 0x08000000 -a 0 -D $<

clean:
	@echo $(MSG_CLEANING)
	@$(REMOVE) \
		$(OBJ) \
		$(OBJ:%.o=%.d) \
		$(OBJ:%.o=%.lst) \
		$(TARGET).elf \
		$(TARGET).hex \
		$(TARGET).bin \
		$(TARGET).map
