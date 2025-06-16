#include "xgpio.h"
#include "xparameters.h"
#include <unistd.h>


int main(){

	XGpio led;

	//ini LEDs
	XGpio_Initialize(&led,XPAR_LED_SWITCH_DEVICE_ID);

	//set data direction

	//LED
	XGpio_SetDataDirection(&led,2,0);
	//switches
	XGpio_SetDataDirection(&led,1,0xFFFF);



	int led_val;
	int sleep_val = 1;

	XGpio_DiscreteWrite(&led,2, 1);
	sleep(1);

	while(1){

//gestoin vitesse
		if(  XGpio_DiscreteRead(&led,1) == 0x0  ){ //sw1 on
			sleep_val = 1;
		}
		if(  XGpio_DiscreteRead(&led,1) == 0x1  ){ //sw1 on
			sleep_val = 2;
		}
		if(  XGpio_DiscreteRead(&led,1) == 0x2 ){ //sw2 on
			sleep_val = 3;
		}
		if(  XGpio_DiscreteRead(&led,1) == 0x4 ){ //sw3 on
			sleep_val= 4;
		}
		if( XGpio_DiscreteRead(&led,1) == 0x8 ){ //sw4 on
			sleep_val = 5;
		}
//gestion chenillard

		//décalage
		led_val = XGpio_DiscreteRead(&led,2) <<1;
		//on se remet à la 1ere LED
		if( led_val == 0x0000){
			led_val=1;
		}
		XGpio_DiscreteWrite(&led,2, led_val);
		delay(sleep_val*100);





	}
	return 0;
}

