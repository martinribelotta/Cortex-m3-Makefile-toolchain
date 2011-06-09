#include "lpc17xx_gpio.h"
#include "lpc17xx_clkpwr.h"
#include "lpc17xx_systick.h"

static volatile unsigned int msTicks = 0;

void NombreExotico1(void) {
	msTicks++;
}

void Delay(unsigned int delayTicks) {
	unsigned int currentTicks;
	
	currentTicks = msTicks;
	while ((msTicks - currentTicks) < delayTicks)
		;
}

int main(void)
{
    CLKPWR_ConfigPPWR(CLKPWR_PCONP_PCGPIO, ENABLE);
    GPIO_SetDir(1, 1 << 18, 1);

    SYSTICK_InternalInit(10); // 10ms entre ticks
	SYSTICK_IntCmd(ENABLE);   // Habilita interrupcion SYSTICK
	SYSTICK_Cmd(ENABLE);      // Habilita timer SYSTICK

    while(1)
    {
    	Delay(25);
    	GPIO_ClearValue(1, 1 << 18);
    	Delay(25);
    	GPIO_SetValue(1, 1 << 18);
    }
}
