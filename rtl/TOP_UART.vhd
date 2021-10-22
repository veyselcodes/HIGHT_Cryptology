library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.HIGHT_TOP_comps.all;

entity top is
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
btn                 : in std_logic;
-- Output
seg          		: out std_logic_vector(6 downto 0);
an           		: out std_logic_vector(3 downto 0);
tx_o	  	   		: out std_logic
);
end top;

architecture Behavioural of top is

signal Plain_Text			: std_logic_vector(63 downto 0);
signal key					: std_logic_vector(127 downto 0);
-- signal cnt_CT           	: integer := 0;
signal i_top_valid  		: std_logic;
signal i_top_ready  		: std_logic;
signal o_top_valid  		: std_logic;
signal o_top_ready  		: std_logic;
signal btn_clone      		: std_logic;

type states is (S_RECEIVE, S_PROCESS, S_TRANSMIT);
signal state : states := S_RECEIVE;

-- Counters
signal byte_cnt 	: integer := 0;
signal transmit_cnt : integer := 0;

-- Receiver Signals
signal dout_o             	: std_logic_vector(7 downto 0);
signal rx_done_tick_o  		: std_logic:= '0';
-- Transmitter Signals
signal tx_done_tick_o  		: std_logic:= '0';
signal din_i             	: std_logic_vector(7 downto 0);
signal tx_start_i  			: std_logic;

-- Buffers
signal databuffer_PT : std_logic_vector(8*8-1 downto 0) := (others => '0');
signal databuffer_MK : std_logic_vector(16*8-1 downto 0) := (others => '0');
signal databuffer_CT : std_logic_vector(8*8-1 downto 0) := (others => '0');


begin

i_uart_tx: uart_transmitter generic map(
c_clkfreq 	   => 100_000_000,
c_baudrate	   => 115_200,
c_stopbit 	   => 2
)
port map(
clk		  	   => clk		  	  ,
din_i	  	   => din_i			  ,
tx_start_i	   => tx_start_i  	  ,
tx_o	  	   => tx_o	  	      ,
tx_done_tick_o => tx_done_tick_o
);

i_uart_rx: uart_receiver
generic map(
c_clkfreq 	   => 100_000_000,
c_baudrate	   => 115_200
)
port map(
clk		  	   => clk,
rx_i		   => rx_i,
dout_o	  	   => dout_o,
rx_done_tick_o => rx_done_tick_o
);

i_HIGHT_Encryption: HIGHT_Encryption
port map(
		i_HIGHT_Encryption_rst 				=> '1',
		i_HIGHT_Encryption_clk				=> clk,
		i_HIGHT_Encryption_MasterKey		=> key,
		i_HIGHT_Encryption_PlainText		=> Plain_Text,
		i_HIGHT_Encryption_valid			=> i_top_valid,
		i_HIGHT_Encryption_ready  			=> i_top_ready,
		-- Outputs
		o_HIGHT_Encryption_CipherKey		=> databuffer_CT,
		o_HIGHT_Encryption_valid			=> o_top_valid,
		o_HIGHT_Encryption_ready			=> o_top_ready
);

P_MAIN: process(clk) begin
	if(rising_edge(clk))then
		case state is
			when S_RECEIVE =>
			
				if(rx_done_tick_o = '1')then
					if(byte_cnt <= 7)then
						databuffer_PT(7 downto 0) <= dout_o;
						databuffer_PT(8*8-1 downto 1*8)   <= databuffer_PT(7*8-1 downto 0);
					else
						databuffer_MK(7 downto 0)         <= dout_o;
						databuffer_MK(16*8-1 downto 1*8)  <= databuffer_MK(15*8-1 downto 0);
					end if;
					
					if(byte_cnt < 24)then
					   byte_cnt <= byte_cnt +1;
					else
					   byte_cnt      <= 0;
					   i_top_valid   <= '1';
					   state         <= S_PROCESS;
					   Plain_Text    <= databuffer_PT;
					   key           <= databuffer_MK;
					end if;
					
				end if;
				
			when S_PROCESS =>
				if(o_top_ready = '1')then		
					tx_start_i <= '1';	
					state <= S_TRANSMIT;
				    transmit_cnt <= 8;
				end if;
			when S_TRANSMIT =>
				
				if(transmit_cnt=0)then
					tx_start_i <= '0';
					if(tx_done_tick_o ='1')then	
						state <= S_RECEIVE;
					end if;
				else
					din_i <= databuffer_CT(transmit_cnt*8-1 downto (transmit_cnt-1)*8);
					if(tx_done_tick_o ='1')then
						transmit_cnt <= transmit_cnt -1;
					end if;
				end if;
				
			when others =>
				state <= S_RECEIVE;
		end case;
	end if;
end process;
end architecture;