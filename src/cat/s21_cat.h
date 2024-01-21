#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

void find_flags(int argc, char *argv[], int *Q);
void process_file(int argc, char *argv[]);
void process_flag(char current, int emptyLines, char previous, int *number,
                  FILE *fp);

int bflag = 0, eflag = 0, nflag = 0, sflag = 0, tflag = 0, vflag = 0;

struct option flagWord[] = {{"number-nonblank", 0, NULL, 'b'},
                            {"number", 0, NULL, 'n'},
                            {"squeeze-blank", 0, NULL, 's'},
                            {NULL, 0, NULL, 0}};

#endif