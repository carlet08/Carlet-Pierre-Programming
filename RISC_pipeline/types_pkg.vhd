-- File: types_pkg.vhd
library ieee;
use ieee.std_logic_1164.all;

package types_pkg is
    -- Define reg_type
      type reg_type is array (0 to 31) of std_logic_vector(31 downto 0);
end package types_pkg;
