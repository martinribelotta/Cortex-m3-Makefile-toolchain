# CFLAGS: gcc compilation flags
CFLAGS = -g$(DEBUG)
CFLAGS += $(CDEFS)
CFLAGS += -O$(OPT)
CFLAGS += -Wall
CFLAGS += -Wno-unused
CFLAGS += -Wno-comments
CFLAGS += -fmessage-length=0
CFLAGS += -fno-builtin
CFLAGS += -ffunction-sections
CFLAGS += -Wextra
CFLAGS += -D__thumb2__=1
CFLAGS += -msoft-float
CFLAGS += -mno-sched-prolog
CFLAGS += -fno-hosted
CFLAGS += -mtune=cortex-m3
CFLAGS += -march=armv7-m
CFLAGS += -mfix-cortex-m3-ldrd
#CFLAGS += -Wundef
#CFLAGS += -funsigned-char
#CFLAGS += -funsigned-bitfields
#CFLAGS += -fno-inline-small-functions
#CFLAGS += -fpack-struct
#CFLAGS += -fshort-enums
#CFLAGS += -Wstrict-prototypes
#CFLAGS += -fno-unit-at-a-time
#CFLAGS += -Wunreachable-code
#CFLAGS += -Wsign-compare
CFLAGS += -Wa,-alhms=$(<:%.c=%.lst)
CFLAGS += $(patsubst %,-I%,$(EXTRAINCDIRS))
CFLAGS += -std=$(CSTANDARD)
CFLAGS += -mcpu=cortex-m3 -mthumb -mapcs-frame

# LDFLAGS: ld linker flags
LDFLAGS = -Wl,-Map=$(TARGET).map
#LDFLAGS += -Wl,--relax 
LDFLAGS += --gc-sections
LDFLAGS += $(EXTMEMOPTS)
LDFLAGS += $(patsubst %,-L%,$(EXTRALIBDIRS))
#LDFLAGS += $(PRINTF_LIB) $(SCANF_LIB)
LDFLAGS += -static
LDFLAGS += -Wl,--start-group 
#LDFLAGS += -L$(THUMB2GNULIB) -L$(THUMB2GNULIB2)
LDFLAGS += -lc -lg -lstdc++ -lsupc++ 
LDFLAGS += -lgcc -lm 
LDFLAGS += -Wl,--end-group 
#LDFLAGS += $(MATH_LIB)
#LDFLAGS += -T linker_script.x

GENDEPFLAGS = -MMD -MP -MD

# All flags
ALL_CFLAGS = -I. $(ALL_INCDIRS) $(CFLAGS) $(GENDEPFLAGS)
ALL_CFLAGS_LINKER = -mcpu=cortex-m3 -mthumb -mapcs-frame $(ALL_LIBDIRS)
