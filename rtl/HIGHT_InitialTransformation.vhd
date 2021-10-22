library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity HIGHT_InitialTransformation	is
port(
		i_HIGHT_InitialTransformation_rst 			: in std_logic;
		i_HIGHT_InitialTransformation_clk			: in std_logic;
		i_HIGHT_InitialTransformation_WK			: in std_logic_vector(63 downto 0);
		i_HIGHT_InitialTransformation_PlainText		: in std_logic_vector(63 downto 0);
		-- Outputs
		o_HIGHT_InitialTransformation_X				: out std_logic_vector(63 downto 0)
);
end HIGHT_InitialTransformation;

architecture behaviour of HIGHT_InitialTransformation is

begin
process(ALL)is
begin
	if(i_HIGHT_InitialTransformation_rst = '0')then
		o_HIGHT_InitialTransformation_X <= (others=> '0'); 
	else
		o_HIGHT_InitialTransformation_X(8*8-1 downto 8*7) <= i_HIGHT_InitialTransformation_PlainText(8*1-1 downto 8*0) + i_HIGHT_InitialTransformation_WK(8*1-1 downto 8*0);
		o_HIGHT_InitialTransformation_X(8*7-1 downto 8*6) <= i_HIGHT_InitialTransformation_PlainText(8*2-1 downto 8*1);
		o_HIGHT_InitialTransformation_X(8*6-1 downto 8*5) <= i_HIGHT_InitialTransformation_PlainText(8*3-1 downto 8*2) XOR i_HIGHT_InitialTransformation_WK(8*2-1 downto 8*1);	
		o_HIGHT_InitialTransformation_X(8*5-1 downto 8*4) <= i_HIGHT_InitialTransformation_PlainText(8*4-1 downto 8*3);
		o_HIGHT_InitialTransformation_X(8*4-1 downto 8*3) <= i_HIGHT_InitialTransformation_PlainText(8*5-1 downto 8*4) + i_HIGHT_InitialTransformation_WK(8*3-1 downto 8*2);	
		o_HIGHT_InitialTransformation_X(8*3-1 downto 8*2) <= i_HIGHT_InitialTransformation_PlainText(8*6-1 downto 8*5);
		o_HIGHT_InitialTransformation_X(8*2-1 downto 8*1) <= i_HIGHT_InitialTransformation_PlainText(8*7-1 downto 8*6) XOR i_HIGHT_InitialTransformation_WK(8*4-1 downto 8*3);	
		o_HIGHT_InitialTransformation_X(8*1-1 downto 8*0) <= i_HIGHT_InitialTransformation_PlainText(8*8-1 downto 8*7);
	end if;
end process;

end architecture;
