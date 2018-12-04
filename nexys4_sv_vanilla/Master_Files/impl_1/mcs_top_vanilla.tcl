proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}


start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a100tcsg324-1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.cache/wt [current_project]
  set_property parent.project_path H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.xpr [current_project]
  set_property ip_output_repo H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  add_files -quiet H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/Master_Files/synth_1/mcs_top_vanilla.dcp
  read_ip -quiet H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.srcs/sources_1/ip/cpu/cpu.xci
  set_property is_locked true [get_files H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.srcs/sources_1/ip/cpu/cpu.xci]
  add_files H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.srcs/sources_1/imports/code_listing_sv/build/elf/vanilla_test.elf
  set_property SCOPED_TO_REF cpu [get_files -all H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.srcs/sources_1/imports/code_listing_sv/build/elf/vanilla_test.elf]
  set_property SCOPED_TO_CELLS U0/microblaze_I [get_files -all H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.srcs/sources_1/imports/code_listing_sv/build/elf/vanilla_test.elf]
  read_xdc H:/SoC_Labs/sseg_soc/nexys4_sv_vanilla/nexys4_sv_vanilla.srcs/constrs_1/imports/constraint/Nexys4_DDR_chu.xdc
  link_design -top mcs_top_vanilla -part xc7a100tcsg324-1
  write_hwdef -force -file mcs_top_vanilla.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force mcs_top_vanilla_opt.dcp
  catch { report_drc -file mcs_top_vanilla_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force mcs_top_vanilla_placed.dcp
  catch { report_io -file mcs_top_vanilla_io_placed.rpt }
  catch { report_utilization -file mcs_top_vanilla_utilization_placed.rpt -pb mcs_top_vanilla_utilization_placed.pb }
  catch { report_control_sets -verbose -file mcs_top_vanilla_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force mcs_top_vanilla_routed.dcp
  catch { report_drc -file mcs_top_vanilla_drc_routed.rpt -pb mcs_top_vanilla_drc_routed.pb -rpx mcs_top_vanilla_drc_routed.rpx }
  catch { report_methodology -file mcs_top_vanilla_methodology_drc_routed.rpt -rpx mcs_top_vanilla_methodology_drc_routed.rpx }
  catch { report_power -file mcs_top_vanilla_power_routed.rpt -pb mcs_top_vanilla_power_summary_routed.pb -rpx mcs_top_vanilla_power_routed.rpx }
  catch { report_route_status -file mcs_top_vanilla_route_status.rpt -pb mcs_top_vanilla_route_status.pb }
  catch { report_clock_utilization -file mcs_top_vanilla_clock_utilization_routed.rpt }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file mcs_top_vanilla_timing_summary_routed.rpt -rpx mcs_top_vanilla_timing_summary_routed.rpx }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force mcs_top_vanilla_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  catch { write_mem_info -force mcs_top_vanilla.mmi }
  catch { write_bmm -force mcs_top_vanilla_bd.bmm }
  write_bitstream -force mcs_top_vanilla.bit 
  catch { write_sysdef -hwdef mcs_top_vanilla.hwdef -bitfile mcs_top_vanilla.bit -meminfo mcs_top_vanilla.mmi -file mcs_top_vanilla.sysdef }
  catch {write_debug_probes -no_partial_ltxfile -quiet -force debug_nets}
  catch {file copy -force debug_nets.ltx mcs_top_vanilla.ltx}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

