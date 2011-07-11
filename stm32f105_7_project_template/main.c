#include "stm32f10x.h"
#include "stm32f10x_gpio.h"
#include "stm32f10x_rcc.h"
#include "system_stm32f10x.h"

void Delay(uint32_t msCount);

int main(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;

	SystemCoreClockUpdate();
	SysTick_Config(SystemCoreClock/1000);

	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE);

	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_All;
	GPIO_Init(GPIOB, &GPIO_InitStructure);

	while (1)
	{
		GPIO_WriteBit(GPIOB, GPIO_Pin_11, Bit_SET);
		Delay(100);
		GPIO_WriteBit(GPIOB, GPIO_Pin_11, Bit_RESET);
		Delay(100);
	}
	return 0;
}

static volatile uint32_t msTick = 0;

void SysTick_Handler(void)
{
	msTick++;
}

void Delay(uint32_t msCount)
{
	uint32_t currentTicks = msTick;
	while( (msTick - currentTicks) < msCount )
		;
}
