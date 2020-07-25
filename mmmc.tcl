#################mmmc_file_which_defines_multiple corners_for_the_design#####################

#################best_case###################

create_rc_corner -name best -preRoute_res {1.0} -preRoute_cap {1.0} -preRoute_clkres {0.0} -preRoute_clkcap {0.0} -postRoute_res {1.0}\
-postRoute_cap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} -qx_tech_file {/home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/qx/qrcTechFile}

create_op_cond -name best -library_file {/home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/lib/min/fast.lib} -P (1) -V (1.2) -T (-40)
create_library_set -name best -timing {/home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/lib/min/fast.lib}
create_constraint_mode -name func_sdc -sdc_files {/home/sois/Desktop/Rohith/mini_project/synthesis/feb17_gui_pd/outputs_Feb18-00:20:39/CPUtop_m.sdc}
create_delay_corner -name best -library_set best -rc_corner best

#################worst_case#################

create_rc_corner -name worst -preRoute_res {1.1} -preRoute_cap {1.1} -preRoute_clkres {1.1} -preRoute_clkcap {1.1}\
-postRoute_res {1.1} -postRoute_cap {1.1} -postRoute_clkres {1.1} -postRoute_clkcap {1.1}\
-qx_tech_file {/home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/qx/qrcTechFile}

create_op_cond -name worst -library_file {/home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/lib/max/slow.lib} -P (1) -V (0.9) -T (125)
create_library_set -name worst -timing {/home/sois/Desktop/Rohith/RAK_18.1_blockImplementation/LIBS/lib/max/slow.lib}
create_constraint_mode -name func_sdc -sdc_files {/home/sois/Desktop/Rohith/mini_project/synthesis/feb17_gui_pd/outputs_Feb18-00:20:39/CPUtop_m.sdc}
create_delay_corner -name worst -library_set worst -rc_corner worst

###############creating_analysis_view_for_setup_hold#############

create_analysis_view -name best_hold -constraint_mode func_sdc -delay_corner best
create_analysis_view -name worst_setup -constraint_mode func_sdc -delay_corner worst

set_analysis_view -hold best_hold -setup worst_setup

