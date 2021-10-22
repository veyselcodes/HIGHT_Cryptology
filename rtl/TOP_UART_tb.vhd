library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity TOP_UART_tb	is
--
end TOP_UART_tb;

architecture tb of TOP_UART_tb is

component top is
generic(
c_clkfreq 	   : integer := 100_000_000;
c_baudrate	   : integer := 115_200;
c_stopbit 	   : integer := 2
);
port (
clk 	     		: in std_logic;
number	     		: in std_logic_vector(3 downto 0);
key_or_cipher		: in std_logic;
rx_i		   		: in std_logic;
-- Output
seg          		: out std_logic_vector(6 downto 0);
an           		: out std_logic_vector(3 downto 0);
CT           		: out std_logic_vector(63 downto 0);
o_top_valid 		: out std_logic;
o_top_ready 		: out std_logic;
tx_o	  	   		: out std_logic;
tx_done_tick_o 		: out std_logic;
rx_done_tick_o 		: out std_logic;
done           		: out std_logic;
LED            		: out std_logic_vector(7 downto 0)
);
end component;

constant   clk_period : time := 20 ns;
signal clk 	     	  :  std_logic;
signal number	      :  std_logic_vector(3 downto 0);	
signal key_or_cipher  :  std_logic;		
signal tx_start_i	  :  std_logic;  	
signal rx_i		   	  :  std_logic;
 -- Output      
signal seg            :   std_logic_vector(6 downto 0);	
signal an             :   std_logic_vector(3 downto 0);	
signal CT             :   std_logic_vector(63 downto 0);	
signal o_top_valid 	  :   std_logic;
signal o_top_ready 	  :   std_logic;
signal tx_o	  	   	  :   std_logic;
signal tx_done_tick_o :   std_logic;		
signal rx_done_tick_o :   std_logic;	
signal done           :   std_logic;	
signal LED            :   std_logic_vector(7 downto 0);


begin



UUT:  top
generic map(
c_clkfreq 	   => 100_000_000,
c_baudrate	   => 115_200,
c_stopbit 	   => 2
)
port map(
clk 	     		=> clk 	     	,
number	     		=> number	    ,	
key_or_cipher		=> key_or_cipher,	
rx_i		   		=> rx_i		   	,
-- Output          
seg          		=> seg          	,
an           		=> an           	,
CT           		=> CT           	,
o_top_valid 		=> o_top_valid 	    ,
o_top_ready 		=> o_top_ready 	    ,
tx_o	  	   		=> tx_o	  	        ,
tx_done_tick_o 		=> tx_done_tick_o   ,
rx_done_tick_o 		=> rx_done_tick_o   ,
done           		=> done             ,
LED            		=> LED            
);

i_clk_process :process
begin
	clk <= '0';
	wait for clk_period/2;  --for 0.5 ns signal is '0'.
	clk <= '1';
	wait for clk_period/2;  --for next 0.5 ns signal is '1'.
end process;
   
    
i_TOP_UART_stimulus:process
begin
	-- TRY 1
	key_or_cipher <= '0';
	wait for 40 ns;
	key_or_cipher <= '1';
	wait;

end process i_TOP_UART_stimulus;
	
end tb;
   