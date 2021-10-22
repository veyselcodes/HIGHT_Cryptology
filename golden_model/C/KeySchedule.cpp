#include <stdio.h>
#include <math.h>

int bin2dec (unsigned int x[],int size);

int main(int argc, char **argv) {
    const char hexstring[] = "F43FB7FF9696D7AD55E687A34B960686", *pos = hexstring;
    unsigned char MK[16];
    unsigned char WK[8];
    unsigned char SK[128];
    unsigned int delta[128][7];
    unsigned int s[134];
    unsigned int s_init[7]= {0,1,0,1,1,0,1};
    int i,cnt,temp;

     /* WARNING: no sanitization or error-checking whatsoever */
    for (size_t count = 0; count < sizeof MK/sizeof *MK; count++) {
        sscanf(pos, "%2hhx", &MK[count]);
        pos += 2;
    }
	
	printf("Key: ");
    for(size_t count = 0; count < sizeof MK/sizeof *MK; count++)
        printf("%02x", MK[count]);
    printf("\n");
    
    
   // Constant Generation
    for(size_t count = 0; count < sizeof s_init/sizeof *s_init; count++)		// Ýlk 7 state bitinin ilk deltaya entegresi
   		 s[count]= s_init[count];
   		 
	for(i=1;i <= 127; i++){
		s[i+6]=s[i+2] ^ s[i-1];
		for( cnt=0;cnt<=6;cnt++){
			delta[i-1][6-cnt]= s[i-1+cnt];
		}
	}
	
	for(size_t count = 0; count < sizeof s_init/sizeof *s_init; count++)		// Ýlk 7 state bitinin son deltaya entegresi
   		 delta[127][6-count]= s_init[count];
	
	
	// Print Delta
	/*for(i=0;i<=127;i++)
		for(cnt=0;cnt<=6;cnt++){
			if(cnt % 7 == 0)
				printf("\n%d => ",i);
			printf("%d",delta[i][cnt]);
		}*/
	
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
	for(i=0;i<=7;i++){
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
        
			
    return 0;
}

int bin2dec (unsigned int x[],int size)   // function definition
{
	int decimal_val=0;
	for(int i=0;i<size;i++){
		decimal_val = decimal_val + ((int)pow(2,size-1-i))*x[i];
	}
    return ( decimal_val) ;
}
