/*
 *  DLX "Linker" (global declarations)
 *  Copyright (C) 1995,1996  Peter Bergner, Aaron Sawdey
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *  Email: bergner@mountains.ee.umn.edu or sawdey@mountains.ee.umn.edu
 *
 *  Snail Mail:
 *
 *  Department of Electrical Engineering
 *  University of Minnesota
 *  4-174 EE/CSci Building
 *  200 Union Street S.E.
 *  Minneapolis, MN 55455
 *
 *
 */

#ifndef EXTERN
#define EXTERN extern
#endif

#ifndef TRUE
# define TRUE	1
# define FALSE	0
#endif

#include "sym.h"

#ifndef TRUE
# define TRUE   1
# define FALSE  0
#endif

#define  MAX_TEXT_LEN		256
#define  MAX_ASM_OPS		256

#define YYSTYPE 		NEW_YYSTYPE

/* Parse Tree Node	---  i.e. Redifined YYSTYPE
*/
typedef struct new_yystype {
    int    token;
    int    ival;
    float  fval;
    double dval;
    char   text[MAX_TEXT_LEN];
} NEW_YYSTYPE;

EXTERN FILE *outfp;
#if 0
EXTERN char basename[MAX_TEXT_LEN];
#endif
EXTERN char *outfile;

void err(char *);
int get_addr_state(void);
void set_addr_state(int);
int get_addr(void);
void set_addr(int);
void align_addr(int);
void inc_addr(int);
void init_queue(void);
int queue_empty(void);
void push_item(char *);
char *pop_item(void);
char *outname(char *);
void catN();
void fix_UNKs();

EXTERN int addr_state;
EXTERN int *address;
EXTERN struct asm_addrtype
{
    int  data_addr;
    int  text_addr;
} asm_addr;

EXTERN int errors;		/* Number of errors seen. */

EXTERN int dstart,tstart;	/* Start addr of text and data. */
EXTERN int dsize,tsize;

EXTERN int nfiles;		/* Number of files. */
EXTERN int nobjs;
EXTERN int curfileno;
EXTERN int curfile;		/* Current file. */
EXTERN char *filename;		/* Name of file being worked on. */

#define PRINTSYM  (lastsym == NULL || !(lastsym->flags&tDATA) || lastsym->init == curfile)
EXTERN Symbol *lastsym;
EXTERN int align;

EXTERN int pass;		/* pass number */

EXTERN int top_queue, btm_queue;
EXTERN char queue_text[MAX_ASM_OPS][MAX_TEXT_LEN];



#define tDATA		0x00000001	/* Data section */
#define tTEXT		0x00000002	/* Text section */
#define tGLOBAL		0x00000004	/* Has global scope */
#define	tLABEL		0x00000008	/* Has a label */
#define tFUNC		0x00000010	/* is a function */
#define tWORD		0x00000020	/* Used in .word LABEL */
#define tMINIT		0x00000040	/* symbol had multiple init. */
#define tDEF		0x00000080	/* symbol has been defined. */
#define tREF		0x00000100	/* symbol has been referenced. */
#define tUNK		0x00000200	/* could be global or local. */
#define tDELETED	0x00000400	/* symbol has been deleted. */

#define BYTES_PER_INSN		4
#define BYTES_PER_CHAR		1
#define BYTES_PER_BYTE		1
#define BYTES_PER_WORD		4
#define BYTES_PER_FLOAT		4
#define BYTES_PER_DOUBLE	8


