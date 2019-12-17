NAME = lab11

JC = javac
JFLAGS = -g
SRC = $(wildcard *.java)
OBJ = $(SRC:.java=.class)

all: program

program: $(SRC)
	$(JC) $(JFLAGS) $(SRC)

.PHONY: run clean

run:
	java $(NAME)

test:
	diff --color output target

clean:
	rm -f *.class
	rm -rf docs
	rm output

docs:
	javadoc -d docs *.java
