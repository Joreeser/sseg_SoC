/*****************************************************************//**
 * @file uart_core.h
 *
 * @brief Access MMIO timer core and
 *        display number/sting on a serial console
 *
 * @author p chu
 * @version v1.0: initial release
 ********************************************************************/

#ifndef _SSEG_CORE_H_INCLUDED
#define _SSEG_CORE_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"  
/**
 * SSEG core driver
 * - Set refresh rate for sseg display 
 * - Set data to be displayed
 */
class SsegCore {
public:
// Register map
   enum {
      DATA_REG = 0, // Display data register
	  REFRESH_REG = 1 // Refresh rate register
   };

   // Constructor
   SsegCore(uint32_t core_base_addr);
   ~SsegCore();
   
   // Set display data
   // Data should be exactly 32-bit Hex to display on all digits of screen
   void set_display_data(uint32_t display_data);
   
   // Set refresh rate
   // Refresh rate should be in milliseconds and fit within 10 bits
   void set_refresh_rate(int refresh_rate);

private:
   uint32_t base_addr;
};

#endif  // _SSEG_CORE_H_INCLUDED
