#ifndef GSX_H
#define GSX_H

#if defined ST7735
	#include <ST7735_GSX.h>
#elif defined ILI9341
	#include <ILI9341_GSX.h>
#elif defined PiGFX
	#include "pigfx_gsx.h"
#endif

GSX gsx;

uint16 _gdos(uint16 DE) {
	
	uint16*	gsx_params = (uint16*)_RamSysAddr(DE);

	gsx.contrl = (int16*)_RamSysAddr(gsx_params[GSX_PB_CONTRL]);
	gsx.intin  = (int16*)_RamSysAddr(gsx_params[GSX_PB_INTIN]);
	gsx.ptsin  = (int16*)_RamSysAddr(gsx_params[GSX_PB_PTSIN]);
	gsx.intout = (int16*)_RamSysAddr(gsx_params[GSX_PB_INTOUT]);
	gsx.ptsout = (int16*)_RamSysAddr(gsx_params[GSX_PB_PTSOUT]);
	
	// any input points to convert from NDC to dev units?
	// convert to internal buffer (that's what CP/M-80's GSX.SYS did)
	if (gsx.contrl[CONTRL_FUNCTION] != 1 && gsx.contrl[CONTRL_PTSIN]) {
		int16 num_ptsin = gsx.contrl[CONTRL_PTSIN] < MAX_PTSIN 
							  ? gsx.contrl[CONTRL_PTSIN] : MAX_PTSIN;
		for (int16 i = 0; i < num_ptsin*2; i = i + 2) {
			gsx.int_ptsin[i + 0] = gsx.ndc_to_dev(gsx.ptsin[i + 0], 0, gsx.maxX);
			gsx.int_ptsin[i + 1] = gsx.ndc_to_dev(gsx.ptsin[i + 1], gsx.maxY, 0);
		}
	}
	
	gsx.contrl[CONTRL_PTSOUT] = 0;		// assume no values returned ptsout
	gsx.contrl[CONTRL_INTOUT] = 0;		// and nothing in intout
	switch (gsx.contrl[CONTRL_FUNCTION]) {

		case 1:			// open workstation REQ for CRT
			gsx.open_workstation();
			gsx.maxX = gsx.intout[0];
			gsx.maxY = gsx.intout[1];
			break;

		case 2:			// close workstation REQ for CRT
			gsx.close_workstation();
			break;

		case 3:			// clear workstation REQ for CRT
			gsx.clear_workstation();
			break;
			
		case 4:			// update workstation REQ for CRT
			gsx.update_workstation();
			break;
			
		case 5:			// escape REQ for CRT
			gsx.escape();
			break;
			
		case 6:			// draw polyline REQ for CRT
			gsx.draw_polyline();
			break;
			
		case 7:			// plot a group of markers REQ for CRT
			gsx.draw_polymarkers();
			break;
			
		case 8:			// draw text REQ for CRT
			gsx.draw_text();
			break;
			
		case 9:			// draw a filled polygon REQ for CRT
			gsx.draw_filled_polygon();
			break;
			
		case 10:			// draw bitmap REQ for CRT
			gsx.draw_bitmap();
			break;
			
		case 11:			// general drawing primitive REQ for CRT
			gsx.drawing_primitive();
			break;
			
		case 12:			// set text size REQ for CRT
			gsx.set_text_height();
			break;
			
		case 13:			// set text direction
			gsx.set_text_direction();
			break;
			
		case 14:			// set colour index (palette registers) REQ for CRT
			gsx.set_colour_palette();
			break;
			
		case 15:			// set line style REQ for CRT
			gsx.set_line_style();
			break;
			
		case 16:			// set line width
			gsx.set_line_width();
			break;
			
		case 17:			// set line colour REQ for CRT
			gsx.set_line_colour();
			break;
			
		case 18:			// set marker style REQ for CRT
			gsx.set_marker_style();
			break;
			
		case 19:			// set marker height
			gsx.set_marker_height();
			break;
			
		case 20:			// set marker colour REQ for CRT
			gsx.set_marker_colour();
			break;
			
		case 21:			// set text font
			gsx.set_text_font();
			break;
			
		case 22:			// set text colour REQ for CRT
			gsx.set_text_colour();
			break;
			
		case 23:			// set fill style
			gsx.set_fill_style();
			break;
			
		case 24:			// set fill index
			gsx.set_fill_index();
			break;
			
		case 25:			// set fill colour REQ for CRT
			gsx.set_fill_colour();
			break;
			
		case 26:			// read palette REQ for CRT
			gsx.read_colour_palette();
			break;

		case 27:			// read bitmap
			gsx.read_bitmap();
			break;
			
		case 28:			// read locator (eg tablet or mouse)
			gsx.read_locator();
			break;
			
		case 29:			// read valuator
			gsx.read_valuator();
			break;
			
		case 30:			// read choice
			gsx.read_choice();
			break;
			
		case 31:			// read string
			gsx.read_string();
			break;
			
		case 32:			// set writing mode
			gsx.set_writing_mode();
			break;
			
		case 33:			// set input mode
			gsx.set_input_mode();
			break;
			
		default:
			break;
	}

	for (int16 i = 0; i < gsx.contrl[CONTRL_PTSOUT]*2; i = i + 2) {
		gsx.ptsout[i + 0] = gsx.dev_to_ndc(gsx.ptsout[i + 0], 0, gsx.maxX);
		gsx.ptsout[i + 1] = gsx.dev_to_ndc(gsx.ptsout[i + 1], 0, gsx.maxY);
	}
	return DE;			// CP/M-80's GSX.SYS doesn't return anything useful
							// but this can't hurt
}
#endif	// #ifndef GSX_H
