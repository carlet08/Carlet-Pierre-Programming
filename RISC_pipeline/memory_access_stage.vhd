library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
---  access data mem to load and store instructions
--- Load -> read data from mem
-- store -> write data to mem

entity memory_access_stage is
    Port ( clk : in STD_LOGIC;
           mem_read : in STD_LOGIC;
           mem_write : in STD_LOGIC;
           ALU_result : in STD_LOGIC_VECTOR (31 downto 0);
           write_data : in STD_LOGIC_VECTOR (31 downto 0);
           read_data : out STD_LOGIC_VECTOR (31 downto 0));
end memory_access_stage;

architecture Behavioral of memory_access_stage is
    type memory_type is array (0 to 255) of std_logic_vector(31 downto 0);
    signal data_memory : memory_type;
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if mem_write = '1' then 
            --extract mem adress 4 byte word
            --data is written to mem loc
                data_memory(to_integer(unsigned(ALU_result(31 downto 2)))) <= write_data;
             end if;
           end if;
        end process;
    
     process(mem_read, ALU_result)
     begin
        if mem_read = '1' then
        --read data from mem loc
            read_data <= data_memory(to_integer(unsigned(ALU_result(31 downto 2))));
        else 
            read_data <= (others => '0');
        end if;
       end process;       
end Behavioral;
