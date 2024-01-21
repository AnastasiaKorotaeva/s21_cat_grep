#include "s21_cat.h"

int main(int argc, char **argv) {
  int Q = 0;
  if (argc > 1) {
    find_flags(argc, argv, &Q);
    if (Q != -1) {
      process_file(argc, argv);
    }
  }
  return 0;
}

void find_flags(int argc, char **argv, int *Q) {
  int opt = 0;
  while ((*Q != -1) &&
         (opt = getopt_long(argc, argv, "+beEnstTv", flagWord, NULL)) != -1) {
    if (opt == 'b')
      bflag++;
    else if (opt == 'e') {
      eflag++;
      vflag++;
    } else if (opt == 'n') {
      nflag++;
    } else if (opt == 's') {
      sflag++;
    } else if (opt == 't') {
      tflag++;
      vflag++;
    } else if (opt == 'E') {
      eflag++;
    } else if (opt == 'T') {
      tflag++;
    } else if (opt == 'v') {
      vflag++;
    } else {
      fprintf(stderr,
              "Write: cat [-benstvET]or[--number-nonblank --number "
              "--squeeze-blank] [file]\n");
      *Q = -1;
      continue;
    }
  }
}

void process_file(int argc, char *argv[]) {
  char current = '\0';
  char previous = '\n';
  int number = 0;
  int emptyLines = 0;
  FILE *fp = NULL;
  for (int i = optind; i < argc; i++) {
    number = 0;
    previous = '\n';
    fp = fopen(argv[i], "r");
    if (fp == NULL) {
      fprintf(stderr, "%s: %s: No such file or directory", argv[0], argv[i]);
      continue;
    }
    process_flag(current, emptyLines, previous, &number, fp);
  }
}

void process_flag(char current, int emptyLines, char previous, int *number,
                  FILE *fp) {
  while (fp != NULL && (current = fgetc(fp)) != EOF) {
    if (sflag && current == '\n' && previous == '\n')
      emptyLines++;
    else
      emptyLines = 0;
    if (emptyLines <= 1) {
      if (bflag && previous == '\n' && current != '\n')
        printf("%6d\t", ++(*number));
      else if (!bflag && nflag && previous == '\n')
        printf("%6d\t", ++(*number));

      if (tflag) {
        if (current == '\t') {
          printf("^");
          current = 'I';
        }
      }
      if (vflag) {
        if ((current >= 0 && current <= 31 && current != '\n' &&
             current != '\t') ||
            current == 127) {
          if (current == 127) {
            printf("^");
            current = current - 64;
          } else {
            printf("^");
            current = current + 64;
          }
        }
      }
      if (eflag)
        if (current == '\n') printf("$");
      previous = current;
      printf("%c", current);
    }
  }
  fclose(fp);
}
