/*****************************************************************//**
 * @file uart_core.cpp
 *
 * @brief implementation of UartCore class
 *
 * @author p chu
 * @version v1.0: initial release
 ********************************************************************/

#include "sseg_core.h"

SsegCore::SsegCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
   set_display_data(0); // Default display
   set_refresh_rate(50); // Default refresh rate
}

SsegCore::~SsegCore() {
}

void SsegCore::set_display_data(uint32_t display_data) {
   io_write(base_addr, DATA_REG, display_data);
}

void SsegCore::set_refresh_rate(int refresh_rate) {
	io_write(base_addr, REFRESH_REG, refresh_rate);
}




