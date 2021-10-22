library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity HIGHT_KeySchedule_tb	is
--
end HIGHT_KeySchedule_tb;

architecture tb of HIGHT_KeySchedule_tb is


constant 	clk_period : time := 20 ns;
signal 		i_HIGHT_KeySchedule_reset 			: std_logic;
signal 		i_HIGHT_KeySchedule_clk				: std_logic;
signal 		i_HIGHT_KeySchedule_MasterKey		: std_logic_vector(127 downto 0);
-- Outputs
signal 		o_HIGHT_KeySchedule_WhitteningKey	: std_logic_vector(63 downto 0);
signal 		o_HIGHT_KeySchedule_SubKey			: std_logic_vector(1023 downto 0);


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

begin

UUT: HIGHT_KeySchedule
port map(
		i_HIGHT_KeySchedule_reset 			=> i_HIGHT_KeySchedule_reset 			,
		i_HIGHT_KeySchedule_clk				=> i_HIGHT_KeySchedule_clk				,
		i_HIGHT_KeySchedule_MasterKey		=> i_HIGHT_KeySchedule_MasterKey		,
		-- Outputs                          => -- Outputs                           ,
		o_HIGHT_KeySchedule_WhitteningKey	=> o_HIGHT_KeySchedule_WhitteningKey	,
		o_HIGHT_KeySchedule_SubKey			=> o_HIGHT_KeySchedule_SubKey			
);

i_clk_process :process
   begin
        i_HIGHT_KeySchedule_clk <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        i_HIGHT_KeySchedule_clk <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;
   
   
i_HIGHT_KeySchedule_stimulus:process
begin
	-- TRY 1
    i_HIGHT_KeySchedule_reset 	 	<='0';
	i_HIGHT_KeySchedule_MasterKey	<= x"F43FB7FF9696D7AD55E687A34B960686";
	wait for 3*clk_period;
	i_HIGHT_KeySchedule_reset 	 	<='1';
	wait for 300 ns;
	i_HIGHT_KeySchedule_reset 	 	<='1';
	
	wait for 10 ns;
	
	assert false
	report "SIM_DONE"
	severity failure;
end process i_HIGHT_KeySchedule_stimulus;
	
end tb;