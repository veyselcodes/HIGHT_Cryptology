
Library ieee;
  use ieee.std_logic_1164.all;
  USE ieee.std_logic_unsigned.ALL;

   
package common_verif_pack is


-- data injector declaration
	
	-- component data_injector1 is

-- generic (
        -- fname_data    : string;
        -- DATA_WIDTH    : integer := 8;
	    -- IS_DEC        : boolean := false;
	    -- IS_HEX        : boolean := false;
	    -- IS_COMPLEX    : boolean := false;
	    -- DELAY         : integer := 8      -- delay as clock cycle to finish simulation (default 8cc)
        -- );            
                      
-- port    (             
        -- clk           : in  std_logic;
        -- rst_n         : in  std_logic;
        -- enable        : in  std_logic;
        -- data_out_i    : out std_logic_vector(DATA_WIDTH-1 downto 0);
        -- data_out_q    : out std_logic_vector(DATA_WIDTH-1 downto 0);
        -- valid_out     : out std_logic;
	    -- eof           : out std_logic
       -- );
	   
-- end component;
--data dumper declaration
    -- component data_dumper IS
      -- GENERIC (
       -- -- fname_ref       : string  := "fname_ref.txt";
    	-- fname_dmp       : string  := "fname_dmp.txt";
        -- DATA_WIDTH      : integer := PIX_WIDTH;
    	-- IS_BIN          : boolean := false;
    	-- IS_DEC          : boolean := false;
    	-- IS_HEX          : boolean := false;
    	-- IS_COMPLEX      : boolean := false;
    	-- COMPARE         : boolean := false
        -- );
      -- PORT (
        -- clk             : in std_logic;
        -- data_valid      : in std_logic;
        -- data_in_i       : in std_logic_vector (DATA_WIDTH-1 downto 0);
        -- data_in_q       : in std_logic_vector (DATA_WIDTH-1 downto 0);
    	-- eof             : out std_logic := '0'
        -- );
    -- END component;
	
--- dual ram declaration
   -- component dual_ram is
    -- generic(
   	 -- ADDR_WIDTH     : integer   := 10;
   	 -- DATA_WIDTH     : integer   := 32;
   	 -- MEM_INITIALIZE : std_logic := '0';
   	 -- InitFileName   : string    := "dualram_init.txt"
    -- );

    -- port(
   	 -- -- port a (read/write)
   	 -- clka  : in  std_logic;
   	 -- ena   : in  std_logic;
   	 -- wea   : in  std_logic;
   	 -- addra : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
   	 -- dia   : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
   	 -- doa   : out std_logic_vector(DATA_WIDTH - 1 downto 0);
   	 -- -- port b (read/write)
   	 -- clkb  : in  std_logic;
   	 -- enb   : in  std_logic;
   	 -- web   : in  std_logic;
   	 -- addrb : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
   	 -- dib   : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
   	 -- dob   : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    -- );
   -- end component;	
	
	
	
--end of declaration	
	
 function vec2hstr(slv: std_logic_vector) return string;
 function hstr2vec(in_string: string) return std_logic_vector;
 FUNCTION str2vec(str : string) RETURN std_logic_vector;
 FUNCTION vec2str(vec : std_logic_vector) RETURN string;
 FUNCTION std2chr(vec : std_logic) RETURN character;
 --FUNCTION str2coderate(str : string) RETURN CODERATE_TYPE;	
 
end package common_verif_pack;


PACKAGE BODY common_verif_pack IS

 -- converts a std_logic_vector into a hex string.
 function vec2hstr(slv: std_logic_vector) return string is
     variable hexlen: integer;
     variable longslv : std_logic_vector(127 downto 0) := (others => '0');
     variable hex : string(1 to 32);
     variable fourbit : std_logic_vector(3 downto 0);
   begin
     hexlen := (slv'left+1)/4;
     if (slv'left+1) mod 4 /= 0 then
       hexlen := hexlen + 1;
     end if;
     longslv(slv'left downto 0) := slv;
     for i in (hexlen -1) downto 0 loop
       fourbit := longslv(((i*4)+3) downto (i*4));
       case fourbit is
         when "0000" => hex(hexlen -I) := '0';
         when "0001" => hex(hexlen -I) := '1';
         when "0010" => hex(hexlen -I) := '2';
         when "0011" => hex(hexlen -I) := '3';
         when "0100" => hex(hexlen -I) := '4';
         when "0101" => hex(hexlen -I) := '5';
         when "0110" => hex(hexlen -I) := '6';
         when "0111" => hex(hexlen -I) := '7';
         when "1000" => hex(hexlen -I) := '8';
         when "1001" => hex(hexlen -I) := '9';
         when "1010" => hex(hexlen -I) := 'A';
         when "1011" => hex(hexlen -I) := 'B';
         when "1100" => hex(hexlen -I) := 'C';
         when "1101" => hex(hexlen -I) := 'D';
         when "1110" => hex(hexlen -I) := 'E';
         when "1111" => hex(hexlen -I) := 'F';
         when "ZZZZ" => hex(hexlen -I) := 'z';
         when "UUUU" => hex(hexlen -I) := 'u';
         when "XXXX" => hex(hexlen -I) := 'x';
         when others => hex(hexlen -I) := '?';
       end case;
     end loop;
     return hex(1 to hexlen);
   end vec2hstr;

function hstr2vec(in_string: string) return std_logic_vector is
  variable temp: std_logic_vector(4*in_string'length - 1 downto 0 ) := (others => 'X');
   begin 
    for i in 1 to in_string'length loop --in_string'range loop
     case in_string(i) is
       when '0' => temp ((4*i-1) downto 4*(i-1)) := "0000";
       when '1' => temp ((4*i-1) downto 4*(i-1)) := "0001";
       when '2' => temp ((4*i-1) downto 4*(i-1)) := "0010";
       when '3' => temp ((4*i-1) downto 4*(i-1)) := "0011";
       when '4' => temp ((4*i-1) downto 4*(i-1)) := "0100";
       when '5' => temp ((4*i-1) downto 4*(i-1)) := "0101";
       when '6' => temp ((4*i-1) downto 4*(i-1)) := "0110";
       when '7' => temp ((4*i-1) downto 4*(i-1)) := "0111";
       when '8' => temp ((4*i-1) downto 4*(i-1)) := "1000";
       when '9' => temp ((4*i-1) downto 4*(i-1)) := "1001";
       when 'A' => temp ((4*i-1) downto 4*(i-1)) := "1010";
       when 'a' => temp ((4*i-1) downto 4*(i-1)) := "1010";
       when 'B' => temp ((4*i-1) downto 4*(i-1)) := "1011";
       when 'b' => temp ((4*i-1) downto 4*(i-1)) := "1011";
       when 'C' => temp ((4*i-1) downto 4*(i-1)) := "1100";
       when 'c' => temp ((4*i-1) downto 4*(i-1)) := "1100";
       when 'D' => temp ((4*i-1) downto 4*(i-1)) := "1101";
       when 'd' => temp ((4*i-1) downto 4*(i-1)) := "1101";
       when 'E' => temp ((4*i-1) downto 4*(i-1)) := "1110";
       when 'e' => temp ((4*i-1) downto 4*(i-1)) := "1110";
       when 'F' => temp ((4*i-1) downto 4*(i-1)) := "1111";
       when 'f' => temp ((4*i-1) downto 4*(i-1)) := "1111";
       when 'Z' => temp ((4*i-1) downto 4*(i-1)) := "ZZZZ";
       when 'z' => temp ((4*i-1) downto 4*(i-1)) := "ZZZZ";
       when 'U' => temp ((4*i-1) downto 4*(i-1)) := "UUUU";
       when 'u' => temp ((4*i-1) downto 4*(i-1)) := "UUUU";
       when 'X' => temp ((4*i-1) downto 4*(i-1)) := "XXXX";
       when 'x' => temp ((4*i-1) downto 4*(i-1)) := "XXXX";
       when others =>  temp ((4*i-1) downto 4*(i-1)) := "XXXX";
     end case;
    end loop; 
   return(temp);
end hstr2vec;   

-- function to convert string of character to vector
FUNCTION str2vec(str : string) RETURN std_logic_vector IS
  VARIABLE vtmp: std_logic_vector(str'RANGE);
  BEGIN
    FOR i IN str'RANGE LOOP
      IF str(i) = '1' THEN
        vtmp(i) := '1';
      ELSIF str(i) = '0' THEN
        vtmp(i) := '0';
      ELSE
        vtmp(i) := 'X';
      END IF;
    END LOOP;
  RETURN vtmp;
END str2vec;

-- function to convert vector to string
FUNCTION vec2str(vec : std_logic_vector) RETURN string IS
  VARIABLE stmp : string(vec'LEFT+1 DOWNTO 1);
  BEGIN
    FOR i IN vec'REVERSE_RANGE LOOP
      IF vec(i) = '1' THEN
        stmp(i+1) := '1';
      ELSIF vec(i) = '0' THEN
        stmp(i+1) := '0';
      ELSE
        stmp(i+1) := 'X';
      END IF;
    END LOOP;
  RETURN stmp;
END vec2str;

-- function to convert std_logic to character
FUNCTION std2chr(vec : std_logic) RETURN character IS
  VARIABLE stmp : character;
  BEGIN
    IF vec = '1' THEN
      stmp := '1';
    ELSIF vec = '0' THEN
      stmp := '0';
    ELSE
      stmp := 'X';
    END IF;
  RETURN stmp;
END std2chr;

-- function to convert string of character to coderate type
-- FUNCTION str2coderate(str : string) RETURN CODERATE_TYPE IS
  -- VARIABLE codetmp: CODERATE_TYPE;
  -- BEGIN
	  -- if (str = "CODE_1_3") then codetmp := CODE_1_3; end if;
      -- if (str = "CODE_1_2") then codetmp := CODE_1_2; end if;
      -- if (str = "CODE_2_3") then codetmp := CODE_2_3; end if;
      -- if (str = "CODE_2_5") then codetmp := CODE_2_5; end if;
      -- if (str = "CODE_3_4") then codetmp := CODE_3_4; end if;
      -- if (str = "CODE_4_5") then codetmp := CODE_4_5; end if;
      -- if (str = "CODE_6_7") then codetmp := CODE_6_7; end if;
  -- RETURN codetmp;
-- END str2coderate;

END PACKAGE BODY common_verif_pack;



