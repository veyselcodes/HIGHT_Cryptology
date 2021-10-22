library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

library work;
use work.HIGHT_comps.all;

entity HIGHT_Encryption	is
port(
		i_HIGHT_Encryption_rst 				: in std_logic;
		i_HIGHT_Encryption_clk				: in std_logic;
		i_HIGHT_Encryption_MasterKey		: in std_logic_vector(127 downto 0);
		i_HIGHT_Encryption_PlainText		: in std_logic_vector(63 downto 0);
		i_HIGHT_Encryption_valid			: in std_logic;
		i_HIGHT_Encryption_ready  			: in std_logic;
		-- Outputs
		o_HIGHT_Encryption_CipherKey		: out std_logic_vector(63 downto 0);
		o_HIGHT_Encryption_valid			: out std_logic;
		o_HIGHT_Encryption_ready			: out std_logic
);
end HIGHT_Encryption;


architecture behaviour of HIGHT_Encryption is
-- --  Signals
signal WK : std_logic_vector(63 downto 0);
signal SK : std_logic_vector(1023 downto 0);
signal X0  : std_logic_vector(63 downto 0);
signal XR  : std_logic_vector(2047 downto 0);

 begin


i_HIGHT_KeySchedule: HIGHT_KeySchedule
port map(
		i_HIGHT_KeySchedule_reset 			=> i_HIGHT_Encryption_rst,
		i_HIGHT_KeySchedule_clk				=> i_HIGHT_Encryption_clk,
		i_HIGHT_KeySchedule_MasterKey		=> i_HIGHT_Encryption_MasterKey,
		-- Outputs                          
		o_HIGHT_KeySchedule_WhitteningKey	=> WK,
		o_HIGHT_KeySchedule_SubKey			=> SK
);

i_HIGHT_InitialTransformation: HIGHT_InitialTransformation	
port map(
		i_HIGHT_InitialTransformation_rst 		=> i_HIGHT_Encryption_rst,
		i_HIGHT_InitialTransformation_clk		=> i_HIGHT_Encryption_clk,
		i_HIGHT_InitialTransformation_WK		=> WK,
		i_HIGHT_InitialTransformation_PlainText	=> i_HIGHT_Encryption_PlainText,
		-- Outputs                              
		o_HIGHT_InitialTransformation_X			=> X0
);

i_HIGHT_RoundFunction: HIGHT_RoundFunction	
port map(
		i_HIGHT_RoundFunction_rst 	=> i_HIGHT_Encryption_rst,
		i_HIGHT_RoundFunction_clk	=> i_HIGHT_Encryption_clk,
		i_HIGHT_RoundFunction_SK	=> SK,
		i_HIGHT_RoundFunction_X		=> X0,
		i_HIGHT_RoundFunction_valid	=>  i_HIGHT_Encryption_valid,
		i_HIGHT_RoundFunction_ready =>  i_HIGHT_Encryption_ready,
		-- Outputs                  
		o_HIGHT_RoundFunction_X		=> XR,
		o_HIGHT_RoundFunction_valid => o_HIGHT_Encryption_valid,
		o_HIGHT_RoundFunction_ready => o_HIGHT_Encryption_ready
);		

i_HIGHT_FinalTransformation: HIGHT_FinalTransformation		
port map(
		i_HIGHT_FinalTransformation_rst 		=> i_HIGHT_Encryption_rst,
		i_HIGHT_FinalTransformation_clk			=> i_HIGHT_Encryption_clk,
		i_HIGHT_FinalTransformation_WK			=> WK,
		i_HIGHT_FinalTransformation_X			=> XR(2047 downto 2048-64),
		-- Outputs                              
		o_HIGHT_FinalTransformation_CipherText	=> o_HIGHT_Encryption_CipherKey
);

end architecture;
