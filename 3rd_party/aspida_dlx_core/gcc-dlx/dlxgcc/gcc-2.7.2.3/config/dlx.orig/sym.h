/*
 *  Symbol table for DLX-ld (header file).
 *  Copyright (C) 1994,1995,1996  Aaron Sawdey
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
 *  Email: sawdey@mountains.ee.umn.edu
 *
 *  Snail Mail:
 *
 *  Department of Electrical Engineering
 *  University of Minnesota
 *  4-174 EE/CSci Building
 *  200 Union Street S.E.
 *  Minneapolis, MN 55455
 */

#define HASHSIZE 4001

typedef struct Symbol_s Symbol;

struct Symbol_s {
        Symbol 		*next;		/* chaining for hash table */
	char		*name;		/* char representation */
	char		*outname;	/* Output name */
	int		addr;		/* address */
	int		flags;
	int 		fileno;		/* file number when multiple .o's */
	int		libno;
	int		size;
	int		init;		/* file # where global was inited */
};

typedef struct libsym_s {
  struct libsym_s 	*next;		/* chaining for hash table */
  struct libsym_s	*fnext;		/* next sym in this file */
  char			*name;		/* name of sym */
  char			*file;		/* obj file sym is in. */
  int			flags;		/* flags (tREF or tDEF) */
  int			libno;		/* what library is it in? */
} libsym;

extern int hash_occupancy, num_collisions;

EXTERN libsym *libtab[HASHSIZE];
EXTERN Symbol *symtab[HASHSIZE];

libsym *libsym_find(char *);
libsym *libsym_insert(libsym *);
Symbol *newsymbol(char *, int);
char *outname(char *);
Symbol *findsymbol(char *,int);
void initsymbol();
Symbol *hashinsert(Symbol *);
long hash(char *);
void *cmalloc(int, char *);
