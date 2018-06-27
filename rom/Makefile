SOURCES = dp.s lcd.s rom.s

%.o: %.s
	ca65 -o $@ -l $(@:.o=.lst) $<

all: rom

rom: $(SOURCES:.s=.o)
	cl65 -C rom.cfg -t none -o $@.bin $^

clean:
	rm -f *.o *.lst rom.bin
