g = gcc
www = -Wall -Werror -Wextra
File = s21_cat.c
Object = s21_cat

all: s21_cat leaks style

s21_cat: s21_cat.c s21_cat.h
	$(g) $(www) -g $(File) -o $(Object) 

autotest: test.sh
	sh test.sh

leaks:
	leaks -atExit -- ./s21_cat -benstv test1.txt test3.txt

style: 
	clang-format -style=Google -n *.c *.h

clean:
	rm -rf s21_cat

rebuild: 
	$(MAKE) clean
	$(MAKE) s21_cat