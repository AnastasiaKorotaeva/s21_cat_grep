g = gcc
www = -Wall -Werror -Wextra
File = s21_grep.c
Object = s21_grep

all: s21_grep style

s21_grep: s21_grep.c s21_grep.h
	$(g) $(www) -g $(File) -o $(Object) 

autotest: test.sh
	sh test.sh

style: 
	clang-format -style=Google -n *.c *.h

clean:
	rm -rf s21_grep

rebuild: 
	$(MAKE) clean
	$(MAKE) s21_grep