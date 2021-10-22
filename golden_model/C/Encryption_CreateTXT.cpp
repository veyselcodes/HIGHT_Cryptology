#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#define STR_LEN 16
#define KEYS 10
int main () {
    FILE *fp;
   	FILE *PlainT;
   	FILE *KT;
    unsigned char PT[STR_LEN + 1] = {0};
    unsigned char MK[2*STR_LEN + 1] = {0};
    const char *hex_digits = "0123456789ABCDEF";
    int i;

	fp = fopen("../../verif/Random_Plain_and_Master_Texts.txt", "wb");
	PlainT = fopen("../../verif/Random_Plain_Texts.txt", "wb");
	KT = fopen("../../verif/Random_Master_Texts.txt", "wb");
	
	if(fp == NULL)
    	exit(-1);
    if(PlainT == NULL)
    	exit(-1);
	if(KT == NULL)
    	exit(-1);
				
    printf("Plain Text\t\tMaster Key\n");
   for(int j=0; j< KEYS; j++){
   		for( i = 0 ; i < STR_LEN; i++ ) {
	      PT[i] = hex_digits[ ( rand() % 16 ) ];
	      fprintf (fp, "%c",PT[i]);
	      fprintf(PlainT,"%c",PT[i]);
	   }
	   fprintf (fp, "\t");
	   for( i = 0 ; i < 2*STR_LEN; i++ ) {
	      MK[i] = hex_digits[ ( rand() % 16 ) ];
	      fprintf (fp, "%c",MK[i]);
	      fprintf(KT,"%c",MK[i]);
	   }
	   fprintf (fp, "\n");
	   fprintf (PlainT, "\n");
	   fprintf (KT, "\n");
	   printf( "%s\t%s\n", PT , MK);
   }

  fclose(fp); 
   return(0);
}

