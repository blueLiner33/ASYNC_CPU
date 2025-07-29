/*
 *  DLX "Linker"
 *  Copyright (C) 1995,1996 Peter Bergner, Aaron Sawdey
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
 *  This will link together several DLX object (assembly) files.
 *
 * - Resolves multiple copies of global variables. Complains
 *   if more than one copy is initialized.
 * - Re-names static objects to prevent conflict.
 *
 * - If run with the name (argv[0]) "ranlib", it will build a 
 *   .SYMTAB file and add it to an ar archive.
 *
 * - links against ar libraries (.a files)
 */

#include  <stdio.h>
#include  <stdlib.h>
#include  <unistd.h>
#include  <string.h>
#include  <time.h>
#include  <sys/time.h>
#include  <ctype.h>
#include  <math.h>
#include  <varargs.h>
#include  <ar.h>
#define EXTERN
#include  "globals.h"

extern FILE *yyin;
extern int yylineno;
void symbol_analysis();

struct listof {
  char **n;	/* names */
  int nn;	/* number of names */
  int alloc;	/* number allocated. */
};

struct ar_info {
  FILE *fp;
  int nfiles;
  int *offsets;
  int *lengths;
  int *filenos;
  char **names;
};

struct listof libdirs = { NULL, 0, 0 };
struct listof libs = { NULL, 0, 0 };
struct ar_info **libinfo;
struct listof filenames = { NULL, 0, 0 };
struct listof *libfiles;

#define LISTOF_ALLOC 50

/*
 * New input func for lexer so we can parse just
 * a portion of a file.
 */
int lexoffset,lexlimit = 0;
int
lexin(FILE *fp)
{
  lexoffset++;
  if(lexlimit && lexoffset > lexlimit) return EOF;
  else return getc(fp);
}

void addtolist(struct listof *l, char *new)
{
  if(l->alloc == 0) {
    l->alloc = LISTOF_ALLOC;
    l->n = malloc(l->alloc * sizeof(char *));
  } else if(l->nn == l->alloc) {
    l->alloc += LISTOF_ALLOC;
    l->n = realloc(l->n,l->alloc * sizeof(char *));
  }
  l->n[l->nn] = new;
  l->nn += 1;
  return;
}

void
addlibdir(char *dir)
{
  int l;
  char *ndir;

  ndir = strdup(dir);

  l = strlen(ndir);
  if(ndir[l-1] == '/') ndir[l-1] = '\0';

  addtolist(&libdirs,ndir);

  return;
}

void
addfile(char *file)
{
  char *fn = strdup(file);

  addtolist(&filenames,fn);
  return;
}

void
addlib(char *lib)
{
  addtolist(&libs,lib);
  return;
}

/*
struct ar_info {
  FILE *fp;
  int nfiles;
  int *offsets;
  int *lengths;
  char **names;};
*/

struct ar_info *
setup_ar_file(char *name)
{
  struct ar_info *r = calloc(sizeof(struct ar_info),1);
  char buf[100];
  char sz[11];
  char *cp;
  int i,j;
  struct ar_hdr hdr;

  int nalloc;

  r->fp = fopen(name,"r");
  if(r->fp == NULL) {
    perror(name);
    fprintf(stderr,"Can't open archive %s.\n",name);
    exit(1);
  }

  i = fread(buf,SARMAG,1,r->fp);
  if(i != 1) {
    perror(name);
    fprintf(stderr,"Can't read archive identifier.\n");
    exit(1);
  }
  if(strncmp(buf,ARMAG,SARMAG)) {
    fprintf(stderr,"Invalid archive header in %s.\n",name);
    exit(1);
  }

  nalloc = 100;
  r->offsets = malloc(sizeof(int)*nalloc);
  r->lengths = malloc(sizeof(int)*nalloc);
  r->names = malloc(sizeof(char *)*nalloc);
  r->filenos = malloc(sizeof(char *)*nalloc);
  r->nfiles = 0;
  
  do {
    i = fread(&hdr,sizeof(hdr),1,r->fp);
    if(feof(r->fp)) break;
    if(i != 1) {
      perror(name);
      fprintf(stderr,"Can't read archive header.\n");
    }
    j = (r->nfiles)++;
    if(r->nfiles == nalloc) {
      nalloc += 100;
      r->offsets = realloc(r->offsets,sizeof(int)*nalloc);
      r->lengths = realloc(r->lengths,sizeof(int)*nalloc);
      r->names = realloc(r->names,sizeof(char *)*nalloc);
      r->filenos = realloc(r->filenos,sizeof(int)*nalloc);
    }

    if(strncmp(hdr.ar_fmag,ARFMAG,strlen(ARFMAG))) {
      fprintf(stderr,"Invalid archive header '%s' in %s.\n",hdr.ar_fmag,name);
      exit(1);
    }

    strncpy(sz,hdr.ar_size,10);
    sz[10] = '\0';
    r->filenos[j] = curfileno++;
    r->lengths[j] = atoi(sz);
    r->lengths[j] += (r->lengths[j] & 1);
    r->offsets[j] = ftell(r->fp);
    r->names[j] = calloc(sizeof(hdr.ar_name)+1,1);
    strncpy(r->names[j],hdr.ar_name,sizeof(hdr.ar_name));
    cp = r->names[j];
    cp += strlen(cp)-1;
    while(*cp == ' ') cp--;

    /* 
     * Some systems (SGI) put a trailing slash on the archive name
     * and then blank fill the field.
     */
    if(*cp == '/') *cp = '\0';
    else *(++cp) = '\0';

    fseek(r->fp,r->lengths[j],1);
  } while(!feof(r->fp));
  return r;
}


/*
 * Load the .SYMTAB file from the given library into the
 * library symbol hash table.
 */
void
add_lib_toc(char *lib,int libno,struct ar_info *libi)
{
  FILE *fp;
  char buf[1024];
  char t;
  char sname[1024];
  char *obj,*cp;
  int nfiles;
  int i;
  libsym s,*fs,*ls,*cs;

  for(i = 0 ; i < libi->nfiles ; i++)
    if(!strcmp(libi->names[i],".SYMTAB")) break;
  
  if(i == libi->nfiles) {
    fprintf(stderr,
	    "Library %s does not have a index. Run the DLX ranlib on it.\n",
	    lib);
    exit(1);
  }

  fp = libi->fp;
  fseek(fp,libi->offsets[i],0);

  fscanf(fp,"%d",&nfiles);
  nfiles++;

  fs = NULL;
  ls = NULL;
  while(nfiles && fgets(buf,sizeof(buf),fp) != NULL)
    {
      if(buf[0] != '\t') { /* new object file name. */
	if(ls != NULL) {
	  ls->fnext = fs;
	}
	cp = strchr(buf,'\n');
	if(cp != NULL) *cp = '\0';
	obj = strdup(buf);
	fs = NULL;
	ls = NULL;
	nfiles--;
	continue;
      } else { /* symbol */
	sscanf(buf,"\t%c %s",&t,&sname);
	s.name = strdup(sname);
	s.file = obj;
	s.libno = libno;
	s.flags = 0;
	if(t == 'U') s.flags = tREF;
	if(t == 'D') s.flags = tDEF;
	cs = libsym_insert(&s);
	if(fs == NULL) fs = cs;
	if(ls != NULL) ls->fnext = cs;
	ls = cs;
      }
    }

  return;
}

void
parse_lib_obj(int libno,char *name)
{
  int i,l;

  l = strlen(name);
  for(i = 0 ; i < libinfo[libno]->nfiles ; i++) {
    if(!strncmp(libinfo[libno]->names[i],name,l)) break;
  }

  if(i == libinfo[libno]->nfiles) {
    fprintf(stderr,"Internal error in dlx ranlib,"
	    " file %s not found in library.\n",name);
    exit(1);
  }

  yyin = libinfo[libno]->fp;
  fseek(yyin,libinfo[libno]->offsets[i],0);
  lexoffset = libinfo[libno]->offsets[i];
  lexlimit = libinfo[libno]->offsets[i]+libinfo[libno]->lengths[i];

  curfile = libinfo[libno]->filenos[i];
  filename = libinfo[libno]->names[i];
  yylineno = 1;
  yyparse();

  lexlimit = 0;

  return;
}


void
parse_lib_objs()
{
  libsym *ls;
  int i,j,l;
  Symbol *p;
  char buf[1024];

  for(i=0;i < libs.nn;i++)
    for(j=0; j < libfiles[i].nn ; j++) {
      addfile(libfiles[i].n[j]);
    }

  l = 0;
  for(i = 0 ; i < libs.nn ; i++) {
    for(j=0; j < libfiles[i].nn ; j++) {
      parse_lib_obj(i,libfiles[i].n[j]);
    }
  }
}


void
add_lib_objs()
{
  libsym *ls,*lso;
  int i,j;
  int added;
  Symbol *p,*q;
  char buf[1024];

  added = 1;

  while(added) {
    added = 0;
    for(j = 0 ; j < HASHSIZE ; j++) {
      for(p = symtab[j] ; p != NULL ; p = p->next ) {
	if(p->flags & tGLOBAL && !(p->flags & tDEF)) {
	  ls = libsym_find(p->name);
	  if(ls == NULL) {
	    fprintf(stderr,"Undefined symbol %s referenced in file %s.\n",
		    p->name,filenames.n[p->fileno]);
	    errors++;
	    continue;
	  }
	  addtolist(&(libfiles[ls->libno]),ls->file);
	  added++;
	  lso = ls;
	  do {
	    q = findsymbol(ls->name,-1);
	    if(q == NULL) {
	      q = newsymbol(ls->name,-1);
	      q->flags = ls->flags | tGLOBAL;
	    } else {
	      q->flags |= ls->flags;
	    }
	    ls = ls->fnext;
	  } while(ls != lso);
	}
      }
    }
  }

  parse_lib_objs();
  fix_UNKs();

  return;
}
  
/*
 * arg is "-lXXXX"
 * This looks for libXXXX.a in the lib search directories.
 */
char *
findlib(char *arg)
{
  int i;
  char buf[1024];

  if(strncmp(arg,"-l",2)) {
    fprintf(stderr,"Internal error in dlx-ld: arg to findlib should be -l opt.\n");
    exit(1);
  }

  arg += 2;

  for(i = 0 ; i < libdirs.nn ; i++)
    {
      sprintf(buf,"%s/lib%s.a",libdirs.n[i],arg);
      if(access(buf,R_OK) == 0) {
	return strdup(buf);
      }
    }
  return NULL;
}

void
usage()
{
  fprintf(stderr,"Usage: dlx-ld [arguments]\n"
	  "  [-o output]      	Select output file (a.out is the default).\n"
	  "  [-S stacksize]     Set stack section size.\n"
	  "  [-llib]            Link against library.\n"
	  "  [-Llibpath]        Add to library search path.\n"
	  "  file.o             Object file to be linked.\n");
  exit(1);
}

void
add_std_symbols()
{
  int i;
  char *names[] = { "memSize","_edata","_etext",NULL };
  Symbol *s;

  for(i = 0 ; names[i] != NULL ; i++) {
    s = newsymbol(names[i],-2);
    s->outname = NULL;
    s->flags = tDEF|tGLOBAL;
  }
}

int main(argc,argv)
int	argc;
char	*argv[];
{
    int  i,j;
    int dsize_ur,tsize_ur;

    int stacksize;
    char *crt0 = NULL;
    char *pt; 
    Symbol *p;

    addlibdir(PREFIX "/lib");

//fprintf(stderr, "Changed loader!!!\n");
    
    pt = strrchr(argv[0],'/');
    if(pt) pt++;
    else pt = argv[0];

    if(!strcmp(pt,"ranlib")) ranlib(argc,argv);

    if(argc == 1) usage();
    
    initsymbol();
    asm_addr.data_addr=0;
    asm_addr.text_addr=0;

    errors = 0;

    stacksize=0x2000;
    outfile="a.out";
    add_std_symbols();

    addfile("crt0.o");

    for(j=0,i=1; i<argc ; i++) {
      if(argv[i][0] == '-') {
	if(!strncmp(argv[i],"-o",2)) {
	  outfile=argv[++i];
	} else if(!strncmp(argv[i],"-S",2)) {
	  stacksize = strtol(argv[++i],NULL,0);
	} else if(!strncmp(argv[i],"-L",2)) {
	  addlibdir(argv[i]+2);
	} else if(!strncmp(argv[i],"-l",2)) {
	  /* ignore -lgcc because we don't need libgcc.a */
	  /*if(strcmp(argv[i],"-lgcc")) {*/
	  /* Andrikos:ignore -lc because we don't need libc.a */
	  if(strcmp(argv[i],"-lc")) {
	    pt = findlib(argv[i]);
	    if(pt == NULL) {
	      fprintf(stderr,"Can't find library for %s\n",argv[i]);
	      exit(1);
	    }
	    addlib(pt);
	  }
	} else {
	  fprintf(stderr,"Unknown options %s\n",argv[i]);
	  usage();
	}
      } else if(crt0 == NULL && strstr(argv[i],"crt0.o") != NULL) {
	crt0 = argv[i];
      } else {
	addfile(argv[i]);
      }
    }

    /*if(crt0 != NULL) {
      addfile(crt0);
    }*/
    filenames.n[0] = crt0;

    nobjs = filenames.nn;
    curfileno = nobjs;

    libfiles = (struct listof *)calloc(sizeof(struct listof),libs.nn);

    /* 
     * pass 1: collect symbol info and assign addresses. 
     */

    pass=1;
    
    for(i=0;i<nobjs ; i++) {
      curfile=i;
      yyin = fopen(filenames.n[i],"r");
      filename = filenames.n[i];
      if(yyin == NULL) {
	fprintf(stderr,"dlx-ld: Can't open %s\n",filenames.n[i]);
	perror(filenames.n[i]);
	exit(1);
      }
      yylineno = 1;
      yyparse();
      fclose(yyin);
    }

    /*
     * Mark "UNK" symbols GLOBAL.
     */
    fix_UNKs();
    
    libinfo = calloc(sizeof(struct ar_info *),libs.nn);

    /*
     * Load library symbol tables
     */
    for(i = 0 ; i < libs.nn ; i++) {
      libinfo[i] = setup_ar_file(libs.n[i]);
      add_lib_toc(libs.n[i],i,libinfo[i]);
    }

    /*
     * Iterate through libraries,
     * adding object files until 
     * we get all the symbols defined.
     */
    add_lib_objs();

    dsize=asm_addr.data_addr;
    tsize=asm_addr.text_addr;

    /*
     * Resolve duplicate symbols
     */

    symbol_analysis();


    if(errors > 0) exit(1);

    /*
     * pass 2: produce output. 
     */

    pass=2;

    dsize_ur=dsize;
    tsize_ur=tsize;

    dsize=(dsize+4096)&(~4095);
    tsize=(tsize+4096)&(~4095);

//    tstart=0x1000;
    tstart=0x0000;
    dstart=tstart+tsize;

    outfp=fopen(outfile,"w");

    fprintf(outfp,"; Linked by DLX-LD.\n");

    fprintf(outfp,"; MemSize %d\n",dstart+dsize+stacksize);
    fprintf(outfp,"; Data size: %d\n",dsize_ur);
    fprintf(outfp,"; Text size: %d\n",tsize_ur);
    fprintf(outfp,"; Stack size: %d\n",stacksize);
    fprintf(outfp,".text 0x%04x\n.data 0x%04x\n",tstart,dstart);

    set_addr_state(tDATA);

    for(i=0;i<nobjs ; i++) {
      curfile=i;
      yyin = fopen(filenames.n[i],"r");
      filename = filenames.n[i];
      if(yyin == NULL) {
	fprintf(stderr,"dlx-ld: Can't open %s\n",filenames.n[i]);
	perror(filenames.n[i]);
	exit(1);
      }
      yylineno = 1;
      yyparse();
      fclose(yyin);
    }

    /*
     * Do a pass-2 parse of the library .o files
     */
    parse_lib_objs();

    fprintf(outfp,".text\n.global _etext\n_etext:\n");
    fprintf(outfp,".align 3\n.data\n.global _edata\n_edata:\n");

    fclose(outfp);

    if(errors > 0) exit(1);

    exit(0);
}

/*
 * Called when we are to do ranlib instead of linking.
 */
int
ranlib(int argc, char **argv)
{
  int i;
  if(argc == 1) {
    fprintf(stderr,"Usage: ranlib file.a [file.a ...]\n");
    exit(1);
  }

  initsymbol();

  for(i = 1 ; i < argc ; i++) {

    asm_addr.data_addr=0;
    asm_addr.text_addr=0;

    ranlib_file(argv[i]);

  }

  exit(0);
}

int
ranlib_file(char *fn)
{
  char buf[1024];
  int i,j;
  Symbol *p;
  FILE *fp;
  struct ar_info *info;

  printf("Building symbol directory file for %s\n",fn);

  info = setup_ar_file(fn);

  libinfo = &info;

  unlink(".SYMTAB");
  fp = fopen(".SYMTAB","w");
  if(fp == NULL) {
    fprintf(stderr,"Ranlib can't open .SYMTAB.\n");
    perror(".SYMTAB");
    exit(1);
  }

  fprintf(fp,"%d\n",info->nfiles);

  pass=1;

  for(i = 0 ; i < info->nfiles ; i++)
    {
      filename = info->names[i];
      if(!strncmp(".SYMTAB",filename,7)) continue;

      yyin = info->fp;
      fseek(yyin,info->offsets[i],0);
      lexoffset = info->offsets[i];
      lexlimit = info->offsets[i]+info->lengths[i];

      curfile = i;
      yylineno = 1;
      yyparse();

      lexlimit = 0;

      fix_UNKs();
      fprintf(fp,"%s\n",filename);
      for(j = 0 ; j < HASHSIZE ; j++) {
	for(p = symtab[j] ; p != NULL ; p = p->next ) {
	  if(p->flags & tGLOBAL) {
	    if(p->flags & tDEF) {
	      fprintf(fp,"\tD %s\n",p->name);
	    } else {
	      fprintf(fp,"\tU %s\n",p->name);
	    }
	  }
	}
      }
      reinitsymbol();
    }

  fclose(fp);
  fclose(info->fp);
  sprintf(buf,"ar q %s .SYMTAB",fn);
  system(buf);
  unlink(".SYMTAB");
}

/*
 * Don't bother copying around expressions during pass 1.
 */
void
strcpyp(char *a, char *b)
{
  if(pass == 2) strcpy(a,b);
  else a[0] = '\0';
}
void
catN(va_alist)
va_dcl
{
  va_list ap;
  char *str;
  char *dp;

  va_start(ap);
  dp = va_arg(ap,char *);
  *dp = '\0';
  if(pass == 2)
    {
      while((str = va_arg(ap,char *)) != NULL) 
	{
	  while((*(dp++) = *(str++)));
	  dp--;
	}
    }
  va_end(ap);
  return;
}

void
symsize(int s,int isinit)
{
  if(pass==1 && lastsym != NULL) {
    lastsym->size += s;
    if(isinit) {
      lastsym->init = curfile;
    }
  }
}

void
fix_UNKs()
{
  int i;
  int d;
  Symbol *s,*t;
  for(i=0;i<HASHSIZE;i++) {
    d = 0;
    for(s=symtab[i]; s != NULL; s=s->next) {
      if(s->flags & tUNK) {
	/*
	 * Either there is a global symbol for this in which
	 * case the UNK symbol should be deleted, or there is
	 * no global symbol defined in which case we delete
	 * all other UNK symbols with the same name and change
	 * this one to tGLOBAL.
	 */
	for(t = symtab[i] ; t != NULL ; t = t->next) {
	  if(s != t && !strcmp(s->name,t->name) && 
	     (t->flags & tGLOBAL || t->flags & tUNK) ) {
	    if(t->flags & tGLOBAL) {
	      s->flags = tDELETED;
	    } else {
	      t->flags = tDELETED;
	    }
	    d++;
	  }
	}
	if(!(s->flags & tDELETED)) {
	  s->flags &= ~tUNK;
	  s->flags |= (tGLOBAL|tREF);
	}
      }
    }
    for(s=symtab[i]; s != NULL; s=s->next) {
      if(s->flags & tGLOBAL) {
	/*
	 * Remove duplicate globals.
	 */
	for(t = symtab[i] ; t != NULL ; t = t->next) {
	  if(t != s && !strcmp(s->name,t->name) && t->flags&tGLOBAL) {
	    t->flags = tDELETED;
	    d++;
	  }
	}
      }
    }
    if(d) { /* something was deleted from this bucket. */
      s = symtab[i];
      while(s != NULL && s->flags & tDELETED) {
	symtab[i] = s->next;
	if(s->name != NULL) free(s->name);
	free(s);
	s = symtab[i];
      }
      if(s != NULL) {
	t = s->next;
	while(t != NULL) {
	  if(t->flags & tDELETED) {
	    s->next = t->next;
	    if(t->name != NULL) free(t->name);
	    free(t);
	    t = s->next;
	  } else {
	    s = t;
	    t = t->next;
	  }
	}
      }
    }
  }
}

void
symbol_analysis()
{
  int i,j;
  Symbol *s,*t,*tp,*tprev;
  char tmp[1024];
  char *fwop;

  for(i=0;i<HASHSIZE;i++) {

    for(s=symtab[i]; s != NULL; s=s->next) {
      /* 
       * Rename non-global symbols.
       */
      if(!(s->flags & tGLOBAL)) {
	sprintf(tmp,"%s_LF%d",s->name,s->fileno);
	for(j=0; tmp[j]; j++) if(!(isalnum(tmp[j]))) tmp[j]='_';
	s->outname = strdup(tmp);
      }
      
      /*
       * Find duplicate global symbols and resolve them.
       */
      if((s->flags & tGLOBAL) && (s->flags & tDATA)) {
	for(t=s->next,tp=s; t != NULL ; t=t->next) {

	  tprev = t;

	  if((t->flags & tGLOBAL) && !strcmp(s->outname,t->outname)) {
	    /*
	     * s and t have the same name and both are global.
	     */

	    if((t->init) >= 0) {
	      if((s->init) >= 0) {
		fprintf(stderr,"Multiply defined symbol %s in file %s.\n",
			t->name,filenames.n[t->init]);
		errors++;
	      } else {
		/* Move the init file number to s. */
		s->init = t->init;
	      }
	    }
	    /*
	     * Delete symbol t and decrement the datasize.
	     * This isn't strictly correct because of alignment
	     * concerns.
	     */
	    tp->next = t->next;
	    dsize -= t->size;
	    bzero(t,sizeof(*t));
	    free(t);
	    tprev=tp;
	    t=tp;
	  }
	  tp=tprev;
	}
      }
      /*
       * All symbols that are duplicates of s have been eliminated.
       * Now set s->init to s->fileno so we know where to allow s 
       * to be defined. (If it wasn't set already.)
       */
      if(s->init < 0) s->init = s->fileno;
    }
  }
}

/* Number of bytes to store this string. */
int
actual_string_length(char *s)
{
  int i,l,c;
  for(i=0,l=0; s[i] ; i++,l++) {
    if(s[i] == '\\' && s[i+1]) {
      i++;
      switch(s[i]) {
      case 'n':
      case 't':
      case 'v':
      case 'b':
      case 'r':
      case 'f':
      case 'a':
      case '\\':
      case '\?':
      case '\'':
      case '\"':
	break;
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
	for(c=1; s[i+c] && c<3 && isdigit(s[i+c]) && 
                 s[i+c] != '8' && s[i+c] != '9'; c++);
	i+=c-1;
	break;

      case 'x':
	for(c=0;c<2 && s[i+c+1]; c++)
	  switch(s[i+c+1]) {
	  case '0':
	  case '1':
	  case '2':
	  case '3':
	  case '4':
	  case '5':
	  case '6':
	  case '7':
	  case '8':
	  case '9':
	  case 'a':
	  case 'A':
	  case 'b':
	  case 'B':
	  case 'c':
	  case 'C':
	  case 'd':
	  case 'D':
	  case 'e':
	  case 'E':
	  case 'f':
	  case 'F':
	    i++;
	    break;
	  }
	break;
      }
    }
  }

  /* subtract 2 for the leading and trailing "'s. */

  return l-2;
}

int get_addr_state(void)
{    return addr_state;
}

void set_addr_state(int state)
{
    if (state == tDATA)
    {   addr_state = tDATA;
        address = &asm_addr.data_addr;
    } else if (state == tTEXT)
    {   addr_state = tTEXT;
        address = &asm_addr.text_addr;
    } else
        err("invalid code state\n");
}

void set_addr(int addr)
{
    *address = addr;
}

int get_addr(void)
{
    return *address;
}

void align_addr(int alignment)
{
    int num = (1 << alignment) - 1;
    int addr = get_addr();

    set_addr((addr+num) & ~num);
}

void inc_addr(int num_bytes)
{
    set_addr(get_addr()+num_bytes);
}

void init_queue(void)
{
    int i;

    top_queue = 0;
    btm_queue = 0;
    for (i=0; i < MAX_ASM_OPS ;i++)
        queue_text[i][0] = '\0';
}

int queue_empty(void)
{
    if (top_queue >= btm_queue)
        return TRUE;
    else
        return FALSE;
}

void push_item(char *text)
{
   if (btm_queue >= MAX_ASM_OPS)
       err("error: too many asm ops\n");
   strcpy(queue_text[btm_queue++],text);
}

char *pop_item(void)
{
   if (top_queue >= btm_queue)
       err("error: no more asm ops to pop\n");
   return &(queue_text[top_queue++][0]);
}
