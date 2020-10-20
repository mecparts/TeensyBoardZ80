#ifndef GLOBALS_H
#define GLOBALS_H

/* Definitions for file/console based debugging */
//#define DEBUG
//#define DEBUGLOG		// Writes extensive call trace information to RunCPM.log
//#define CONSOLELOG	// Writes debug information to console instead of file
//#define LOGONLY 22	// If defined will log only this BDOS (or BIOS) function
#define LogName "RunCPM.log"
//#define iDEBUG		// Instruction debugger (PC only, for development)

/* T4RunZCPR version for the greeting header */
#define VERSION	"1.0"
#define VersionBCD 0x10

#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)

/* Definition of the CCP memory information */
//
#define CCPname		"ZCPR33." STR(CPMSIZE) "K"
#define Z3REV 33
#define VersionCCP	0x05
#define BatchFCB	(CCPaddr + 0x5E)		// Position of the $$$.SUB fcb on this CCP
#define CCPaddr		(BDOSjmppage-0x0800)
//
//#define PROFILE		// For measuring time taken to run a CP/M command
						// This should be enabled only for debugging purposes when trying to improve emulation speed

/* Definition for CP/M 2.2 user number support */

#define BATCHA			// If this is defined, the $$$.SUB will be looked for on drive A:
//#define BATCH0		// If this is defined, the $$$.SUB will be looked for on user area 0
						// The default behavior of DRI's CP/M 2.2 was to have $$$.SUB created on the current drive/user while looking for it
						// on drive A: current user, which made it complicated to run SUBMITs when not logged to drive A: user 0

/* Some environment and type definitions */

#ifndef TRUE
#define FALSE 0
#define TRUE 1
#endif

typedef signed char		int8;
typedef signed short		int16;
typedef signed int		int32;
typedef unsigned char	uint8;
typedef unsigned short	uint16;
typedef unsigned int		uint32;

#define LOW_DIGIT(x)            ((x) & 0xf)
#define HIGH_DIGIT(x)           (((x) >> 4) & 0xf)
#define LOW_REGISTER(x)         ((x) & 0xff)
#define HIGH_REGISTER(x)        (((x) >> 8) & 0xff)

#define SET_LOW_REGISTER(x, v)  x = (((x) & 0xff00) | ((v) & 0xff))
#define SET_HIGH_REGISTER(x, v) x = (((x) & 0xff) | (((v) & 0xff) << 8))

#define WORD16(x)	((x) & 0xffff)

/* CP/M disk definitions */
#define BlkSZ 128	// CP/M block size
#define BlkEX 128	// Number of blocks on an extension
#define ExtSZ (BlkSZ * BlkEX)
#define BlkS2 4096	// Number of blocks on a S2 (module)
#define MaxEX 31	// Maximum value the EX field can take
#define MaxS2 63	// Maximum value the S2 (modules) field can take - Can be set to 63 to emulate CP/M Plus
#define MaxCR 128	// Maximum value the CR field can take
#define MaxRC 128	// Maximum value the RC field can take

/* CP/M memory definitions */
#define RAM_FAST	// If this is defined, all RAM function calls become direct access (see below)
					// This saves about 2K on the Arduino code and should bring speed improvements

#define CPMSIZE 62 // Can be 64 for CP/M 2.2 compatibility or more, up to 66 for extra memory
					// Values other than 62 or 66 would require rebuilding the CCP
					// CCP ORG = (CPMSIZE * 1024) - 0x0600 - 0x0E00 - 0x0800


#define MEMSIZE 64 * 1024	// RAM(plus ROM) needs to be 64K to avoid compatibility issues

#define IOBYTE	0x0003

#ifdef RAM_FAST		// Makes all function calls to memory access into direct RAM access (less calls / less code)
static uint8 RAM[MEMSIZE];
#define _RamSysAddr(a)		&RAM[a]
#define _RamRead(a)			RAM[a]
#define _RamRead16(a)		((RAM[(a & 0xffff) + 1] << 8) | RAM[a & 0xffff])
#define _RamWrite(a, v)		RAM[a] = v
#define _RamWrite16(a, v)	RAM[a] = (v) & 0xff; RAM[a + 1] = (v) >> 8
#endif

//// Size of the allocated pages (Minimum size = 1 page = 256 bytes)

// BIOS Pages (always on the top of memory)
#define TERM_COLS	80
#define TERM_ROWS	29

#define EXTSTK_B	48
#define Z3CL_B		208
#define Z3TCAP_S	1
#define Z3TCAP_B	(128 * Z3TCAP_S)
#define Z3ENV_S	1
#define Z3ENV_B	(128 * Z3ENV_S)
#define EXTFCB_B	48
#define Z3MSG_B	80
#define SHSTK_N	4
#define SHSTK_L	32
#define SHSTK_B	(SHSTK_N * SHSTK_L)
#define Z3NDIR_S	28
#define Z3NDIR_B	(18 * Z3NDIR_S + 8)
#define FCP_S		6
#define FCP_B		(128 * FCP_S)
#define RCP_S		8
#define RCP_B		(128 * RCP_S)
#define IOP_S		0
#define IOP_B		(128 * IOP_S)

#if EXTSTK_B
#define EXTSTK	(MEMSIZE - EXTSTK_B)
#else
#define EXTSTK	0
#endif

#if Z3CL_B
#define Z3CL	(MEMSIZE - EXTSTK_B - Z3CL_B)
#else
#define Z3CL	0
#endif

#if Z3TCAP_B
#define Z3TCAP	(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B)
#else
#define Z3TCAP	0
#endif

#if Z3ENV_B
#define Z3ENV	(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B)
#else
#define Z3ENV	0
#endif

#if EXTFCB_B
#define EXTFCB	(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B)
#else
#define EXTFCB	0
#endif

#if Z3MSG_B
#define Z3MSG	(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B - Z3MSG_B)
#else
#define Z3MSG	0
#endif

#if SHSTK_B
#define SHSTK	(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B - Z3MSG_B - SHSTK_B)
#else
#define SHSTK	0
#endif

#if Z3NDIR_B
#define Z3NDIR	(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B - Z3MSG_B - SHSTK_B - Z3NDIR_B)
#else
#define Z3NDIR	0
#endif

#if FCP_B
#define FCP		(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B - Z3MSG_B - SHSTK_B - Z3NDIR_B - FCP_B)
#else
#define FCP		0
#endif

#if RCP_B
#define RCP		(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B - Z3MSG_B - SHSTK_B - Z3NDIR_B - FCP_B - RCP_B)
#else
#define RCP		0
#endif

#if IOP_B
#define IOP		(MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B - Z3MSG_B - SHSTK_B - Z3NDIR_B - FCP_B - RCP_B - IOP_B)
#else
#define IOP		0
#endif

#define BIOS_TOP	((MEMSIZE - EXTSTK_B - Z3CL_B - Z3TCAP_B - Z3ENV_B - EXTFCB_B - Z3MSG_B - SHSTK_B - Z3NDIR_B - FCP_B - RCP_B - IOP_B) & 0xFF00)
#define Z3WHL		0x004B
#define EXPATH		0x0040
#define EXPATH_S	5

#define MAXDSK		'F'
#define MAXUSR		15

#define numBIOScalls 23
#define BIOSpage		(BIOS_TOP - 256)
#define BIOSjmppage	(BIOSpage - 256)
#define DPBaddr	(BIOSpage + 256 - 16)	// Address of the Disk Parameters Block (Hardcoded in BIOS)
#define DPHaddr   (DPBaddr - 16)
#define DirBufAddr (DPHaddr - 128)
#if (BIOSpage + numBIOScalls * 3) > DirBufAddr
#error Collision between BIOS jumps and DirBuf
#endif

// BDOS Pages (depend on CPMSIZE)
#define BDOSsize		0x0E00
#define BDOSjmppage	(BIOSjmppage - BDOSsize)
#define BDOSpage		(BDOSjmppage + 1024)

#define novaDosFlagsByte (BDOSpage + 0)
#define SCBaddr	(novaDosFlagsByte + 1)	// Address of the System Control Block
#define tmpFCB 	(SCBaddr + 48)	// Address of the temporary FCB
#define fileTS		(tmpFCB + 64)	// address of the timestamp of the last open/found file
#define millisTS	(fileTS + 10)		// address of last millis() value

/* Definition of global variables */
static uint8	filename[17];		// Current filename in host filesystem format
static uint8	newname[17];		// New filename in host filesystem format
static uint8	fcbname[13];		// Current filename in CP/M format
static uint8	pattern[13];		// File matching pattern in CP/M format
static uint16	dmaAddr = 0x0080;	// Current dmaAddr
static uint8	oDrive = 0;			// Old selected drive
static uint8	cDrive = 0;			// Currently selected drive
static uint8	userCode = 0;		// Current user code
static uint16	roVector = 0;
static uint16	loginVector = 0;
static int16	bdosFunc = -1;
static uint8	allUsers = FALSE;	// true when dr is '?' in BDOS search first
static uint8	allExtents = FALSE; // true when ex is '?' in BDOS search first
static bool		publicOnly = FALSE;	// true when searching for only a public file
static uint8	currFindUser = 0;	// user number of current directory in BDOS search first on all user numbers
static uint8	blockShift;			// disk allocation block shift
static uint8	blockMask;			// disk allocation block mask
static uint8	extentMask;			// disk extent mask
static uint16	firstBlockAfterDir;	// first allocation block after directory
static uint16	numAllocBlocks;		// # of allocation blocks on disk
static uint8	extentsPerDirEntry;	// # of logical (16K) extents in a directory entry
#define logicalExtentBytes (16*1024UL)
static uint16	physicalExtentBytes;	// # bytes described by 1 directory entry

enum NovaDOSflags {
	PublicFlag = 1<<0,
	//CtrlSFlag = 1<<1,
	HiInFlag = 1<<2,
	HiOutFlag = 1<<3,
	PubROFlag = 1<<4
	//RbldVecFlag = 1<<5
};
#define setNovaDosFlags(x) _RamWrite(novaDosFlagsByte,x)
#define getNovaDosFlags() _RamRead(novaDosFlagsByte)

#define zsdosErrorModeByte (BDOSjmppage+0x005c)
enum ZSDOSerrorBits {
	SuppressErrMsgFlag = 1<<0,
	ReturnErrCodeFlag = 1<<1,
	ZsdosDefaultFlag = 1<<7
};
#define setZsdosErrorMode(x) _RamWrite(zsdosErrorModeByte,x)
#define getZsdosErrorMode() _RamRead(zsdosErrorModeByte)

#define zsdosFlagsByte (BDOSjmppage+0x0015)
enum ZSDOSflags {
	ZSDOSpublic = 1<<0,
	ZSDOSpublicRW = 1<<1,
	ZSDOSsetROvct = 1<<2,
	ZSDOSquickLogin = 1<<3,
	ZSDOSdiskChg = 1<<4,
	ZSDOSzcprPath = 1<<5,
	ZSDOSpathWpub = 1<<6
};
#define setZsdosFlags(x) _RamWrite(zsdosFlagsByte,x)
#define getZsdosFlags() _RamRead(zsdosFlagsByte)

#define tohex(x)	((x) < 10 ? (x) + '0' : (x) + 'A' - 10)
#define fromhex(x) ((x) <= '9' ? (x) - '0' : (x) - 'A' + 10)

/* Definition of externs to prevent precedence compilation errors */
#ifdef __cplusplus
extern "C"
{
#endif

#ifndef RAM_FAST
	extern uint8* _RamSysAddr(uint16 address);
	extern void _RamWrite(uint16 address, uint8 value);
#endif

	extern void _Bdos(void);
	extern void _Bios(void);

	extern void _HostnameToFCB(uint16 fcbaddr, uint8* filename);
	extern void _HostnameToFCBname(uint8* from, uint8* to);
	extern void _mockupDirEntry(void);
	extern uint8 match(uint8* fcbname, uint8* pattern);

	extern void _puts(const char* str);

#ifdef __cplusplus
}
#endif

#endif
