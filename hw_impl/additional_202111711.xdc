set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {clk}];
create_clock -add -name sys_clk_pin -period 8.000 -waveform {0 4} [get_ports {clk}];

set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {tx_out}]; # JE1
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {rx_in}];  # JE2
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {je3}];  # JE3
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {je4}];  # JE4
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {je7}];  # JE7
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {je8}];  # JE8


set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {ld[0]}];  #LD0
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {ld[1]}];  #LD1
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {ld[2]}];  #LD2
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {ld[3]}];  #LD1


