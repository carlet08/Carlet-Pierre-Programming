
CC = gcc
CFLAGS = -Wall -Wextra
TARGET = pa1
SRCS = Source.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(OBJS) $(TARGET)
