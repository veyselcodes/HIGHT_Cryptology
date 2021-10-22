library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity HIGHT_KeySchedule	is
port(
		i_HIGHT_KeySchedule_reset 			: in std_logic;
		i_HIGHT_KeySchedule_clk				: in std_logic;
		i_HIGHT_KeySchedule_MasterKey		: in std_logic_vector(127 downto 0);
		-- Outputs
		o_HIGHT_KeySchedule_WhitteningKey	: out std_logic_vector(63 downto 0);
		o_HIGHT_KeySchedule_SubKey			: out std_logic_vector(1023 downto 0)
);
end HIGHT_KeySchedule;

architecture behaviour of HIGHT_KeySchedule is

signal WhiteK		: std_logic_vector(63 downto 0);
signal delta	: std_logic_vector(1023 downto 0);
signal SubK		: std_logic_vector(1023 downto 0);



begin

o_HIGHT_KeySchedule_WhitteningKey 	<= WhiteK;
o_HIGHT_KeySchedule_SubKey 			<= SubK;

-- Concurrent Description
		delta(1023 downto 896) 		   <= (others=>'0');
		delta((0+1)  *7-1 downto 0  *7)<= "1011010";
		delta((1+1)  *7-1 downto 1  *7)<= "1101101";
		delta((2+1)  *7-1 downto 2  *7)<= "0110110";
		delta((3+1)  *7-1 downto 3  *7)<= "0011011";
		delta((4+1)  *7-1 downto 4  *7)<= "0001101";
		delta((5+1)  *7-1 downto 5  *7)<= "0000110";
		delta((6+1)  *7-1 downto 6  *7)<= "0000011";
		delta((7+1)  *7-1 downto 7  *7)<= "1000001";
		delta((8+1)  *7-1 downto 8  *7)<= "1100000";
		delta((9+1)  *7-1 downto 9  *7)<= "0110000";
		delta((10+1) *7-1 downto 10 *7)<= "0011000";
		delta((11+1) *7-1 downto 11 *7)<= "1001100";
		delta((12+1) *7-1 downto 12 *7)<= "1100110";
		delta((13+1) *7-1 downto 13 *7)<= "0110011";
		delta((14+1) *7-1 downto 14 *7)<= "1011001";
		delta((15+1) *7-1 downto 15 *7)<= "0101100";
		delta((16+1) *7-1 downto 16 *7)<= "1010110";
		delta((17+1) *7-1 downto 17 *7)<= "0101011";
		delta((18+1) *7-1 downto 18 *7)<= "0010101";
		delta((19+1) *7-1 downto 19 *7)<= "1001010";
		delta((20+1) *7-1 downto 20 *7)<= "1100101";
		delta((21+1) *7-1 downto 21 *7)<= "1110010";
		delta((22+1) *7-1 downto 22 *7)<= "0111001";
		delta((23+1) *7-1 downto 23 *7)<= "0011100";
		delta((24+1) *7-1 downto 24 *7)<= "1001110";
		delta((25+1) *7-1 downto 25 *7)<= "1100111";
		delta((26+1) *7-1 downto 26 *7)<= "1110011";
		delta((27+1) *7-1 downto 27 *7)<= "1111001";
		delta((28+1) *7-1 downto 28 *7)<= "0111100";
		delta((29+1) *7-1 downto 29 *7)<= "1011110";
		delta((30+1) *7-1 downto 30 *7)<= "1101111";
		delta((31+1) *7-1 downto 31 *7)<= "0110111";
		delta((32+1) *7-1 downto 32 *7)<= "1011011";
		delta((33+1) *7-1 downto 33 *7)<= "0101101";
		delta((34+1) *7-1 downto 34 *7)<= "0010110";
		delta((35+1) *7-1 downto 35 *7)<= "0001011";
		delta((36+1) *7-1 downto 36 *7)<= "0000101";
		delta((37+1) *7-1 downto 37 *7)<= "1000010";
		delta((38+1) *7-1 downto 38 *7)<= "0100001";
		delta((39+1) *7-1 downto 39 *7)<= "1010000";
		delta((40+1) *7-1 downto 40 *7)<= "0101000";
		delta((41+1) *7-1 downto 41 *7)<= "1010100";
		delta((42+1) *7-1 downto 42 *7)<= "0101010";
		delta((43+1) *7-1 downto 43 *7)<= "1010101";
		delta((44+1) *7-1 downto 44 *7)<= "1101010";
		delta((45+1) *7-1 downto 45 *7)<= "1110101";
		delta((46+1) *7-1 downto 46 *7)<= "1111010";
		delta((47+1) *7-1 downto 47 *7)<= "1111101";
		delta((48+1) *7-1 downto 48 *7)<= "0111110";
		delta((49+1) *7-1 downto 49 *7)<= "1011111";
		delta((50+1) *7-1 downto 50 *7)<= "0101111";
		delta((51+1) *7-1 downto 51 *7)<= "0010111";
		delta((52+1) *7-1 downto 52 *7)<= "1001011";
		delta((53+1) *7-1 downto 53 *7)<= "0100101";
		delta((54+1) *7-1 downto 54 *7)<= "1010010";
		delta((55+1) *7-1 downto 55 *7)<= "0101001";
		delta((56+1) *7-1 downto 56 *7)<= "0010100";
		delta((57+1) *7-1 downto 57 *7)<= "0001010";
		delta((58+1) *7-1 downto 58 *7)<= "1000101";
		delta((59+1) *7-1 downto 59 *7)<= "1100010";
		delta((60+1) *7-1 downto 60 *7)<= "0110001";
		delta((61+1) *7-1 downto 61 *7)<= "1011000";
		delta((62+1) *7-1 downto 62 *7)<= "1101100";
		delta((63+1) *7-1 downto 63 *7)<= "1110110";
		delta((64+1) *7-1 downto 64 *7)<= "0111011";
		delta((65+1) *7-1 downto 65 *7)<= "0011101";
		delta((66+1) *7-1 downto 66 *7)<= "0001110";
		delta((67+1) *7-1 downto 67 *7)<= "1000111";
		delta((68+1) *7-1 downto 68 *7)<= "1100011";
		delta((69+1) *7-1 downto 69 *7)<= "1110001";
		delta((70+1) *7-1 downto 70 *7)<= "1111000";
		delta((71+1) *7-1 downto 71 *7)<= "1111100";
		delta((72+1) *7-1 downto 72 *7)<= "1111110";
		delta((73+1) *7-1 downto 73 *7)<= "1111111";
		delta((74+1) *7-1 downto 74 *7)<= "0111111";
		delta((75+1) *7-1 downto 75 *7)<= "0011111";
		delta((76+1) *7-1 downto 76 *7)<= "0001111";
		delta((77+1) *7-1 downto 77 *7)<= "0000111";
		delta((78+1) *7-1 downto 78 *7)<= "1000011";
		delta((79+1) *7-1 downto 79 *7)<= "1100001";
		delta((80+1) *7-1 downto 80 *7)<= "1110000";
		delta((81+1) *7-1 downto 81 *7)<= "0111000";
		delta((82+1) *7-1 downto 82 *7)<= "1011100";
		delta((83+1) *7-1 downto 83 *7)<= "1101110";
		delta((84+1) *7-1 downto 84 *7)<= "1110111";
		delta((85+1) *7-1 downto 85 *7)<= "1111011";
		delta((86+1) *7-1 downto 86 *7)<= "0111101";
		delta((87+1) *7-1 downto 87 *7)<= "0011110";
		delta((88+1) *7-1 downto 88 *7)<= "1001111";
		delta((89+1) *7-1 downto 89 *7)<= "0100111";
		delta((90+1) *7-1 downto 90 *7)<= "1010011";
		delta((91+1) *7-1 downto 91 *7)<= "1101001";
		delta((92+1) *7-1 downto 92 *7)<= "0110100";
		delta((93+1) *7-1 downto 93 *7)<= "0011010";
		delta((94+1) *7-1 downto 94 *7)<= "1001101";
		delta((95+1) *7-1 downto 95 *7)<= "0100110";
		delta((96+1) *7-1 downto 96 *7)<= "0010011";
		delta((97+1) *7-1 downto 97 *7)<= "1001001";
		delta((98+1) *7-1 downto 98 *7)<= "0100100";
		delta((99+1) *7-1 downto 99 *7)<= "0010010";
		delta((100+1)*7-1 downto 100*7)<= "0001001";
		delta((101+1)*7-1 downto 101*7)<= "0000100";
		delta((102+1)*7-1 downto 102*7)<= "0000010";
		delta((103+1)*7-1 downto 103*7)<= "0000001";
		delta((104+1)*7-1 downto 104*7)<= "1000000";
		delta((105+1)*7-1 downto 105*7)<= "0100000";
		delta((106+1)*7-1 downto 106*7)<= "0010000";
		delta((107+1)*7-1 downto 107*7)<= "0001000";
		delta((108+1)*7-1 downto 108*7)<= "1000100";
		delta((109+1)*7-1 downto 109*7)<= "0100010";
		delta((110+1)*7-1 downto 110*7)<= "0010001";
		delta((111+1)*7-1 downto 111*7)<= "1001000";
		delta((112+1)*7-1 downto 112*7)<= "1100100";
		delta((113+1)*7-1 downto 113*7)<= "0110010";
		delta((114+1)*7-1 downto 114*7)<= "0011001";
		delta((115+1)*7-1 downto 115*7)<= "0001100";
		delta((116+1)*7-1 downto 116*7)<= "1000110";
		delta((117+1)*7-1 downto 117*7)<= "0100011";
		delta((118+1)*7-1 downto 118*7)<= "1010001";
		delta((119+1)*7-1 downto 119*7)<= "1101000";
		delta((120+1)*7-1 downto 120*7)<= "1110100";
		delta((121+1)*7-1 downto 121*7)<= "0111010";
		delta((122+1)*7-1 downto 122*7)<= "1011101";
		delta((123+1)*7-1 downto 123*7)<= "0101110";
		delta((124+1)*7-1 downto 124*7)<= "1010111";
		delta((125+1)*7-1 downto 125*7)<= "1101011";
		delta((126+1)*7-1 downto 126*7)<= "0110101";	
		delta((127+1)*7-1 downto 127*7)<= "1011010";
		
process(ALL) is begin

	if(i_HIGHT_KeySchedule_reset = '0')then
		WhiteK <= (others=> '0'); 
		SubK <= (others=> '0'); 
	else
	-- Whittening Key Generation Process:
	
		-- if  0<= i <= 3, then WhiteK(i) <= MK(i+12):
		WhiteK(1*8-1 downto 0*8) <= i_HIGHT_KeySchedule_MasterKey(13*8-1 downto 12*8);
		WhiteK(2*8-1 downto 1*8) <= i_HIGHT_KeySchedule_MasterKey(14*8-1 downto 13*8);
		WhiteK(3*8-1 downto 2*8) <= i_HIGHT_KeySchedule_MasterKey(15*8-1 downto 14*8);
		WhiteK(4*8-1 downto 3*8) <= i_HIGHT_KeySchedule_MasterKey(16*8-1 downto 15*8);
		
		-- if  4<= i <= 7, then WhiteK(i) <= MK(i-4):
		WhiteK(5*8-1 downto 4*8) <= i_HIGHT_KeySchedule_MasterKey(1*8-1 downto 0*8);
		WhiteK(6*8-1 downto 5*8) <= i_HIGHT_KeySchedule_MasterKey(2*8-1 downto 1*8);
		WhiteK(7*8-1 downto 6*8) <= i_HIGHT_KeySchedule_MasterKey(3*8-1 downto 2*8);
		WhiteK(8*8-1 downto 7*8) <= i_HIGHT_KeySchedule_MasterKey(4*8-1 downto 3*8);
		
			
		-- Run Key Generation
	 -- SubK(((16*i + (j+1))*8)-1 downto (16*i + j)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((j-i) mod 8))*8-1 downto (0+(j-i) mod 8)*8) + delta((16*i+(j+1))*8-1 downto (16*i+j)*8);
		SubK(((16*0 + 1)*8)-1 	downto (16*0 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-0) mod 8))*8-1 downto (0+(0-0) mod 8)*8) + delta((16*0+1)*7-1 	downto (16*0+0)*7); -- i= 0 j= 0
		SubK(((16*0 + 2)*8)-1 	downto (16*0 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-0) mod 8))*8-1 downto (0+(1-0) mod 8)*8) + delta((16*0+2)*7-1 	downto (16*0+1)*7); -- i= 0 j= 1
		SubK(((16*0 + 3)*8)-1 	downto (16*0 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-0) mod 8))*8-1 downto (0+(2-0) mod 8)*8) + delta((16*0+3)*7-1 	downto (16*0+2)*7); -- i= 0 j= 2
		SubK(((16*0 + 4)*8)-1 	downto (16*0 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-0) mod 8))*8-1 downto (0+(3-0) mod 8)*8) + delta((16*0+4)*7-1 	downto (16*0+3)*7); -- i= 0 j= 3
		SubK(((16*0 + 5)*8)-1 	downto (16*0 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-0) mod 8))*8-1 downto (0+(4-0) mod 8)*8) + delta((16*0+5)*7-1 	downto (16*0+4)*7); -- i= 0 j= 4
		SubK(((16*0 + 6)*8)-1 	downto (16*0 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-0) mod 8))*8-1 downto (0+(5-0) mod 8)*8) + delta((16*0+6)*7-1 	downto (16*0+5)*7); -- i= 0 j= 5
		SubK(((16*0 + 7)*8)-1 	downto (16*0 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-0) mod 8))*8-1 downto (0+(6-0) mod 8)*8) + delta((16*0+7)*7-1 	downto (16*0+6)*7); -- i= 0 j= 6
		SubK(((16*0 + 8)*8)-1 	downto (16*0 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-0) mod 8))*8-1 downto (0+(7-0) mod 8)*8) + delta((16*0+8)*7-1 	downto (16*0+7)*7); -- i= 0 j= 7
																																					
		SubK(((16*1 + 1)*8)-1 	downto (16*1 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-1) mod 8))*8-1 downto (0+(0-1) mod 8)*8) + delta((16*1+1)*7-1 	downto (16*1+0)*7); -- i= 1 j= 0
		SubK(((16*1 + 2)*8)-1 	downto (16*1 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-1) mod 8))*8-1 downto (0+(1-1) mod 8)*8) + delta((16*1+2)*7-1 	downto (16*1+1)*7); -- i= 1 j= 1
		SubK(((16*1 + 3)*8)-1 	downto (16*1 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-1) mod 8))*8-1 downto (0+(2-1) mod 8)*8) + delta((16*1+3)*7-1 	downto (16*1+2)*7); -- i= 1 j= 2
		SubK(((16*1 + 4)*8)-1 	downto (16*1 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-1) mod 8))*8-1 downto (0+(3-1) mod 8)*8) + delta((16*1+4)*7-1 	downto (16*1+3)*7); -- i= 1 j= 3
		SubK(((16*1 + 5)*8)-1 	downto (16*1 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-1) mod 8))*8-1 downto (0+(4-1) mod 8)*8) + delta((16*1+5)*7-1 	downto (16*1+4)*7); -- i= 1 j= 4
		SubK(((16*1 + 6)*8)-1 	downto (16*1 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-1) mod 8))*8-1 downto (0+(5-1) mod 8)*8) + delta((16*1+6)*7-1 	downto (16*1+5)*7); -- i= 1 j= 5
		SubK(((16*1 + 7)*8)-1 	downto (16*1 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-1) mod 8))*8-1 downto (0+(6-1) mod 8)*8) + delta((16*1+7)*7-1 	downto (16*1+6)*7); -- i= 1 j= 6
		SubK(((16*1 + 8)*8)-1 	downto (16*1 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-1) mod 8))*8-1 downto (0+(7-1) mod 8)*8) + delta((16*1+8)*7-1 	downto (16*1+7)*7); -- i= 1 j= 7
																																					
		SubK(((16*2 + 1)*8)-1 	downto (16*2 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-2) mod 8))*8-1 downto (0+(0-2) mod 8)*8) + delta((16*2+1)*7-1 	downto (16*2+0)*7); -- i= 2 j= 0
		SubK(((16*2 + 2)*8)-1 	downto (16*2 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-2) mod 8))*8-1 downto (0+(1-2) mod 8)*8) + delta((16*2+2)*7-1 	downto (16*2+1)*7); -- i= 2 j= 1
		SubK(((16*2 + 3)*8)-1 	downto (16*2 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-2) mod 8))*8-1 downto (0+(2-2) mod 8)*8) + delta((16*2+3)*7-1 	downto (16*2+2)*7); -- i= 2 j= 2
		SubK(((16*2 + 4)*8)-1 	downto (16*2 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-2) mod 8))*8-1 downto (0+(3-2) mod 8)*8) + delta((16*2+4)*7-1 	downto (16*2+3)*7); -- i= 2 j= 3
		SubK(((16*2 + 5)*8)-1 	downto (16*2 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-2) mod 8))*8-1 downto (0+(4-2) mod 8)*8) + delta((16*2+5)*7-1 	downto (16*2+4)*7); -- i= 2 j= 4
		SubK(((16*2 + 6)*8)-1 	downto (16*2 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-2) mod 8))*8-1 downto (0+(5-2) mod 8)*8) + delta((16*2+6)*7-1 	downto (16*2+5)*7); -- i= 2 j= 5
		SubK(((16*2 + 7)*8)-1 	downto (16*2 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-2) mod 8))*8-1 downto (0+(6-2) mod 8)*8) + delta((16*2+7)*7-1 	downto (16*2+6)*7); -- i= 2 j= 6
		SubK(((16*2 + 8)*8)-1 	downto (16*2 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-2) mod 8))*8-1 downto (0+(7-2) mod 8)*8) + delta((16*2+8)*7-1 	downto (16*2+7)*7); -- i= 2 j= 7
																																				
		SubK(((16*3 + 1)*8)-1 	downto (16*3 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-3) mod 8))*8-1 downto (0+(0-3) mod 8)*8) + delta((16*3+1)*7-1 	downto (16*3+0)*7); -- i= 3 j= 0
		SubK(((16*3 + 2)*8)-1 	downto (16*3 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-3) mod 8))*8-1 downto (0+(1-3) mod 8)*8) + delta((16*3+2)*7-1 	downto (16*3+1)*7); -- i= 3 j= 1
		SubK(((16*3 + 3)*8)-1 	downto (16*3 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-3) mod 8))*8-1 downto (0+(2-3) mod 8)*8) + delta((16*3+3)*7-1 	downto (16*3+2)*7); -- i= 3 j= 2
		SubK(((16*3 + 4)*8)-1 	downto (16*3 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-3) mod 8))*8-1 downto (0+(3-3) mod 8)*8) + delta((16*3+4)*7-1 	downto (16*3+3)*7); -- i= 3 j= 3
		SubK(((16*3 + 5)*8)-1 	downto (16*3 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-3) mod 8))*8-1 downto (0+(4-3) mod 8)*8) + delta((16*3+5)*7-1 	downto (16*3+4)*7); -- i= 3 j= 4
		SubK(((16*3 + 6)*8)-1 	downto (16*3 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-3) mod 8))*8-1 downto (0+(5-3) mod 8)*8) + delta((16*3+6)*7-1 	downto (16*3+5)*7); -- i= 3 j= 5
		SubK(((16*3 + 7)*8)-1 	downto (16*3 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-3) mod 8))*8-1 downto (0+(6-3) mod 8)*8) + delta((16*3+7)*7-1 	downto (16*3+6)*7); -- i= 3 j= 6
		SubK(((16*3 + 8)*8)-1 	downto (16*3 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-3) mod 8))*8-1 downto (0+(7-3) mod 8)*8) + delta((16*3+8)*7-1 	downto (16*3+7)*7); -- i= 3 j= 7
																																					
		SubK(((16*4 + 1)*8)-1 	downto (16*4 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-4) mod 8))*8-1 downto (0+(0-4) mod 8)*8) + delta((16*4+1)*7-1 	downto (16*4+0)*7); -- i= 4 j= 0
		SubK(((16*4 + 2)*8)-1 	downto (16*4 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-4) mod 8))*8-1 downto (0+(1-4) mod 8)*8) + delta((16*4+2)*7-1 	downto (16*4+1)*7); -- i= 4 j= 1
		SubK(((16*4 + 3)*8)-1 	downto (16*4 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-4) mod 8))*8-1 downto (0+(2-4) mod 8)*8) + delta((16*4+3)*7-1 	downto (16*4+2)*7); -- i= 4 j= 2
		SubK(((16*4 + 4)*8)-1 	downto (16*4 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-4) mod 8))*8-1 downto (0+(3-4) mod 8)*8) + delta((16*4+4)*7-1 	downto (16*4+3)*7); -- i= 4 j= 3
		SubK(((16*4 + 5)*8)-1 	downto (16*4 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-4) mod 8))*8-1 downto (0+(4-4) mod 8)*8) + delta((16*4+5)*7-1 	downto (16*4+4)*7); -- i= 4 j= 4
		SubK(((16*4 + 6)*8)-1 	downto (16*4 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-4) mod 8))*8-1 downto (0+(5-4) mod 8)*8) + delta((16*4+6)*7-1 	downto (16*4+5)*7); -- i= 4 j= 5
		SubK(((16*4 + 7)*8)-1 	downto (16*4 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-4) mod 8))*8-1 downto (0+(6-4) mod 8)*8) + delta((16*4+7)*7-1 	downto (16*4+6)*7); -- i= 4 j= 6
		SubK(((16*4 + 8)*8)-1 	downto (16*4 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-4) mod 8))*8-1 downto (0+(7-4) mod 8)*8) + delta((16*4+8)*7-1 	downto (16*4+7)*7); -- i= 4 j= 7		
																																			
		SubK(((16*5 + 1)*8)-1 	downto (16*5 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-5) mod 8))*8-1 downto (0+(0-5) mod 8)*8) + delta((16*5+1)*7-1 	downto (16*5+0)*7); -- i= 5 j= 0
		SubK(((16*5 + 2)*8)-1 	downto (16*5 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-5) mod 8))*8-1 downto (0+(1-5) mod 8)*8) + delta((16*5+2)*7-1 	downto (16*5+1)*7); -- i= 5 j= 1
		SubK(((16*5 + 3)*8)-1 	downto (16*5 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-5) mod 8))*8-1 downto (0+(2-5) mod 8)*8) + delta((16*5+3)*7-1 	downto (16*5+2)*7); -- i= 5 j= 2
		SubK(((16*5 + 4)*8)-1 	downto (16*5 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-5) mod 8))*8-1 downto (0+(3-5) mod 8)*8) + delta((16*5+4)*7-1 	downto (16*5+3)*7); -- i= 5 j= 3
		SubK(((16*5 + 5)*8)-1 	downto (16*5 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-5) mod 8))*8-1 downto (0+(4-5) mod 8)*8) + delta((16*5+5)*7-1 	downto (16*5+4)*7); -- i= 5 j= 4
		SubK(((16*5 + 6)*8)-1 	downto (16*5 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-5) mod 8))*8-1 downto (0+(5-5) mod 8)*8) + delta((16*5+6)*7-1 	downto (16*5+5)*7); -- i= 5 j= 5
		SubK(((16*5 + 7)*8)-1 	downto (16*5 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-5) mod 8))*8-1 downto (0+(6-5) mod 8)*8) + delta((16*5+7)*7-1 	downto (16*5+6)*7); -- i= 5 j= 6
		SubK(((16*5 + 8)*8)-1 	downto (16*5 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-5) mod 8))*8-1 downto (0+(7-5) mod 8)*8) + delta((16*5+8)*7-1 	downto (16*5+7)*7); -- i= 5 j= 7		
																																			
		SubK(((16*6 + 1)*8)-1 	downto (16*6 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-6) mod 8))*8-1 downto (0+(0-6) mod 8)*8) + delta((16*6+1)*7-1 	downto (16*6+0)*7); -- i= 6 j= 0
		SubK(((16*6 + 2)*8)-1 	downto (16*6 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-6) mod 8))*8-1 downto (0+(1-6) mod 8)*8) + delta((16*6+2)*7-1 	downto (16*6+1)*7); -- i= 6 j= 1
		SubK(((16*6 + 3)*8)-1 	downto (16*6 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-6) mod 8))*8-1 downto (0+(2-6) mod 8)*8) + delta((16*6+3)*7-1 	downto (16*6+2)*7); -- i= 6 j= 2
		SubK(((16*6 + 4)*8)-1 	downto (16*6 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-6) mod 8))*8-1 downto (0+(3-6) mod 8)*8) + delta((16*6+4)*7-1 	downto (16*6+3)*7); -- i= 6 j= 3
		SubK(((16*6 + 5)*8)-1 	downto (16*6 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-6) mod 8))*8-1 downto (0+(4-6) mod 8)*8) + delta((16*6+5)*7-1 	downto (16*6+4)*7); -- i= 6 j= 4
		SubK(((16*6 + 6)*8)-1 	downto (16*6 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-6) mod 8))*8-1 downto (0+(5-6) mod 8)*8) + delta((16*6+6)*7-1 	downto (16*6+5)*7); -- i= 6 j= 5
		SubK(((16*6 + 7)*8)-1 	downto (16*6 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-6) mod 8))*8-1 downto (0+(6-6) mod 8)*8) + delta((16*6+7)*7-1 	downto (16*6+6)*7); -- i= 6 j= 6
		SubK(((16*6 + 8)*8)-1 	downto (16*6 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-6) mod 8))*8-1 downto (0+(7-6) mod 8)*8) + delta((16*6+8)*7-1 	downto (16*6+7)*7); -- i= 6 j= 7		
																																			
		SubK(((16*7 + 1)*8)-1 	downto (16*7 + 0)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-7) mod 8))*8-1 downto (0+(0-7) mod 8)*8) + delta((16*7+1)*7-1 	downto (16*7+0)*7); -- i= 7 j= 0
		SubK(((16*7 + 2)*8)-1 	downto (16*7 + 1)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-7) mod 8))*8-1 downto (0+(1-7) mod 8)*8) + delta((16*7+2)*7-1 	downto (16*7+1)*7); -- i= 7 j= 1
		SubK(((16*7 + 3)*8)-1 	downto (16*7 + 2)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-7) mod 8))*8-1 downto (0+(2-7) mod 8)*8) + delta((16*7+3)*7-1 	downto (16*7+2)*7); -- i= 7 j= 2
		SubK(((16*7 + 4)*8)-1 	downto (16*7 + 3)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-7) mod 8))*8-1 downto (0+(3-7) mod 8)*8) + delta((16*7+4)*7-1 	downto (16*7+3)*7); -- i= 7 j= 3
		SubK(((16*7 + 5)*8)-1 	downto (16*7 + 4)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-7) mod 8))*8-1 downto (0+(4-7) mod 8)*8) + delta((16*7+5)*7-1 	downto (16*7+4)*7); -- i= 7 j= 4
		SubK(((16*7 + 6)*8)-1 	downto (16*7 + 5)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-7) mod 8))*8-1 downto (0+(5-7) mod 8)*8) + delta((16*7+6)*7-1 	downto (16*7+5)*7); -- i= 7 j= 5
		SubK(((16*7 + 7)*8)-1 	downto (16*7 + 6)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-7) mod 8))*8-1 downto (0+(6-7) mod 8)*8) + delta((16*7+7)*7-1 	downto (16*7+6)*7); -- i= 7 j= 6
		SubK(((16*7 + 8)*8)-1 	downto (16*7 + 7)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-7) mod 8))*8-1 downto (0+(7-7) mod 8)*8) + delta((16*7+8)*7-1 	downto (16*7+7)*7); -- i= 7 j= 7
		                                                                                                             
		
	 -- SubK(((16*i + (j+1)+8)*8)-1 downto (16*i + j+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((j-i) mod 8)+8)*8-1 downto (0+(j-i) mod 8)+8)*8) + delta((16*i+(j+1)+8)*8-1 downto (16*i+j+8)*8);
		SubK(((16*0 + 1+8)*8)-1 	  downto (16*0 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-0) mod 8)+8)*8-1 downto (0+(0-0) mod 8+8)*8) + delta((16*0+1+8)*7-1 	  downto (16*0+0+8)*7); -- i= 0 j= 0
		SubK(((16*0 + 2+8)*8)-1 	  downto (16*0 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-0) mod 8)+8)*8-1 downto (0+(1-0) mod 8+8)*8) + delta((16*0+2+8)*7-1 	  downto (16*0+1+8)*7); -- i= 0 j= 1
		SubK(((16*0 + 3+8)*8)-1 	  downto (16*0 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-0) mod 8)+8)*8-1 downto (0+(2-0) mod 8+8)*8) + delta((16*0+3+8)*7-1 	  downto (16*0+2+8)*7); -- i= 0 j= 2
		SubK(((16*0 + 4+8)*8)-1 	  downto (16*0 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-0) mod 8)+8)*8-1 downto (0+(3-0) mod 8+8)*8) + delta((16*0+4+8)*7-1 	  downto (16*0+3+8)*7); -- i= 0 j= 3
		SubK(((16*0 + 5+8)*8)-1 	  downto (16*0 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-0) mod 8)+8)*8-1 downto (0+(4-0) mod 8+8)*8) + delta((16*0+5+8)*7-1 	  downto (16*0+4+8)*7); -- i= 0 j= 4
		SubK(((16*0 + 6+8)*8)-1 	  downto (16*0 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-0) mod 8)+8)*8-1 downto (0+(5-0) mod 8+8)*8) + delta((16*0+6+8)*7-1 	  downto (16*0+5+8)*7); -- i= 0 j= 5
		SubK(((16*0 + 7+8)*8)-1 	  downto (16*0 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-0) mod 8)+8)*8-1 downto (0+(6-0) mod 8+8)*8) + delta((16*0+7+8)*7-1 	  downto (16*0+6+8)*7); -- i= 0 j= 6
		SubK(((16*0 + 8+8)*8)-1 	  downto (16*0 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-0) mod 8)+8)*8-1 downto (0+(7-0) mod 8+8)*8) + delta((16*0+8+8)*7-1 	  downto (16*0+7+8)*7); -- i= 0 j= 7
																																							
		SubK(((16*1 + 1+8)*8)-1 	  downto (16*1 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-1) mod 8)+8)*8-1 downto (0+(0-1) mod 8+8)*8) + delta((16*1+1+8)*7-1 	  downto (16*1+0+8)*7); -- i= 1 j= 0
		SubK(((16*1 + 2+8)*8)-1 	  downto (16*1 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-1) mod 8)+8)*8-1 downto (0+(1-1) mod 8+8)*8) + delta((16*1+2+8)*7-1 	  downto (16*1+1+8)*7); -- i= 1 j= 1
		SubK(((16*1 + 3+8)*8)-1 	  downto (16*1 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-1) mod 8)+8)*8-1 downto (0+(2-1) mod 8+8)*8) + delta((16*1+3+8)*7-1 	  downto (16*1+2+8)*7); -- i= 1 j= 2
		SubK(((16*1 + 4+8)*8)-1 	  downto (16*1 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-1) mod 8)+8)*8-1 downto (0+(3-1) mod 8+8)*8) + delta((16*1+4+8)*7-1 	  downto (16*1+3+8)*7); -- i= 1 j= 3
		SubK(((16*1 + 5+8)*8)-1 	  downto (16*1 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-1) mod 8)+8)*8-1 downto (0+(4-1) mod 8+8)*8) + delta((16*1+5+8)*7-1 	  downto (16*1+4+8)*7); -- i= 1 j= 4
		SubK(((16*1 + 6+8)*8)-1 	  downto (16*1 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-1) mod 8)+8)*8-1 downto (0+(5-1) mod 8+8)*8) + delta((16*1+6+8)*7-1 	  downto (16*1+5+8)*7); -- i= 1 j= 5
		SubK(((16*1 + 7+8)*8)-1 	  downto (16*1 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-1) mod 8)+8)*8-1 downto (0+(6-1) mod 8+8)*8) + delta((16*1+7+8)*7-1 	  downto (16*1+6+8)*7); -- i= 1 j= 6
		SubK(((16*1 + 8+8)*8)-1 	  downto (16*1 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-1) mod 8)+8)*8-1 downto (0+(7-1) mod 8+8)*8) + delta((16*1+8+8)*7-1 	  downto (16*1+7+8)*7); -- i= 1 j= 7
																																									
		SubK(((16*2 + 1+8)*8)-1 	  downto (16*2 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-2) mod 8)+8)*8-1 downto (0+(0-2) mod 8+8)*8) + delta((16*2+1+8)*7-1 	  downto (16*2+0+8)*7); -- i= 2 j= 0
		SubK(((16*2 + 2+8)*8)-1 	  downto (16*2 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-2) mod 8)+8)*8-1 downto (0+(1-2) mod 8+8)*8) + delta((16*2+2+8)*7-1 	  downto (16*2+1+8)*7); -- i= 2 j= 1
		SubK(((16*2 + 3+8)*8)-1 	  downto (16*2 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-2) mod 8)+8)*8-1 downto (0+(2-2) mod 8+8)*8) + delta((16*2+3+8)*7-1 	  downto (16*2+2+8)*7); -- i= 2 j= 2
		SubK(((16*2 + 4+8)*8)-1 	  downto (16*2 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-2) mod 8)+8)*8-1 downto (0+(3-2) mod 8+8)*8) + delta((16*2+4+8)*7-1 	  downto (16*2+3+8)*7); -- i= 2 j= 3
		SubK(((16*2 + 5+8)*8)-1 	  downto (16*2 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-2) mod 8)+8)*8-1 downto (0+(4-2) mod 8+8)*8) + delta((16*2+5+8)*7-1 	  downto (16*2+4+8)*7); -- i= 2 j= 4
		SubK(((16*2 + 6+8)*8)-1 	  downto (16*2 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-2) mod 8)+8)*8-1 downto (0+(5-2) mod 8+8)*8) + delta((16*2+6+8)*7-1 	  downto (16*2+5+8)*7); -- i= 2 j= 5
		SubK(((16*2 + 7+8)*8)-1 	  downto (16*2 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-2) mod 8)+8)*8-1 downto (0+(6-2) mod 8+8)*8) + delta((16*2+7+8)*7-1 	  downto (16*2+6+8)*7); -- i= 2 j= 6
		SubK(((16*2 + 8+8)*8)-1 	  downto (16*2 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-2) mod 8)+8)*8-1 downto (0+(7-2) mod 8+8)*8) + delta((16*2+8+8)*7-1 	  downto (16*2+7+8)*7); -- i= 2 j= 7
																																								
		SubK(((16*3 + 1+8)*8)-1 	  downto (16*3 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-3) mod 8)+8)*8-1 downto (0+(0-3) mod 8+8)*8) + delta((16*3+1+8)*7-1 	  downto (16*3+0+8)*7); -- i= 3 j= 0
		SubK(((16*3 + 2+8)*8)-1 	  downto (16*3 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-3) mod 8)+8)*8-1 downto (0+(1-3) mod 8+8)*8) + delta((16*3+2+8)*7-1 	  downto (16*3+1+8)*7); -- i= 3 j= 1
		SubK(((16*3 + 3+8)*8)-1 	  downto (16*3 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-3) mod 8)+8)*8-1 downto (0+(2-3) mod 8+8)*8) + delta((16*3+3+8)*7-1 	  downto (16*3+2+8)*7); -- i= 3 j= 2
		SubK(((16*3 + 4+8)*8)-1 	  downto (16*3 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-3) mod 8)+8)*8-1 downto (0+(3-3) mod 8+8)*8) + delta((16*3+4+8)*7-1 	  downto (16*3+3+8)*7); -- i= 3 j= 3
		SubK(((16*3 + 5+8)*8)-1 	  downto (16*3 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-3) mod 8)+8)*8-1 downto (0+(4-3) mod 8+8)*8) + delta((16*3+5+8)*7-1 	  downto (16*3+4+8)*7); -- i= 3 j= 4
		SubK(((16*3 + 6+8)*8)-1 	  downto (16*3 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-3) mod 8)+8)*8-1 downto (0+(5-3) mod 8+8)*8) + delta((16*3+6+8)*7-1 	  downto (16*3+5+8)*7); -- i= 3 j= 5
		SubK(((16*3 + 7+8)*8)-1 	  downto (16*3 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-3) mod 8)+8)*8-1 downto (0+(6-3) mod 8+8)*8) + delta((16*3+7+8)*7-1 	  downto (16*3+6+8)*7); -- i= 3 j= 6
		SubK(((16*3 + 8+8)*8)-1 	  downto (16*3 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-3) mod 8)+8)*8-1 downto (0+(7-3) mod 8+8)*8) + delta((16*3+8+8)*7-1 	  downto (16*3+7+8)*7); -- i= 3 j= 7
																																								
		SubK(((16*4 + 1+8)*8)-1 	  downto (16*4 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-4) mod 8)+8)*8-1 downto (0+(0-4) mod 8+8)*8) + delta((16*4+1+8)*7-1 	  downto (16*4+0+8)*7); -- i= 4 j= 0
		SubK(((16*4 + 2+8)*8)-1 	  downto (16*4 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-4) mod 8)+8)*8-1 downto (0+(1-4) mod 8+8)*8) + delta((16*4+2+8)*7-1 	  downto (16*4+1+8)*7); -- i= 4 j= 1
		SubK(((16*4 + 3+8)*8)-1 	  downto (16*4 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-4) mod 8)+8)*8-1 downto (0+(2-4) mod 8+8)*8) + delta((16*4+3+8)*7-1 	  downto (16*4+2+8)*7); -- i= 4 j= 2
		SubK(((16*4 + 4+8)*8)-1 	  downto (16*4 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-4) mod 8)+8)*8-1 downto (0+(3-4) mod 8+8)*8) + delta((16*4+4+8)*7-1 	  downto (16*4+3+8)*7); -- i= 4 j= 3
		SubK(((16*4 + 5+8)*8)-1 	  downto (16*4 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-4) mod 8)+8)*8-1 downto (0+(4-4) mod 8+8)*8) + delta((16*4+5+8)*7-1 	  downto (16*4+4+8)*7); -- i= 4 j= 4
		SubK(((16*4 + 6+8)*8)-1 	  downto (16*4 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-4) mod 8)+8)*8-1 downto (0+(5-4) mod 8+8)*8) + delta((16*4+6+8)*7-1 	  downto (16*4+5+8)*7); -- i= 4 j= 5
		SubK(((16*4 + 7+8)*8)-1 	  downto (16*4 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-4) mod 8)+8)*8-1 downto (0+(6-4) mod 8+8)*8) + delta((16*4+7+8)*7-1 	  downto (16*4+6+8)*7); -- i= 4 j= 6
		SubK(((16*4 + 8+8)*8)-1 	  downto (16*4 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-4) mod 8)+8)*8-1 downto (0+(7-4) mod 8+8)*8) + delta((16*4+8+8)*7-1 	  downto (16*4+7+8)*7); -- i= 4 j= 7		
																																							
		SubK(((16*5 + 1+8)*8)-1 	  downto (16*5 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-5) mod 8)+8)*8-1 downto (0+(0-5) mod 8+8)*8) + delta((16*5+1+8)*7-1 	  downto (16*5+0+8)*7); -- i= 5 j= 0
		SubK(((16*5 + 2+8)*8)-1 	  downto (16*5 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-5) mod 8)+8)*8-1 downto (0+(1-5) mod 8+8)*8) + delta((16*5+2+8)*7-1 	  downto (16*5+1+8)*7); -- i= 5 j= 1
		SubK(((16*5 + 3+8)*8)-1 	  downto (16*5 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-5) mod 8)+8)*8-1 downto (0+(2-5) mod 8+8)*8) + delta((16*5+3+8)*7-1 	  downto (16*5+2+8)*7); -- i= 5 j= 2
		SubK(((16*5 + 4+8)*8)-1 	  downto (16*5 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-5) mod 8)+8)*8-1 downto (0+(3-5) mod 8+8)*8) + delta((16*5+4+8)*7-1 	  downto (16*5+3+8)*7); -- i= 5 j= 3
		SubK(((16*5 + 5+8)*8)-1 	  downto (16*5 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-5) mod 8)+8)*8-1 downto (0+(4-5) mod 8+8)*8) + delta((16*5+5+8)*7-1 	  downto (16*5+4+8)*7); -- i= 5 j= 4
		SubK(((16*5 + 6+8)*8)-1 	  downto (16*5 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-5) mod 8)+8)*8-1 downto (0+(5-5) mod 8+8)*8) + delta((16*5+6+8)*7-1 	  downto (16*5+5+8)*7); -- i= 5 j= 5
		SubK(((16*5 + 7+8)*8)-1 	  downto (16*5 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-5) mod 8)+8)*8-1 downto (0+(6-5) mod 8+8)*8) + delta((16*5+7+8)*7-1 	  downto (16*5+6+8)*7); -- i= 5 j= 6
		SubK(((16*5 + 8+8)*8)-1 	  downto (16*5 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-5) mod 8)+8)*8-1 downto (0+(7-5) mod 8+8)*8) + delta((16*5+8+8)*7-1 	  downto (16*5+7+8)*7); -- i= 5 j= 7		
																																								
		SubK(((16*6 + 1+8)*8)-1 	  downto (16*6 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-6) mod 8)+8)*8-1 downto (0+(0-6) mod 8+8)*8) + delta((16*6+1+8)*7-1 	  downto (16*6+0+8)*7); -- i= 6 j= 0
		SubK(((16*6 + 2+8)*8)-1 	  downto (16*6 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-6) mod 8)+8)*8-1 downto (0+(1-6) mod 8+8)*8) + delta((16*6+2+8)*7-1 	  downto (16*6+1+8)*7); -- i= 6 j= 1
		SubK(((16*6 + 3+8)*8)-1 	  downto (16*6 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-6) mod 8)+8)*8-1 downto (0+(2-6) mod 8+8)*8) + delta((16*6+3+8)*7-1 	  downto (16*6+2+8)*7); -- i= 6 j= 2
		SubK(((16*6 + 4+8)*8)-1 	  downto (16*6 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-6) mod 8)+8)*8-1 downto (0+(3-6) mod 8+8)*8) + delta((16*6+4+8)*7-1 	  downto (16*6+3+8)*7); -- i= 6 j= 3
		SubK(((16*6 + 5+8)*8)-1 	  downto (16*6 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-6) mod 8)+8)*8-1 downto (0+(4-6) mod 8+8)*8) + delta((16*6+5+8)*7-1 	  downto (16*6+4+8)*7); -- i= 6 j= 4
		SubK(((16*6 + 6+8)*8)-1 	  downto (16*6 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-6) mod 8)+8)*8-1 downto (0+(5-6) mod 8+8)*8) + delta((16*6+6+8)*7-1 	  downto (16*6+5+8)*7); -- i= 6 j= 5
		SubK(((16*6 + 7+8)*8)-1 	  downto (16*6 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-6) mod 8)+8)*8-1 downto (0+(6-6) mod 8+8)*8) + delta((16*6+7+8)*7-1 	  downto (16*6+6+8)*7); -- i= 6 j= 6
		SubK(((16*6 + 8+8)*8)-1 	  downto (16*6 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-6) mod 8)+8)*8-1 downto (0+(7-6) mod 8+8)*8) + delta((16*6+8+8)*7-1 	  downto (16*6+7+8)*7); -- i= 6 j= 7		
																																								
		SubK(((16*7 + 1+8)*8)-1 	  downto (16*7 + 0+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((0-7) mod 8)+8)*8-1 downto (0+(0-7) mod 8+8)*8) + delta((16*7+1+8)*7-1 	  downto (16*7+0+8)*7); -- i= 7 j= 0
		SubK(((16*7 + 2+8)*8)-1 	  downto (16*7 + 1+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((1-7) mod 8)+8)*8-1 downto (0+(1-7) mod 8+8)*8) + delta((16*7+2+8)*7-1 	  downto (16*7+1+8)*7); -- i= 7 j= 1
		SubK(((16*7 + 3+8)*8)-1 	  downto (16*7 + 2+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((2-7) mod 8)+8)*8-1 downto (0+(2-7) mod 8+8)*8) + delta((16*7+3+8)*7-1 	  downto (16*7+2+8)*7); -- i= 7 j= 2
		SubK(((16*7 + 4+8)*8)-1 	  downto (16*7 + 3+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((3-7) mod 8)+8)*8-1 downto (0+(3-7) mod 8+8)*8) + delta((16*7+4+8)*7-1 	  downto (16*7+3+8)*7); -- i= 7 j= 3
		SubK(((16*7 + 5+8)*8)-1 	  downto (16*7 + 4+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((4-7) mod 8)+8)*8-1 downto (0+(4-7) mod 8+8)*8) + delta((16*7+5+8)*7-1 	  downto (16*7+4+8)*7); -- i= 7 j= 4
		SubK(((16*7 + 6+8)*8)-1 	  downto (16*7 + 5+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((5-7) mod 8)+8)*8-1 downto (0+(5-7) mod 8+8)*8) + delta((16*7+6+8)*7-1 	  downto (16*7+5+8)*7); -- i= 7 j= 5
		SubK(((16*7 + 7+8)*8)-1 	  downto (16*7 + 6+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((6-7) mod 8)+8)*8-1 downto (0+(6-7) mod 8+8)*8) + delta((16*7+7+8)*7-1 	  downto (16*7+6+8)*7); -- i= 7 j= 6
		SubK(((16*7 + 8+8)*8)-1 	  downto (16*7 + 7+8)*8) <= i_HIGHT_KeySchedule_MasterKey((1+((7-7) mod 8)+8)*8-1 downto (0+(7-7) mod 8+8)*8) + delta((16*7+8+8)*7-1 	  downto (16*7+7+8)*7); -- i= 7 j= 7
			
		
	end if;

end process;


end architecture;