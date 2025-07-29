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
//	$Id: dlx.h,v 1.9 2003/11/25 01:51:56 elm Exp $

#ifndef	_dlx_h_
#define	_dlx_h_

#include <stdio.h>
#include <string.h>
#include <strings.h>
// Needed for termio restoration
#include <termios.h>
// Needed for byte order stuff
#include <netinet/in.h>

#include "dlxtypes.h"
#include "dlxdisk.h"

#ifdef	DEBUG
#define	DBPRINTF(flag, format, args...) 		\
{if (Debug(flag)) {printf (format, ## args); fflush(stdout);}}
#else
#define	DBPRINTF(flag, format, args...)
#endif	// DEBUG

extern char	debug[100];
inline
int
Debug (char flag)
{
  if (debug[0] == '+') {
    return (1);
  } else {
    return (index (debug, flag) != NULL);
  }
}

// This defines the endianness of the native machine on which the simulator
// will be run.
#define	DLX_BIG_ENDIAN		0
#define	DLX_LITTLE_ENDIAN	1
#define	DLX_NATIVE_ENDIAN	DLX_LITTLE_ENDIAN


#define	DLX_FLAG_KBD_INTERRUPT	0x80
#define	DLX_FLAG_IGNORE_EXIT	0x100
#define	DLX_TRACE_INSTRUCTIONS	0x4
#define	DLX_TRACE_MEMORY	0x8
#define	DLX_TRACE_MAX_MEM	8000

#define	DLX_TLB_NENTRIES	8	// Number of TLB entries
// The following is used in the LOGICAL page number to determine page size
// Page size is 2^(value) bytes, and the page must be aligned on a page size
// boundary.  For example, a 64 KB page must start at an address evenly
// divisible by 64 KB
#define	DLX_TLB_ENTRY_PAGESIZE_MASK	0x1f

#define	DLX_MAX_FILES		16
#define	DLX_FILE_READ		1
#define	DLX_FILE_WRITE		2

#define	DLX_OPCODE_SHIFT	26
#define	DLX_OPCODE_MASK		0x3f	// masks off 6 bit opcode
#define	DLX_RFMT_SRC1_SHIFT	21
#define	DLX_RFMT_SRC2_SHIFT	16
#define	DLX_RFMT_DST_SHIFT	11
#define	DLX_IFMT_SRC_SHIFT	21
#define	DLX_IFMT_DST_SHIFT	16
#define	DLX_IFMT_IMM_SHIFT	0
#define	DLX_REG_MASK		0x1f	// masks off regs 0-31
#define	DLX_ALU_FUNC_CODE_SHIFT	0
#define	DLX_ALU_FUNC_CODE_MASK	0x3f
#define	DLX_FPU_FUNC_CODE_SHIFT	0
#define	DLX_FPU_FUNC_CODE_MASK	0x1f

#define	DLX_FMT_IFMT		1
#define	DLX_FMT_RFMT		2
#define	DLX_FMT_JFMT		3

#define	DLX_EXC_ILLEGALINST	0x1	// Illegal instruction
#define	DLX_EXC_ADDRESS		0x2	// Bad address
#define	DLX_EXC_ACCESS		0x3	// Attempted to access illegal memory
#define	DLX_EXC_OVERFLOW	0x4	// Math overflow
#define	DLX_EXC_DIV0		0x5	// Divide by 0
#define	DLX_EXC_PRIVILEGE	0x6	// Instruction must be executed as sys
#define	DLX_EXC_FORMAT		0x7	// Instruction is malformed
#define	DLX_EXC_PAGEFAULT	0x20
#define	DLX_EXC_TLBFAULT	0x30	// Virtual page not found in TLB
#define	DLX_EXC_TLBRANGE	0x31	// TLB entry number out of range
#define	DLX_EXC_TIMER		0x40	// timer interrupt
#define	DLX_EXC_KBD		0x48	// keyboard interrupt
#define	DLX_EXC_DISK		0x50	// disk interrupt
#define	DLX_EXC_TRAP		0x100	// Actually uses vector as cause

#define	DLX_TRAP_PRINTF		0x2001
#define	DLX_TRAP_READ		0x2010
#define	DLX_TRAP_WRITE		0x2011
#define	DLX_TRAP_LSEEK		0x2012
#define	DLX_TRAP_OPEN		0x2013
#define	DLX_TRAP_CLOSE		0x2014
#define	DLX_TRAP_RANDOM		0x2020
#define	DLX_TRAP_SRANDOM	0x2021
#define	DLX_TRAP_TIME		0x2022
#define	DLX_TRAP_EXITSIM	0x2f00	// Exit a user program
#define	DLX_TRAP_EXIT		0x300	// Exit a user program

#define	DLX_STATUS_INTRMASK	0x0f	// up to 16 interrupt levels
#define	DLX_STATUS_FPTRUE	0x20
#define	DLX_STATUS_SYSMODE	0x40	// Set -> in system mode
#define	DLX_STATUS_PAGE_TABLE	0x100	// Set -> use a page table
#define	DLX_STATUS_TLB		0x200	// Set -> use a software-loaded TLB
#define	DLX_STATUS_XLATE_RD	0x400	// Set -> system mode reads go thru VM
#define	DLX_STATUS_XLATE_WR	0x800	// Set -> system mode writes go thru VM

#define	DLX_PTE_VALID		0x00000001
#define	DLX_PTE_DIRTY		0x00000002
#define	DLX_PTE_REFERENCED	0x00000004
#define	DLX_PTE_MASK		0x00000007

#define	DLX_SREG_PC		0
#define	DLX_SREG_IR31		2
#define	DLX_SREG_ISR		3
#define	DLX_SREG_IAR		4
#define	DLX_SREG_STATUS		5
#define	DLX_SREG_CAUSE		6
#define	DLX_SREG_INTRVEC	8
#define	DLX_SREG_FAULT_ADDR	9
#define	DLX_SREG_PGTBL_BASE	16
#define	DLX_SREG_PGTBL_SIZE	17
#define	DLX_SREG_PGTBL_BITS	18

#define	DLX_TIMER_SETTIMER	0xfff00010
#define	DLX_TIMER_NOT_ACTIVE	1e50

// I/O addresses
#define	DLX_IO_BASE		0xfff00000
#define	DLX_IO_SIZE		0x000fff00
#define	DLX_GETMEMSIZE		(DLX_IO_BASE + 0xf0000)

// Keyboard information
#define	DLX_KBD_PUTCHAR		(DLX_IO_BASE + 0x100)
#define	DLX_KBD_NCHARSOUT	(DLX_IO_BASE + 0x120)
#define	DLX_KBD_GETCHAR		(DLX_IO_BASE + 0x180)
#define	DLX_KBD_NCHARSIN	(DLX_IO_BASE + 0x1a0)
#define	DLX_KBD_INTR		(DLX_IO_BASE + 0x1c0)
#define	DLX_KBD_FREQUENCY	5000
#define	DLX_KBD_BUFFER_SIZE	100

// Disk information
#define	DLX_DISK_REQ		(DLX_IO_BASE + 0x400)
#define	DLX_DISK_STATUS		(DLX_IO_BASE + 0x408)
#define	DLX_DISK_MAX_DISKS	4
#define	DLX_DISK_ADDR_MIN	(DLX_DISK_REQ)
#define	DLX_DISK_ADDR_MAX	(DLX_DISK_STATUS + sizeof (uint32) + \
				 (DLX_DISK_MAX_DISKS-1)*0x10)

#define	DLX_DISK_BLOCK_SIZE	512
#define	DLX_DISK_IO_READ	1
#define	DLX_DISK_IO_WRITE	2

// Memory access type
#define	DLX_MEM_READ		1
#define	DLX_MEM_WRITE		2
#define	DLX_MEM_INSTR		4

typedef struct {
  uint32	opcode;
  uint32	fmt;
  InstrFunc	handler;
} Instruction;

typedef struct {
  char			*inst;
  uint32		reg;
  uint32		addr;
  uint32		value;
} MemRef;

class Cpu {
private:
  uint32	flags;
  double	usPerInst;
  double	usElapsed;
  double	instrsExecuted;
  double	timerInterrupt;
  double	realElapsed;
  uint32	sreg[32];
  uint32	ireg[32];
  uint32	freg[32];
  uint32	tlb[DLX_TLB_NENTRIES*2];
  FILE		*fp[DLX_MAX_FILES];
  char		kbdbuffer[DLX_KBD_BUFFER_SIZE];
  int		kbdbufferedchars;
  int		kbdwpos;
  int		kbdrpos;
  int		kbdcounter;
  int		memSize;
  uint32	*memory;
  uint32	codestart, codesize;
  uint32	datastart, datasize;
  int		fullmem;
  int		verbose;
  int		bindump;
  FILE		*tracefp;
  FILE		*startdumpfp;
  FILE		*enddumpfp;
  uint32	basicBlockStart;
  int		naccesses;
  double	diskIntrTime;
  Disk		*disk[DLX_DISK_MAX_DISKS];
  struct termios term;
  MemRef	accesses[DLX_TRACE_MAX_MEM];
  static Instruction	rrrInstrs[64];
  static Instruction	fpInstrs[32];
  static Instruction	regInstrs[64];
  inline int	 VaddrToPaddr (uint32 vaddr, uint32& paddr, uint32 op,
			       uint32 flags = 0);
  inline int	CheckFd (int fd);
  void		FileIo (int kind);
  uint32	GetParam (int paramNum);
  void		SetResult (uint32 value);
  void		OutputBasicBlockActual ();
  void		SetupRawIo ();
  void		ClearRawIo ();
  int		GetCharIfAvail ();
public:
  Cpu (int memSize = 1024 * 1024 * 16);
  inline int	CheckAddr (uint32 addr) {return (addr < memSize);}
  inline uint32 Memory(uint32 addr) {return (ntohl(memory[addr >> 2]));}
  inline uint32 *MemoryBase () const {return (memory);}
  inline void	 SetMemory(uint32 addr, uint32 v) {memory[addr >> 2]=htonl(v);}
  static inline void	GetRFields (uint32 i,uint32& s1,uint32& s2,uint32& d);
  static inline void	GetIFields (uint32 i,uint32& s1,uint32& m,uint32& d);
  static inline void	GetJFields (uint32 i,uint32& jaddr);
  static 	void SignExtend16 (uint32& v);
  static 	void SignExtend8 (uint32& v);
  inline int	Jump (uint32 jmpDst);
  inline uint32 EffectiveAddress (uint32 addrReg, uint32 offset);
  inline uint32 GetIreg (uint32 reg) const;
  inline void	PutIreg (uint32 reg, uint32 val);
  inline uint32 GetFreg (uint32 reg) const;
  inline float	GetFregF (uint32 reg) const;
  inline double GetFregD (uint32 reg) const;
  inline void	PutFreg (uint32 reg, uint32 val);
  inline void	PutFregF (uint32 reg, float val);
  inline void	PutFregD (uint32 reg, double val);
  inline uint32 GetSreg (uint32 reg) const;
  inline void	PutSreg (uint32 reg, uint32 val);
  inline void	GetTlb (uint32 ntry, uint32& vpage, uint32& ppage);
  inline void	SetTlb (uint32 ntry, uint32 vpage, uint32 ppage);
  inline void	AccessTlb (uint32 ntry, uint32 flags);
  inline void	TraceAccess (char *inst, int reg, uint32 addr, uint32 value);
  inline uint32 PC() const {return (sreg[DLX_SREG_PC]);}
  inline void	SetPC (uint32 pc);
  inline void	InitPC (uint32 pc);
  inline uint32	StatusBit (uint32 b) const;
  inline void	SetStatusBit (uint32 b);
  inline void	ClrStatusBit (uint32 b);
  inline int	UserMode () const;
  inline void	EnableInterrupts () {SetIntrLevel (0);}
  inline void	DisableInterrupts () {SetIntrLevel (0xf);}
  inline int	IntrLevel () const;
  inline void	SetIntrLevel (int level);
  void		SetInstrTime (double t) {usPerInst = t;}
  double	GetElapsed () const {return (usElapsed);}
  void		Printf ();
  void		Open ();
  void		Close ();
  void		Read ();
  void		Write ();
  void		Seek ();
  void		Exit ();
  void		Random ();
  void		Srandom ();
  void		GetTime ();
  int		LoadMemory (const char *file, uint32& startAt);
  int		CauseException (int excType);
  int		VmTranslate (uint32 vmAddr, uint32& physAddr);
  int		ReadWord (uint32 vmAddr, uint32& val, uint32 op=DLX_MEM_READ);
  int		WriteWord (uint32 vmAddr, uint32 val);
  int		TestWriteWord (uint32 vmAddr);
  int		DoRfe (uint32 inst);
  int		ExecOne ();
  void		SetTimer (uint32 val);
  void		KbdPutChar (uint32 val);
  uint32	KbdGetChar ();
  uint32	KbdNumInChars () {return (kbdbufferedchars);};
  uint32	KbdNumOutChars () {return(0);};
  void		IgnoreExit (int i);
  int		IgnoreExit() const {return ((flags&DLX_FLAG_IGNORE_EXIT)!=0);}
  inline void	OutputBasicBlock (uint32 jmpDst);
  int		TraceFile (char *name);
  int		Startdump (char *name);
  int		Enddump (char *name);
  int		DumpMem(FILE * fp);
  void		Fullmem(int f);
  void		Verbose(int v);
  void		Bindump(int b);
  FILE *	GetStartDump(void);
  void		Tracing (int t) {flags |= t & (DLX_TRACE_INSTRUCTIONS |
					       DLX_TRACE_MEMORY);}
  int		Flags () const {return (flags);}
  FILE *	TraceFp () {return (tracefp);}
  void		SetDisk (int n, Disk *theDisk) {disk[n] = theDisk;}
};

inline
void
Cpu::SetPC (uint32 pc)
{
  sreg[DLX_SREG_PC] = pc;
}

inline
void
Cpu::InitPC (uint32 pc)
{
  sreg[DLX_SREG_PC] = pc;
  basicBlockStart = pc;
  naccesses = 0;
}
inline
int
Cpu::UserMode () const
{
  return (! StatusBit (DLX_STATUS_SYSMODE));
}

inline
uint32
Cpu::StatusBit (uint32 b) const
{
  return ((sreg[DLX_SREG_STATUS] & b) != 0);
}

inline
void
Cpu::SetStatusBit (uint32 b)
{
  sreg[DLX_SREG_STATUS] |= b;
}

inline
void
Cpu::ClrStatusBit (uint32 b)
{
  sreg[DLX_SREG_STATUS] &= ~b;
}

inline
void
Cpu::PutIreg (uint32 reg, uint32 val)
{
  if (reg != 0) {
    ireg[reg] = val;
  }
}

inline
uint32
Cpu::GetIreg (uint32 reg) const
{
  return (ireg[reg]);
}

inline
void
Cpu::PutFreg (uint32 reg, uint32 val)
{
  freg[reg] = val;
}

inline
uint32
Cpu::GetFreg (uint32 reg) const
{
  return (freg[reg]);
}

inline
void
Cpu::PutFregF (uint32 reg, float val)
{
  ((float *)freg)[reg] = val;
}

inline
float
Cpu::GetFregF (uint32 reg) const
{
  return (((float *)freg)[reg]);
}

inline
void
Cpu::PutFregD (uint32 reg, double val)
{
  ((double *)freg)[reg>>1] = val;
}

inline
double
Cpu::GetFregD (uint32 reg) const
{
  return (((double *)freg)[reg>>1]);
}

inline
void
Cpu::PutSreg (uint32 reg, uint32 val)
{
  DBPRINTF ('S', "Putting 0x%x in special reg %d.\n", val, reg);
  if (reg != 0) {
    sreg[reg] = val;
  }
}

inline
uint32
Cpu::GetSreg (uint32 reg) const
{
  return (sreg[reg]);
}

inline
void
Cpu::GetTlb (uint32 ntry, uint32& vpage, uint32& ppage)
{
  ntry = (ntry % DLX_TLB_NENTRIES) * 2;
  vpage = tlb[ntry];
  ppage = tlb[ntry+1];
}

inline
void
Cpu::SetTlb (uint32 ntry, uint32 vpage, uint32 ppage)
{
  ntry = (ntry % DLX_TLB_NENTRIES) * 2;
  tlb[ntry] = vpage;
  tlb[ntry+1] = ppage;
}

inline
void
Cpu::AccessTlb (uint32 ntry, uint32 flags)
{
  ntry = (ntry % DLX_TLB_NENTRIES) * 2;
  tlb[ntry] |= (flags & (DLX_PTE_REFERENCED | DLX_PTE_DIRTY));
}

inline
int
Cpu::CheckFd (int fd)
{
  if ((fd < 0) || (fd >= DLX_MAX_FILES) || (fp[fd] == NULL)) {
    return (0);
  } else {
    return (1);
  }
}

inline
int
Cpu::IntrLevel () const
{
  return (GetSreg(DLX_SREG_STATUS) & DLX_STATUS_INTRMASK);
}

inline
void
Cpu::SetIntrLevel (int l)
{
  PutSreg (DLX_SREG_STATUS,
	   (GetSreg(DLX_SREG_STATUS) & ~DLX_STATUS_INTRMASK) |
	   (l & DLX_STATUS_INTRMASK));
}

inline
void
Cpu::TraceAccess (char *c, int r, uint32 addr, uint32 v)
{
  if (flags & DLX_TRACE_MEMORY) {
    accesses[naccesses].inst = c;
    accesses[naccesses].reg = r;
    accesses[naccesses].addr = addr;
    accesses[naccesses].value = v;
    naccesses++;
  }
}

inline
void
Cpu::OutputBasicBlock (uint32 jmpDst)
{
  if (flags & (DLX_TRACE_INSTRUCTIONS | DLX_TRACE_MEMORY)) {
    OutputBasicBlockActual ();
    basicBlockStart = jmpDst;
  }
}

#endif	// _dlx_h_
