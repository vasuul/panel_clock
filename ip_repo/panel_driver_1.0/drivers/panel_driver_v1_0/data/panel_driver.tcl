

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "panel_driver" "NUM_INSTANCES" "DEVICE_ID"  "C_PANEL_AXI_BASEADDR" "C_PANEL_AXI_HIGHADDR"
}
