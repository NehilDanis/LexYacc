# LexYacc

To compile and run these lex and yacc files, you should follow the instructions which are shown below.

lex pl1.l

yacc pl1y.y -d (That -d is for creation of the header file which is y.tab.h)

gcc -o pl1 lex.yy.c y.tab.c -ly -ll


As a result of this process you will get an executable that will be pl1 for our project.

./pl1 < text.txt 

By using pipe, we can run the executable.
