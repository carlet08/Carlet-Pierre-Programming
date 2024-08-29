CC = gcc
CFLAGS = -Wall -Wextra
LDFLAGS = -lm  # Linker flag to include math library
TARGET = pa2
SRCS = main.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean:
	rm -f $(OBJS) $(TARGET)