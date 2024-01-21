# Simple Bash Utils

Разработка утилит Bash по работе с текстом: cat, grep.

![simple_bash_utils](images/logo.png)

## Краткое описание

В этом проекте разработаны базовые утилиты Bash по работе с текстами на языке программирования Си. Эти утилиты (cat и grep) достаточно часто используются при работе в терминале Linux. 

### cat Использование

Cat - одна из наиболее часто используемых команд в Unix-подобных операционных системах. Команда имеет три взаимосвязанные функции в отношении текстовых файлов: отображение, объединение их копий и создание новых.

`cat [OPTION] [FILE]...`

### cat Опции

| № | Опции | Описание |
| ------ | ------ | ------ |
| 1 | -b (GNU: --number-nonblank) | нумерует только непустые строки |
| 2 | -e предполагает и -v (GNU only: -E то же самое, но без применения -v) | также отображает символы конца строки как $  |
| 3 | -n (GNU: --number) | нумерует все выходные строки |
| 4 | -s (GNU: --squeeze-blank) | сжимает несколько смежных пустых строк |
| 5 | -t предполагает и -v (GNU: -T то же самое, но без применения -v) | также отображает табы как ^I |

### grep Использование

`grep [options] template [file_name]`

### grep Опции

| № | Опции | Описание |
| ------ | ------ | ------ |
| 1 | -e | Шаблон |
| 2 | -i | Игнорирует различия регистра.  |
| 3 | -v | Инвертирует смысл поиска соответствий. |
| 4 | -c | Выводит только количество совпадающих строк. |
| 5 | -l | Выводит только совпадающие файлы.  |
| 6 | -n | Предваряет каждую строку вывода номером строки из файла ввода. |
| 7 | -h | Выводит совпадающие строки, не предваряя их именами файлов. |
| 8 | -s | Подавляет сообщения об ошибках о несуществующих или нечитаемых файлах. |
| 9 | -f file | Получает регулярные выражения из файла. |
| 10 | -o | Печатает только совпадающие (непустые) части совпавшей строки. |

## Установка

Чтобы пользоваться программой, необходимо зайти в папку src/cat и с помощью команд:   

 `make s21_cat` - скомпилируем программу  

 `make autotest` - проведем написанные тесты с расширением .sh  

 `make leaks` - проверим на утечки  

 `make style` - проверки на googlestyle  

 `make clean` - удалим исполняемый файл  

 `make rebuild` - запустим заново  
 

Чтобы воспользоваться программой с grep, можно проделать аналогичные дейстивя как и с cat, только зайти в папку src/grep.
