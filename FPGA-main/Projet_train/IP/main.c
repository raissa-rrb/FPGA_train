#include "CENTRALE_DCC.h"
#include "xil_io.h"
#include "xparameters.h"

int main() {

	int sw;
    int btn;
    int btn_rebond = 0;
    int debut_trame; //bits 0 à 18 (bit 18 = start bit)
    int fin_trame; //bits 0 à 31 (bit 0 = stop bit)

	while(1) {
		sw = CENTRALE_DCC_mReadReg(XPAR_SW_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET);
        btn = CENTRALE_DCC_mReadReg(XPAR_BTN_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET);

        if (btn_rebond == 1 && btn == 0){
            btn_rebond = 0;
        }

		if (sw == 0x1 && btn == 1 && btn_rebond == 0){
            debut_trame = 0b1111111111111100000;
            fin_trame = 0b00010110111100000000000110111111;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
            btn_rebond = 1;
		}
		if (sw == 0x2 && btn == 1 && btn_rebond == 0){
			debut_trame = 0b1111111111111100000;
            fin_trame = 0b00010110111100000000010110111101;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
		}
		if (sw == 0x4 && btn == 1 && btn_rebond == 0){
			debut_trame = 0b1111111111111111111;
            fin_trame = 0b11110000000010101000000101000011;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
		}
		if (sw == 0x8 && btn == 1 && btn_rebond == 0){
			debut_trame = 0b1111111111111111111;
            fin_trame = 0b11110000000010101001000101001011;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
		}
		if (sw == 0x10 && btn == 1 && btn_rebond == 0) {
			debut_trame = 0b1111111111111111111;
            fin_trame = 0b11110000000010100000000100000011;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
		}
        if (sw == 0x20 && btn == 1 && btn_rebond == 0) {
			debut_trame = 0b1111111111111111111;
            fin_trame = 0b11110000000010100100000100100011;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
		}
        if (sw == 0x40 && btn == 1 && btn_rebond == 0) {
			debut_trame = 0b1111111111111111111;
            fin_trame = 0b11110000000010010101000010101011;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
		}
        if (sw == 0x80 && btn == 1 && btn_rebond == 0) {
			debut_trame = 0b1111111111111111111;
            fin_trame = 0b11110000000010011101000011101011;
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG0_OFFSET, debut_trame);
			CENTRALE_DCC_mWriteReg(XPAR_CENTRALE_DCC_0_S00_AXI_BASEADDR, CENTRALE_DCC_S00_AXI_SLV_REG1_OFFSET, fin_trame);
		}
	}

    return 0;

}