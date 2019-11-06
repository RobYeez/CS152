parse: mini_l.lex mini_i.y
	bison -v -d --file-prefix=y mini_i.y
	flex mini_l.lex
	gcc -o parser y.tab.c lex.yy.c -lfl
