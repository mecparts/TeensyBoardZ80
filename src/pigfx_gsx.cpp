#include "pigfx_gsx.h"

const static char CSI[] = {"\x1B["};
const static char CSI_PRIVATE[] = {"\x1B[#"};
const unsigned int xterm_colors[256] = {
	0x000000,  0x800000,  0x008000,  0x808000,  0x000080,
	0x800080,  0x008080,  0xc0c0c0,  0x808080,  0xff0000,
	0x00ff00,  0xffff00,  0x0000ff,  0xff00ff,  0x00ffff,
	0xffffff,  0x000000,  0x00005f,  0x000087,  0x0000af,
	0x0000df,  0x0000ff,  0x005f00,  0x005f5f,  0x005f87,
	0x005faf,  0x005fdf,  0x005fff,  0x008700,  0x00875f,
	0x008787,  0x0087af,  0x0087df,  0x0087ff,  0x00af00,
	0x00af5f,  0x00af87,  0x00afaf,  0x00afdf,  0x00afff,
	0x00df00,  0x00df5f,  0x00df87,  0x00dfaf,  0x00dfdf,
	0x00dfff,  0x00ff00,  0x00ff5f,  0x00ff87,  0x00ffaf,
	0x00ffdf,  0x00ffff,  0x5f0000,  0x5f005f,  0x5f0087,
	0x5f00af,  0x5f00df,  0x5f00ff,  0x5f5f00,  0x5f5f5f,
	0x5f5f87,  0x5f5faf,  0x5f5fdf,  0x5f5fff,  0x5f8700,
	0x5f875f,  0x5f8787,  0x5f87af,  0x5f87df,  0x5f87ff,
	0x5faf00,  0x5faf5f,  0x5faf87,  0x5fafaf,  0x5fafdf,
	0x5fafff,  0x5fdf00,  0x5fdf5f,  0x5fdf87,  0x5fdfaf,
	0x5fdfdf,  0x5fdfff,  0x5fff00,  0x5fff5f,  0x5fff87,
	0x5fffaf,  0x5fffdf,  0x5fffff,  0x870000,  0x87005f,
	0x870087,  0x8700af,  0x8700df,  0x8700ff,  0x875f00,
	0x875f5f,  0x875f87,  0x875faf,  0x875fdf,  0x875fff,
	0x878700,  0x87875f,  0x878787,  0x8787af,  0x8787df,
	0x8787ff,  0x87af00,  0x87af5f,  0x87af87,  0x87afaf,
	0x87afdf,  0x87afff,  0x87df00,  0x87df5f,  0x87df87,
	0x87dfaf,  0x87dfdf,  0x87dfff,  0x87ff00,  0x87ff5f,
	0x87ff87,  0x87ffaf,  0x87ffdf,  0x87ffff,  0xaf0000,
	0xaf005f,  0xaf0087,  0xaf00af,  0xaf00df,  0xaf00ff,
	0xaf5f00,  0xaf5f5f,  0xaf5f87,  0xaf5faf,  0xaf5fdf,
	0xaf5fff,  0xaf8700,  0xaf875f,  0xaf8787,  0xaf87af,
	0xaf87df,  0xaf87ff,  0xafaf00,  0xafaf5f,  0xafaf87,
	0xafafaf,  0xafafdf,  0xafafff,  0xafdf00,  0xafdf5f,
	0xafdf87,  0xafdfaf,  0xafdfdf,  0xafdfff,  0xafff00,
	0xafff5f,  0xafff87,  0xafffaf,  0xafffdf,  0xafffff,
	0xdf0000,  0xdf005f,  0xdf0087,  0xdf00af,  0xdf00df,
	0xdf00ff,  0xdf5f00,  0xdf5f5f,  0xdf5f87,  0xdf5faf,
	0xdf5fdf,  0xdf5fff,  0xdf8700,  0xdf875f,  0xdf8787,
	0xdf87af,  0xdf87df,  0xdf87ff,  0xdfaf00,  0xdfaf5f,
	0xdfaf87,  0xdfafaf,  0xdfafdf,  0xdfafff,  0xdfdf00,
	0xdfdf5f,  0xdfdf87,  0xdfdfaf,  0xdfdfdf,  0xdfdfff,
	0xdfff00,  0xdfff5f,  0xdfff87,  0xdfffaf,  0xdfffdf,
	0xdfffff,  0xff0000,  0xff005f,  0xff0087,  0xff00af,
	0xff00df,  0xff00ff,  0xff5f00,  0xff5f5f,  0xff5f87,
	0xff5faf,  0xff5fdf,  0xff5fff,  0xff8700,  0xff875f,
	0xff8787,  0xff87af,  0xff87df,  0xff87ff,  0xffaf00,
	0xffaf5f,  0xffaf87,  0xffafaf,  0xffafdf,  0xffafff,
	0xffdf00,  0xffdf5f,  0xffdf87,  0xffdfaf,  0xffdfdf,
	0xffdfff,  0xffff00,  0xffff5f,  0xffff87,  0xffffaf,
	0xffffdf,  0xffffff,  0x080808,  0x121212,  0x1c1c1c,
	0x262626,  0x303030,  0x3a3a3a,  0x444444,  0x4e4e4e,
	0x585858,  0x606060,  0x666666,  0x767676,  0x808080,
	0x8a8a8a,  0x949494,  0x9e9e9e,  0xa8a8a8,  0xb2b2b2,
	0xbcbcbc,  0xc6c6c6,  0xd0d0d0,  0xdadada,  0xe4e4e4,
	0xeeeeee 
};

GSX::GSX() {
}

void GSX::begin() {
}

// GSX 1: open workstation REQ for CRT
void GSX::open_workstation() {
	close_workstation();

	Serial1.print(CSI_PRIVATE);
	Serial1.print(OPC_OPEN_WORKSTATION);
	for (int i = 0; i < 10; ++i) {
		Serial1.print(';');
		Serial1.print(intin[i]);
	}
	Serial1.print('G');
	contrl[CONTRL_PTSOUT] = 6;		// # points in ptsout
	
	ptsout[0] = TW_MIN;
	ptsout[1] = TH_MIN;				// minimum character height
	ptsout[2] = 4 * TW_MIN;
	ptsout[3] = 4 * TH_MIN;			// maximum character height
	ptsout[4] = 1;						// minimum line width
	ptsout[5] = 0;
	ptsout[6] = 1;						// maximum line width
	ptsout[7] = 0;
	ptsout[8] = 0;
	ptsout[9] = TH_MIN;				// minimum marker height
	ptsout[10] = 0;
	ptsout[11] = 256;					// maximum marker height.
	ptsout[12] = FONT_WIDTH;		// cell width
	ptsout[13] = FONT_HEIGHT;		// cell height
	
	contrl[CONTRL_INTOUT] = 45;	// # integers in intout

	intout[OWS_INTOUT_MAX_WIDTH] = PiGFX_WIDTH - 1;		// Screen width, device units
	intout[OWS_INTOUT_MAX_HEIGHT] = PiGFX_HEIGHT - 1;	// Screen height, device units
	intout[OWS_INTOUT_COORD_FLAGS] = 1;						// 0 if device is capable of
																		// continuous scaling (printer)
																		// 1 if not (CRT)
	intout[OWS_INTOUT_PIXEL_WIDTH] = PIXEL_WIDTH;		// Width of a pixel, in thousandths of a millimetre.
	intout[OWS_INTOUT_PIXEL_HEIGHT] = PIXEL_HEIGHT;		// Height of a pixel, in thousandths of a millimetre.
	intout[5] = 4;			// Number of character sizes, 0 for continuous sizing.
	intout[6] = 5;			// Number of line styles.
	intout[7] = 1;			// Number of line widths.
	intout[8] = 5;			// Number of marker styles.
	intout[9] = 256;		// Number of marker sizes.
	intout[10] = 1;		// Number of fonts.
	intout[11] = 6;		// Number of patterns.
	intout[12] = 6;		// Number of hatch styles.
	intout[13] = 256;		//	Number of colours displayable at once.

	intout[14] = 3;		// Number of General Drawing Primitives
	intout[15] = 1;		// General Drawing Primitive numbers.
	intout[16] = 2;		//-1 => End of list
	intout[17] = 4;		// 1 => Bar
	intout[18] = -1;		// 2 => Arc
								// 3 => Pie slice
								// 4 => Circle
								// 5 => Ruling characters
 
	intout[25] = 0;		// General Drawing Primitive attributes
	intout[26] = 1;		//-1 => End of list
	intout[27] = 2;		// 0 => Polyline
	intout[28] = 3;		// 1 => Polymarker
	intout[29] = 4;		// 2 => Text
	intout[30] = -1;		// 3 => Filled area
								// 4 => None
 
	intout[35] = 1;		//	0 for black/white, 1 for colour.
	intout[36] = 1;		//	0 if text rotation is not possible, 1 if it is.
	intout[37] = 1;		//	0 if filled areas are not possible, 1 if they are.
	intout[38] = 1;		//	0 if cannot read cell array, 1 if can.
	intout[39] = 256;		//	Number of colours in the palette.
								// 0 => More than 32767
								// 2 => Black and white
								// >2 => number of colours available
	intout[40] = 1;		//	Number of locator devices (mice, tablets, lightpens)
	intout[41] = 0;		//	Number of valuator devices
	intout[42] = 0;		//	Number of choice devices
	intout[43] = 0;		// Number of string devices
	intout[44] = 2;		//	Workstation type
								// 0 => Output only
								// 1 => Input only
								// 2 => Input and output
								// 3 => Segment storage
								// 4 => GKS metafile output.
	clear_workstation();
}

// GSX 2: close workstation REQ for CRT
void GSX::close_workstation() {
	clear_workstation();
	Serial1.print(CSI_PRIVATE);
	Serial1.print(OPC_CLOSE_WORKSTATION);
	Serial1.print('G');
}

// GSX 3: clear workstation REQ for CRT
void GSX::clear_workstation() {
	Serial1.print(CSI_PRIVATE);
	Serial1.print(OPC_CLEAR_WORKSTATION);
	Serial1.print('G');
}

// GSX 4: update workstation REQ for CRT
void GSX::update_workstation() {
}

// GSX 5: escape REQ for CRT
void GSX::escape() {
	switch (contrl[CONTROL_FUNCTIONID]) {
		
		case ESC_GET_TEXT_ROWS_AND_COLUMNS:	// inquire addressable character cells REQ for CRT
			contrl[CONTRL_INTOUT] = 2;
			intout[0] = TEXT_ROWS;
			intout[1] = TEXT_COLUMNS;
			break;
			
		case ESC_EXIT_GRAPHICS_MODE:		// enter graphics mode REQ for CRT
		case ESC_ENTER_GRAPHICS_MODE:		// exit graphics mode REQ for CRT
		case ESC_TEXT_CURSOR_UP:			// cursor up REQ for CRT
		case ESC_TEXT_CURSOR_DOWN:			// cursor down REQ for CRT
		case ESC_TEXT_CURSOR_RIGHT:		// cursor right REQ for CRT
		case ESC_TEXT_CURSOR_LEFT:			// cursor left REQ for CRT
		case ESC_TEXT_CURSOR_HOME:			// home cursor REQ for CRT
		case ESC_TEXT_ERASE_EOS:			// erase to end of screen REQ for CRT
		case ESC_TEXT_ERASE_EOL:			// erase to end of line REQ for CRT
		case ESC_TEXT_REVERSE_VIDEO_ON:	// reverse video on
		case ESC_TEXT_REVERSE_VIDEO_OFF:	// reverse video off
		case ESC_REMOVE_GRAPHIC_CURSOR:	// remove last graphic cursor REQ for CRT
			Serial1.print(CSI_PRIVATE);
			Serial1.print(OPC_ESCAPE);
			Serial1.print(';');
			Serial1.print(contrl[CONTROL_FUNCTIONID]);
			Serial1.print('G');
			break;
			
		case ESC_SET_TEXT_CURSOR: // direct cursor address REQ for CRT
			Serial1.print(CSI_PRIVATE);
			Serial1.print(OPC_ESCAPE);
			Serial1.print(';');
			Serial1.print(ESC_SET_TEXT_CURSOR);
			Serial1.print(';');
			Serial1.print(intin[0]);
			Serial1.print(';');
			Serial1.print(intin[1]);
			Serial1.print('G');
			break;
			
		case ESC_TEXT:	// direct cursor addressable text REQ for CRT
			if (contrl[CONTRL_INTIN] > 0) {
				Serial1.print(CSI_PRIVATE);
				Serial1.print(OPC_ESCAPE);
				Serial1.print(';');
				Serial1.print(ESC_TEXT);
				Serial1.print(';');
				Serial1.print(contrl[CONTRL_INTIN]);
				for (uint16 i = 0; i < contrl[CONTRL_INTIN] ; ++i ) {
					Serial1.print(';');
					Serial1.print(intin[i]);
				}
				Serial1.print('G');
			}
			break;
			
			
		case ESC_GET_TEXT_CURSOR:	// inquire current current cursor address REQ for CRT
			contrl[CONTRL_INTOUT] = 2;
			intout[0] = 0; // TODO ### getCursorY() / (TH_MIN + 1);
			intout[1] = 0; // TODO ### getCursorX() / (TW_MIN + 1);
			break;
			
		case ESC_TABLET_STATUS:	// inquire tablet status
			contrl[CONTRL_INTOUT] = 1;
			intout[0] = 0;	// tablet not available
			break;
			
		case ESC_HARDCOPY:	// hardcopy
			// TODO
			break;
			
		case ESC_PLACE_GRAPHIC_CURSOR:	// place graphic cursor at location REQ for CRT
			place_graphic_cursor(int_ptsin[0], int_ptsin[1]);
			break;
			
	}
}

// GSX 6: draw polyline REQ for CRT
void GSX::draw_polyline() {
	int16 nPoints = contrl[CONTRL_PTSIN];
	if (nPoints > 1) {
		Serial1.print(CSI_PRIVATE);
		Serial1.print(OPC_DRAW_POLYLINE);
		Serial1.print(';');
		Serial1.print(nPoints);
		for (int16 i = 0; i < nPoints * 2; i += 2) {
			Serial1.print(';');
			Serial1.print(int_ptsin[i + 0]);
			Serial1.print(';');
			Serial1.print(int_ptsin[i + 1]);
		}
		Serial1.print('G');
	}
}
			
// GSX 7: plot a group of markers REQ for CRT
void GSX::draw_polymarkers() {
	int nMarkers = contrl[CONTRL_PTSIN];
	if (nMarkers > 0) {
		Serial1.print(CSI_PRIVATE);
		Serial1.print(OPC_DRAW_POLYMARKER);
		Serial1.print(';');
		Serial1.print(nMarkers);
		for (int16 i = 0; i < nMarkers * 2; i += 2) {
			Serial1.print(';');
			Serial1.print(int_ptsin[i + 0]);
			Serial1.print(';');
			Serial1.print(int_ptsin[i + 1]);
		}
		Serial1.print('G');
	}
}

// GSX 8: draw text REQ for CRT
void GSX::draw_text() {
	uint16 nChars = contrl[CONTRL_INTIN];

	if (nChars > 0) {
		Serial1.print(CSI_PRIVATE);
		Serial1.print(OPC_DRAW_TEXT);
		Serial1.print(';');
		Serial1.print(nChars);
		Serial1.print(';');
		Serial1.print(int_ptsin[0]);
		Serial1.print(';');
		Serial1.print(int_ptsin[1]);
		for (uint16 i = 0; i < nChars ; ++i ) {
			Serial1.print(';');
			Serial1.print(intin[i]);
		}
		Serial1.print('G');
	}
}
			
// GSX 9: draw a filled polygon REQ for CRT
void GSX::draw_filled_polygon() {
	int16 nPoints = contrl[CONTRL_PTSIN];
	if (nPoints > 2) {
		Serial1.print(CSI_PRIVATE);
		Serial1.print(OPC_DRAW_FILLED_POLYGON);
		Serial1.print(';');
		Serial1.print(nPoints);
		for( int16 i = 0; i < nPoints * 2; i += 2) {
			Serial1.print(';');
			Serial1.print(int_ptsin[i + 0]);
			Serial1.print(';');
			Serial1.print(int_ptsin[i + 1]);
		}
		Serial1.print('G');
	}
}
			
// GSX 10: draw bitmap REQ for CRT
void GSX::draw_bitmap() {
	// TODO
}
			
// GSX 11: general drawing primitive REQ for CRT
void GSX::drawing_primitive() {
	switch (contrl[CONTROL_FUNCTIONID]) {
		case DRAW_BAR:	// bar REQ for CRT
			Serial1.print(CSI_PRIVATE);
			Serial1.print(OPC_DRAWING_PRIMITIVE);
			Serial1.print(';');
			Serial1.print(DRAW_BAR);
			for (int16 i = 0; i < 4; ++i) {	// llx, lly, urx, ury
				Serial1.print(';');
				Serial1.print(int_ptsin[i]);
			}
			Serial1.print('G');
			break;
		case DRAW_ARC:	// arc: drawn counter clockwise from arc_s to arc_e
			Serial1.print(CSI_PRIVATE);
			Serial1.print(OPC_DRAWING_PRIMITIVE);
			Serial1.print(';');
			Serial1.print(DRAW_ARC);
			Serial1.print(';');
			Serial1.print(int_ptsin[0]);	// x0
			Serial1.print(';');
			Serial1.print(int_ptsin[1]);	// y0
			Serial1.print(';');
			Serial1.print(int_ptsin[6]);	// r
			Serial1.print(';');
			Serial1.print(intin[0]);		// arc_s
			Serial1.print(';');
			Serial1.print(intin[1]);		// arc_x
			Serial1.print('G');
			break;
		case DRAW_PIE_SLICE:	// pie slice
			// TODO
			break;
		case DRAW_CIRCLE:	// circle
			Serial1.print(CSI_PRIVATE);
			Serial1.print(OPC_DRAWING_PRIMITIVE);
			Serial1.print(';');
			Serial1.print(DRAW_CIRCLE);
			Serial1.print(';');
			Serial1.print(int_ptsin[0]);	// x0
			Serial1.print(';');
			Serial1.print(int_ptsin[1]);	// y0
			Serial1.print(';');
			Serial1.print(int_ptsin[4]);	// r
			Serial1.print('G');
			break;
		case DRAW_GRAPHICS_CHAR:	// print graphic characters (ruling characters)
			// TODO
			break;
	}
}

// GSX 12: set text size REQ for CRT
void GSX::set_text_height() {
	int16 text_height = ndc_to_dev(ptsin[1], 0, maxY);
	int16 text_size, text_width;

	if (text_height < TH_MIN) {
		text_height = TH_MIN;
	}
	if (text_height < 2 * TH_MIN) {
		text_size = 1;
	} else if (text_height < 3 * TH_MIN) {
		text_size = 2;
	} else if (text_height < 4 * TH_MIN) {
		text_size = 3;
	} else {
		text_size = 4;
	} 
	text_height = text_size * TH_MIN;
	text_width = text_size * TW_MIN;
	Serial1.print(CSI_PRIVATE);
	Serial1.print(OPC_TEXT_HEIGHT);
	Serial1.print(';');
	Serial1.print(text_size);
	Serial1.print(';');
	Serial1.print(text_height);
	Serial1.print(';');
	Serial1.print(text_width);
	Serial1.print('G');
	
	contrl[CONTRL_PTSOUT] = 2;
	ptsout[0] = text_width;
	ptsout[1] = text_height;
	ptsout[2] = FONT_WIDTH * text_size;
	ptsout[3] = FONT_HEIGHT * text_size;
}
			
// GSX 13: set text direction
void GSX::set_text_direction() {
	int16 text_direction = intin[0];
	if (text_direction > 450 && text_direction <= 1350) {
		text_direction = 900;
	} else if (text_direction > 1350 && text_direction <= 2250) {
		text_direction = 1800;
	} else if (text_direction > 2250 && text_direction <= 3150) {
		text_direction = 2700;
	} else {
		text_direction = 0;
	}
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = text_direction;
	send_parameter(OPC_TEXT_ROTATION, text_direction);
}
			
// GSX 14: set colour index (palette registers) REQ for CRT
void GSX::set_colour_palette() {
	send_parameters(OPC_SET_PALETTE_COLOUR, intin, 4);
}
			
// GSX 15: set line style REQ for CRT
void GSX::set_line_style() {
	int16 line_style = intin[0];
	if (line_style < LS_SOLID || line_style > LS_LONG_DASH) {
		line_style = LS_SOLID;
	}
	send_parameter(OPC_POLYLINE_LINESTYLE, line_style);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = line_style;
}
			
// GSX 16: set line width
void GSX::set_line_width() {
	int16 line_width = intin[0];
	if (line_width < 1) {
		line_width = 1;
	} else if (line_width > LW_MAX) {
		line_width = LW_MAX;
	}
	send_parameter(OPC_POLYLINE_LINEWIDTH, line_width);
	contrl[CONTRL_PTSOUT] = 1;
	ptsout[0] = line_width;
	ptsout[1] = 0;
}
			
// GSX 17: set line colour REQ for CRT
void GSX::set_line_colour() {
	int16 line_colour = intin[0];
	send_parameter(OPC_POLYLINE_COLOUR, line_colour);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = line_colour;
}
			
// GSX 18: set marker style REQ for CRT
void GSX::set_marker_style() {
	int16 marker_style = intin[0];
	if (marker_style < MS_DOT || marker_style > MS_CROSS) {
		marker_style = MS_ASTERISK;
	}
	send_parameter(OPC_POLYMARKER_STYLE, marker_style);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = marker_style;
}
			
// GSX 19: set marker height
void GSX::set_marker_height() {
	int16 marker_height = ndc_to_dev(ptsin[1], 0, maxY);
	send_parameter(OPC_POLYMARKER_HEIGHT, marker_height);
	contrl[CONTRL_PTSOUT] = 1;
	ptsout[0] = 0;
	ptsout[1] = marker_height;
}
			
// GSX 20: set marker colour REQ for CRT
void GSX::set_marker_colour() {
	send_parameter(OPC_POLYMARKER_COLOUR, intin[0]);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = intin[0];
}
			
// GSX 21: set text font
void GSX::set_text_font() {
	send_parameter(OPC_TEXT_FONT, intin[0]);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = intin[0];
}
			
// GSX 22: set text colour REQ for CRT
void GSX::set_text_colour() {
	send_parameter(OPC_TEXT_COLOUR, intin[0]);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = intin[0];
}
			
// GSX 23: set fill style
void GSX::set_fill_style() {
	send_parameter(OPC_FILL_STYLE, intin[0]);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = intin[0];
}
			
// GSX 24: set fill index
void GSX::set_fill_index() {
	send_parameter(OPC_FILL_STYLE_INDEX, intin[0]);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = intin[0];
}
			
// GSX 25: set fill colour REQ for CRT
void GSX::set_fill_colour() {
	send_parameter(OPC_FILL_COLOUR, intin[0]);
}
			
// GSX 26: read colour palette REQ for CRT
void GSX::read_colour_palette() {
	uint16 clr_index = intin[0];
	if (clr_index >= NUM_COLOURS) {
		clr_index = NUM_COLOURS - 1;
	}
	intout[0] = clr_index;
	intout[1] = 0; // TODO ### map((clr >> 11), 0, 0x1F, 0, 1000);
	intout[2] = 0; // TODO ### map(((clr >> 5) & 0x3F), 0, 0x3F, 0, 1000);
	intout[3] = 0; // TODO ###  map((clr & 0x1F), 0, 0x1F, 0, 1000);
}

// GSX 27: read bitmap
void GSX::read_bitmap() {
	// TODO
}
			
extern uint8 _crtist(void);
extern uint8 _getcrt(void);

// GSX 28: read locator (eg tablet or mouse)
void GSX::read_locator() {
	int16 x = int_ptsin[0];
	int16 y = int_ptsin[1];
	char ch;
   
	place_graphic_cursor(x, y);
   while (true) {
		if (_crtist()) {
			ch = _getcrt();
			remove_graphic_cursor();
			switch (ch) {
				case 'X'-'@': y = min(y + 10, maxY); break;
				case 'E'-'@': y = max(y - 10, 0); break;
				case 'D'-'@': x = min(x + 10, maxX); break;
				case 'S'-'@': x = max(x - 10, 0); break;
				case 'Z'-'@': y = min(y + 1, maxY); break;
				case 'W'-'@': y = max(y - 1, 0); break;
				case 'F'-'@': x = min(x + 1, maxX); break;
				case 'A'-'@': x = max(x - 1, 0); break;
				default:
					contrl[CONTRL_PTSOUT] = 1;
					ptsout[0] = x;
					ptsout[1] = maxY - y;
					contrl[CONTRL_INTOUT] = 1;
					intout[0] = ch;
					return;
			}
			place_graphic_cursor(x, y);
		}
	}
}

void GSX::place_graphic_cursor(int16 x, int16 y) {
	Serial1.print(CSI_PRIVATE);
	Serial1.print(OPC_ESCAPE);
	Serial1.print(';');
	Serial1.print(ESC_PLACE_GRAPHIC_CURSOR);
	Serial1.print(';');
	Serial1.print(x);
	Serial1.print(';');
	Serial1.print(y);
	Serial1.print('G');
}

void GSX::remove_graphic_cursor() {
	Serial1.print(CSI_PRIVATE);
	Serial1.print(OPC_ESCAPE);
	Serial1.print(';');
	Serial1.print(ESC_REMOVE_GRAPHIC_CURSOR);
	Serial1.print('G');
}
			
// GSX 29: read valuator
void GSX::read_valuator() {
	// TODO
}
			
// GSX 30: read choice
void GSX::read_choice() {
	// TODO
}
			
// GSX 31: read string
void GSX::read_string() {
	// TODO
}
			
// GSX 32: set writing mode
void GSX::set_writing_mode() {
	int16 writing_mode = intin[0];
	if (writing_mode < WM_REPLACE || writing_mode > WM_ERASE) {
		writing_mode = WM_REPLACE;
	}
	send_parameter(OPC_WRITING_MODE, writing_mode);
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = writing_mode;
}
			
// GSX 33: set input mode
void GSX::set_input_mode() {
	Serial1.print(CSI_PRIVATE);
	Serial1.print(OPC_INPUT_MODE);
	Serial1.print(';');
	Serial1.print(intin[0]);
	Serial1.print(';');
	Serial1.print(intin[1]);
	Serial1.print('G');
	contrl[CONTRL_INTOUT] = 1;
	intout[0] = intin[1];
}

void GSX::send_parameter(int16 opcode, int16 parameter) {
	Serial1.print(CSI_PRIVATE);
	Serial1.print(opcode);
	Serial1.print(';');
	Serial1.print(parameter);
	Serial1.print('G');
}

void GSX::send_parameters(int16 opcode, int16 *parameters, int16 nParameters) {
	Serial1.print(CSI_PRIVATE);
	Serial1.print(opcode);
	while (nParameters > 0) {
		Serial1.print(';');
		Serial1.print(*parameters);
		++parameters;
		--nParameters;
	}
	Serial1.print('G');
}

