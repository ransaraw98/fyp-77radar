# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set C_S_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -name "C_S_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {AXI4Stream sink: Data Width} ${C_S_AXIS_TDATA_WIDTH}
  set C_M_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -name "C_M_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.} ${C_M_AXIS_TDATA_WIDTH}
  set C_M_AXIS_START_COUNT [ipgui::add_param $IPINST -name "C_M_AXIS_START_COUNT" -parent ${Page_0}]
  set_property tooltip {Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.} ${C_M_AXIS_START_COUNT}

  set RAM_ADDRW [ipgui::add_param $IPINST -name "RAM_ADDRW"]
  set_property tooltip {Always choose the log2(RAM_DEPTH) value} ${RAM_ADDRW}
  ipgui::add_param $IPINST -name "RAM_DEPTH"

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

proc update_PARAM_VALUE.C_S_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_S_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_S_AXIS_TDATA_WIDTH
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


proc update_MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH PARAM_VALUE.C_S_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH PARAM_VALUE.C_M_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_START_COUNT { MODELPARAM_VALUE.C_M_AXIS_START_COUNT PARAM_VALUE.C_M_AXIS_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_START_COUNT}] ${MODELPARAM_VALUE.C_M_AXIS_START_COUNT}
}

proc update_MODELPARAM_VALUE.RAM_ADDRW { MODELPARAM_VALUE.RAM_ADDRW PARAM_VALUE.RAM_ADDRW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_ADDRW}] ${MODELPARAM_VALUE.RAM_ADDRW}
}

proc update_MODELPARAM_VALUE.RAM_DEPTH { MODELPARAM_VALUE.RAM_DEPTH PARAM_VALUE.RAM_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_DEPTH}] ${MODELPARAM_VALUE.RAM_DEPTH}
}

