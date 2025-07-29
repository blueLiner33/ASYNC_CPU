/*
 *  Symbol table for DLX-ld.
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

#include <stdio.h>
#include <string.h>
#include "globals.h"

int hash_occupancy;
int num_collisions;

extern char *malloc();
extern char *calloc();

/* error checking malloc */
void *
cmalloc(int size, char *who)
{
  void *pt;

  pt = (void*)calloc(size,1);

  if(pt == NULL)
    {
      fprintf(stderr,"Out of memory in %s.\n",who);
      exit(1);
    }
  return pt;
}

/* hash function for symbol table. */
/* From the Dragon Book (Aho, Sethi, Ullman) p. 436 */
long hash(char *s)
{
  unsigned h=0 , g;

  for (  ; *s ; s++ )
    {
      h = (h << 4) + *s;
      if ((g = h&0xf0000000))
	{
	  h = h ^ (g >> 24);
	  h = h ^ g;
	}
    }

  return h;
}

libsym *
libsym_find(char *n)
{
  long h = hash(n)%HASHSIZE;
  libsym *s;

  s = libtab[h];
  while(s && (strcmp(s->name,n) || (s->flags&tDEF) == 0) ) s = s->next;

  return s;
}
/* 
 * Insert a new symbol in the hash table.
 * Returns the inserted symbol.
 */
libsym *
libsym_insert(libsym *s)
{

  libsym *si,*sn;

  long h;

  h = hash(s->name)%HASHSIZE;
  si = libtab[h];
  sn = cmalloc(sizeof(libsym),"hashinsert");
  *sn = *s;
  sn->next = NULL;

  if(si == NULL)
    {
      libtab[h] = sn;
      return sn;
    }

  /* insert at end of chain */
  while(si->next != NULL) si = si->next;

  si->next = sn;

  return sn;
}

/* 
 * Insert a new symbol in the hash table.
 * Returns the inserted symbol.
 */
Symbol *hashinsert(Symbol *s)
{

  Symbol *si,*sn;

  long h;

  hash_occupancy++;

  h = hash(s->name)%HASHSIZE;
  si = symtab[h];

  if(si == NULL)
    {
      si = cmalloc(sizeof(Symbol),"hashinsert");

      symtab[h] = si;

      *si = *s;

      si->next = NULL;	/* sanity */

      return si;	/* success */
    }

  num_collisions++;

  sn = cmalloc(sizeof(Symbol),"hashinsert");

  *sn = *s;	/* copy new symbol. */

  sn->next = si;

  symtab[h] = sn;

  return sn;
}

/*
 * Reinitialize the symbol table.
 */
void reinitsymbol()
{
  int i;
  Symbol *p1,*p2;

  hash_occupancy = 0;
  num_collisions = 0;

  for(i = 0 ; i < HASHSIZE ; i++)
    {
      p1 = symtab[i];
      while(p1 != NULL)
	{
	  p2 = p1;
	  p1 = p1->next;
	  if(p2 != NULL) {
	    if(p2->name != NULL) free(p2->name);
	    free(p2);
	  }
	}
      symtab[i] = NULL;
    }
}

/*
 * Initialize the symbol table.
 */
void initsymbol()
{
  int i;

  for(i = 0 ; i < HASHSIZE ; i++)
    {
      symtab[i] = NULL;
    }
}

/* 
 * Look for a symbol in the hash table. Returns a pointer to the
 * entry in the hash table if it found the symbol, NULL if it didn't.
 * Look for a local symbol in filenames[fileno] first, then look for
 * a global symbol.
 */
Symbol *findsymbol(char *name,int fileno)
{

  Symbol *s;

  long h = hash(name)%HASHSIZE;

  s = symtab[h];

  if(s == NULL) return(s);	/* Short-cut for an empty slot. */


  /* Look for a local symbol first. */

  while(s != NULL)
    {
      if(fileno == s->fileno && !strcmp(s->name, name)) 
	return(s);
      s = s->next;
    }

  /* Now look for a global symbol. */
  s = symtab[h];
  while(s != NULL)
    {
      if((s->flags & tGLOBAL) && !strcmp(s->name, name)) 
	return(s);
      s = s->next;
    }

  /* didn't find anything. */
  return(NULL);
}

/*
 * Find how a name is supposed to be output.
 * If it's not in the symbol table, just return
 * what was given.
 */
char *outname(char *name)
{
  Symbol *s=findsymbol(name,curfile);

  if(s==NULL || s->outname==NULL) return name;
  else return s->outname;
}


/*
 * Create a new symbol.
 * If this name is already defined for this file,
 * just return the existing def. Otherwise, create
 * a new symbol.
 */
Symbol *newsymbol(char *name, int fileno)
{
  Symbol *s;
  Symbol ss;

  long h = hash(name)%HASHSIZE;

  /*
   * Search only for a local symbol here.
   */
  s = symtab[h];
  while(s != NULL)
    {
      if(fileno == s->fileno && !strcmp(s->name, name)) 
	return(s);
      s = s->next;
    }

  /*
   * Create a new symbol.
   */
  bzero(&ss,sizeof(ss));
  ss.name = strdup(name);
  ss.outname = ss.name;
  ss.fileno = fileno;
  ss.libno = -1;
  ss.init=-1;
  return hashinsert(&ss);

}
