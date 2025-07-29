//
//	dlx.h
//
//	Definitions for the DLX simulator.  These include the instruction
//	set for DLX.
//
//	There are a few changes between this version of DLX and the
//	standard version.
//	* The OS interface is much better specified.  This includes
//	  special registers and memory management functions.
//	* Delayed branches are disabled.  It was too difficult to
//	  get them to work properly with traps and interrupts
//	* The simulator contains support for memory-mapped I/O.
//
//	Copyright (c) 1999-2003 by Ethan L. Miller
//
//	$Id: dlxdisk.h,v 1.2 2003/11/25 01:51:56 elm Exp $

#ifndef	_dlxdisk_h_
#define	_dlxdisk_h_

#define	DISK_BLOCKS_PER_TRACK	800

#define	DISK_STATUS_NOTWORKING	-1
#define	DISK_STATUS_IDLE	0

// Disk rotates at 5400 RPM
#define	DISK_ROTATION_TIME	(60.0/5400.0)

#define	DISK_MAX_OUTSTANDING_REQUESTS	100


typedef struct {
  uint32	startBlock;
  uint32	nBlocks;
  uint32	bufPtr;
  uint32	opAndStatus;
} DiskReq;

class Disk {
private:
  char		filename[200];
  int		diskSize;
  int		fd;
  int		status;
  uint32	ioId;
  int		curTrack;
  int		blocksPerTrack;
  double	rotationTime;
  double	finishTime;
  int		emptySlot;
  int		activeRequest;
  int		nRequests;
  DiskReq	reqs[DISK_MAX_OUTSTANDING_REQUESTS];
  uint32	reqAddr[DISK_MAX_OUTSTANDING_REQUESTS];
  int		curDone;
  int		nDone;
  int		doneRequests[DISK_MAX_OUTSTANDING_REQUESTS];
  double	Latency (int req);
  void		ScheduleNextRequest (class Cpu *cpu);
public:
  Disk (const char *fn, int sizeInBlocks);
  int	StartIo (uint32 reqAddr, class Cpu *cpu);
  uint32 FinishIo (class Cpu *cpu);
  uint32 GetStatus ();
  void	ClearStatus ();
  double	FinishTime() {return (finishTime);}
};

#endif	// _dlxdisk_h_
