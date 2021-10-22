library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.numeric_std.all;

package HIGHT_comps is
--  Components

component HIGHT_KeySchedule	is
port(
		i_HIGHT_KeySchedule_reset 			: in std_logic;
		i_HIGHT_KeySchedule_clk				: in std_logic;
		i_HIGHT_KeySchedule_MasterKey		: in std_logic_vector(127 downto 0);
		-- Outputs
		o_HIGHT_KeySchedule_WhitteningKey	: out std_logic_vector(63 downto 0);
		o_HIGHT_KeySchedule_SubKey			: out std_logic_vector(1023 downto 0)
);
end component;

component HIGHT_InitialTransformation	is
port(
		i_HIGHT_InitialTransformation_rst 			: in std_logic;
		i_HIGHT_InitialTransformation_clk			: in std_logic;
		i_HIGHT_InitialTransformation_WK			: in std_logic_vector(63 downto 0);
		i_HIGHT_InitialTransformation_PlainText		: in std_logic_vector(63 downto 0);
		-- Outputs
		o_HIGHT_InitialTransformation_X				: out std_logic_vector(63 downto 0)
);
end component;

component HIGHT_RoundFunction	is
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
end component;

component HIGHT_FinalTransformation	is
port(
		i_HIGHT_FinalTransformation_rst 			: in std_logic;
		i_HIGHT_FinalTransformation_clk				: in std_logic;
		i_HIGHT_FinalTransformation_WK				: in std_logic_vector(63 downto 0);
		i_HIGHT_FinalTransformation_X				: in std_logic_vector(63 downto 0);
		-- Outputs
		o_HIGHT_FinalTransformation_CipherText		: out std_logic_vector(63 downto 0)
);
end component;

end package;
