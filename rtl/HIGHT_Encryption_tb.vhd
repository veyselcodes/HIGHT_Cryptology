library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity HIGHT_Encryption_tb	is
--
end HIGHT_Encryption_tb;

architecture tb of HIGHT_Encryption_tb is

component HIGHT_Encryption	is
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
		o_HIGHT_Encryption_ready			: out	 std_logic
);
end component;

-- Signals
constant 	clk_period : time 		 	 	:= 20 ns;
signal 		i_HIGHT_Encryption_rst 		 	: std_logic;
signal 		i_HIGHT_Encryption_clk		 	: std_logic;
signal 		i_HIGHT_Encryption_MasterKey  	: std_logic_vector(127 downto 0);
signal 		i_HIGHT_Encryption_PlainText  	: std_logic_vector(63 downto 0);
 -- Outputs                          	
signal 		o_HIGHT_Encryption_CipherKey  	:  std_logic_vector(63 downto 0);
signal 		o_HIGHT_Encryption_valid		: std_logic;
signal 		o_HIGHT_Encryption_ready		: std_logic;
signal 		i_HIGHT_Encryption_valid		: std_logic;
signal 		i_HIGHT_Encryption_ready		: std_logic;
begin

UUT: HIGHT_Encryption
port map(
		i_HIGHT_Encryption_rst 			=> i_HIGHT_Encryption_rst,
		i_HIGHT_Encryption_clk			=> i_HIGHT_Encryption_clk,
		i_HIGHT_Encryption_MasterKey	=> i_HIGHT_Encryption_MasterKey,
		i_HIGHT_Encryption_PlainText	=> i_HIGHT_Encryption_PlainText,
		i_HIGHT_Encryption_valid		=> i_HIGHT_Encryption_valid,
		i_HIGHT_Encryption_ready		=> i_HIGHT_Encryption_ready,
		-- Outputs                      
		o_HIGHT_Encryption_CipherKey	=> o_HIGHT_Encryption_CipherKey,
		o_HIGHT_Encryption_valid		=> o_HIGHT_Encryption_valid,
		o_HIGHT_Encryption_ready		=> o_HIGHT_Encryption_ready
);

i_clk_process :process
   begin
        i_HIGHT_Encryption_clk <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        i_HIGHT_Encryption_clk <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process i_clk_process;
      
i_HIGHT_Encryption_stimulus:process
begin
	-- TRY 1
	i_HIGHT_Encryption_valid	<= '1';
	i_HIGHT_Encryption_ready 	<= '1';
    i_HIGHT_Encryption_rst 	 		<='0';
	i_HIGHT_Encryption_MasterKey	<= x"36BC7CE94EDC677E32D83BB6F3AD985F";
	i_HIGHT_Encryption_PlainText	<= x"93E41C6E20911B9B";
	wait for 3*clk_period;
	i_HIGHT_Encryption_rst 	 	<='1';
	wait for 300 ns;
	
	wait for 10 ns;
	
	wait;
end process i_HIGHT_Encryption_stimulus;

end tb;