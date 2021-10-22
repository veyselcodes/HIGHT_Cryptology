library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity HIGHT2Board is
port(
		clk 	     		: in std_logic;
		number	     		: in std_logic_vector(3 downto 0);
		key          		: in std_logic_vector(127 downto 0);
		cipher       		: in std_logic_vector(63 downto 0);
		key_or_cipher		: in std_logic;
		i_HIGHT2Board_valid : in std_logic; 
		i_HIGHT2Board_ready : in std_logic;
		-- Output
		seg          		: out std_logic_vector(6 downto 0);
	    an           		: out std_logic_vector(3 downto 0);
	    CT           		: out std_logic_vector(63 downto 0);
		o_HIGHT2Board_valid : out std_logic;
		o_HIGHT2Board_ready : out std_logic
);
end HIGHT2Board;



architecture behavioral of HIGHT2Board is

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

TYPE matrix_index is array (15 downto 0) of std_logic_vector(7 downto 0); 
signal encrypt: matrix_index;

signal segm                 : std_logic_vector(3 downto 0);
signal segmx                : std_logic_vector(4 downto 0);
signal clkm		            : std_logic;
signal cnt		            : std_logic_vector(23 downto 0);
signal seg_temp             : std_logic_vector(6 downto 0);
signal led_activating_cnt   : std_logic_vector(1 downto 0);
signal key_encrypt          : std_logic_vector(63 downto 0);
signal result               : std_logic_vector(63 downto 0);
signal PT                   : std_logic_vector(63 downto 0);
signal MK                   : std_logic_vector(127 downto 0);
begin


	
i_HIGHT_Encryption: HIGHT_Encryption
port map(
		i_HIGHT_Encryption_rst 				=> '1',
		i_HIGHT_Encryption_clk				=> clk,
		i_HIGHT_Encryption_MasterKey		=> key,
		i_HIGHT_Encryption_PlainText		=> cipher,
		i_HIGHT_Encryption_valid			=> i_HIGHT2Board_valid,
		i_HIGHT_Encryption_ready  			=> i_HIGHT2Board_ready,
		-- Outputs
		o_HIGHT_Encryption_CipherKey		=> key_encrypt,
		o_HIGHT_Encryption_valid			=> o_HIGHT2Board_valid,
		o_HIGHT_Encryption_ready			=> o_HIGHT2Board_ready
);	
	


process(clk)is
begin
	if(rising_edge(clk))then
		cnt<= cnt + "000000000000000000000001";
	end if;
end process;
led_activating_cnt <=cnt(19 downto 18);

-------------------
result <= key_encrypt;

process(segm)is
begin 
	case segm is 
		when "0000" =>	seg_temp <="0111111";--0
		when "0001" =>	seg_temp <="0000110";--1
		when "0010" =>	seg_temp <="1011011";--2
		when "0011" =>	seg_temp <="1001111";--3
		when "0100" =>	seg_temp <="1100110";--4
		when "0101" =>	seg_temp <="1101101";--5
		when "0110" =>	seg_temp <="1111101";--6	
		when "0111" =>	seg_temp <="0000111";--7
		when "1000" =>	seg_temp <="1111111";--8
		when "1001" => 	seg_temp <="1101111";--9
		when "1010" => 	seg_temp <="1110111";--A
		when "1011" => 	seg_temp <="1111100";--B
		when "1100" => 	seg_temp <="0111001";--C
		when "1101" => 	seg_temp <="1011110";--D
		when "1110" => 	seg_temp <="1111001";--E
		when "1111" => 	seg_temp <="1110001";--F
		when others =>  seg_temp <="0000000";
	end case;
end process;
seg <= not seg_temp;

process(led_activating_cnt) is
begin
    case led_activating_cnt is
    when "00" =>
        an <= "1101";
        if(key_or_cipher = '1')then
            segm <= cipher((8*to_integer(unsigned(number+1)))-1 downto (8*to_integer(unsigned(number+1)))-1-3);
        else
            segm <= key((8*(to_integer(unsigned(number))+1))-1 downto ((8*(to_integer(unsigned(number))+1))-1-3));
        end if;
    when "01" =>
        an <= "1110";
        if(key_or_cipher = '1')then
            segm <= cipher((8*to_integer(unsigned(number+1))-1-4) downto ((8*to_integer(unsigned(number+1)))-1-7));
        else
            segm <= key((8*(to_integer(unsigned(number)+1)))-1-4 downto ((8*(to_integer(unsigned(number)+1)))-1-7));
        end if;
    when "11" =>
        an <= "0111";
        segm <= number;
    when others =>
        an <= "1101";
        if(key_or_cipher = '1')then
            segm <= cipher((8*to_integer(unsigned(number+1)))-1 downto (8*to_integer(unsigned(number+1)))-1-3);
        else
            segm <= key((8*(to_integer(unsigned(number))+1))-1 downto ((8*(to_integer(unsigned(number))+1))-1-3));
        end if;
    end case; 
end process;
CT <= key_encrypt;
end architecture;