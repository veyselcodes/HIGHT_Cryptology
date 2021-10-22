#include <stdio.h>
#include <conio.h>

int main(int argc, char **argv) {
    const char hexstring[] = "F43FB7FF9696D7AD55E687A34B960686", *pos = hexstring;
    unsigned char MK[16];
    unsigned char WK[8];

     /* WARNING: no sanitization or error-checking whatsoever */
    for (size_t count = 0; count < sizeof MK/sizeof *MK; count++) {
        sscanf(pos, "%2hhx", &MK[count]);
        pos += 2;
    }

    for(size_t count = 0; count < sizeof MK/sizeof *MK; count++)
        printf("%02x", MK[count]);
    printf("\n");
    for(size_t count = 0; count < sizeof MK/2/sizeof *MK; count++){
    	if(count <=3)
    		WK[count]=MK[count+12];
    	else
    		WK[count]=MK[count-4];
    	printf("%02x",WK[count]);
	}
	printf("\n");
    return 0;
}
