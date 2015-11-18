CC=gcc

FRAMEWORKS:= 
LIBRARIES:= 
INCLUDEFLAGS =

CFLAGS=-Wall
LDFLAGS=$(LIBRARIES) $(FRAMEWORKS)
OUT=-o main.exe

objects = main.o

run:all
	@echo "-------------------------------------"
	@./main.exe

# @ means target, < means source!
%.o : %.c
	$(CC) -c $< -o $@

%.d : %.c
	@set -e; rm -f $@; $(CC) -MM $< $(INCLUDEFLAGS) > $@.$$$$; \
    sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
    rm -f $@.$$$$

-include $(objects:.o=.d)

all: $(objects)
	$(CC) $(CFLAGS) $(LDFLAGS) $(objects) $(OUT)

.PHONY : all clean run
clean:
	-rm main.exe *.o *.d
