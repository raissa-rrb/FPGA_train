#include "xgpio.h"
#include "xparameters.h"
#include <unistd.h>


int main(){

	XGpio led, btn;
	int sw0_val,btn_val, led_val;
	int btnL_ON=0;
	int cpt = 0;
	int btnC_inc = 0;

	//associer variable au périphérique
	XGpio_Initialize(&led,XPAR_LED_SWITCH_DEVICE_ID);
	XGpio_Initialize(&btn,XPAR_BOUTON_DEVICE_ID);

	//Fixer direction des ports
	XGpio_SetDataDirection(&led,1,0xFFFF);//entrée
	XGpio_SetDataDirection(&led,2,0);//sortie
	XGpio_SetDataDirection(&btn,1,0xF);//entrée


	while(1){

		sw0_val = XGpio_DiscreteRead(&led,1);//lit int0


		if(sw0_val== 0x1){//int0 ou les deux

			while(sw0_val == 0x1){
				sw0_val = XGpio_DiscreteRead(&led,1);//lit int0
				led_val = XGpio_DiscreteRead(&led,2);
				XGpio_DiscreteWrite(&led,2,led_val | 0xFF00);//8G ON
				delay(100);
				XGpio_DiscreteWrite(&led,2,led_val & 0x00FF);//8G OFF
				delay(100);
			}
		}
		if (sw0_val == 0x2){//int1
			while (sw0_val == 0x2){
				sw0_val = XGpio_DiscreteRead(&led,1);
				led_val = XGpio_DiscreteRead(&led,2);
				XGpio_DiscreteWrite(&led,2, (0xFF00 & led_val) | cpt);

				btn_val = XGpio_DiscreteRead(&btn,1);
				if (btn_val == 0x2 && btnC_inc == 0){
					cpt = (cpt+1)%16;
					btnC_inc = 1;
				}

				if (btn_val != 0x2 && btnC_inc == 1) {
					btnC_inc = 0;
				}

				btn_val = XGpio_DiscreteRead(&btn,1);
				if(btn_val == 0x4){btnL_ON=1;}
				while(btnL_ON && sw0_val == 0x2){
					sw0_val = XGpio_DiscreteRead(&led,1);
					led_val = XGpio_DiscreteRead(&led,2);

					btn_val = XGpio_DiscreteRead(&btn,1);
					if (btn_val == 0x2 && btnC_inc == 0){
						cpt = (cpt+1)%16;
						btnC_inc = 1;
					}

					if (btn_val != 0x2 && btnC_inc == 1) {
						btnC_inc = 0;
					}

					XGpio_DiscreteWrite(&led,2, ((0xFF00 & led_val) | cpt) | 0x00F0);//8G OFF
					if(btn_val == 0x1){
						btnL_ON=0;
						led_val = XGpio_DiscreteRead(&led,2);
						XGpio_DiscreteWrite(&led,2,led_val & 0xFF0F);//8G OFF
					}
				}
			}
			btnL_ON = 0;
		}
		if (sw0_val == 0x0 || sw0_val == 0x1){
			cpt = 0;
			XGpio_DiscreteWrite(&led,2,led_val & 0xFF00);
		}
		if (sw0_val == 0x3){ //int0 et int1 (optionnel)
			while(sw0_val == 0x3){
				sw0_val = XGpio_DiscreteRead(&led,1);//lit int0
				led_val = XGpio_DiscreteRead(&led,2);
				XGpio_DiscreteWrite(&led,2,led_val | 0xFF00);//8G ON
				delay(100);
				XGpio_DiscreteWrite(&led,2,led_val & 0x00FF);//8G OFF
				delay(100);
				sw0_val = XGpio_DiscreteRead(&led,1);
				led_val = XGpio_DiscreteRead(&led,2);
				XGpio_DiscreteWrite(&led,2, (0xFF00 | led_val) | cpt);

				btn_val = XGpio_DiscreteRead(&btn,1);
				if (btn_val == 0x2 && btnC_inc == 0){
					cpt = (cpt+1)%16;
					btnC_inc = 1;
				}

				if (btn_val != 0x2 && btnC_inc == 1) {
					btnC_inc = 0;
				}

				btn_val = XGpio_DiscreteRead(&btn,1);
				if(btn_val == 0x4){btnL_ON=1;}
				while(btnL_ON && sw0_val == 0x3){
					sw0_val = XGpio_DiscreteRead(&led,1);
					led_val = XGpio_DiscreteRead(&led,2);

					XGpio_DiscreteWrite(&led,2,led_val | 0xFF00);//8G ON
					delay(100);
					XGpio_DiscreteWrite(&led,2,led_val & 0x00FF);//8G OFF
					delay(100);

					btn_val = XGpio_DiscreteRead(&btn,1);
					if (btn_val == 0x2 && btnC_inc == 0){
						cpt = (cpt+1)%16;
						btnC_inc = 1;
					}

					if (btn_val != 0x2 && btnC_inc == 1) {
						btnC_inc = 0;
					}

					XGpio_DiscreteWrite(&led,2, ((0xFF00 & led_val) | cpt) | 0x00F0);//8G OFF
					if(btn_val == 0x1){
						btnL_ON=0;
						led_val = XGpio_DiscreteRead(&led,2);
						XGpio_DiscreteWrite(&led,2,led_val & 0xFF0F);//8G OFF
					}
				}
			}

			btnL_ON = 0;
			XGpio_DiscreteWrite(&led,2,led_val & 0x0000);//éteindre tout le monde
		}
	}
	return 0;
}

