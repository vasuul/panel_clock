

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "heartbeat" "NUM_INSTANCES" "DEVICE_ID"  "C_HB_AXI_BASEADDR" "C_HB_AXI_HIGHADDR"
}
