library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity HIGHT_RoundFunction	is
port(
		i_HIGHT_RoundFunction_rst 			: in std_logic;
		i_HIGHT_RoundFunction_clk			: in std_logic;
		i_HIGHT_RoundFunction_SK			: in std_logic_vector(1023 downto 0);
		i_HIGHT_RoundFunction_X				: in std_logic_vector(63 downto 0);
		i_HIGHT_RoundFunction_valid			: in std_logic;
		i_HIGHT_RoundFunction_ready			: in std_logic;
		-- Outputs
		o_HIGHT_RoundFunction_X				: out std_logic_vector(2047 downto 0);
		o_HIGHT_RoundFunction_valid			: out std_logic;
		o_HIGHT_RoundFunction_ready			: out std_logic
);
end HIGHT_RoundFunction;


architecture behaviour of HIGHT_RoundFunction is

-- Signals
signal RF_X: std_logic_vector(2111 downto 0);

type state_mach is (IDLE,R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,R30,R31);
signal state: state_mach;


function F0(X : in std_logic_vector(7 downto 0)) return std_logic_vector is 
	variable x_temp : std_logic_vector(7 downto 0);
begin
	x_temp := (X(6 downto 0)& X(7)) XOR (X(5 downto 0)& X(7 downto 6)) XOR (X(0)& X(7 downto 1)); 
	return x_temp;	
end function;

function F1(X : in std_logic_vector(7 downto 0)) return std_logic_vector is 
	variable x_temp : std_logic_vector(7 downto 0);
begin
	x_temp := (X(4 downto 0)& X(7 downto 5)) XOR (X(3 downto 0)& X(7 downto 4)) XOR (X(1 downto 0)& X(7 downto 2));
	return x_temp;
end function;


begin

process(ALL)is
begin
	if(i_HIGHT_RoundFunction_rst='0')then
		o_HIGHT_RoundFunction_X <=(others=> '0');
		RF_X <=(others=> '0');
		o_HIGHT_RoundFunction_ready <= '0';
		o_HIGHT_RoundFunction_valid <= '0';
	else
		o_HIGHT_RoundFunction_X <= RF_X(2111 downto 64);
		RF_X(63 downto 0) 		<= i_HIGHT_RoundFunction_X(63 downto 0);
		if(i_HIGHT_RoundFunction_clk'event and i_HIGHT_RoundFunction_clk='1')then
			
			o_HIGHT_RoundFunction_ready <= '0';	
			if((i_HIGHT_RoundFunction_ready = '1') and state = R31 )then
				o_HIGHT_RoundFunction_valid <= '1';
			else
				o_HIGHT_RoundFunction_valid <= '0';
			end if;
			case state is
				when IDLE => 
					state <= R0;
					o_HIGHT_RoundFunction_ready <= '1';
				when R0 =>
				
					if(i_HIGHT_RoundFunction_valid='1')then
						state <= R1;
					else
						state <= R0;
					end if;
					RF_X(1*64+8*8-1 downto 1*64+8*7) <= RF_X(8*1-1 downto 8*0) XOR (F0(RF_X(8*2-1 downto 8*1)) + i_HIGHT_RoundFunction_SK((4)*8-1 downto (3)*8));
					RF_X(1*64+8*7-1 downto 1*64+8*6) <= RF_X(8*8-1 downto 8*7);
					RF_X(1*64+8*6-1 downto 1*64+8*5) <= RF_X(8*7-1 downto 8*6) + (F1(RF_X(8*8-1 downto 8*7)) XOR i_HIGHT_RoundFunction_SK((3)*8-1 downto (2)*8));
					RF_X(1*64+8*5-1 downto 1*64+8*4) <= RF_X(8*6-1 downto 8*5);
					RF_X(1*64+8*4-1 downto 1*64+8*3) <= RF_X(8*5-1 downto 8*4) XOR (F0(RF_X(8*6-1 downto 8*5)) + i_HIGHT_RoundFunction_SK((2)*8-1 downto (1)*8));
					RF_X(1*64+8*3-1 downto 1*64+8*2) <= RF_X(8*4-1 downto 8*3);
					RF_X(1*64+8*2-1 downto 1*64+8*1) <= RF_X(8*3-1 downto 8*2) + (F1(RF_X(8*4-1 downto 8*3)) XOR i_HIGHT_RoundFunction_SK((1)*8-1 downto (0)*8));
					RF_X(1*64+8*1-1 downto 1*64+8*0) <= RF_X(8*2-1 downto 8*1);
			-- 
				when R1 =>
					state <= R2;
					RF_X(2*64+8*8-1 downto 2*64+8*7) <= RF_X((2-1)*64+8*1-1 downto (2-1)*64+8*0) XOR (F0(RF_X((2-1)*64+8*2-1 downto (2-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(2-1)+4)*8-1 downto (4*(2-1)+3)*8));
					RF_X(2*64+8*7-1 downto 2*64+8*6) <= RF_X((2-1)*64+8*8-1 downto (2-1)*64+8*7);
					RF_X(2*64+8*6-1 downto 2*64+8*5) <= RF_X((2-1)*64+8*7-1 downto (2-1)*64+8*6) + (F1(RF_X((2-1)*64+8*8-1 downto (2-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(2-1)+3)*8-1 downto (4*(2-1)+2)*8));
					RF_X(2*64+8*5-1 downto 2*64+8*4) <= RF_X((2-1)*64+8*6-1 downto (2-1)*64+8*5);
					RF_X(2*64+8*4-1 downto 2*64+8*3) <= RF_X((2-1)*64+8*5-1 downto (2-1)*64+8*4) XOR (F0(RF_X((2-1)*64+8*6-1 downto (2-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(2-1)+2)*8-1 downto (4*(2-1)+1)*8));
					RF_X(2*64+8*3-1 downto 2*64+8*2) <= RF_X((2-1)*64+8*4-1 downto (2-1)*64+8*3);
					RF_X(2*64+8*2-1 downto 2*64+8*1) <= RF_X((2-1)*64+8*3-1 downto (2-1)*64+8*2) + (F1(RF_X((2-1)*64+8*4-1 downto (2-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(2-1)+1)*8-1 downto (4*(2-1)+0)*8));
					RF_X(2*64+8*1-1 downto 2*64+8*0) <= RF_X((2-1)*64+8*2-1 downto (2-1)*64+8*1);
				when R2=>
					state <= R3;
					RF_X(3*64+8*8-1 downto 3*64+8*7) <= RF_X((3-1)*64+8*1-1 downto (3-1)*64+8*0) XOR (F0(RF_X((3-1)*64+8*2-1 downto (3-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(3-1)+4)*8-1 downto (4*(3-1)+3)*8));
					RF_X(3*64+8*7-1 downto 3*64+8*6) <= RF_X((3-1)*64+8*8-1 downto (3-1)*64+8*7);
					RF_X(3*64+8*6-1 downto 3*64+8*5) <= RF_X((3-1)*64+8*7-1 downto (3-1)*64+8*6) + (F1(RF_X((3-1)*64+8*8-1 downto (3-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(3-1)+3)*8-1 downto (4*(3-1)+2)*8));
					RF_X(3*64+8*5-1 downto 3*64+8*4) <= RF_X((3-1)*64+8*6-1 downto (3-1)*64+8*5);
					RF_X(3*64+8*4-1 downto 3*64+8*3) <= RF_X((3-1)*64+8*5-1 downto (3-1)*64+8*4) XOR (F0(RF_X((3-1)*64+8*6-1 downto (3-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(3-1)+2)*8-1 downto (4*(3-1)+1)*8));
					RF_X(3*64+8*3-1 downto 3*64+8*2) <= RF_X((3-1)*64+8*4-1 downto (3-1)*64+8*3);
					RF_X(3*64+8*2-1 downto 3*64+8*1) <= RF_X((3-1)*64+8*3-1 downto (3-1)*64+8*2) + (F1(RF_X((3-1)*64+8*4-1 downto (3-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(3-1)+1)*8-1 downto (4*(3-1)+0)*8));
					RF_X(3*64+8*1-1 downto 3*64+8*0) <= RF_X((3-1)*64+8*2-1 downto (3-1)*64+8*1);
				when R3=>
					state <= R4;
					RF_X(4*64+8*8-1 downto 4*64+8*7) <= RF_X((4-1)*64+8*1-1 downto (4-1)*64+8*0) XOR (F0(RF_X((4-1)*64+8*2-1 downto (4-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(4-1)+4)*8-1 downto (4*(4-1)+3)*8));
					RF_X(4*64+8*7-1 downto 4*64+8*6) <= RF_X((4-1)*64+8*8-1 downto (4-1)*64+8*7);
					RF_X(4*64+8*6-1 downto 4*64+8*5) <= RF_X((4-1)*64+8*7-1 downto (4-1)*64+8*6) + (F1(RF_X((4-1)*64+8*8-1 downto (4-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(4-1)+3)*8-1 downto (4*(4-1)+2)*8));
					RF_X(4*64+8*5-1 downto 4*64+8*4) <= RF_X((4-1)*64+8*6-1 downto (4-1)*64+8*5);
					RF_X(4*64+8*4-1 downto 4*64+8*3) <= RF_X((4-1)*64+8*5-1 downto (4-1)*64+8*4) XOR (F0(RF_X((4-1)*64+8*6-1 downto (4-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(4-1)+2)*8-1 downto (4*(4-1)+1)*8));
					RF_X(4*64+8*3-1 downto 4*64+8*2) <= RF_X((4-1)*64+8*4-1 downto (4-1)*64+8*3);
					RF_X(4*64+8*2-1 downto 4*64+8*1) <= RF_X((4-1)*64+8*3-1 downto (4-1)*64+8*2) + (F1(RF_X((4-1)*64+8*4-1 downto (4-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(4-1)+1)*8-1 downto (4*(4-1)+0)*8));
					RF_X(4*64+8*1-1 downto 4*64+8*0) <= RF_X((4-1)*64+8*2-1 downto (4-1)*64+8*1);
				when R4=>	
					state <= R5;
					RF_X(5*64+8*8-1 downto 5*64+8*7) <= RF_X((5-1)*64+8*1-1 downto (5-1)*64+8*0) XOR (F0(RF_X((5-1)*64+8*2-1 downto (5-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(5-1)+4)*8-1 downto (4*(5-1)+3)*8));
					RF_X(5*64+8*7-1 downto 5*64+8*6) <= RF_X((5-1)*64+8*8-1 downto (5-1)*64+8*7);
					RF_X(5*64+8*6-1 downto 5*64+8*5) <= RF_X((5-1)*64+8*7-1 downto (5-1)*64+8*6) + (F1(RF_X((5-1)*64+8*8-1 downto (5-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(5-1)+3)*8-1 downto (4*(5-1)+2)*8));
					RF_X(5*64+8*5-1 downto 5*64+8*4) <= RF_X((5-1)*64+8*6-1 downto (5-1)*64+8*5);
					RF_X(5*64+8*4-1 downto 5*64+8*3) <= RF_X((5-1)*64+8*5-1 downto (5-1)*64+8*4) XOR (F0(RF_X((5-1)*64+8*6-1 downto (5-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(5-1)+2)*8-1 downto (4*(5-1)+1)*8));
					RF_X(5*64+8*3-1 downto 5*64+8*2) <= RF_X((5-1)*64+8*4-1 downto (5-1)*64+8*3);
					RF_X(5*64+8*2-1 downto 5*64+8*1) <= RF_X((5-1)*64+8*3-1 downto (5-1)*64+8*2) + (F1(RF_X((5-1)*64+8*4-1 downto (5-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(5-1)+1)*8-1 downto (4*(5-1)+0)*8));
					RF_X(5*64+8*1-1 downto 5*64+8*0) <= RF_X((5-1)*64+8*2-1 downto (5-1)*64+8*1);
				when R5=>	
					state <= R6;
					RF_X(6*64+8*8-1 downto 6*64+8*7) <= RF_X((6-1)*64+8*1-1 downto (6-1)*64+8*0) XOR (F0(RF_X((6-1)*64+8*2-1 downto (6-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(6-1)+4)*8-1 downto (4*(6-1)+3)*8));
					RF_X(6*64+8*7-1 downto 6*64+8*6) <= RF_X((6-1)*64+8*8-1 downto (6-1)*64+8*7);
					RF_X(6*64+8*6-1 downto 6*64+8*5) <= RF_X((6-1)*64+8*7-1 downto (6-1)*64+8*6) + (F1(RF_X((6-1)*64+8*8-1 downto (6-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(6-1)+3)*8-1 downto (4*(6-1)+2)*8));
					RF_X(6*64+8*5-1 downto 6*64+8*4) <= RF_X((6-1)*64+8*6-1 downto (6-1)*64+8*5);
					RF_X(6*64+8*4-1 downto 6*64+8*3) <= RF_X((6-1)*64+8*5-1 downto (6-1)*64+8*4) XOR (F0(RF_X((6-1)*64+8*6-1 downto (6-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(6-1)+2)*8-1 downto (4*(6-1)+1)*8));
					RF_X(6*64+8*3-1 downto 6*64+8*2) <= RF_X((6-1)*64+8*4-1 downto (6-1)*64+8*3);
					RF_X(6*64+8*2-1 downto 6*64+8*1) <= RF_X((6-1)*64+8*3-1 downto (6-1)*64+8*2) + (F1(RF_X((6-1)*64+8*4-1 downto (6-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(6-1)+1)*8-1 downto (4*(6-1)+0)*8));
					RF_X(6*64+8*1-1 downto 6*64+8*0) <= RF_X((6-1)*64+8*2-1 downto (6-1)*64+8*1);
				when R6=>	
					state <= R7;
					RF_X(7*64+8*8-1 downto 7*64+8*7) <= RF_X((7-1)*64+8*1-1 downto (7-1)*64+8*0) XOR (F0(RF_X((7-1)*64+8*2-1 downto (7-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(7-1)+4)*8-1 downto (4*(7-1)+3)*8));
					RF_X(7*64+8*7-1 downto 7*64+8*6) <= RF_X((7-1)*64+8*8-1 downto (7-1)*64+8*7);
					RF_X(7*64+8*6-1 downto 7*64+8*5) <= RF_X((7-1)*64+8*7-1 downto (7-1)*64+8*6) + (F1(RF_X((7-1)*64+8*8-1 downto (7-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(7-1)+3)*8-1 downto (4*(7-1)+2)*8));
					RF_X(7*64+8*5-1 downto 7*64+8*4) <= RF_X((7-1)*64+8*6-1 downto (7-1)*64+8*5);
					RF_X(7*64+8*4-1 downto 7*64+8*3) <= RF_X((7-1)*64+8*5-1 downto (7-1)*64+8*4) XOR (F0(RF_X((7-1)*64+8*6-1 downto (7-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(7-1)+2)*8-1 downto (4*(7-1)+1)*8));
					RF_X(7*64+8*3-1 downto 7*64+8*2) <= RF_X((7-1)*64+8*4-1 downto (7-1)*64+8*3);
					RF_X(7*64+8*2-1 downto 7*64+8*1) <= RF_X((7-1)*64+8*3-1 downto (7-1)*64+8*2) + (F1(RF_X((7-1)*64+8*4-1 downto (7-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(7-1)+1)*8-1 downto (4*(7-1)+0)*8));
					RF_X(7*64+8*1-1 downto 7*64+8*0) <= RF_X((7-1)*64+8*2-1 downto (7-1)*64+8*1);
				when R7=>	
					state <= R8;
					RF_X(8*64+8*8-1 downto 8*64+8*7) <= RF_X((8-1)*64+8*1-1 downto (8-1)*64+8*0) XOR (F0(RF_X((8-1)*64+8*2-1 downto (8-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(8-1)+4)*8-1 downto (4*(8-1)+3)*8));
					RF_X(8*64+8*7-1 downto 8*64+8*6) <= RF_X((8-1)*64+8*8-1 downto (8-1)*64+8*7);
					RF_X(8*64+8*6-1 downto 8*64+8*5) <= RF_X((8-1)*64+8*7-1 downto (8-1)*64+8*6) + (F1(RF_X((8-1)*64+8*8-1 downto (8-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(8-1)+3)*8-1 downto (4*(8-1)+2)*8));
					RF_X(8*64+8*5-1 downto 8*64+8*4) <= RF_X((8-1)*64+8*6-1 downto (8-1)*64+8*5);
					RF_X(8*64+8*4-1 downto 8*64+8*3) <= RF_X((8-1)*64+8*5-1 downto (8-1)*64+8*4) XOR (F0(RF_X((8-1)*64+8*6-1 downto (8-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(8-1)+2)*8-1 downto (4*(8-1)+1)*8));
					RF_X(8*64+8*3-1 downto 8*64+8*2) <= RF_X((8-1)*64+8*4-1 downto (8-1)*64+8*3);
					RF_X(8*64+8*2-1 downto 8*64+8*1) <= RF_X((8-1)*64+8*3-1 downto (8-1)*64+8*2) + (F1(RF_X((8-1)*64+8*4-1 downto (8-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(8-1)+1)*8-1 downto (4*(8-1)+0)*8));
					RF_X(8*64+8*1-1 downto 8*64+8*0) <= RF_X((8-1)*64+8*2-1 downto (8-1)*64+8*1);
				when R8=>	
					state <= R9;
					RF_X(9*64+8*8-1 downto 9*64+8*7) <= RF_X((9-1)*64+8*1-1 downto (9-1)*64+8*0) XOR (F0(RF_X((9-1)*64+8*2-1 downto (9-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(9-1)+4)*8-1 downto (4*(9-1)+3)*8));
					RF_X(9*64+8*7-1 downto 9*64+8*6) <= RF_X((9-1)*64+8*8-1 downto (9-1)*64+8*7);
					RF_X(9*64+8*6-1 downto 9*64+8*5) <= RF_X((9-1)*64+8*7-1 downto (9-1)*64+8*6) + (F1(RF_X((9-1)*64+8*8-1 downto (9-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(9-1)+3)*8-1 downto (4*(9-1)+2)*8));
					RF_X(9*64+8*5-1 downto 9*64+8*4) <= RF_X((9-1)*64+8*6-1 downto (9-1)*64+8*5);
					RF_X(9*64+8*4-1 downto 9*64+8*3) <= RF_X((9-1)*64+8*5-1 downto (9-1)*64+8*4) XOR (F0(RF_X((9-1)*64+8*6-1 downto (9-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(9-1)+2)*8-1 downto (4*(9-1)+1)*8));
					RF_X(9*64+8*3-1 downto 9*64+8*2) <= RF_X((9-1)*64+8*4-1 downto (9-1)*64+8*3);
					RF_X(9*64+8*2-1 downto 9*64+8*1) <= RF_X((9-1)*64+8*3-1 downto (9-1)*64+8*2) + (F1(RF_X((9-1)*64+8*4-1 downto (9-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(9-1)+1)*8-1 downto (4*(9-1)+0)*8));
					RF_X(9*64+8*1-1 downto 9*64+8*0) <= RF_X((9-1)*64+8*2-1 downto (9-1)*64+8*1);
				when R9=>	
					state <= R10;
					RF_X(10*64+8*8-1 downto 10*64+8*7) <= RF_X((10-1)*64+8*1-1 downto (10-1)*64+8*0) XOR (F0(RF_X((10-1)*64+8*2-1 downto (10-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(10-1)+4)*8-1 downto (4*(10-1)+3)*8));
					RF_X(10*64+8*7-1 downto 10*64+8*6) <= RF_X((10-1)*64+8*8-1 downto (10-1)*64+8*7);
					RF_X(10*64+8*6-1 downto 10*64+8*5) <= RF_X((10-1)*64+8*7-1 downto (10-1)*64+8*6) + (F1(RF_X((10-1)*64+8*8-1 downto (10-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(10-1)+3)*8-1 downto (4*(10-1)+2)*8));
					RF_X(10*64+8*5-1 downto 10*64+8*4) <= RF_X((10-1)*64+8*6-1 downto (10-1)*64+8*5);
					RF_X(10*64+8*4-1 downto 10*64+8*3) <= RF_X((10-1)*64+8*5-1 downto (10-1)*64+8*4) XOR (F0(RF_X((10-1)*64+8*6-1 downto (10-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(10-1)+2)*8-1 downto (4*(10-1)+1)*8));
					RF_X(10*64+8*3-1 downto 10*64+8*2) <= RF_X((10-1)*64+8*4-1 downto (10-1)*64+8*3);
					RF_X(10*64+8*2-1 downto 10*64+8*1) <= RF_X((10-1)*64+8*3-1 downto (10-1)*64+8*2) + (F1(RF_X((10-1)*64+8*4-1 downto (10-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(10-1)+1)*8-1 downto (4*(10-1)+0)*8));
					RF_X(10*64+8*1-1 downto 10*64+8*0) <= RF_X((10-1)*64+8*2-1 downto (10-1)*64+8*1);
				when R10=>	
					state <= R11;
					RF_X(11*64+8*8-1 downto 11*64+8*7) <= RF_X((11-1)*64+8*1-1 downto (11-1)*64+8*0) XOR (F0(RF_X((11-1)*64+8*2-1 downto (11-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(11-1)+4)*8-1 downto (4*(11-1)+3)*8));
					RF_X(11*64+8*7-1 downto 11*64+8*6) <= RF_X((11-1)*64+8*8-1 downto (11-1)*64+8*7);
					RF_X(11*64+8*6-1 downto 11*64+8*5) <= RF_X((11-1)*64+8*7-1 downto (11-1)*64+8*6) + (F1(RF_X((11-1)*64+8*8-1 downto (11-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(11-1)+3)*8-1 downto (4*(11-1)+2)*8));
					RF_X(11*64+8*5-1 downto 11*64+8*4) <= RF_X((11-1)*64+8*6-1 downto (11-1)*64+8*5);
					RF_X(11*64+8*4-1 downto 11*64+8*3) <= RF_X((11-1)*64+8*5-1 downto (11-1)*64+8*4) XOR (F0(RF_X((11-1)*64+8*6-1 downto (11-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(11-1)+2)*8-1 downto (4*(11-1)+1)*8));
					RF_X(11*64+8*3-1 downto 11*64+8*2) <= RF_X((11-1)*64+8*4-1 downto (11-1)*64+8*3);
					RF_X(11*64+8*2-1 downto 11*64+8*1) <= RF_X((11-1)*64+8*3-1 downto (11-1)*64+8*2) + (F1(RF_X((11-1)*64+8*4-1 downto (11-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(11-1)+1)*8-1 downto (4*(11-1)+0)*8));
					RF_X(11*64+8*1-1 downto 11*64+8*0) <= RF_X((11-1)*64+8*2-1 downto (11-1)*64+8*1);
				when R11=>	
					state <= R12;
					RF_X(12*64+8*8-1 downto 12*64+8*7) <= RF_X((12-1)*64+8*1-1 downto (12-1)*64+8*0) XOR (F0(RF_X((12-1)*64+8*2-1 downto (12-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(12-1)+4)*8-1 downto (4*(12-1)+3)*8));
					RF_X(12*64+8*7-1 downto 12*64+8*6) <= RF_X((12-1)*64+8*8-1 downto (12-1)*64+8*7);
					RF_X(12*64+8*6-1 downto 12*64+8*5) <= RF_X((12-1)*64+8*7-1 downto (12-1)*64+8*6) + (F1(RF_X((12-1)*64+8*8-1 downto (12-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(12-1)+3)*8-1 downto (4*(12-1)+2)*8));
					RF_X(12*64+8*5-1 downto 12*64+8*4) <= RF_X((12-1)*64+8*6-1 downto (12-1)*64+8*5);
					RF_X(12*64+8*4-1 downto 12*64+8*3) <= RF_X((12-1)*64+8*5-1 downto (12-1)*64+8*4) XOR (F0(RF_X((12-1)*64+8*6-1 downto (12-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(12-1)+2)*8-1 downto (4*(12-1)+1)*8));
					RF_X(12*64+8*3-1 downto 12*64+8*2) <= RF_X((12-1)*64+8*4-1 downto (12-1)*64+8*3);
					RF_X(12*64+8*2-1 downto 12*64+8*1) <= RF_X((12-1)*64+8*3-1 downto (12-1)*64+8*2) + (F1(RF_X((12-1)*64+8*4-1 downto (12-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(12-1)+1)*8-1 downto (4*(12-1)+0)*8));
					RF_X(12*64+8*1-1 downto 12*64+8*0) <= RF_X((12-1)*64+8*2-1 downto (12-1)*64+8*1);
				when R12=>	
					state <= R13;
					RF_X(13*64+8*8-1 downto 13*64+8*7) <= RF_X((13-1)*64+8*1-1 downto (13-1)*64+8*0) XOR (F0(RF_X((13-1)*64+8*2-1 downto (13-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(13-1)+4)*8-1 downto (4*(13-1)+3)*8));
					RF_X(13*64+8*7-1 downto 13*64+8*6) <= RF_X((13-1)*64+8*8-1 downto (13-1)*64+8*7);
					RF_X(13*64+8*6-1 downto 13*64+8*5) <= RF_X((13-1)*64+8*7-1 downto (13-1)*64+8*6) + (F1(RF_X((13-1)*64+8*8-1 downto (13-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(13-1)+3)*8-1 downto (4*(13-1)+2)*8));
					RF_X(13*64+8*5-1 downto 13*64+8*4) <= RF_X((13-1)*64+8*6-1 downto (13-1)*64+8*5);
					RF_X(13*64+8*4-1 downto 13*64+8*3) <= RF_X((13-1)*64+8*5-1 downto (13-1)*64+8*4) XOR (F0(RF_X((13-1)*64+8*6-1 downto (13-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(13-1)+2)*8-1 downto (4*(13-1)+1)*8));
					RF_X(13*64+8*3-1 downto 13*64+8*2) <= RF_X((13-1)*64+8*4-1 downto (13-1)*64+8*3);
					RF_X(13*64+8*2-1 downto 13*64+8*1) <= RF_X((13-1)*64+8*3-1 downto (13-1)*64+8*2) + (F1(RF_X((13-1)*64+8*4-1 downto (13-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(13-1)+1)*8-1 downto (4*(13-1)+0)*8));
					RF_X(13*64+8*1-1 downto 13*64+8*0) <= RF_X((13-1)*64+8*2-1 downto (13-1)*64+8*1);
				when R13=>	
					state <= R14;
					RF_X(14*64+8*8-1 downto 14*64+8*7) <= RF_X((14-1)*64+8*1-1 downto (14-1)*64+8*0) XOR (F0(RF_X((14-1)*64+8*2-1 downto (14-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(14-1)+4)*8-1 downto (4*(14-1)+3)*8));
					RF_X(14*64+8*7-1 downto 14*64+8*6) <= RF_X((14-1)*64+8*8-1 downto (14-1)*64+8*7);
					RF_X(14*64+8*6-1 downto 14*64+8*5) <= RF_X((14-1)*64+8*7-1 downto (14-1)*64+8*6) + (F1(RF_X((14-1)*64+8*8-1 downto (14-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(14-1)+3)*8-1 downto (4*(14-1)+2)*8));
					RF_X(14*64+8*5-1 downto 14*64+8*4) <= RF_X((14-1)*64+8*6-1 downto (14-1)*64+8*5);
					RF_X(14*64+8*4-1 downto 14*64+8*3) <= RF_X((14-1)*64+8*5-1 downto (14-1)*64+8*4) XOR (F0(RF_X((14-1)*64+8*6-1 downto (14-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(14-1)+2)*8-1 downto (4*(14-1)+1)*8));
					RF_X(14*64+8*3-1 downto 14*64+8*2) <= RF_X((14-1)*64+8*4-1 downto (14-1)*64+8*3);
					RF_X(14*64+8*2-1 downto 14*64+8*1) <= RF_X((14-1)*64+8*3-1 downto (14-1)*64+8*2) + (F1(RF_X((14-1)*64+8*4-1 downto (14-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(14-1)+1)*8-1 downto (4*(14-1)+0)*8));
					RF_X(14*64+8*1-1 downto 14*64+8*0) <= RF_X((14-1)*64+8*2-1 downto (14-1)*64+8*1);
				when R14=>	
					state <= R15;
					RF_X(15*64+8*8-1 downto 15*64+8*7) <= RF_X((15-1)*64+8*1-1 downto (15-1)*64+8*0) XOR (F0(RF_X((15-1)*64+8*2-1 downto (15-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(15-1)+4)*8-1 downto (4*(15-1)+3)*8));
					RF_X(15*64+8*7-1 downto 15*64+8*6) <= RF_X((15-1)*64+8*8-1 downto (15-1)*64+8*7);
					RF_X(15*64+8*6-1 downto 15*64+8*5) <= RF_X((15-1)*64+8*7-1 downto (15-1)*64+8*6) + (F1(RF_X((15-1)*64+8*8-1 downto (15-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(15-1)+3)*8-1 downto (4*(15-1)+2)*8));
					RF_X(15*64+8*5-1 downto 15*64+8*4) <= RF_X((15-1)*64+8*6-1 downto (15-1)*64+8*5);
					RF_X(15*64+8*4-1 downto 15*64+8*3) <= RF_X((15-1)*64+8*5-1 downto (15-1)*64+8*4) XOR (F0(RF_X((15-1)*64+8*6-1 downto (15-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(15-1)+2)*8-1 downto (4*(15-1)+1)*8));
					RF_X(15*64+8*3-1 downto 15*64+8*2) <= RF_X((15-1)*64+8*4-1 downto (15-1)*64+8*3);
					RF_X(15*64+8*2-1 downto 15*64+8*1) <= RF_X((15-1)*64+8*3-1 downto (15-1)*64+8*2) + (F1(RF_X((15-1)*64+8*4-1 downto (15-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(15-1)+1)*8-1 downto (4*(15-1)+0)*8));
					RF_X(15*64+8*1-1 downto 15*64+8*0) <= RF_X((15-1)*64+8*2-1 downto (15-1)*64+8*1);
				when R15=>	
					state <= R16;
					RF_X(16*64+8*8-1 downto 16*64+8*7) <= RF_X((16-1)*64+8*1-1 downto (16-1)*64+8*0) XOR (F0(RF_X((16-1)*64+8*2-1 downto (16-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(16-1)+4)*8-1 downto (4*(16-1)+3)*8));
					RF_X(16*64+8*7-1 downto 16*64+8*6) <= RF_X((16-1)*64+8*8-1 downto (16-1)*64+8*7);
					RF_X(16*64+8*6-1 downto 16*64+8*5) <= RF_X((16-1)*64+8*7-1 downto (16-1)*64+8*6) + (F1(RF_X((16-1)*64+8*8-1 downto (16-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(16-1)+3)*8-1 downto (4*(16-1)+2)*8));
					RF_X(16*64+8*5-1 downto 16*64+8*4) <= RF_X((16-1)*64+8*6-1 downto (16-1)*64+8*5);
					RF_X(16*64+8*4-1 downto 16*64+8*3) <= RF_X((16-1)*64+8*5-1 downto (16-1)*64+8*4) XOR (F0(RF_X((16-1)*64+8*6-1 downto (16-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(16-1)+2)*8-1 downto (4*(16-1)+1)*8));
					RF_X(16*64+8*3-1 downto 16*64+8*2) <= RF_X((16-1)*64+8*4-1 downto (16-1)*64+8*3);
					RF_X(16*64+8*2-1 downto 16*64+8*1) <= RF_X((16-1)*64+8*3-1 downto (16-1)*64+8*2) + (F1(RF_X((16-1)*64+8*4-1 downto (16-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(16-1)+1)*8-1 downto (4*(16-1)+0)*8));
					RF_X(16*64+8*1-1 downto 16*64+8*0) <= RF_X((16-1)*64+8*2-1 downto (16-1)*64+8*1);
				when R16=>	
					state <= R17;
					RF_X(17*64+8*8-1 downto 17*64+8*7) <= RF_X((17-1)*64+8*1-1 downto (17-1)*64+8*0) XOR (F0(RF_X((17-1)*64+8*2-1 downto (17-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(17-1)+4)*8-1 downto (4*(17-1)+3)*8));
					RF_X(17*64+8*7-1 downto 17*64+8*6) <= RF_X((17-1)*64+8*8-1 downto (17-1)*64+8*7);
					RF_X(17*64+8*6-1 downto 17*64+8*5) <= RF_X((17-1)*64+8*7-1 downto (17-1)*64+8*6) + (F1(RF_X((17-1)*64+8*8-1 downto (17-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(17-1)+3)*8-1 downto (4*(17-1)+2)*8));
					RF_X(17*64+8*5-1 downto 17*64+8*4) <= RF_X((17-1)*64+8*6-1 downto (17-1)*64+8*5);
					RF_X(17*64+8*4-1 downto 17*64+8*3) <= RF_X((17-1)*64+8*5-1 downto (17-1)*64+8*4) XOR (F0(RF_X((17-1)*64+8*6-1 downto (17-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(17-1)+2)*8-1 downto (4*(17-1)+1)*8));
					RF_X(17*64+8*3-1 downto 17*64+8*2) <= RF_X((17-1)*64+8*4-1 downto (17-1)*64+8*3);
					RF_X(17*64+8*2-1 downto 17*64+8*1) <= RF_X((17-1)*64+8*3-1 downto (17-1)*64+8*2) + (F1(RF_X((17-1)*64+8*4-1 downto (17-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(17-1)+1)*8-1 downto (4*(17-1)+0)*8));
					RF_X(17*64+8*1-1 downto 17*64+8*0) <= RF_X((17-1)*64+8*2-1 downto (17-1)*64+8*1);
				when R17=>	
					state <= R18;
					RF_X(18*64+8*8-1 downto 18*64+8*7) <= RF_X((18-1)*64+8*1-1 downto (18-1)*64+8*0) XOR (F0(RF_X((18-1)*64+8*2-1 downto (18-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(18-1)+4)*8-1 downto (4*(18-1)+3)*8));
					RF_X(18*64+8*7-1 downto 18*64+8*6) <= RF_X((18-1)*64+8*8-1 downto (18-1)*64+8*7);
					RF_X(18*64+8*6-1 downto 18*64+8*5) <= RF_X((18-1)*64+8*7-1 downto (18-1)*64+8*6) + (F1(RF_X((18-1)*64+8*8-1 downto (18-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(18-1)+3)*8-1 downto (4*(18-1)+2)*8));
					RF_X(18*64+8*5-1 downto 18*64+8*4) <= RF_X((18-1)*64+8*6-1 downto (18-1)*64+8*5);
					RF_X(18*64+8*4-1 downto 18*64+8*3) <= RF_X((18-1)*64+8*5-1 downto (18-1)*64+8*4) XOR (F0(RF_X((18-1)*64+8*6-1 downto (18-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(18-1)+2)*8-1 downto (4*(18-1)+1)*8));
					RF_X(18*64+8*3-1 downto 18*64+8*2) <= RF_X((18-1)*64+8*4-1 downto (18-1)*64+8*3);
					RF_X(18*64+8*2-1 downto 18*64+8*1) <= RF_X((18-1)*64+8*3-1 downto (18-1)*64+8*2) + (F1(RF_X((18-1)*64+8*4-1 downto (18-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(18-1)+1)*8-1 downto (4*(18-1)+0)*8));
					RF_X(18*64+8*1-1 downto 18*64+8*0) <= RF_X((18-1)*64+8*2-1 downto (18-1)*64+8*1);
				when R18=>	
					state <= R19;
					RF_X(19*64+8*8-1 downto 19*64+8*7) <= RF_X((19-1)*64+8*1-1 downto (19-1)*64+8*0) XOR (F0(RF_X((19-1)*64+8*2-1 downto (19-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(19-1)+4)*8-1 downto (4*(19-1)+3)*8));
					RF_X(19*64+8*7-1 downto 19*64+8*6) <= RF_X((19-1)*64+8*8-1 downto (19-1)*64+8*7);
					RF_X(19*64+8*6-1 downto 19*64+8*5) <= RF_X((19-1)*64+8*7-1 downto (19-1)*64+8*6) + (F1(RF_X((19-1)*64+8*8-1 downto (19-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(19-1)+3)*8-1 downto (4*(19-1)+2)*8));
					RF_X(19*64+8*5-1 downto 19*64+8*4) <= RF_X((19-1)*64+8*6-1 downto (19-1)*64+8*5);
					RF_X(19*64+8*4-1 downto 19*64+8*3) <= RF_X((19-1)*64+8*5-1 downto (19-1)*64+8*4) XOR (F0(RF_X((19-1)*64+8*6-1 downto (19-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(19-1)+2)*8-1 downto (4*(19-1)+1)*8));
					RF_X(19*64+8*3-1 downto 19*64+8*2) <= RF_X((19-1)*64+8*4-1 downto (19-1)*64+8*3);
					RF_X(19*64+8*2-1 downto 19*64+8*1) <= RF_X((19-1)*64+8*3-1 downto (19-1)*64+8*2) + (F1(RF_X((19-1)*64+8*4-1 downto (19-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(19-1)+1)*8-1 downto (4*(19-1)+0)*8));
					RF_X(19*64+8*1-1 downto 19*64+8*0) <= RF_X((19-1)*64+8*2-1 downto (19-1)*64+8*1);
				when R19=>	
					state <= R20;
					RF_X(20*64+8*8-1 downto 20*64+8*7) <= RF_X((20-1)*64+8*1-1 downto (20-1)*64+8*0) XOR (F0(RF_X((20-1)*64+8*2-1 downto (20-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(20-1)+4)*8-1 downto (4*(20-1)+3)*8));
					RF_X(20*64+8*7-1 downto 20*64+8*6) <= RF_X((20-1)*64+8*8-1 downto (20-1)*64+8*7);
					RF_X(20*64+8*6-1 downto 20*64+8*5) <= RF_X((20-1)*64+8*7-1 downto (20-1)*64+8*6) + (F1(RF_X((20-1)*64+8*8-1 downto (20-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(20-1)+3)*8-1 downto (4*(20-1)+2)*8));
					RF_X(20*64+8*5-1 downto 20*64+8*4) <= RF_X((20-1)*64+8*6-1 downto (20-1)*64+8*5);
					RF_X(20*64+8*4-1 downto 20*64+8*3) <= RF_X((20-1)*64+8*5-1 downto (20-1)*64+8*4) XOR (F0(RF_X((20-1)*64+8*6-1 downto (20-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(20-1)+2)*8-1 downto (4*(20-1)+1)*8));
					RF_X(20*64+8*3-1 downto 20*64+8*2) <= RF_X((20-1)*64+8*4-1 downto (20-1)*64+8*3);
					RF_X(20*64+8*2-1 downto 20*64+8*1) <= RF_X((20-1)*64+8*3-1 downto (20-1)*64+8*2) + (F1(RF_X((20-1)*64+8*4-1 downto (20-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(20-1)+1)*8-1 downto (4*(20-1)+0)*8));
					RF_X(20*64+8*1-1 downto 20*64+8*0) <= RF_X((20-1)*64+8*2-1 downto (20-1)*64+8*1);
				when R20=>	
					state <= R21;
					RF_X(21*64+8*8-1 downto 21*64+8*7) <= RF_X((21-1)*64+8*1-1 downto (21-1)*64+8*0) XOR (F0(RF_X((21-1)*64+8*2-1 downto (21-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(21-1)+4)*8-1 downto (4*(21-1)+3)*8));
					RF_X(21*64+8*7-1 downto 21*64+8*6) <= RF_X((21-1)*64+8*8-1 downto (21-1)*64+8*7);
					RF_X(21*64+8*6-1 downto 21*64+8*5) <= RF_X((21-1)*64+8*7-1 downto (21-1)*64+8*6) + (F1(RF_X((21-1)*64+8*8-1 downto (21-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(21-1)+3)*8-1 downto (4*(21-1)+2)*8));
					RF_X(21*64+8*5-1 downto 21*64+8*4) <= RF_X((21-1)*64+8*6-1 downto (21-1)*64+8*5);
					RF_X(21*64+8*4-1 downto 21*64+8*3) <= RF_X((21-1)*64+8*5-1 downto (21-1)*64+8*4) XOR (F0(RF_X((21-1)*64+8*6-1 downto (21-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(21-1)+2)*8-1 downto (4*(21-1)+1)*8));
					RF_X(21*64+8*3-1 downto 21*64+8*2) <= RF_X((21-1)*64+8*4-1 downto (21-1)*64+8*3);
					RF_X(21*64+8*2-1 downto 21*64+8*1) <= RF_X((21-1)*64+8*3-1 downto (21-1)*64+8*2) + (F1(RF_X((21-1)*64+8*4-1 downto (21-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(21-1)+1)*8-1 downto (4*(21-1)+0)*8));
					RF_X(21*64+8*1-1 downto 21*64+8*0) <= RF_X((21-1)*64+8*2-1 downto (21-1)*64+8*1);
				when R21=>	
					state <= R22;
					RF_X(22*64+8*8-1 downto 22*64+8*7) <= RF_X((22-1)*64+8*1-1 downto (22-1)*64+8*0) XOR (F0(RF_X((22-1)*64+8*2-1 downto (22-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(22-1)+4)*8-1 downto (4*(22-1)+3)*8));
					RF_X(22*64+8*7-1 downto 22*64+8*6) <= RF_X((22-1)*64+8*8-1 downto (22-1)*64+8*7);
					RF_X(22*64+8*6-1 downto 22*64+8*5) <= RF_X((22-1)*64+8*7-1 downto (22-1)*64+8*6) + (F1(RF_X((22-1)*64+8*8-1 downto (22-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(22-1)+3)*8-1 downto (4*(22-1)+2)*8));
					RF_X(22*64+8*5-1 downto 22*64+8*4) <= RF_X((22-1)*64+8*6-1 downto (22-1)*64+8*5);
					RF_X(22*64+8*4-1 downto 22*64+8*3) <= RF_X((22-1)*64+8*5-1 downto (22-1)*64+8*4) XOR (F0(RF_X((22-1)*64+8*6-1 downto (22-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(22-1)+2)*8-1 downto (4*(22-1)+1)*8));
					RF_X(22*64+8*3-1 downto 22*64+8*2) <= RF_X((22-1)*64+8*4-1 downto (22-1)*64+8*3);
					RF_X(22*64+8*2-1 downto 22*64+8*1) <= RF_X((22-1)*64+8*3-1 downto (22-1)*64+8*2) + (F1(RF_X((22-1)*64+8*4-1 downto (22-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(22-1)+1)*8-1 downto (4*(22-1)+0)*8));
					RF_X(22*64+8*1-1 downto 22*64+8*0) <= RF_X((22-1)*64+8*2-1 downto (22-1)*64+8*1);
				when R22=>	
					state <= R23;
					RF_X(23*64+8*8-1 downto 23*64+8*7) <= RF_X((23-1)*64+8*1-1 downto (23-1)*64+8*0) XOR (F0(RF_X((23-1)*64+8*2-1 downto (23-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(23-1)+4)*8-1 downto (4*(23-1)+3)*8));
					RF_X(23*64+8*7-1 downto 23*64+8*6) <= RF_X((23-1)*64+8*8-1 downto (23-1)*64+8*7);
					RF_X(23*64+8*6-1 downto 23*64+8*5) <= RF_X((23-1)*64+8*7-1 downto (23-1)*64+8*6) + (F1(RF_X((23-1)*64+8*8-1 downto (23-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(23-1)+3)*8-1 downto (4*(23-1)+2)*8));
					RF_X(23*64+8*5-1 downto 23*64+8*4) <= RF_X((23-1)*64+8*6-1 downto (23-1)*64+8*5);
					RF_X(23*64+8*4-1 downto 23*64+8*3) <= RF_X((23-1)*64+8*5-1 downto (23-1)*64+8*4) XOR (F0(RF_X((23-1)*64+8*6-1 downto (23-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(23-1)+2)*8-1 downto (4*(23-1)+1)*8));
					RF_X(23*64+8*3-1 downto 23*64+8*2) <= RF_X((23-1)*64+8*4-1 downto (23-1)*64+8*3);
					RF_X(23*64+8*2-1 downto 23*64+8*1) <= RF_X((23-1)*64+8*3-1 downto (23-1)*64+8*2) + (F1(RF_X((23-1)*64+8*4-1 downto (23-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(23-1)+1)*8-1 downto (4*(23-1)+0)*8));
					RF_X(23*64+8*1-1 downto 23*64+8*0) <= RF_X((23-1)*64+8*2-1 downto (23-1)*64+8*1);
				when R23=>	
					state <= R24;
					RF_X(24*64+8*8-1 downto 24*64+8*7) <= RF_X((24-1)*64+8*1-1 downto (24-1)*64+8*0) XOR (F0(RF_X((24-1)*64+8*2-1 downto (24-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(24-1)+4)*8-1 downto (4*(24-1)+3)*8));
					RF_X(24*64+8*7-1 downto 24*64+8*6) <= RF_X((24-1)*64+8*8-1 downto (24-1)*64+8*7);
					RF_X(24*64+8*6-1 downto 24*64+8*5) <= RF_X((24-1)*64+8*7-1 downto (24-1)*64+8*6) + (F1(RF_X((24-1)*64+8*8-1 downto (24-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(24-1)+3)*8-1 downto (4*(24-1)+2)*8));
					RF_X(24*64+8*5-1 downto 24*64+8*4) <= RF_X((24-1)*64+8*6-1 downto (24-1)*64+8*5);
					RF_X(24*64+8*4-1 downto 24*64+8*3) <= RF_X((24-1)*64+8*5-1 downto (24-1)*64+8*4) XOR (F0(RF_X((24-1)*64+8*6-1 downto (24-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(24-1)+2)*8-1 downto (4*(24-1)+1)*8));
					RF_X(24*64+8*3-1 downto 24*64+8*2) <= RF_X((24-1)*64+8*4-1 downto (24-1)*64+8*3);
					RF_X(24*64+8*2-1 downto 24*64+8*1) <= RF_X((24-1)*64+8*3-1 downto (24-1)*64+8*2) + (F1(RF_X((24-1)*64+8*4-1 downto (24-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(24-1)+1)*8-1 downto (4*(24-1)+0)*8));
					RF_X(24*64+8*1-1 downto 24*64+8*0) <= RF_X((24-1)*64+8*2-1 downto (24-1)*64+8*1);
				when R24=>	
					state <= R25;
					RF_X(25*64+8*8-1 downto 25*64+8*7) <= RF_X((25-1)*64+8*1-1 downto (25-1)*64+8*0) XOR (F0(RF_X((25-1)*64+8*2-1 downto (25-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(25-1)+4)*8-1 downto (4*(25-1)+3)*8));
					RF_X(25*64+8*7-1 downto 25*64+8*6) <= RF_X((25-1)*64+8*8-1 downto (25-1)*64+8*7);
					RF_X(25*64+8*6-1 downto 25*64+8*5) <= RF_X((25-1)*64+8*7-1 downto (25-1)*64+8*6) + (F1(RF_X((25-1)*64+8*8-1 downto (25-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(25-1)+3)*8-1 downto (4*(25-1)+2)*8));
					RF_X(25*64+8*5-1 downto 25*64+8*4) <= RF_X((25-1)*64+8*6-1 downto (25-1)*64+8*5);
					RF_X(25*64+8*4-1 downto 25*64+8*3) <= RF_X((25-1)*64+8*5-1 downto (25-1)*64+8*4) XOR (F0(RF_X((25-1)*64+8*6-1 downto (25-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(25-1)+2)*8-1 downto (4*(25-1)+1)*8));
					RF_X(25*64+8*3-1 downto 25*64+8*2) <= RF_X((25-1)*64+8*4-1 downto (25-1)*64+8*3);
					RF_X(25*64+8*2-1 downto 25*64+8*1) <= RF_X((25-1)*64+8*3-1 downto (25-1)*64+8*2) + (F1(RF_X((25-1)*64+8*4-1 downto (25-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(25-1)+1)*8-1 downto (4*(25-1)+0)*8));
					RF_X(25*64+8*1-1 downto 25*64+8*0) <= RF_X((25-1)*64+8*2-1 downto (25-1)*64+8*1);
				when R25=>	
					state <= R26;
					RF_X(26*64+8*8-1 downto 26*64+8*7) <= RF_X((26-1)*64+8*1-1 downto (26-1)*64+8*0) XOR (F0(RF_X((26-1)*64+8*2-1 downto (26-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(26-1)+4)*8-1 downto (4*(26-1)+3)*8));
					RF_X(26*64+8*7-1 downto 26*64+8*6) <= RF_X((26-1)*64+8*8-1 downto (26-1)*64+8*7);
					RF_X(26*64+8*6-1 downto 26*64+8*5) <= RF_X((26-1)*64+8*7-1 downto (26-1)*64+8*6) + (F1(RF_X((26-1)*64+8*8-1 downto (26-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(26-1)+3)*8-1 downto (4*(26-1)+2)*8));
					RF_X(26*64+8*5-1 downto 26*64+8*4) <= RF_X((26-1)*64+8*6-1 downto (26-1)*64+8*5);
					RF_X(26*64+8*4-1 downto 26*64+8*3) <= RF_X((26-1)*64+8*5-1 downto (26-1)*64+8*4) XOR (F0(RF_X((26-1)*64+8*6-1 downto (26-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(26-1)+2)*8-1 downto (4*(26-1)+1)*8));
					RF_X(26*64+8*3-1 downto 26*64+8*2) <= RF_X((26-1)*64+8*4-1 downto (26-1)*64+8*3);
					RF_X(26*64+8*2-1 downto 26*64+8*1) <= RF_X((26-1)*64+8*3-1 downto (26-1)*64+8*2) + (F1(RF_X((26-1)*64+8*4-1 downto (26-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(26-1)+1)*8-1 downto (4*(26-1)+0)*8));
					RF_X(26*64+8*1-1 downto 26*64+8*0) <= RF_X((26-1)*64+8*2-1 downto (26-1)*64+8*1);
				when R26=>	
					state <= R27;
					RF_X(27*64+8*8-1 downto 27*64+8*7) <= RF_X((27-1)*64+8*1-1 downto (27-1)*64+8*0) XOR (F0(RF_X((27-1)*64+8*2-1 downto (27-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(27-1)+4)*8-1 downto (4*(27-1)+3)*8));
					RF_X(27*64+8*7-1 downto 27*64+8*6) <= RF_X((27-1)*64+8*8-1 downto (27-1)*64+8*7);
					RF_X(27*64+8*6-1 downto 27*64+8*5) <= RF_X((27-1)*64+8*7-1 downto (27-1)*64+8*6) + (F1(RF_X((27-1)*64+8*8-1 downto (27-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(27-1)+3)*8-1 downto (4*(27-1)+2)*8));
					RF_X(27*64+8*5-1 downto 27*64+8*4) <= RF_X((27-1)*64+8*6-1 downto (27-1)*64+8*5);
					RF_X(27*64+8*4-1 downto 27*64+8*3) <= RF_X((27-1)*64+8*5-1 downto (27-1)*64+8*4) XOR (F0(RF_X((27-1)*64+8*6-1 downto (27-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(27-1)+2)*8-1 downto (4*(27-1)+1)*8));
					RF_X(27*64+8*3-1 downto 27*64+8*2) <= RF_X((27-1)*64+8*4-1 downto (27-1)*64+8*3);
					RF_X(27*64+8*2-1 downto 27*64+8*1) <= RF_X((27-1)*64+8*3-1 downto (27-1)*64+8*2) + (F1(RF_X((27-1)*64+8*4-1 downto (27-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(27-1)+1)*8-1 downto (4*(27-1)+0)*8));
					RF_X(27*64+8*1-1 downto 27*64+8*0) <= RF_X((27-1)*64+8*2-1 downto (27-1)*64+8*1);
				when R27=>	
					state <= R28;
					RF_X(28*64+8*8-1 downto 28*64+8*7) <= RF_X((28-1)*64+8*1-1 downto (28-1)*64+8*0) XOR (F0(RF_X((28-1)*64+8*2-1 downto (28-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(28-1)+4)*8-1 downto (4*(28-1)+3)*8));
					RF_X(28*64+8*7-1 downto 28*64+8*6) <= RF_X((28-1)*64+8*8-1 downto (28-1)*64+8*7);
					RF_X(28*64+8*6-1 downto 28*64+8*5) <= RF_X((28-1)*64+8*7-1 downto (28-1)*64+8*6) + (F1(RF_X((28-1)*64+8*8-1 downto (28-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(28-1)+3)*8-1 downto (4*(28-1)+2)*8));
					RF_X(28*64+8*5-1 downto 28*64+8*4) <= RF_X((28-1)*64+8*6-1 downto (28-1)*64+8*5);
					RF_X(28*64+8*4-1 downto 28*64+8*3) <= RF_X((28-1)*64+8*5-1 downto (28-1)*64+8*4) XOR (F0(RF_X((28-1)*64+8*6-1 downto (28-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(28-1)+2)*8-1 downto (4*(28-1)+1)*8));
					RF_X(28*64+8*3-1 downto 28*64+8*2) <= RF_X((28-1)*64+8*4-1 downto (28-1)*64+8*3);
					RF_X(28*64+8*2-1 downto 28*64+8*1) <= RF_X((28-1)*64+8*3-1 downto (28-1)*64+8*2) + (F1(RF_X((28-1)*64+8*4-1 downto (28-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(28-1)+1)*8-1 downto (4*(28-1)+0)*8));
					RF_X(28*64+8*1-1 downto 28*64+8*0) <= RF_X((28-1)*64+8*2-1 downto (28-1)*64+8*1);
				when R28=>	
					state <= R29;
					RF_X(29*64+8*8-1 downto 29*64+8*7) <= RF_X((29-1)*64+8*1-1 downto (29-1)*64+8*0) XOR (F0(RF_X((29-1)*64+8*2-1 downto (29-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(29-1)+4)*8-1 downto (4*(29-1)+3)*8));
					RF_X(29*64+8*7-1 downto 29*64+8*6) <= RF_X((29-1)*64+8*8-1 downto (29-1)*64+8*7);
					RF_X(29*64+8*6-1 downto 29*64+8*5) <= RF_X((29-1)*64+8*7-1 downto (29-1)*64+8*6) + (F1(RF_X((29-1)*64+8*8-1 downto (29-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(29-1)+3)*8-1 downto (4*(29-1)+2)*8));
					RF_X(29*64+8*5-1 downto 29*64+8*4) <= RF_X((29-1)*64+8*6-1 downto (29-1)*64+8*5);
					RF_X(29*64+8*4-1 downto 29*64+8*3) <= RF_X((29-1)*64+8*5-1 downto (29-1)*64+8*4) XOR (F0(RF_X((29-1)*64+8*6-1 downto (29-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(29-1)+2)*8-1 downto (4*(29-1)+1)*8));
					RF_X(29*64+8*3-1 downto 29*64+8*2) <= RF_X((29-1)*64+8*4-1 downto (29-1)*64+8*3);
					RF_X(29*64+8*2-1 downto 29*64+8*1) <= RF_X((29-1)*64+8*3-1 downto (29-1)*64+8*2) + (F1(RF_X((29-1)*64+8*4-1 downto (29-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(29-1)+1)*8-1 downto (4*(29-1)+0)*8));
					RF_X(29*64+8*1-1 downto 29*64+8*0) <= RF_X((29-1)*64+8*2-1 downto (29-1)*64+8*1);
				when R29=>	
					state <= R30;
					RF_X(30*64+8*8-1 downto 30*64+8*7) <= RF_X((30-1)*64+8*1-1 downto (30-1)*64+8*0) XOR (F0(RF_X((30-1)*64+8*2-1 downto (30-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(30-1)+4)*8-1 downto (4*(30-1)+3)*8));
					RF_X(30*64+8*7-1 downto 30*64+8*6) <= RF_X((30-1)*64+8*8-1 downto (30-1)*64+8*7);
					RF_X(30*64+8*6-1 downto 30*64+8*5) <= RF_X((30-1)*64+8*7-1 downto (30-1)*64+8*6) + (F1(RF_X((30-1)*64+8*8-1 downto (30-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(30-1)+3)*8-1 downto (4*(30-1)+2)*8));
					RF_X(30*64+8*5-1 downto 30*64+8*4) <= RF_X((30-1)*64+8*6-1 downto (30-1)*64+8*5);
					RF_X(30*64+8*4-1 downto 30*64+8*3) <= RF_X((30-1)*64+8*5-1 downto (30-1)*64+8*4) XOR (F0(RF_X((30-1)*64+8*6-1 downto (30-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(30-1)+2)*8-1 downto (4*(30-1)+1)*8));
					RF_X(30*64+8*3-1 downto 30*64+8*2) <= RF_X((30-1)*64+8*4-1 downto (30-1)*64+8*3);
					RF_X(30*64+8*2-1 downto 30*64+8*1) <= RF_X((30-1)*64+8*3-1 downto (30-1)*64+8*2) + (F1(RF_X((30-1)*64+8*4-1 downto (30-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(30-1)+1)*8-1 downto (4*(30-1)+0)*8));
					RF_X(30*64+8*1-1 downto 30*64+8*0) <= RF_X((30-1)*64+8*2-1 downto (30-1)*64+8*1);
				when R30=>	
					state <= R31;
					RF_X(31*64+8*8-1 downto 31*64+8*7) <= RF_X((31-1)*64+8*1-1 downto (31-1)*64+8*0) XOR (F0(RF_X((31-1)*64+8*2-1 downto (31-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(31-1)+4)*8-1 downto (4*(31-1)+3)*8));
					RF_X(31*64+8*7-1 downto 31*64+8*6) <= RF_X((31-1)*64+8*8-1 downto (31-1)*64+8*7);
					RF_X(31*64+8*6-1 downto 31*64+8*5) <= RF_X((31-1)*64+8*7-1 downto (31-1)*64+8*6) + (F1(RF_X((31-1)*64+8*8-1 downto (31-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(31-1)+3)*8-1 downto (4*(31-1)+2)*8));
					RF_X(31*64+8*5-1 downto 31*64+8*4) <= RF_X((31-1)*64+8*6-1 downto (31-1)*64+8*5);
					RF_X(31*64+8*4-1 downto 31*64+8*3) <= RF_X((31-1)*64+8*5-1 downto (31-1)*64+8*4) XOR (F0(RF_X((31-1)*64+8*6-1 downto (31-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(31-1)+2)*8-1 downto (4*(31-1)+1)*8));
					RF_X(31*64+8*3-1 downto 31*64+8*2) <= RF_X((31-1)*64+8*4-1 downto (31-1)*64+8*3);
					RF_X(31*64+8*2-1 downto 31*64+8*1) <= RF_X((31-1)*64+8*3-1 downto (31-1)*64+8*2) + (F1(RF_X((31-1)*64+8*4-1 downto (31-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(31-1)+1)*8-1 downto (4*(31-1)+0)*8));
					RF_X(31*64+8*1-1 downto 31*64+8*0) <= RF_X((31-1)*64+8*2-1 downto (31-1)*64+8*1);
				when R31=>	
					state <= R0;
					RF_X(32*64+8*8-1 downto 32*64+8*7) <= RF_X((32-1)*64+8*1-1 downto (32-1)*64+8*0) XOR (F0(RF_X((32-1)*64+8*2-1 downto (32-1)*64+8*1)) + i_HIGHT_RoundFunction_SK((4*(32-1)+4)*8-1 downto (4*(32-1)+3)*8));
					RF_X(32*64+8*7-1 downto 32*64+8*6) <= RF_X((32-1)*64+8*8-1 downto (32-1)*64+8*7);
					RF_X(32*64+8*6-1 downto 32*64+8*5) <= RF_X((32-1)*64+8*7-1 downto (32-1)*64+8*6) + (F1(RF_X((32-1)*64+8*8-1 downto (32-1)*64+8*7)) XOR i_HIGHT_RoundFunction_SK((4*(32-1)+3)*8-1 downto (4*(32-1)+2)*8));
					RF_X(32*64+8*5-1 downto 32*64+8*4) <= RF_X((32-1)*64+8*6-1 downto (32-1)*64+8*5);
					RF_X(32*64+8*4-1 downto 32*64+8*3) <= RF_X((32-1)*64+8*5-1 downto (32-1)*64+8*4) XOR (F0(RF_X((32-1)*64+8*6-1 downto (32-1)*64+8*5)) + i_HIGHT_RoundFunction_SK((4*(32-1)+2)*8-1 downto (4*(32-1)+1)*8));
					RF_X(32*64+8*3-1 downto 32*64+8*2) <= RF_X((32-1)*64+8*4-1 downto (32-1)*64+8*3);
					RF_X(32*64+8*2-1 downto 32*64+8*1) <= RF_X((32-1)*64+8*3-1 downto (32-1)*64+8*2) + (F1(RF_X((32-1)*64+8*4-1 downto (32-1)*64+8*3)) XOR i_HIGHT_RoundFunction_SK((4*(32-1)+1)*8-1 downto (4*(32-1)+0)*8));
					RF_X(32*64+8*1-1 downto 32*64+8*0) <= RF_X((32-1)*64+8*2-1 downto (32-1)*64+8*1);
					o_HIGHT_RoundFunction_ready <= '1';
					
				when others=>
					state <= IDLE;
					o_HIGHT_RoundFunction_ready <= '0';
				end case;
			end if;	
			
	end if;
end process;

end architecture;