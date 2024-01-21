#ifndef S21_GREP_H_
#define S21_GREP_H_

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <string.h>

#define size 8192
#define bufferSize 4096

int eflag = 0;
int iflag = 0;
int vflag = 0;
int cflag = 0;
int lflag = 0;
int nflag = 0;
int hflag = 0;
int sflag = 0;
int fflag = 0;
int oflag = 0;

int col_file = 0;

struct option flags[] = {
    {"e", 0, NULL, 'e'}, {"i", 0, NULL, 'i'}, {"v", 0, NULL, 'v'},
    {"c", 0, NULL, 'c'}, {"l", 0, NULL, 'l'}, {"n", 0, NULL, 'n'},
    {"h", 0, NULL, 'h'}, {"s", 0, NULL, 's'}, {"f", 0, NULL, 'f'},
    {"o", 0, NULL, 'o'}, {NULL, 0, NULL, 0}};

void find_flag(int argc, char **argv, char *pattern, int *Q);
void read_file(int argc, char **argv, char *pattern);
void process_file(char **argv, char *pattern, FILE *fp, int *col_file);
int check_identical(char **argv, char *str, regex_t *regex, int *num_lin);
void output(char **argv, char *str, int *num_lin, FILE *fp, int *col_file);
void process_eflag(char *pattern);
void process_fflag(char **argv, char *pattern, int *Q);
void process_flag_cl(char **argv, int *col_sovp, int *col_file);

#endif
