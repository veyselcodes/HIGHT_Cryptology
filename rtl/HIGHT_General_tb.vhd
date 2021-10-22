library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity HIGHT_General_tb is
end HIGHT_General_tb;

architecture behavioral of HIGHT_General_tb is

 component data_dumper
    GENERIC (
    	fname_dmp       : string  := "default.txt";
    	DATA_WIDTH   	: integer := 32;
    	IS_BIN          : boolean := false;
    	IS_DEC          : boolean := false;
    	IS_HEX          : boolean := false
    );
    PORT (
  		clk             : in  std_logic;
  		data_valid      : in  std_logic;
  		data_in_i       : in  std_logic_vector (DATA_WIDTH-1 downto 0)
    );
  end component;
  
 component data_injector
    generic (
      fname_data    	: string;
      DATA_WIDTH    	: integer := 32;
    	IS_DEC        	: boolean := false;
    	IS_HEX        	: boolean := false;
    	IS_COMPLEX    	: boolean := false;
    	DELAY         	: integer := 5    -- delay as clock cycle to finish simulation (default 8cc)
    );
    port(
      clk           : in  std_logic;
      rst_n         : in  std_logic;
      enable        : in  std_logic;
      data_out_i    : out std_logic_vector(DATA_WIDTH-1 downto 0);
      data_out_q    : out std_logic_vector(DATA_WIDTH-1 downto 0);
      valid_out     : out std_logic;
  	  eof           : out std_logic
    );
  end component;
  
  component HIGHT_Encryption	is
port(
		i_HIGHT_Encryption_rst 				: in std_logic;
		i_HIGHT_Encryption_clk				: in std_logic;
		i_HIGHT_Encryption_MasterKey		: in std_logic_vector(127 downto 0);
		i_HIGHT_Encryption_PlainText		: in std_logic_vector(63 downto 0);
		i_HIGHT_Encryption_valid				: in std_logic;
		i_HIGHT_Encryption_ready  			: in std_logic;
		-- Outputs
		o_HIGHT_Encryption_CipherKey		: out std_logic_vector(63 downto 0);
		o_HIGHT_Encryption_valid				: out std_logic;
		o_HIGHT_Encryption_ready				: out std_logic
);
end component;

-- Signals
signal clk 				: std_logic:='1';
signal en				: std_logic;
signal rst				: std_logic;
signal eof1				: std_logic;
signal eof2				: std_logic;
signal inj_valid_out 	: std_logic;
signal HIGHT_valid_out  : std_logic;
signal write_valid		: std_logic;
signal PlainText 		: std_logic_vector(63 downto 0);
signal MasterKey 		: std_logic_vector(127 downto 0);
signal Cipher 			: std_logic_vector(63 downto 0);

begin

UUT: HIGHT_Encryption
port map(
		i_HIGHT_Encryption_rst 				=> rst,
		i_HIGHT_Encryption_clk				=> clk,
		i_HIGHT_Encryption_MasterKey		=> MasterKey,
		i_HIGHT_Encryption_PlainText		=> PlainText,
		i_HIGHT_Encryption_valid			=> inj_valid_out,
		i_HIGHT_Encryption_ready  			=> '1',
		-- Outputs                          
		o_HIGHT_Encryption_CipherKey		=> Cipher,
		o_HIGHT_Encryption_valid			=> HIGHT_valid_out,
		o_HIGHT_Encryption_ready			=> en
);

i_injector_Key: data_injector
generic map(
fname_data  => "../verif/Random_Master_Texts.txt",
DATA_WIDTH => 128,
IS_HEX     => true
)
port map(
clk      	=> clk,
rst_n     	=> rst,
enable    	=> en,
data_out_i	=> MasterKey,
valid_out 	=> inj_valid_out,
eof       	=> eof1
);

i_injector_Cipher: data_injector
generic map(
fname_data  => "../verif/Random_Plain_Texts.txt",
DATA_WIDTH => 64,
IS_HEX     => true
)
port map(
clk      	=> clk,
rst_n     	=> rst,
enable    	=> en,
data_out_i	=> PlainText,
valid_out 	=> inj_valid_out,
eof       	=> eof2
);

write_valid <=  HIGHT_valid_out; --((not eof1 and not eof2) and

i_dumper: data_dumper
generic map(
fname_dmp => "../verif/VHDL_Results.txt",
DATA_WIDTH => 64,
IS_HEX     => true
)
port map(
clk      	=> clk,
data_in_i	=> Cipher,
data_valid 	=> write_valid
);

--clock stimulus
 clk_process: process
	begin
	clk <= '1';
	wait for 10 ns;
	clk <= '0';
	wait for 10 ns;
 end process;
 
 process
begin
rst<='0';
wait for 30 ns;
rst <='1';
wait;
end process;

END behavioral;