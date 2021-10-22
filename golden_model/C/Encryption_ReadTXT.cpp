#include <stdio.h>
#include <stdlib.h> // For exit() function
int main() {
	char line[1000];
    char PT[17];
    char MK[33];
    
    char hexstring[] = "F43FB7FF9696D7AD55E687A34B960686", *pos = hexstring;
    char hexstring1[] = "F43FB7FF969696D7", *pos1 = hexstring1;
    unsigned char PlainT[8];
    unsigned char MasterK[16];
    
    FILE *fptr;
    if ((fptr = fopen("test.txt", "r")) == NULL) {
        printf("Error! opening file");
        // Program exits if file pointer returns NULL.
        exit(1);
    }
	
/*	while((fptr = fopen("test.txt", "r")) != NULL){
		// reads text until newline is encountered
	    fscanf(fptr, "%[^\n\t]", PT);
	    fscanf(fptr, "%[^\n1234567890ABCDEF]", tab);
	    fscanf(fptr, "%[^\n]", MK);
	    printf("%s\t%s\n", PT,MK);
	}*/
	
	 /* WARNING: no sanitization or error-checking whatsoever */
    
    printf("Plaint Texts\t\tMaster Keys\n");
    while(fgets(line,sizeof(line),fptr)){
    	for(int i=0;i<16;i++){
    		PT[i]=line[i];
    		hexstring1[i]=line[i];
		}
		PT[16]='\0';
		for(int i=17;i<49;i++){
    		MK[i-17]=line[i];
		}
		MK[32]='\0';
		printf("%s\t%s\n",PT,MK);
	}
	
	for (size_t count = 0; count < sizeof MasterK/sizeof *MasterK; count++) {
        sscanf(pos, "%2hhx", &MasterK[count]);
        pos += 2;
    }
    
    for (size_t count = 0; count < sizeof PlainT/sizeof *PlainT; count++) {
        sscanf(pos1, "%2hhx", &PlainT[count]);
        pos1 += 2;
    }
	
	
    printf("\nPlain Text: ");
    for(size_t count = 0; count <  8; count++)
        printf("%02x", PlainT[count]);
    printf("\n");
    fclose(fptr);

    return 0;
}
