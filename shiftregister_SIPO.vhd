library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

entity shift_registers_sipo is
    port(CLK: in std_logic;
				clr_counter : in std_logic;
				nv : in std_logic_vector(n-1 downto 0);
				Si : in std_logic_vector(n-1 downto 0);
				Si2 : in std_logic_vector(n-1 downto 0);
				SO : out array3;
				complete : out std_logic);
end shift_registers_sipo;

architecture archi of shift_registers_sipo is
component registerN is
	port(d : in std_logic_vector(n-1 downto 0);
		  load : in std_logic;
		   clk : in std_logic;
			clr : in std_logic;
			q : out std_logic_vector(n-1 downto 0));
end component;

    signal tmp: array3;
	 signal in_times :integer range 0 to 323;
	 signal t1, t2 : std_logic_vector(n-1 downto 0);
begin
    process (CLK)
    begin
        if (CLK'event and CLK='1') then
				in_times <= in_times +1;
				if in_times = 322 then
					complete <= '1';
				elsif in_times = 323 then
					complete <= '0';
				end if;
            if clr_counter = '1' then 
					in_times <= 0;
				end if;
				-- SHIFT REGISTER SIPO
				for i in 322 downto 0  loop
					 tmp(2*i+1) <= tmp(2*i+3);
                tmp(2*i) <= tmp(2*i+2);
            end loop;
            tmp(646) <= std_logic_vector(signed(t1) / signed(nv));
				t1 <= std_logic_vector(signed(Si) + signed(SI)); 
				tmp(647) <= std_logic_vector(signed(t2) / signed(nv));
				t2 <= std_logic_vector(signed(SI2)+signed(SI2));
		  end if;
    end process;
--	 out1: registerN port map (d => tmp, clk => clk, clr => clr, load =>load, q => so);
    SO <= tmp;
end archi;