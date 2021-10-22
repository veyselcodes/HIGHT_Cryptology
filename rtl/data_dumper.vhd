-- =====================================================================================
-- (C) COPYRIGHT 2020 YongaTek (Yonga Technology Microelectronics)
-- All rights reserved.
-- This file contains confidential and proprietary information of YongaTek and
-- is protected under international copyright and other intellectual property laws.
-- =====================================================================================
-- Project           : H264
-- File ID           : %%
-- Design Unit Name  : data_dumper.vhd
-- Description       : Dumps data from RTL
-- Comments          :
-- Revision          : %%
-- Last Changed Date : %%
-- Last Changed By   : %%
-- Designer
--          Name     : Buğra Tufan
--          E-mail   : bugra.tufan@yongatek.com
-- =====================================================================================
LIBRARY std;
USE std.env.ALL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
LIBRARY modelsim_lib;
USE modelsim_lib.util.ALl;
USE std.textio.ALL;
library work;
use work.common_verif_pack.ALL;

ENTITY data_dumper IS
  GENERIC (
  	fname_dmp       : string  := "default.txt";
  	DATA_WIDTH   		: integer := 64;
  	IS_BIN          : boolean := false;
  	IS_DEC          : boolean := false;
  	IS_HEX          : boolean := false
  );
  PORT (
		clk             : in  std_logic;
		data_valid      : in  std_logic;
		data_in_i       : in  std_logic_vector (DATA_WIDTH-1 downto 0)
  );
END data_dumper;

ARCHITECTURE behaviour OF data_dumper IS
  file   ftype_dmp       : text open WRITE_MODE is fname_dmp;
BEGIN
  dump_process: process(clk)
    variable line_dumped   : line;

  begin
    if(clk'event and  clk = '1') then
      if(data_valid = '1' ) then
    	  if (IS_HEX = true) then
            write(line_dumped,vec2hstr(data_in_i));
            writeline(ftype_dmp,line_dumped);
    	  elsif (IS_BIN = true) then
            FOR i in 0 TO DATA_WIDTH-1 LOOP
              write(line_dumped,std2chr(data_in_i(i)));
            END LOOP;
    		    writeline(ftype_dmp,line_dumped);
    	  elsif (IS_DEC = true) then
            write(line_dumped,conv_integer(signed(data_in_i)));
            writeline(ftype_dmp,line_dumped);
    	  else
    	    write(line_dumped,vec2str(data_in_i));
          writeline(ftype_dmp,line_dumped);
    	  end if;
      end if;  --if(data_valid = '1' )
    end if;
  end process;

END behaviour;
