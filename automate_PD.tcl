#import design
set vars(topCellName) "CPUtop"
set init_verilog /home/sois/Desktop/Rohith/mini_project/synthesis/outputs_Feb01-19:03:21/CPUtop_m.v
set init_lef_file { /home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/lef/gsclib045.fixed.lef }
set init_pwr_net VDD
set init_top_cell "CPUtop"
set init_gnd_net VSS
set init_mmmc_file /home/sois/Desktop/Rohith/mini_project/mmmc.tcl
init_design

#################################################
#can add the mmmc.tcl file here#

#########creating_floorplan##################

floorPlan -b { 0 0 200 200 10 10 190 190 20 20 180 180 }
###specifies the core ,IO block and die area

##########add_rings#########

addRing -nets { VDD VSS } -type core_rings -width_bottom 2 -width_top 2 -width_left 2 -width_right 2 -spacing 2 -offset 2 \
-layer {top Metal7 bottom Metal7 left Metal6 right Metal6}

##########add_stripes##########

addStripe -nets { VDD VSS } -layer Metal6 -direction vertical -width 2 \
-spacing 2 -set_to_set_distance 20 -number_of_sets 8 -start_offset 20

########add_power_rails##########

setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } \
-layerChangeRange { Metal1(1) Metal9(9) } -blockPinTarget { nearestTarget } \
-padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } \
-corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } \
-allowJogging 1 -crossoverViaLayerRange { Metal1(1) Metal9(9) } -nets { VDD VSS } \
-allowLayerChange 1 -blockPin useLef -targetViaLayerRange { Metal1(1) Metal9(9) }

#########pin_placement#############

assignIoPins

###alternate_command_for_pin_placement##

editPin -start {0 25} -spreadType START -spreadDirection clockwise -pin [dbGet [dbGet \
-p1 top.terms.isInput  1].name] -layer Metal5 -spacing 10

editPin -start {123 200} -spreadType START -spreadDirection clockwise -pin [dbGet [dbGet \
-p1 top.terms.isOutput 1].name] -layer Metal5 -spacing 10

#########placement#####

place_opt_design
saveDesign preCTS.enc -tcon -compress -def

########cts########

ccopt_design -cts
optDesign -postCTS -incr
saveDesign postCTS.enc -tcon -compress -def

#########route_design########

routeDesign
saveDesign postRoute.enc -tcon -compress -def
optDesign -postRoute -incr
verify_drc -limit 99999
ecoRoute -fix_drc
saveDesign postRoute.enc -tcon -compress -def

#########GDSII###########

streamOut route.gds -mapFile /home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/qx/mapFile
