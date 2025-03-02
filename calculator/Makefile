# Compiling with Make

CC = gcc
CFLAGS = -Wall -Wextra -std=c11
SRC = main.c addition.c subtraction.c multiplication.c division.c
OBJ = $(SRC:.c=.o)
TARGET = calculator

.PHONY: all clean

all: $(TARGET)

# link all object files 
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

# compile .c files to object files
%.o: %.c operations.h
	$(CC) $(CFLAGS) -c $< -o $@

# clean object files and executable, then rebuild
clean:
	rm -f $(OBJ) $(TARGET)
	$(MAKE) all