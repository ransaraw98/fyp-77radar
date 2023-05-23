# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set C_M_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -name "C_M_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.} ${C_M_AXIS_TDATA_WIDTH}
  set C_M_AXIS_START_COUNT [ipgui::add_param $IPINST -name "C_M_AXIS_START_COUNT" -parent ${Page_0}]
  set_property tooltip {Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.} ${C_M_AXIS_START_COUNT}
  set C_S_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -name "C_S_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {AXI4Stream sink: Data Width} ${C_S_AXIS_TDATA_WIDTH}

  set RAM_ADDRW [ipgui::add_param $IPINST -name "RAM_ADDRW"]
  set_property tooltip {Make sure the address space can accomodate the full depth.} ${RAM_ADDRW}
  set RAM_DEPTH [ipgui::add_param $IPINST -name "RAM_DEPTH"]
  set_property tooltip {Should be equal to the maximum address space of ADDRW} ${RAM_DEPTH}
  set FRAME_SIZE [ipgui::add_param $IPINST -name "FRAME_SIZE"]
  set_property tooltip {Number of words in the output frame.} ${FRAME_SIZE}
  set SAMPLE_COUNT [ipgui::add_param $IPINST -name "SAMPLE_COUNT"]
  set_property tooltip {Number of words in the input frame.} ${SAMPLE_COUNT}
  ipgui::add_param $IPINST -name "RAM_TYPE" -widget comboBox

}

proc update_PARAM_VALUE.FRAME_SIZE { PARAM_VALUE.FRAME_SIZE } {
	# Procedure called to update FRAME_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FRAME_SIZE { PARAM_VALUE.FRAME_SIZE } {
	# Procedure called to validate FRAME_SIZE
	return true
}

proc update_PARAM_VALUE.RAM_ADDRW { PARAM_VALUE.RAM_ADDRW } {
	# Procedure called to update RAM_ADDRW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_ADDRW { PARAM_VALUE.RAM_ADDRW } {
	# Procedure called to validate RAM_ADDRW
	return true
}

proc update_PARAM_VALUE.RAM_DEPTH { PARAM_VALUE.RAM_DEPTH } {
	# Procedure called to update RAM_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_DEPTH { PARAM_VALUE.RAM_DEPTH } {
	# Procedure called to validate RAM_DEPTH
	return true
}

proc update_PARAM_VALUE.RAM_TYPE { PARAM_VALUE.RAM_TYPE } {
	# Procedure called to update RAM_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_TYPE { PARAM_VALUE.RAM_TYPE } {
	# Procedure called to validate RAM_TYPE
	return true
}

proc update_PARAM_VALUE.SAMPLE_COUNT { PARAM_VALUE.SAMPLE_COUNT } {
	# Procedure called to update SAMPLE_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SAMPLE_COUNT { PARAM_VALUE.SAMPLE_COUNT } {
	# Procedure called to validate SAMPLE_COUNT
	return true
}

proc update_PARAM_VALUE.C_M_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M_AXIS_START_COUNT { PARAM_VALUE.C_M_AXIS_START_COUNT } {
	# Procedure called to update C_M_AXIS_START_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXIS_START_COUNT { PARAM_VALUE.C_M_AXIS_START_COUNT } {
	# Procedure called to validate C_M_AXIS_START_COUNT
	return true
}

proc update_PARAM_VALUE.C_S_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_S_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_S_AXIS_TDATA_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH PARAM_VALUE.C_M_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_START_COUNT { MODELPARAM_VALUE.C_M_AXIS_START_COUNT PARAM_VALUE.C_M_AXIS_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_START_COUNT}] ${MODELPARAM_VALUE.C_M_AXIS_START_COUNT}
}

proc update_MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH PARAM_VALUE.C_S_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.RAM_ADDRW { MODELPARAM_VALUE.RAM_ADDRW PARAM_VALUE.RAM_ADDRW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_ADDRW}] ${MODELPARAM_VALUE.RAM_ADDRW}
}

proc update_MODELPARAM_VALUE.RAM_DEPTH { MODELPARAM_VALUE.RAM_DEPTH PARAM_VALUE.RAM_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_DEPTH}] ${MODELPARAM_VALUE.RAM_DEPTH}
}

proc update_MODELPARAM_VALUE.FRAME_SIZE { MODELPARAM_VALUE.FRAME_SIZE PARAM_VALUE.FRAME_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FRAME_SIZE}] ${MODELPARAM_VALUE.FRAME_SIZE}
}

proc update_MODELPARAM_VALUE.SAMPLE_COUNT { MODELPARAM_VALUE.SAMPLE_COUNT PARAM_VALUE.SAMPLE_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SAMPLE_COUNT}] ${MODELPARAM_VALUE.SAMPLE_COUNT}
}

proc update_MODELPARAM_VALUE.RAM_TYPE { MODELPARAM_VALUE.RAM_TYPE PARAM_VALUE.RAM_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_TYPE}] ${MODELPARAM_VALUE.RAM_TYPE}
}

