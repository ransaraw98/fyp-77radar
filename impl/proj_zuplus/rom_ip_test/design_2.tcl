
################################################################
# This is a generated script based on design: design_2
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_2_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu7ev-ffvc1156-2-e
   set_property BOARD_PART xilinx.com:zcu106:part0:2.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_2

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xfft:9.1\
xilinx.com:ip:ila:6.2\
xilinx.com:user:ping_pong_buf:2.0\
xilinx.com:user:radarIMG_rom:1.0\
xilinx.com:user:rearrng_ppong_buf:1.0\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set M_AXIS_DATA [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_DATA ]


  # Create ports
  set m_axis_aclk [ create_bd_port -dir I -type clk m_axis_aclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
 ] $m_axis_aclk
  set m_axis_aresetn [ create_bd_port -dir I -type rst m_axis_aresetn ]

  # Create instance: doppler, and set properties
  set doppler [ create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 doppler ]
  set_property -dict [ list \
   CONFIG.aresetn {true} \
   CONFIG.complex_mult_type {use_mults_performance} \
   CONFIG.implementation_options {radix_4_burst_io} \
   CONFIG.memory_options_data {distributed_ram} \
   CONFIG.memory_options_phase_factors {distributed_ram} \
   CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {0} \
   CONFIG.transform_length {256} \
 ] $doppler

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0 ]
  set_property -dict [ list \
   CONFIG.C_DATA_DEPTH {131072} \
   CONFIG.C_NUM_OF_PROBES {9} \
   CONFIG.C_SLOT_0_AXI_PROTOCOL {AXI4S} \
 ] $ila_0

  # Create instance: ping_pong_buf_0, and set properties
  set ping_pong_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:ping_pong_buf:2.0 ping_pong_buf_0 ]
  set_property -dict [ list \
   CONFIG.RAM_ADDRW {7} \
   CONFIG.RAM_DEPTH {128} \
 ] $ping_pong_buf_0

  # Create instance: radarIMG_rom_0, and set properties
  set radarIMG_rom_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:radarIMG_rom:1.0 radarIMG_rom_0 ]

  # Create instance: range_fft, and set properties
  set range_fft [ create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.1 range_fft ]
  set_property -dict [ list \
   CONFIG.aresetn {true} \
   CONFIG.complex_mult_type {use_mults_performance} \
   CONFIG.implementation_options {radix_4_burst_io} \
   CONFIG.memory_options_data {distributed_ram} \
   CONFIG.memory_options_phase_factors {distributed_ram} \
   CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {0} \
   CONFIG.output_ordering {natural_order} \
   CONFIG.transform_length {64} \
   CONFIG.xk_index {true} \
 ] $range_fft

  # Create instance: rearrng_ppong_buf_0, and set properties
  set rearrng_ppong_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:rearrng_ppong_buf:1.0 rearrng_ppong_buf_0 ]
  set_property -dict [ list \
   CONFIG.FRAME_SIZE {256} \
   CONFIG.RAM_ADDRW {15} \
   CONFIG.RAM_DEPTH {32768} \
   CONFIG.RAM_TYPE {ultra} \
   CONFIG.SAMPLE_COUNT {64} \
 ] $rearrng_ppong_buf_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {87} \
   CONFIG.CONST_WIDTH {8} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {343} \
   CONFIG.CONST_WIDTH {16} \
 ] $xlconstant_3

  # Create interface connections
  connect_bd_intf_net -intf_net ping_pong_buf_0_M_AXIS [get_bd_intf_pins ping_pong_buf_0/M_AXIS] [get_bd_intf_pins range_fft/S_AXIS_DATA]
  connect_bd_intf_net -intf_net radarIMG_rom_0_M_AXIS [get_bd_intf_pins ping_pong_buf_0/S_AXIS] [get_bd_intf_pins radarIMG_rom_0/M_AXIS]
  connect_bd_intf_net -intf_net range_fft_M_AXIS_DATA [get_bd_intf_pins range_fft/M_AXIS_DATA] [get_bd_intf_pins rearrng_ppong_buf_0/S_AXIS]
  connect_bd_intf_net -intf_net rearrng_ppong_buf_0_M_AXIS [get_bd_intf_pins doppler/S_AXIS_DATA] [get_bd_intf_pins rearrng_ppong_buf_0/M_AXIS]
  connect_bd_intf_net -intf_net xfft_0_M_AXIS_DATA [get_bd_intf_ports M_AXIS_DATA] [get_bd_intf_pins doppler/M_AXIS_DATA]
connect_bd_intf_net -intf_net [get_bd_intf_nets xfft_0_M_AXIS_DATA] [get_bd_intf_ports M_AXIS_DATA] [get_bd_intf_pins ila_0/SLOT_0_AXIS]

  # Create port connections
  connect_bd_net -net Net [get_bd_ports m_axis_aclk] [get_bd_pins doppler/aclk] [get_bd_pins ila_0/clk] [get_bd_pins ping_pong_buf_0/m_axis_aclk] [get_bd_pins ping_pong_buf_0/s_axis_aclk] [get_bd_pins radarIMG_rom_0/m_axis_aclk] [get_bd_pins range_fft/aclk] [get_bd_pins rearrng_ppong_buf_0/m_axis_aclk] [get_bd_pins rearrng_ppong_buf_0/s_axis_aclk]
  connect_bd_net -net Net1 [get_bd_ports m_axis_aresetn] [get_bd_pins ping_pong_buf_0/m_axis_aresetn] [get_bd_pins ping_pong_buf_0/s_axis_aresetn] [get_bd_pins radarIMG_rom_0/m_axis_aresetn] [get_bd_pins range_fft/aresetn] [get_bd_pins rearrng_ppong_buf_0/m_axis_aresetn] [get_bd_pins rearrng_ppong_buf_0/s_axis_aresetn]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins range_fft/s_axis_config_tvalid] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins range_fft/s_axis_config_tdata] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins doppler/s_axis_config_tvalid] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlconstant_3_dout [get_bd_pins doppler/s_axis_config_tdata] [get_bd_pins xlconstant_3/dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_msg_id "BD_TCL-1000" "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

