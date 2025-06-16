#include "xgpio.h"
#include "xparameters.h"


int main(){

	XGpio led;
	int sw_val;

	//associer variable au périphérique
	XGpio_Initialize(&led,XPAR_LED_SWITCH_DEVICE_ID);

	//Fixer direction des ports
	XGpio_SetDataDirection(&led,1,0xF);//entrée
	XGpio_SetDataDirection(&led,2,0);//sortie


	while(1){
		sw_val = XGpio_DiscreteRead(&led,1);

		XGpio_DiscreteWrite(&led,2,sw_val);

	}



	return 0;
}
