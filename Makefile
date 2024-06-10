LEX = lex
YACC = yacc -d

CC = gcc

all: parser 

parser: y.tab.o lex.yy.o
	$(CC) -o parser y.tab.o lex.yy.o 
	

lex.yy.o: lex.yy.c y.tab.h
lex.yy.o y.tab.o: y.tab.c

y.tab.c y.tab.h: CS315_S23_Team13.yacc
	$(YACC) -v CS315_S23_Team13.yacc

lex.yy.c: CS315_S23_Team13.lex
	$(LEX) CS315_S23_Team13.lex

