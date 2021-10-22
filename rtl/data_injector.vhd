-- =====================================================================================
-- (C) COPYRIGHT 2016 YongaTek (Yonga Technology Microelectronics)
-- All rights reserved.
-- This file contains confidential and proprietary information of YongaTek and
-- is protected under international copyright and other intellectual property laws.
-- =====================================================================================
-- Project           : H264
-- File ID           : %%
-- Design Unit Name  : data_injector.vhd
-- Description       : Injects data to RTL
-- Comments          :
-- Revision          : %%
-- Last Changed Date : %%
-- Last Changed By   : %%
-- Designer
--          Name     : Rifat DEMIRCIOGLU
--          E-mail   : rifat.demircioglu@yongatek.com
-- =====================================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;

LIBRARY modelsim_lib;
USE modelsim_lib.util.ALl;
USE std.textio.ALL;
library work;
use work.common_verif_pack.all;

library std;
use std.textio.all;

entity data_injector is
  generic (
        fname_data    : string;
        DATA_WIDTH    : integer := 64;
  	    IS_DEC        : boolean := false;
  	    IS_HEX        : boolean := false;
  	    IS_COMPLEX    : boolean := false;
  	    DELAY         : integer := 200      -- delay as clock cycle to finish simulation (default 8cc)
  );

port    (
        clk           : in  std_logic;
        rst_n         : in  std_logic;
        enable        : in  std_logic;
        data_out_i    : out std_logic_vector(DATA_WIDTH-1 downto 0);
        data_out_q    : out std_logic_vector(DATA_WIDTH-1 downto 0);
        valid_out     : out std_logic;
	    eof           : out std_logic
       );

end data_injector;

architecture behavioral of data_injector is

file   ftype_ref        : TEXT open READ_MODE is fname_data;

BEGIN

 process(clk, rst_n)
  variable hstr_data   : string(DATA_WIDTH/4 downto 1);
  variable str_data    : string(DATA_WIDTH downto 1);
  variable my_dec_val  : integer;
  variable line_ref    : line;
  begin
      if rst_n = '0' then
        data_out_i    <= (others => '0');
        data_out_q    <= (others => '0');
        valid_out     <= '0';
      elsif(clk'event and  clk ='1') then
        valid_out    <= '0';
        if(not endfile(ftype_ref)) and enable = '1' then
          valid_out   <= '1';
          readline(ftype_ref, line_ref);
          if (IS_HEX = true) then
            read(line_ref,hstr_data);
            data_out_i <= hstr2vec(hstr_data)(DATA_WIDTH-1 downto 0);
          elsif (IS_DEC = true) then
            read(line_ref,my_dec_val);
            data_out_i <= conv_std_logic_vector(my_dec_val, DATA_WIDTH);
          else
            read(line_ref,str_data);
            data_out_i <= str2vec(str_data);
          end if;
          if (IS_COMPLEX = true) then
            if (IS_HEX = true) then
              read(line_ref,hstr_data);
              data_out_q <= hstr2vec(hstr_data)(DATA_WIDTH-1 downto 0);
            elsif (IS_DEC = true) then
              read(line_ref,my_dec_val);
              data_out_q <= conv_std_logic_vector(my_dec_val, DATA_WIDTH);
            else
              read(line_ref,str_data);
              data_out_q <= str2vec(str_data);
            end if;
          end if;
        end if;

     end if;
  end process;

 process(clk, rst_n)
  variable counter  : integer;
  variable count_start: integer;
 begin

    if rst_n = '0' then
	  eof           <= '0';
	  count_start := 0;
	  counter       := 0;
    elsif(clk'event and  clk ='1') then
	  if (endfile(ftype_ref)) then
	    count_start := 1;
	  end if;

	  if (count_start = 1) then
	    counter := counter + 1;  -- guard counter to provide time for dumpers to dump the last data
	  end if;

	  if (counter = DELAY) then
	    eof <= '1';
	  end if;
    end if;

  end process;

END behavioral;
