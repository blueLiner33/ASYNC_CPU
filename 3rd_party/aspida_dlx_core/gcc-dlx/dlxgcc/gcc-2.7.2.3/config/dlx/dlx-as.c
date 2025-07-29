/*
 *  Assembler for DLX that just copies input to the output file.
 *  Copyright (C) 1995  Aaron Sawdey
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
 *
 */

#include <stdio.h>

void
fcp(out,in)
FILE *out,*in;
{
  char buf[8192];
  int iread;

  do
    {
      iread = fread(buf,1,sizeof(buf),in);
      if(iread > 0)
	fwrite(buf,1,iread,out);
    } while(iread >= 0 && !feof(in));
}

int
main(argc,argv)
int argc;
char **argv;
{
  FILE *out;
  FILE *in;
  int i;

  out = stdout;
  in = NULL;

  for(i = 1 ; i < argc ; i++)
    {
      if(!strcmp("-o",argv[i]))
	{
	  out = fopen(argv[i+1],"w");
	  i++;
	}
      else if(argv[i][0] != '-')
	{
	  in = fopen(argv[i],"r");
	  fcp(out,in);
	  fclose(in);
	}
    }

  if(in == NULL) fcp(out,stdin);
  fclose(out);
  exit(0);
}

