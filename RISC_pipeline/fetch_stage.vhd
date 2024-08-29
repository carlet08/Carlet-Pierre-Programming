library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- fetching instruction from mem' using the program counter
---create PC increments each cycle
---instrution memory as an array
---fetch instruction based on PC value

entity instruction_fetch_stage is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           PC_in : in STD_LOGIC_VECTOR (31 downto 0);
           instruction : out STD_LOGIC_VECTOR (31 downto 0));
end instruction_fetch_stage;

architecture Behavioral of instruction_fetch_stage is
   --memory module 
    type memory_type is array (0 to 255) of std_logic_vector(31 downto 0);
    signal instruction_memory : memory_type;
    signal PC_out : std_logic_vector(31 downto 0);
begin
    process(clk, rst)
    begin
    if rst = '1' then
        PC_out <= (others => '0'); --reset program counter
    elsif rising_edge(clk) then
    PC_out <= std_logic_vector(unsigned(PC_in) + 4); -- 4 byte instruction
    instruction <= instruction_memory(to_integer(unsigned(PC_in(31 downto 0))));
    end if;
    end process;
end Behavioral;

---create PC increments each cycle
---instrution memory as an array
---fetch instruction based on PC value
