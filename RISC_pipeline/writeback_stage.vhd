library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.types_pkg.all;

---write computation results back to register

entity writeback_stage is
    Port ( clk : in STD_LOGIC;
           reg_write : in STD_LOGIC;
           write_data : in STD_LOGIC_VECTOR (31 downto 0);
           rd : in STD_LOGIC_VECTOR (4 downto 0);
           register_file : inout reg_type);
end writeback_stage;

architecture Behavioral of writeback_stage is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reg_write = '1' then
                register_file(to_integer(unsigned(rd))) <= write_data;
             end if;
          end if;
       end process;
end Behavioral;
