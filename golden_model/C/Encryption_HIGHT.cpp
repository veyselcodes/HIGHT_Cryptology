#include <stdio.h>
#include <math.h>
#include <stdlib.h> // For exit() function

int bin2dec (int x[],int size);
void dec2bin (int x, int bin[], int size);
void ROTL (int x[],int size,int d);
void Reverse(int x[],int size);
int F0 (int x);
int F1 (int x);

int main(int argc, char **argv) {
    char hexstring[] = "F43FB7FF9696D7AD55E687A34B960686", *pos = hexstring;
    char hexstring1[] = "F43FB7FF969696D7", *pos1 = hexstring1;
    unsigned char PT[8];
    unsigned char MK[16];
    unsigned char WK[8];
    unsigned char SK[128];
    unsigned char X [33][8];
    unsigned char C [8];
    int delta[128][7];
    int s[134];
    int s_init[7]= {0,1,0,1,1,0,1};
    int i,cnt,temp;
    int bin_temp[8];
	int counter = 1;
	
	// Read TXT File
	char line[1000];
	FILE *fptr;
	// Write TXT File
	FILE *fp;
	fp = fopen("../../verif/C_Results.txt", "wb");
	if(fp == NULL)
    	exit(-1);
    printf("Plain Text\t\tMaster Key\n");
	
    if ((fptr = fopen("../../verif/Random_Plain_and_Master_Texts.txt", "r")) == NULL) {
        printf("Error! opening file");
        // Program exits if file pointer returns NULL.
        exit(1);
    }
    
    while(fgets(line,sizeof(line),fptr)){
    	printf("\n\n----------------- CODE %d -----------------\n\n", counter);
    	counter +=1;
    	
    	for(int i=0;i<16;i++){
    		hexstring1[i]=line[i];
		}
		for(int i=17;i<49;i++){
    		hexstring[i-17]=line[i];
		}
		 /* WARNING: no sanitization or error-checking whatsoever */
		pos = hexstring;
		pos1 = hexstring1;
	    for (size_t count = 0; count < sizeof MK/sizeof *MK; count++) {
	        sscanf(pos, "%2hhx", &MK[count]);
	        pos += 2;
	    }
	    
	    for (size_t count = 0; count < sizeof PT/sizeof *PT; count++) {
	        sscanf(pos1, "%2hhx", &PT[count]);
	        pos1 += 2;
	    }
		
		printf("Key: ");
	    for(size_t count = 0; count < sizeof MK/sizeof *MK; count++)
	        printf("%02x", MK[count]);
	    printf("\n");
	    
	    printf("Plain Text: ");
	    for(size_t count = 0; count < sizeof PT/sizeof *PT; count++)
	        printf("%02x", PT[count]);
	    printf("\n");
	    
	    
	    // Constant Generation
	    for(size_t count = 0; count < sizeof s_init/sizeof *s_init; count++)		// Ýlk 7 state bitinin ilk deltaya entegresi
	   		 s[count]= s_init[count];
	   		 
		for(int i=1;i <= 127; i++){
			s[i+6]=s[i+2] ^ s[i-1];
			for( cnt=0;cnt<=6;cnt++){
				delta[i-1][cnt]= s[i-1+cnt];
			}
		}
		
		for(size_t count = 0; count < sizeof s_init/sizeof *s_init; count++)		// Ýlk 7 state bitinin son deltaya entegresi
	   		 delta[127][count]= s_init[count];
		
		
		printf("\n--------------------WK Generation--------------------\n\nWhittening Key:  ");
			
		for(size_t count = 0; count < sizeof MK/2/sizeof *MK; count++){
	    	if(count <=3)
	    		WK[count]=MK[count+12];
	    	else
	    		WK[count]=MK[count-4];
	    	printf("%02x",WK[count]);
		}
		
		printf("\n");	
		printf("\n--------------------SK Generation--------------------\n");
		//Subkey Generation	
		for(int i=0;i<=7;i++){
			for(int j=0;j<=7;j++){
				int x= j-i;
				if(x < 0)
					x= x+16;
				temp = MK[15-((x)%8)] + bin2dec(delta[16*i+j],7);
				
					if(temp <=255)
						SK[16*i+j] = temp;
					else
						SK[16*i+j] = temp-256;
				//--------------------------------------------------//
				temp = MK[15-(((x)%8)+8)] + bin2dec(delta[16*i+j+8],7);
					if(temp <=255)
						SK[16*i+j+8] = temp;
					else
						SK[16*i+j+8] = temp-256;
			}
		}
			
		printf("\nSK:");	
				
		for(size_t count = 0; count < sizeof SK/sizeof *SK; count++){
			if(count % 8 == 0)
				printf("\n\t");
			printf("%02x\t", SK[count]);
		}
		
		printf("\n\n------------------Initial Transformation------------\n"); 
				
		X[0][0] = (PT[7-0] + WK[7-0])%256;
		X[0][1] = PT[7-1];
	 	X[0][2] = PT[7-2] ^ WK[7-1];
		X[0][3] = PT[7-3];
		X[0][4] = (PT[7-4] + WK[7-2])%256;
		X[0][5] = PT[7-5];
		X[0][6] = PT[7-6] ^ WK[7-3];
		X[0][7] = PT[7-7];
		// Write it to the terminal
		for(int i= 0; i<8;i++)
			printf("%02x XOR %02x = X[0][%d] = %02x\n",PT[7-i], WK[7-i], i, X[0][i]);
		printf("\n------------------Round Function--------------\n\n"); 
		for(int i=0;i < 33;i++){
			X[i+1][1] = X[i][0];
			X[i+1][3] = X[i][2];
			X[i+1][5] = X[i][4];
			X[i+1][7] = X[i][6];
			X[i+1][0] = X[i][7] ^ (((F0(X[i][6]))+SK[4*i+3])%256);
			X[i+1][2] = (X[i][1] + ((F1((X[i][0])) ^ SK[4*i+2])))%256;
			X[i+1][4] = X[i][3] ^ ((F0((X[i][2]))+SK[4*i+1])%256);
			X[i+1][6] = (X[i][5] + ((F1((X[i][4])) ^ SK[4*i])))%256;
			}
			
		for(int i=0;i<33;i++){
			for(int j=0;j<8;j++)
				printf("X[%d][%d] = %02x\t", i, j, X[i][j]);
			printf("\n");
		}	
		printf("\n------------------Final Transformation--------------\n");
	;
		C[0] = (X[32][1]+WK[7-4])%256;
		C[1] = X[32][2];
		C[2] = X[32][3] ^ WK[7-5];
		C[3] = X[32][4];
		C[4] = (X[32][5] + WK[7-6])%256;
		C[5] = X[32][6];
		C[6] = X[32][7] ^ WK[7-7];
		C[7] = X[32][0];
		
		for(int i= 0; i<8;i++){
			printf("C[%d] = %02x\n", i, C[i]);
		}
		
		
		printf("\n------------------Cipher Text-----------------------\n\n\t\t");
		for(int i= 0; i<8;i++){
			printf("%02x", C[7-i]);
			fprintf (fp, "%02x",C[7-i]);
		}
		fprintf (fp, "\n");	
	}
	
	fclose(fp); 
    
    return 0;
}

int bin2dec (int x[],int size)   // function definition
{
	int decimal_val=0;
	for(int i=0;i<size;i++){ // 1010
		decimal_val = decimal_val + ((int)pow(2,i))*x[i];
	}
    return ( decimal_val) ;
}

void dec2bin (int x, int bin[], int size)   // function definition
{
	for(int i=0;i<8;i++){
		bin[i] = x % 2;
		x = x / 2; 
	}
}

void ROTL (int x[],int size,int d)   // function definition
{	
	int temp;
	for(int i=0;i <d; i++){
		temp = x[size-1];
		for(int j=size-1;j>=0;j--){
		x[j] = x[j-1];
		}
		x[0] = temp;
	}
}
void Reverse(int x[],int size){
	int x_temp[size];
		
	for(int i=0;i<size;i++)
		x_temp[i]=x[i];
		
	for(int i=0;i<size-1;i++)
		x[i]=x_temp[size-1-i];
}

int F0 (int x){
	int f_zero,a,b,c;
	int b_temp[8];
	dec2bin(x,b_temp,8);
	ROTL(b_temp,8,1);
	a=bin2dec(b_temp,8);
	ROTL(b_temp,8,1);
	b=bin2dec(b_temp,8);
	ROTL(b_temp,8,5);
	c=bin2dec(b_temp,8);
	f_zero = a ^ b ^ c;
	return f_zero;
}

int F1 (int x){
	int f_one,a,b,c;
	int b_temp[8];
	dec2bin(x,b_temp,8);
	ROTL(b_temp,8,3);
	a=bin2dec(b_temp,8);
	ROTL(b_temp,8,1);
	b=bin2dec(b_temp,8);
	ROTL(b_temp,8,2);
	c=bin2dec(b_temp,8);
	f_one = a ^ b ^ c;
	return f_one;
}
