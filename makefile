
sic: sic.o
	gcc -g -Wall -o sic sic.o
	
sic.o: sic.s
	nasm -g -f elf64 sic.s -o sic.o

.PHONY: clean

clean:
	rm -f *.o sic
 
 
