library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.types_pkg.all;
-- decode instruction and read val from registers
---
---
entity decode_stage is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           instruction : in STD_LOGIC_VECTOR (31 downto 0);
           reg_data1 : out STD_LOGIC_VECTOR (31 downto 0);
           reg_data2 : out STD_LOGIC_VECTOR (31 downto 0);
           rd : out STD_LOGIC_VECTOR (4 downto 0));
end decode_stage;

architecture Behavioral of decode_stage is
-- making the registers (32 of them)
    signal register_file : reg_type;

begin
--sensitive to incoming instruction
    process(instruction)
    begin
    -- get register number
        reg_data1 <= register_file(to_integer(unsigned(instruction(19 downto 15))));
        reg_data2 <= register_file(to_integer(unsigned(instruction(24 downto 20))));
    --destination regiter 
        rd <= instruction(11 downto 7);
    end process;
end Behavioral;
