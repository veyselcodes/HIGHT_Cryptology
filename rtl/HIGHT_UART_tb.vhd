library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity HIGHT_UART_tb is
end HIGHT_UART_tb;

architecture behavioral of HIGHT_UART_tb is

component top is
generic(
c_clkfreq 	   : integer := 100_000_000;
c_baudrate	   : integer := 115_200;
c_stopbit 	   : integer := 2
);
port (
clk		  	   : in std_logic;
key_or_cipher  : in std_logic;
rx_i	  	   : in std_logic;
number	       : in std_logic_vector(3 downto 0);
tx_o		   : out std_logic;
seg            : out std_logic_vector(6 downto 0);
an             : out std_logic_vector(3 downto 0)
);
end component;

constant 	clk_period  	:  time := 20 ns;
signal 		clk		  	 	:  std_logic;
signal 		key_or_cipher	:  std_logic;
signal 		rx_i	  	 	:  std_logic;
signal 		number	     	:  std_logic_vector(3 downto 0);
signal 		tx_o		 	:  std_logic;
signal 		seg          	:  std_logic_vector(6 downto 0);
signal 		an           	:  std_logic_vector(3 downto 0);


begin

UUT: top 
generic map(
c_clkfreq 	   => 100_000_000,
c_baudrate	   => 115_200,
c_stopbit 	   => 2
)
port map(
clk		  	   => clk		  	 ,
key_or_cipher  => key_or_cipher  ,
rx_i	  	   => rx_i	  	     ,
number	       => number	     ,
tx_o		   => tx_o		     ,
seg            => seg            ,
an             => an           
);

--clock stimulus
 i_clk_process: process
begin
	clk <= '0';
	wait for clk_period/2;  --for 0.5 ns signal is '0'.
	clk <= '1';
	wait for clk_period/2;  --for next 0.5 ns signal is '1'.
 end process;

 process
begin

tx_o <= x"AA";
wait for 20 ns;
-- tx_o <= x"BB";
-- wait for 20 ns;
-- tx_o <= x"CC";
-- number <= x"F";
-- key_or_cipher <= '1';
wait;
end process;


END behavioral;