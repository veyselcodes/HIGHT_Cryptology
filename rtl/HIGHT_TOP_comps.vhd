library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.numeric_std.all;

package HIGHT_TOP_comps is
-- Components

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
		o_HIGHT_Encryption_ready			: out std_logic
);
end component;

component uart_transmitter is
generic(
c_clkfreq 	   : integer := 100_000_000;
c_baudrate	   : integer := 115_200;
c_stopbit 	   : integer := 2
);
port (
clk		  	   : in std_logic;
din_i	  	   : in std_logic_vector(7 downto 0);
tx_start_i	   : in std_logic;
tx_o	  	   : out std_logic;
tx_done_tick_o : out std_logic
);
end component;

component uart_receiver is
generic(
c_clkfreq 	   : integer := 100_000_000;
c_baudrate	   : integer := 115_200
);
port (
clk		  	   : in std_logic;
rx_i		   : in std_logic;
dout_o	  	   : out std_logic_vector(7 downto 0);
rx_done_tick_o : out std_logic
);
end component;

end package;