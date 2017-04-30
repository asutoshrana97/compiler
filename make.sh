bison -d SA.y
flex LA.lex
g++ -ggdb -o tst lex.yy.c SA.tab.c

