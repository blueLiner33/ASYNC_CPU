MemFile: a.out.exe
	../bin/dlxdump a.out.exe > MemFile

a.out.exe: a.out
	../bin/dlxasm -l listing a.out

a.out: *.c
	../bin/gcc-dlx -O2 *.c

sim: a.out.exe
	../bin/dlxsim -x a.out.exe -e -E mem_end -I -M > trace && tail mem_end
