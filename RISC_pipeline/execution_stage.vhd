library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
---  ALU arithmetic and logic operations
---

entity execution_stage is
    Port ( reg_data1 : in STD_LOGIC_VECTOR (31 downto 0);
           reg_data2 : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_control : in STD_LOGIC_VECTOR (3 downto 0);
           ALU_result : out STD_LOGIC_VECTOR (31 downto 0));
end execution_stage;

architecture Behavioral of execution_stage is

begin
    process(reg_data1, reg_data2, ALU_control)
    begin
        case ALU_control is 
        --addition
            when "0000" =>
             ALU_result <= std_logic_vector(signed(reg_data1) + signed(reg_data2));
        --subtraction
            when "0001" =>
             ALU_result <= std_logic_vector(signed(reg_data1) - signed(reg_data2));
        --multiply
        when "0010" => 
        ALU_result <= std_logic_vector(signed(reg_data1) * signed(reg_data2));
        --division
        when "0011" => 
        ALU_result <= std_logic_vector(signed(reg_data1) / signed(reg_data2));
        --increment by 1
        when "0100" =>
        ALU_result <= std_logic_vector(signed(reg_data1) + 1);
       --decrement by 1 
        ALU_result <= std_logic_vector(signed(reg_data1) - 1);
        --AND
        when "0101" =>
        ALU_result <= reg_data1 and reg_data2;
        --OR
        when "0110" =>
        ALU_result <= reg_data1 or reg_data2;
        --XOR
        when "0111" => 
        ALU_result <= reg_data1 xor reg_data2; 
        
        --not an arithmetic we support
        when others => ALU_result <= (others => '0');   
      end case;
   end process;
end Behavioral;
