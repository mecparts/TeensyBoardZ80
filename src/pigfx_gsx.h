#ifndef _PiGFX_GSXh_
	#define _PiGFX_GSXh_

	#ifdef __cplusplus
		#include "Arduino.h"
	#endif

	typedef signed char		int8;
	typedef signed short		int16;
	typedef signed int		int32;
	typedef unsigned char	uint8;
	typedef unsigned short	uint16;
	typedef unsigned int		uint32;

	#define	MAX_PTSIN	75	// This is what CP/M-80 had (all the room
									// it had in GDOS for internal buffer).
									// If needed, we can expand arbitrarly.
	#define	GSX_MIN_NDC	0
	#define	GSX_MAX_NDC	32767

	#define PiGFX_WIDTH	640
	#define PiGFX_HEIGHT 464

	#define PIXEL_WIDTH 223
	#define PIXEL_HEIGHT 223

	#define TH_MIN 12
	#define TW_MIN 7
	#define FONT_HEIGHT 16
	#define FONT_WIDTH 8
	#define TEXT_ROWS 29
	#define TEXT_COLUMNS 80

	#define LW_MAX 1

	enum {
		OPC_OPEN_WORKSTATION = 1,
		OPC_CLOSE_WORKSTATION = 2,
		OPC_CLEAR_WORKSTATION = 3,
		OPC_UPDATE_WORKSTATION = 4,
		OPC_ESCAPE = 5,
		OPC_DRAW_POLYLINE = 6,
		OPC_DRAW_POLYMARKER = 7,
		OPC_DRAW_TEXT = 8,
		OPC_DRAW_FILLED_POLYGON = 9,
		OPC_DRAW_BITMAP = 10,
		OPC_DRAWING_PRIMITIVE = 11,
		OPC_TEXT_HEIGHT = 12,
		OPC_TEXT_ROTATION = 13,
		OPC_SET_PALETTE_COLOUR = 14,
		OPC_POLYLINE_LINESTYLE = 15,
		OPC_POLYLINE_LINEWIDTH = 16,
		OPC_POLYLINE_COLOUR = 17,
		OPC_POLYMARKER_STYLE = 18,
		OPC_POLYMARKER_HEIGHT = 19,
		OPC_POLYMARKER_COLOUR = 20,
		OPC_TEXT_FONT = 21,
		OPC_TEXT_COLOUR = 22,
		OPC_FILL_STYLE = 23,
		OPC_FILL_STYLE_INDEX = 24,
		OPC_FILL_COLOUR = 25,
		OPC_GET_PALETTE_COLOUR = 26,
		OPC_GET_BITMAP = 27,
		OPC_INPUT_LOCATOR = 28,
		OPC_INPUT_VALUATOR = 29,
		OPC_INPUT_CHOICE = 30,
		OPC_INPUT_STRING = 31,
		OPC_WRITING_MODE = 32,
		OPC_INPUT_MODE = 33
	};

	// Escape opcodes
	enum {
		ESC_GET_TEXT_ROWS_AND_COLUMNS = 1,
		ESC_EXIT_GRAPHICS_MODE = 2,
		ESC_ENTER_GRAPHICS_MODE = 3,
		ESC_TEXT_CURSOR_UP = 4,
		ESC_TEXT_CURSOR_DOWN = 5,
		ESC_TEXT_CURSOR_RIGHT = 6,
		ESC_TEXT_CURSOR_LEFT = 7,
		ESC_TEXT_CURSOR_HOME = 8,
		ESC_TEXT_ERASE_EOS = 9,
		ESC_TEXT_ERASE_EOL = 10,
		ESC_SET_TEXT_CURSOR = 11,
		ESC_TEXT = 12,
		ESC_TEXT_REVERSE_VIDEO_ON = 13,
		ESC_TEXT_REVERSE_VIDEO_OFF = 14,
		ESC_GET_TEXT_CURSOR = 15,
		ESC_TABLET_STATUS = 16,
		ESC_HARDCOPY = 17,
		ESC_PLACE_GRAPHIC_CURSOR = 18,
		ESC_REMOVE_GRAPHIC_CURSOR = 19,
	};

	// Drawing primitives
	enum {
		DRAW_BAR = 1,
		DRAW_ARC = 2,
		DRAW_PIE_SLICE = 3,
		DRAW_CIRCLE = 4,
		DRAW_GRAPHICS_CHAR = 5
	};

	enum {
		GSX_PB_CONTRL = 0,
		GSX_PB_INTIN,
		GSX_PB_PTSIN,
		GSX_PB_INTOUT,
		GSX_PB_PTSOUT,
		
		GSX_PB_MAX,
	};
	
	enum {	
		CONTRL_FUNCTION = 0, // function
		CONTRL_PTSIN, 
		CONTRL_PTSOUT,	
		CONTRL_INTIN,
		CONTRL_INTOUT,
		CONTRL_SPECIAL
	};
	
	enum {
		CONTROL_FUNCTIONID = 5,
	};
	
	enum {	
		OWS_ID = 0,
		OWS_LINETYPE,
		OWS_POLYLINE_COLOUR_INDEX,
		OWS_MARKER_TYPE,
		OWS_POLYMARKER_COLOUR_INDEX,
		OWS_TEXT_FONT,
		OWS_TEXT_COLOUR_INDEX,
		OWS_FILL_INTERIOR_STYLE,
		OWS_FILL_STYLE_INDEX,
		OWS_FILL_COLOUR_INDEX
	};
	
	enum {
		OWS_INTOUT_MAX_WIDTH,
		OWS_INTOUT_MAX_HEIGHT,
		OWS_INTOUT_COORD_FLAGS,
		OWS_INTOUT_PIXEL_WIDTH,
		OWS_INTOUT_PIXEL_HEIGHT
	};
	
	enum {
		LS_SOLID = 1,
		LS_DASH,
		LS_DOT,
		LS_DASH_DOT,
		LS_LONG_DASH
	};
	
	enum {
		MS_DOT = 1,
		MS_PLUS,
		MS_ASTERISK,
		MS_CIRCLE,
		MS_CROSS
	};
	
	enum {
		FS_HOLLOW = 0,
		FS_SOLID,
		FS_HALFTONE,
		FS_HATCH
	};
	
	enum {
		FSI_VERTICAL = 1,
		FSI_HORIZONTAL,
		FSI_PLUS45,
		FSI_MINUS45,
		FSI_CROSS,
		FSI_X
	};
	
	enum {
		WM_REPLACE = 1,
		WM_TRANSPARENT,
		WM_XOR,
		WM_ERASE
	};
	
	enum {
		LID_LOCATOR = 1,
		LID_VALUATOR,
		LID_CHOICE,
		LID_STRING,
	};
	#define LID_MAX 4
	
	enum {
		IM_REQUEST = 1,
		IM_SAMPLE
	};
	
	enum {
		BLACK			= 0,
		MAROON		= 1,
		DARKGREEN	= 2,
		ORANGE		= 3,
		NAVY			= 4,
		PURPLE		= 5,
		DARKCYAN		= 6,
		GREY			= 7,
		DARKGREY    = 8,
		RED			= 9,
		GREEN			= 10,
		YELLOW		= 11,
		BLUE			= 12,
		MAGENTA		= 13,
		CYAN			= 14,
		WHITE			= 15,
		GREY01		= 232,
		GREY02		= 233,
		GREY03		= 234,
		GREY04		= 235,
		GREY05		= 236,
		GREY06		= 237,
		GREY07		= 238,
		GREY08		= 239,
		GREY09		= 240,
		GREY10		= 241,
		GREY11		= 242,
		GREY12		= 243,
		GREY13		= 244,
		GREY14		= 245,
		GREY15		= 246,
		GREY16		= 247,
		GREY17		= 248,
		GREY18		= 249,
		GREY19		= 250,
		GREY20		= 251,
		GREY21		= 252,
		GREY22		= 253,
		GREY23		= 254,
		GREY24		= 255
	};
	#define NUM_COLOURS 256

	#ifdef __cplusplus
	class GSX {
		public:
			GSX(void);
			void begin(void);
			void open_workstation(void);
			void close_workstation(void);
			void clear_workstation(void);
			void update_workstation(void);
			void escape(void);
			void draw_polyline(void);
			void draw_polymarkers(void);
			void draw_text(void);
			void draw_filled_polygon(void);
			void draw_bitmap(void);
			void drawing_primitive(void);
			void set_text_height(void);
			void set_text_direction(void);
			void set_colour_palette(void);
			void set_line_style(void);
			void set_line_width(void);
			void set_line_colour(void);
			void set_marker_style(void);
			void set_marker_height(void);
			void set_marker_colour(void);
			void set_text_font(void);
			void set_text_colour(void);
			void set_fill_style(void);
			void set_fill_index(void);
			void set_fill_colour(void);
			void read_colour_palette(void);
			void read_bitmap(void);
			void read_locator(void);
			void read_valuator(void);
			void read_choice(void);
			void read_string(void);
			void set_writing_mode(void);
			void set_input_mode(void);

			int16*	contrl;
			int16*	intin;
			int16*	ptsin;
			int16*	intout;
			int16*	ptsout;
			int16		int_ptsin[MAX_PTSIN * 2 + 2]; // allow one extra vertice to close polygon
			int16		maxX, maxY;

			int16 ndc_to_dev(long ndc, long dev_min, long dev_max) {
				return ndc * (dev_max - dev_min) / GSX_MAX_NDC + dev_min;
			};
			int16 dev_to_ndc(long dev, long dev_min, long dev_max) {
				return (dev - dev_min) * GSX_MAX_NDC / (dev_max - dev_min);
			};
		private:
			void send_parameter(int16 opcode, int16 parameter);
			void send_parameters(int16 opcode, int16 *params, int16 nParams);
			void place_graphic_cursor(int16 x, int16 y);
			void remove_graphic_cursor();
	};
	#endif

#endif
