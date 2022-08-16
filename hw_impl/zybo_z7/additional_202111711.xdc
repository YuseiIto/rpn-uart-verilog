set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {clk}];
create_clock -add -name sys_clk_pin -period 8.000 -waveform {0 4} [get_ports {clk}];

set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {tx_out}]; # JE1
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {rx_in}];  # JE2

