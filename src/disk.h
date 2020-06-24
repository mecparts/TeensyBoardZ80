#ifndef DISK_H
#define DISK_H

/*
Disk errors
*/
#define errREAD		1
#define errRODISK		2
#define errROFILE		3
#define errSELECT		4

#define RO	(roVector & (1 << F->dr))

// Prints out a BDOS error
uint16 _error(uint8 error, uint16 fcbaddr) {
	if (~getZsdosErrorMode() & SuppressErrMsgFlag) {
		_puts("\r\nZSDOS error on ");
		_putcon('A' + cDrive);
		_puts(": ");
		switch (error) {
			case errREAD:
				_puts("Bad Sector");
				break;
			case errRODISK:
				_puts("W/P");
				break;
			case errROFILE:
				_puts("File W/P");
				break;
			case errSELECT:
				_puts("No Drive");
				break;
			default:
				_puts("Unknown");
				break;
		}
		_puts("\r\nCall ");
		if( bdosFunc >= 100 ) {
			_putcon('0' + bdosFunc / 100);
		}
		if( bdosFunc >= 10 ) {
			_putcon('0' + (bdosFunc / 10) % 10);
		}
		_putcon('0' + bdosFunc % 10);
		if (fcbaddr) {
			CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
			_puts("  File: ");
			if (F->dr) {
				_putcon('A'+F->dr-1);
			}
			uint8 uc;
			if (getZsdosErrorMode() && F->s1 >= 0x80 && F->s1 <= 0x8F) {
				uc = F->s1 & 0x7F;
			} else {
				uc = userCode;
			}
			if (uc >= 10) {
				_putcon('0' + uc / 10);
				uc %= 10;
			}
			_putcon('0' + uc);
			_putcon(':');
			for (uint i=0; i<8; ++i) {
				if ((F->fn[i] & 0x7F) > ' ') {
					_putcon(F->fn[i] & 0x7F);
				}
			}
			_putcon('.');
			for (uint i=0; i<3; ++i) {
				if ((F->tp[i] & 0x7F) > ' ') {
					_putcon(F->tp[i] & 0x7F);
				}
			}
		}
		_puts("\r\n");
	}
	if( ~getZsdosErrorMode() & ReturnErrCodeFlag ) {
		_getcon();
		_puts("\r\n");
		cDrive = oDrive;
		_RamWrite(0x0004, (_RamRead(0x0004) & 0xf0) | oDrive);
		Status = WBOOT;
	}
	return (error<<8) | 0xFF;		// return extended ZSDOS error information
}

uint16 _error(uint8 error) {
	return _error(error, 0);
}

// Selects the disk to be used by the next disk function
uint16 _SelectDisk(uint8 dr, uint16 fcbaddr) {
	uint16 result;
	uint8 disk[2] = { 'A', 0 };

	if (!dr || dr == '?') {
		dr = cDrive;	// This will set dr to defDisk in case no disk is passed
	} else {
		--dr;			// Called from BDOS, set dr back to 0=A: format
	}

	disk[0] += dr;
	if (_sys_select(&disk[0])) {
		loginVector = loginVector | (1 << (disk[0] - 'A'));
		result = 0x00;
	} else {
		result = _error(errSELECT, fcbaddr);
	}

	return result;
}

// Converts a FCB entry onto a host OS filename string
uint8 _FCBtoHostname(uint16 fcbaddr, uint8* filename) {
	uint8 addDot = TRUE;
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 i = 0;
	uint8 unique = TRUE;
	uint8 c;

	if (F->dr && F->dr != '?') {
		*(filename++) = (F->dr - 1) + 'A';
	} else {
		*(filename++) = cDrive + 'A';
	}
	*(filename++) = FOLDERCHAR;

	if (F->s1 >= 0x80 && F->s1 <= 0x8F) {
		*(filename++) = tohex(F->s1 & 0x7F);
	} else {
		*(filename++) = tohex(userCode);
	}
	*(filename++) = FOLDERCHAR;

	if (F->dr != '?') {
		while (i < 8) {
			c = F->fn[i] & 0x7F;
			if (c > 32)
				*(filename++) = toupper(c);
			if (c == '?')
				unique = FALSE;
			++i;
		}
		i = 0;
		while (i < 3) {
			c = F->tp[i] & 0x7F;
			if (c > 32) {
				if (addDot) {
					addDot = FALSE;
					*(filename++) = '.';  // Only add the dot if there's an extension
				}
				*(filename++) = toupper(c);
			}
			if (c == '?')
				unique = FALSE;
			++i;
		}
	} else {
		for (i = 0; i < 8; ++i) {
			*(filename++) = '?';
		}
		*(filename++) = '.';
		for (i = 0; i < 3; ++i) {
			*(filename++) = '?';
		}
		unique = FALSE;
	}
	*filename = 0x00;

	return(unique);
}

// Convers a host OS filename string onto a FCB entry
void _HostnameToFCB(uint16 fcbaddr, uint8* filename) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 i = 0;

	++filename;
	if (*filename == FOLDERCHAR) {	// Skips the drive and / if needed
		filename += 3;
	} else {
		--filename;
	}

	while (*filename != 0 && *filename != '.') {
		F->fn[i] = toupper(*filename);
		++filename;
		++i;
	}
	while (i < 8) {
		F->fn[i] = ' ';
		++i;
	}
	if (*filename == '.')
		++filename;
	i = 0;
	while (*filename != 0) {
		F->tp[i] = toupper(*filename);
		++filename;
		++i;
	}
	while (i < 3) {
		F->tp[i] = ' ';
		++i;
	}
}

// Converts a string name (AB.TXT) onto FCB name (AB      TXT)
void _HostnameToFCBname(uint8* from, uint8* to) {
	int i = 0;

	++from;
	if (*from == FOLDERCHAR) {	// Skips the drive and / if needed
		from += 3;
	} else {
		--from;
	}

	while (*from != 0 && *from != '.') {
		*to = toupper(*from);
		++to; ++from; ++i;
	}
	while (i < 8) {
		*to = ' ';
		++to;  ++i;
	}
	if (*from == '.')
		++from;
	i = 0;
	while (*from != 0) {
		*to = toupper(*from);
		++to; ++from; ++i;
	}
	while (i < 3) {
		*to = ' ';
		++to;  ++i;
	}
	*to = 0;
}

// sets the needed file attribute bits from the FAT file system attributes
void _copyDirAttrsToFCB(CPM_DIRENTRY* DE) {
	if (fileDirEntry.attributes & FAT_ATTRIB_READ_ONLY) {
		DE->tp[0] |= 0x80;
	}
	if (fileDirEntry.attributes & FAT_ATTRIB_ARCHIVE) {
		DE->tp[2] |= 0x80;
	}
	if (fileDirEntry.attributes & FAT_ATTRIB_SYSTEM) {
		DE->tp[1] |= 0x80;
	}
	if (fileDirEntry.attributes & FAT_ATTRIB_HIDDEN) {
		DE->fn[1] |= 0x80;
	}
	if (fileDirEntry.attributes & (1<<6)) {
		DE->fn[2] |= 0x80;
	}
	if (fileDirEntry.attributes & (1<<7)) {
		DE->fn[3] |= 0x80;
	}
}

// Creates a fake directory entry for the current dmaAddr FCB
void _mockupDirEntry(void) {
	CPM_DIRENTRY* DE = (CPM_DIRENTRY*)_RamSysAddr(dmaAddr);
	uint8 blocks;

	for (uint8 i = 0; i < sizeof(CPM_DIRENTRY); ++i) {
		_RamWrite(dmaAddr + i, 0x00); // zero out directory entry
	}
	_HostnameToFCB(dmaAddr, (uint8*)findNextDirName);

	_copyDirAttrsToFCB(DE);
	
	if (allUsers) {
		DE->dr = currFindUser; // set user code for return
	} else {
		DE->dr = userCode;
	}
	// does file fit in a single directory entry?
	if (fileExtents <= extentsPerDirEntry) {
		if (fileExtents) {
			DE->ex = (fileExtents - 1 + fileExtentsUsed) % (MaxEX + 1);
			DE->s2 = (fileExtents - 1 + fileExtentsUsed) / (MaxEX + 1);
			DE->rc = fileRecords - (BlkEX * (fileExtents - 1));
		}
		blocks = (fileRecords >> blockShift) + ((fileRecords & blockMask) ? 1 : 0);
		fileRecords = 0;
		fileExtents = 0;
		fileExtentsUsed = 0;
	} else { // no, max out the directory entry
		DE->ex = (extentsPerDirEntry - 1 + fileExtentsUsed) % (MaxEX + 1);
		DE->s2 = (extentsPerDirEntry - 1 + fileExtentsUsed) / (MaxEX + 1);
		DE->rc = BlkEX;
		blocks = numAllocBlocks < 256 ? 16 : 8;
		// update remaining records and extents for next call
		fileRecords -= BlkEX * extentsPerDirEntry;
		fileExtents -= extentsPerDirEntry;
		fileExtentsUsed += extentsPerDirEntry;
	}
	// phoney up an appropriate number of allocation blocks
	if (numAllocBlocks < 256) {
		for (uint8 i = 0; i < blocks; ++i) {
			DE->al[i] = (uint8)firstFreeAllocBlock++;
		}
	} else {
		for (uint8 i = 0; i < 2 * blocks; i += 2) {
			DE->al[i] = firstFreeAllocBlock & 0xFF;
			DE->al[i + 1] = firstFreeAllocBlock >> 8;
			++firstFreeAllocBlock;
		}
	}
}

// Matches a FCB name to a search pattern
uint8 match(uint8* fcbname, uint8* pattern) {
	uint8 result = 1;
	uint8 i;

	for (i = 0; i < 12; ++i) {
		if (*pattern == '?' || *pattern == *fcbname) {
			++pattern; ++fcbname;
			continue;
		} else {
			result = 0;
			break;
		}
	}
	return(result);
}

// Returns the size of a file
long _FileSize(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	long r, l = -1;

	if (!_SelectDisk(F->dr, fcbaddr)) {
		_FCBtoHostname(fcbaddr, &filename[0]);
		l = _sys_filesize(filename);
		r = l % BlkSZ;
		if (r)
			l = l + BlkSZ - r;
	}
	return(l);
}

// Opens a file
uint8 _OpenFile(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 result = 0xff;
	long len;
	int32 i;

	if (!_SelectDisk(F->dr, fcbaddr)) {
		if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
			F->s1 = 0x00;
		}
		_FCBtoHostname(fcbaddr, filename);
		if (_sys_openfile(filename, F) || 
			((getZsdosFlags() & ZSDOSpublic) && _sys_openpublicfile(filename, F))) {

			len = _FileSize(fcbaddr) / BlkSZ;	// Compute the len on the file in blocks

			F->s2 = 0x80;	// set unmodified flag

			F->rc = len > MaxRC ? MaxRC : (uint8)len;
			for (i = 0; i < 16; ++i)	// Clean up AL
				F->al[i] = 0x00;
			_copyDirAttrsToFCB((CPM_DIRENTRY*)F);
			result = 0x00;
		}
	}
	return(result);
}

// Closes a file
uint16 _CloseFile(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result;

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
			F->s1 = 0x00;
		}
		if (!(F->s2 & 0x80)) {					// if file is modified
			if (!RO) {								// if disk is not R/O
				_FCBtoHostname(fcbaddr, &filename[0]);
				if (_sys_closefile(filename, F)) {	// close it (update modified time)
					if (fcbaddr == BatchFCB) {
						_Truncate((char*)filename, F->rc);	// Truncate $$$.SUB to F->rc CP/M records so SUBMIT.COM can work
					}
					result = 0x00;
				} else {
					result = _error(errREAD, fcbaddr);
				}
			} else {
				result = _error(errRODISK, fcbaddr);
			}
		} else {
			result = 0x00;		// file hasn't been modified, close is a formality
		}
	}
	return result;
}

// Creates a file
uint16 _MakeFile(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result;
	uint8 i;

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!RO) {
			if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
				F->s1 = 0x00;
			}
			_FCBtoHostname(fcbaddr, &filename[0]);
			if (_sys_makefile(&filename[0])) {
				F->ex = 0x00;	// Makefile also initializes the FCB (file becomes "open")
				F->s1 = fromhex(filename[2]) | 0x80;
				F->s2 = 0x00;		// newly created files are already modified
				F->rc = 0x00;
				for (i = 0; i < 16; ++i)	// Clean up AL
					F->al[i] = 0x00;
				F->cr = 0x00;
				result = 0x00;
			}
		} else {
			result = _error(errRODISK, fcbaddr);
		}
	}
	return result;
}

// Searches for the first directory file
uint16 _SearchFirst(uint16 fcbaddr, uint8 isdir) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result = 0xff;

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
			F->s1 = 0x00;
		}
		_FCBtoHostname(fcbaddr, &filename[0]);
		allUsers = F->dr == '?';
		allExtents = F->ex == '?';
		if (allUsers) {
			result = _findfirstallusers(isdir);
		} else {
			result = _findfirst(isdir);
		}
	}
	return result;
}

// Searches for the next directory file
uint16 _SearchNext(uint16 fcbaddr, uint8 isdir) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(tmpFCB);
	uint16 result = 0xff;

	if (!_SelectDisk(F->dr, fcbaddr)) {
		if (allUsers) {
			result = _findnextallusers(isdir);
		} else {
			result = _findnext(isdir);
		}
	}
	return(result);
}

// Deletes a file
uint16 _DeleteFile(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result = 0xFF;
	uint16 fileFound;

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!RO) {
			fileFound = _SearchFirst(fcbaddr, FALSE);	// FALSE = Does not create a fake dir entry when finding the file
			while ((fileFound & 0xFF) != 0xFF) {
				_FCBtoHostname(tmpFCB, &filename[0]);
				if (_sys_deletefile(&filename[0]))
					result = 0x00;
				else {
					result = _error(errROFILE, fcbaddr);
					break;
				}
				fileFound = _SearchFirst(fcbaddr, FALSE);	// FALSE = Does not create a fake dir entry when finding the file
			}
			if (fileFound != 0x00FF && !result) {		// anything other than 0x00FF is an error
				result = fileFound;
			}
		} else {
			result = _error(errRODISK, fcbaddr);
		}
	}
	return result;
}

// Renames a file
uint16 _RenameFile(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result;

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!RO) {
			_RamWrite(fcbaddr + 16, _RamRead(fcbaddr));	// Prevents rename from moving files among folders
			_RamWrite(fcbaddr + 16 + 13, 0x00);				// make sure S1 starts out as 0
			_FCBtoHostname(fcbaddr + 16, &newname[0]);
			_RamWrite(fcbaddr + 13, 0x00);					// make sure S1 starts out as 0
			_FCBtoHostname(fcbaddr, &filename[0]);
			if (_sys_renamefile(&filename[0], &newname[0])) {
				result = 0x00;
			} else {
				result = 0xFF;
			}
		} else {
			result = _error(errRODISK, fcbaddr);
		}
	}
	return result;
}

// Sequential read
uint8 _ReadSeq(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 result = 0xff;

	long fpos = ((F->s2 & MaxS2) * BlkS2 * BlkSZ) +
		(F->ex * BlkEX * BlkSZ) +
		(F->cr * BlkSZ);

	if (!_SelectDisk(F->dr, fcbaddr)) {
		_FCBtoHostname(fcbaddr, &filename[0]);
		result = _sys_readseq(&filename[0], fpos);
		if (!result) {	// Read succeeded, adjust FCB
			++F->cr;
			if (F->cr > MaxCR) {
				F->cr = 1;
				++F->ex;
			}
			if (F->ex > MaxEX) {
				F->ex = 0;
				++F->s2;
			}
			if ((F->s2 & 0x7F) > MaxS2)
				result = 0xfe;	// (todo) not sure what to do 
		}
	}
	return(result);
}

// Sequential write
uint16 _WriteSeq(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result;

	long fpos = ((F->s2 & MaxS2) * BlkS2 * BlkSZ) +
		(F->ex * BlkEX * BlkSZ) +
		(F->cr * BlkSZ);

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!RO) {
			_FCBtoHostname(fcbaddr, &filename[0]);
			result = _sys_writeseq(&filename[0], fpos);
			if (!result) {	// Write succeeded, adjust FCB
				F->s2 &= 0x7F;		// reset unmodified flag
				++F->cr;
				if (F->cr > MaxCR) {
					F->cr = 1;
					++F->ex;
				}
				if (F->ex > MaxEX) {
					F->ex = 0;
					++F->s2;
				}
				if (F->s2 > MaxS2) {
					result = 0xfe;	// (todo) not sure what to do 
				}
			}
		} else {
			result = _error(errRODISK, fcbaddr);
		}
	}
	return result;
}

// Random read
uint8 _ReadRand(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 result = 0xff;

	int32 record = (F->r2 << 16) | (F->r1 << 8) | F->r0;
	long fpos = record * BlkSZ;

	if (!_SelectDisk(F->dr, fcbaddr)) {
		_FCBtoHostname(fcbaddr, &filename[0]);
		result = _sys_readrand(&filename[0], fpos);
		if (result == 0 || result == 1 || result == 4) {
			// adjust FCB unless error #6 (seek past 8MB - max CP/M file & disk size)
			F->cr = record & 0x7F;
			F->ex = (record >> 7) & 0x1f;
			if (F->s2 & 0x80) {
				F->s2 = ((record >> 12) & MaxS2) | 0x80;
			} else {
				F->s2 = (record >> 12) & MaxS2;
			}
		}
	}
	return(result);
}

// Random write
uint16 _WriteRand(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result;

	int32 record = (F->r2 << 16) | (F->r1 << 8) | F->r0;
	long fpos = record * BlkSZ;

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!RO) {
			_FCBtoHostname(fcbaddr, &filename[0]);
			result = _sys_writerand(&filename[0], fpos);
			if (!result) {	// Write succeeded, adjust FCB
				F->cr = record & 0x7F;
				F->ex = (record >> 7) & 0x1F;
				F->s2 = (record >> 12) & MaxS2;	// resets unmodified flag
			}
		} else {
			result = _error(errRODISK, fcbaddr);
		}
	}
	return result;
}

// Returns the size of a CP/M file
uint8 _GetFileSize(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 result = 0xff;
	int32 count ;
	
	if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
		F->s1 = 0x00;
	}
	count = _FileSize(DE) >> 7;

	if (count != -1) {
		F->r0 = count & 0xff;
		F->r1 = (count >> 8) & 0xff;
		F->r2 = (count >> 16) & 0xff;
		result = 0x00;
	}
	return(result);
}

// Set the next random record
uint8 _SetRandom(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 result = 0x00;

	int32 count = F->cr & 0x7f;
	count += (F->ex & 0x1f) << 7;
	count += (F->s2 & MaxS2) << 12;

	F->r0 = count & 0xff;
	F->r1 = (count >> 8) & 0xff;
	F->r2 = (count >> 16) & 0xff;

	return(result);
}

// Sets the current user area
void _SetUser(uint8 user) {
	userCode = user & 0x1f;	// BDOS unoficially allows user areas 0-31
							// this may create folders from G-V if this function is called from an user program
							// It is an unwanted behavior, but kept as BDOS does it
	_MakeUserDir();			// Creates the user dir (0-F[G-V]) if needed
}

// Creates a disk directory folder
uint8 _MakeDisk(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	return(_sys_makedisk(F->dr));
}

// set the file attributes in the directory from the FCB
uint16 _SetFileAttributes(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result;

	result = _SelectDisk(F->dr, fcbaddr);
	if (!result) {
		if (!RO) {
			if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
				F->s1 = 0x00;
			}
			_FCBtoHostname(fcbaddr, &filename[0]);
			result = _sys_setfileattributes(&filename[0],fcbaddr);
			if (!result) {
				// copy FCB to first 32 bytes of DMA address
				_RamWrite(dmaAddr, userCode);
				for (uint8 i = 0; i < sizeof(CPM_DIRENTRY); ++i) {
					_RamWrite(dmaAddr + i, _RamRead(fcbaddr + i));
				}
				_RamWrite(dmaAddr, userCode);
			}
		} else {
			result = _error(errRODISK, fcbaddr);
		}
	}
	return result;
}

// Checks if there's a temp submit file present
uint8 _CheckSUB(void) {
	uint8 result;
	uint8 oCode = userCode;							// Saves the current user code (original BDOS does not do this)
	_HostnameToFCB(tmpFCB, (uint8*)"$???????.???");	// The original BDOS in fact only looks for a file which start with $
#ifdef BATCHA
	_RamWrite(tmpFCB, 1);							// Forces it to be checked on drive A:
#endif
#ifdef BATCH0
	userCode = 0;									// Forces it to be checked on user 0
#endif
	result = (_SearchFirst(tmpFCB, FALSE) == 0x00) ? 0xff : 0x00;
	userCode = oCode;								// Restores the current user code
	return(result);
}

uint8 _getZsDosFileTimeStamp(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint8 result = 0xFF;

	if (!_SelectDisk(F->dr, fcbaddr)) {
		if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
			F->s1 = 0x00;
		}
		_FCBtoHostname(fcbaddr, filename);
		result = _sys_getfiletimestamp(filename);
	}
	return result;
}

uint16 _setZsDosFileTimeStamp(uint16 fcbaddr) {
	CPM_FCB* F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	int result = 0xFF;

	if (!_SelectDisk(F->dr, fcbaddr)) {
		if (!getZsdosErrorMode() || !(F->s1 >= 0x80 && F->s1 <= 0x8F)) {
			F->s1 = 0x00;
		}
		_FCBtoHostname(fcbaddr, filename);
		result = _sys_setfiletimetamp(filename);
	}
	return result;
}

#endif
