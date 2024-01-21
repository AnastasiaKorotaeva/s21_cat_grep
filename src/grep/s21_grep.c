#include "s21_grep.h"

int main(int argc, char **argv) {
  int Q = 0;
  char pattern[size] = {0};
  if (argc > 2) {
    find_flag(argc, argv, pattern, &Q);
    if (Q != -1) {
      read_file(argc, argv, pattern);
    }
  } else {
    printf(
        "usage: s21_grep [-eivclnhsfo] [-e pattern] [-f file] [pattern] "
        "[file]\n");
    Q = -1;
  }
  return 0;
}

void find_flag(int argc, char **argv, char *pattern, int *Q) {
  int opt = 0;
  while ((*Q != -1) &&
         (opt = getopt_long(argc, argv, "e:f:ivclnhso", flags, 0)) != -1) {
    if (opt == 'e') {
      eflag++;
      process_eflag(pattern);
    } else if (opt == 'i')
      iflag++;
    else if (opt == 'v')
      vflag++;
    else if (opt == 'c')
      cflag++;
    else if (opt == 'l')
      lflag++;
    else if (opt == 'n')
      nflag++;
    else if (opt == 'h')
      hflag++;
    else if (opt == 's')
      sflag++;
    else if (opt == 'f') {
      fflag++;
      process_fflag(argv, pattern, Q);
    } else if (opt == 'o')
      oflag++;
    else {
      fprintf(stderr,
              "usage: s21_grep [-eivclnhsfo] [-e pattern] [-f file] [pattern] "
              "[file]\n");
      *Q = -1;
      continue;
    }
  }
  if (!eflag && !fflag) {
    strcat(pattern, argv[optind++]);
  }
}

void read_file(int argc, char **argv, char *pattern) {
  col_file = argc - optind;
  FILE *fp = NULL;
  for (; optind < argc; optind++) {
    if ((fp = fopen(argv[optind], "r")) == NULL) {
      if (sflag == 0)
        fprintf(stderr, "%s: %s: No such file or directory\n", argv[0],
                argv[optind]);
    } else {
      process_file(argv, pattern, fp, &col_file);
      fclose(fp);
    }
  }
}

void process_file(char **argv, char *pattern, FILE *fp, int *col_file) {
  regex_t regex;
  int col_sovp = 0;
  int num_lin = 1;
  char str[bufferSize] = {0};
  int proccess_i = 0;

  if (iflag) proccess_i = REG_ICASE;

  if (fflag) pattern[strlen(pattern) - 1] = '\0';

  regcomp(&regex, pattern, REG_EXTENDED | proccess_i);

  while (!feof(fp)) {
    if (fgets(str, bufferSize, fp)) {
      int identical = check_identical(argv, str, &regex, &num_lin);
      if (identical != REG_NOMATCH) {
        output(argv, str, &num_lin, fp, col_file);
        col_sovp += 1;
      }
      num_lin += 1;
    }
  }
  process_flag_cl(argv, &col_sovp, col_file);
  regfree(&regex);
}

int check_identical(char **argv, char *str, regex_t *regex, int *num_lin) {
  regmatch_t pmatch[1] = {0};
  size_t nmatch = 1;
  int new_line_num = 0;
  int identical = regexec(regex, str, nmatch, pmatch, 0);
  if ((identical == 0) && (!vflag)) {
    if (oflag && !cflag) {
      char *s = (char *)str;
      while (identical == 0) {
        if (col_file > 1 && new_line_num != *num_lin) {
          printf("%s:", argv[optind]);
        }

        for (int i = pmatch[0].rm_so; i < pmatch[0].rm_eo; i++) {
          printf("%c", s[i]);
        }
        printf("\n");
        s += pmatch[0].rm_eo;
        identical = regexec(regex, s, nmatch, pmatch, 0);
        new_line_num = *num_lin;
      }
    }
  }
  if (vflag) {
    if (identical == REG_NOMATCH) {
      identical = 0;
    } else
      identical = REG_NOMATCH;
  }
  return identical;
}

void output(char **argv, char *str, int *num_lin, FILE *fp, int *col_file) {
  if (!cflag && !lflag) {
    if (*col_file > 1 && !hflag) {
      printf("%s:", argv[optind]);
    }
    if (nflag) {
      printf("%d:", *num_lin);
    }
    printf("%s", str);
    if (feof(fp)) {
      printf("\n");
    }
  }
}

void process_eflag(char *pattern) {
  if (eflag == 1) {
    strcpy(pattern, optarg);
  } else if (eflag > 1) {
    strcat(pattern, "|");
    strcat(pattern, optarg);
  }
}

void process_fflag(char **argv, char *pattern, int *Q) {
  FILE *fp_1 = NULL;
  char str_1[bufferSize] = {0};
  fp_1 = fopen(optarg, "r");
  if (fp_1 != NULL && *Q != -1) {
    int len = 0;
    while (fgets(str_1, bufferSize, fp_1) != NULL) {
      len = strlen(str_1);
      if (len > 0) {
        if (!feof(fp_1)) str_1[len - 1] = '\0';
        strcat(pattern, str_1);
        strcat(pattern, "|");
      }
    }
  } else {
    fprintf(stderr, "%s: %s: No such file or directory\n", argv[0],
            argv[optind]);
    *Q = -1;
  }
  fclose(fp_1);
}

void process_flag_cl(char **argv, int *col_sovp, int *col_file) {
  if (cflag) {
    if (*col_file > 1 && !hflag) {
      printf("%s:", argv[optind]);
    }
    if (lflag && *col_sovp)
      printf("1\n");
    else
      printf("%d\n", *col_sovp);
  }

  if (lflag && *col_sovp) {
    printf("%s\n", argv[optind]);
  }
}
