set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1000.0ps


current_design fsm

create_clock -name "clk" -add -period 1.0 -waveform {0.0 2.0} [get_ports clk]
set_clock_transition 0.2 [get_clocks clk]


set_max_transition 0.12 [current_design]
set_max_fanout 25 [current_design]
set_max_capacitance 0.15 [current_design]

set_clock_uncertainty -setup 0.8 [get_clocks clk]
set_clock_uncertainty -hold 0.6 [get_clocks clk]