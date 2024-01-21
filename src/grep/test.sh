#!/bin/bash

SUCCESS=0
FAIL=0
COUNT=0

gcc -Werror -Wextra -Wall s21_grep.c -o s21_grep

flags=("-e" "-i" "-v" "-c" "-l" "-n" "-h" "-o" )
flag_dop=("-i" "-v" "-c" "-l" "-n" "-h")
patterns=( "Jun" "English" )
files=("test1.txt" "test2.txt" "test3.txt" "test4.txt" )
files_f_osn=("test1.txt" "test3.txt")
files_f_dop=("test2.txt" "test4.txt")


echo ""
echo "---------------------------"
echo "--- ONE FLAG, ONE FILES ---"
echo "---------------------------"
echo ""

for flag in "${flags[@]}"
do
    for pattern in "${patterns[@]}"
    do
        for file in "${files[@]}"
        do
            echo "./s21_grep $flag $pattern $file"
            ./s21_grep "$flag" "$pattern" "$file" > mytext.txt
            grep "$flag" "$pattern" "$file" > greptext.txt
        
            if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
            then
                let "COUNT++"
                let "SUCCESS++"
                echo "$COUNT - SUCCESS"
            else 
                let "COUNT++"
                let "FAIL++"
                echo "$COUNT - FAIL"
            fi
            rm mytext.txt
            rm greptext.txt
        done
    done
done

echo ""
echo "---------------------------"
echo "-- ONE FLAG, THREE FILES --"
echo "---------------------------"
echo ""

for flag in "${flags[@]}"
do
    for pattern in "${patterns[@]}"
    do
        for file_1 in "${files[@]}"
        do
            for file_2 in "${files[@]}"
            do
                for file_3 in "${files[@]}"
                do
                    if [  $file_1 != $file_2 ] && [ $file_2 != $file_3 ] && [ $file_1 != $file_3 ]
                    then
                    echo "./s21_grep $flag $pattern $file_1 $file_2 $file_3"

                    ./s21_grep "$flag" "$pattern" "$file_1" "$file_2" "$file_3"> mytext.txt
                   
                    grep "$flag" "$pattern" "$file_1" "$file_2" "$file_3"> greptext.txt
                    
                    if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                    then
                        let "COUNT++"
                        let "SUCCESS++"
                        echo "$COUNT - SUCCESS"
                    else 
                        let "COUNT++"
                        let "FAIL++"
                        echo "$COUNT - FAIL"
                    fi

                    rm mytext.txt
                    rm greptext.txt
                    fi
                done
            done
        done
    done
done



echo ""
echo "---------------------------"
echo "--- TWO FLAG, ONE FILES ---"
echo "---------------------------"
echo ""

for flag_1 in "${flag_dop[@]}"
do
    for flag_2 in "${flag_dop[@]}"
    do
        for pattern in "${patterns[@]}"
        do
            for file in "${files[@]}"
            do 
                if [ $flag_1 != $flag_2 ]
                then
                    echo "./s21_grep  $flag_1 $pattern $flag_2  $file"
                   
                    ./s21_grep "$flag_1" "$pattern" "$flag_2"  "$file" > mytext.txt
                
                    grep "$flag_1" "$pattern" "$flag_2"  "$file" > greptext.txt
                   
                    if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                    then
                        let "COUNT++"
                        let "SUCCESS++"
                        echo "$COUNT - SUCCESS"
                    else 
                        let "COUNT++"
                        let "FAIL++"
                        echo "$COUNT - FAIL"
                    fi
                    
                    rm mytext.txt
                    rm greptext.txt
                fi
            done
        done
    done
done



echo ""
echo "----------------------------"
echo "--- E FLAG, TWO PATTERNS ---"
echo "----------------------------"
echo ""

            for file in "${files[@]}"
            do 
                echo "./s21_grep -e "${patterns[0]}" -e "${patterns[1]}" $file"
              
                ./s21_grep -e "${patterns[0]}" -e "${patterns[1]}" "$file" > mytext.txt
              
                grep -e "${patterns[0]}" -e "${patterns[1]}"  "$file" > greptext.txt
                
                if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                then
                    let "COUNT++"
                    let "SUCCESS++"
                    echo "$COUNT - SUCCESS"
                else 
                    let "COUNT++"
                    let "FAIL++"
                    echo "$COUNT - FAIL"
                fi

                rm mytext.txt
                rm greptext.txt
            done
echo ""
echo "----------------------------"
echo "--- F FLAG, TWO PATTERNS ---"
echo "----------------------------"
echo ""

            for file in "${files_f_osn[@]}"
            do 
                echo "./s21_grep -f "${files_f_dop[0]}" -f "${files_f_dop[1]}" $file"
              
                ./s21_grep -f "${files_f_dop[0]}" -f "${files_f_dop[1]}" "$file" > mytext.txt
              
                grep -f "${files_f_dop[0]}" -f "${files_f_dop[1]}"  "$file" > greptext.txt
                
                if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                then
                    let "COUNT++"
                    let "SUCCESS++"
                    echo "$COUNT - SUCCESS"
                else 
                    let "COUNT++"
                    let "FAIL++"
                    echo "$COUNT - FAIL"
                fi

                rm mytext.txt
                rm greptext.txt
            done
            echo "./s21_grep -f s21_grep.c s21_grep.c "
              
                ./s21_grep -f s21_grep.c s21_grep.c > mytext.txt
              
                grep -f s21_grep.c s21_grep.c > greptext.txt
                
                if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                then
                    let "COUNT++"
                    let "SUCCESS++"
                    echo "$COUNT - SUCCESS"
                else 
                    let "COUNT++"
                    let "FAIL++"
                    echo "$COUNT - FAIL"
                fi

                rm mytext.txt
                rm greptext.txt
echo ""
echo "-----------------------------"
echo "--- PROCESS INVALID INPUT ---"
echo "-----------------------------"
echo ""

                echo "./s21_grep -u nes.c rty.c "
              
                ./s21_grep -f -u nes.c rty.c > mytext.txt
              
                grep -f -u nes.c rty.c > greptext.txt
                
                if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                then
                    let "COUNT++"
                    let "SUCCESS++"
                    echo "$COUNT - SUCCESS"
                else 
                    let "COUNT++"
                    let "FAIL++"
                    echo "$COUNT - FAIL"
                fi

                rm mytext.txt
                rm greptext.txt

                echo "./s21_grep -u test2.txt test1.txt "
              
                ./s21_grep -u test2.txt test1.txt > mytext.txt
              
                grep -u test2.txt test1.txt > greptext.txt
                
                if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                then
                    let "COUNT++"
                    let "SUCCESS++"
                    echo "$COUNT - SUCCESS"
                else 
                    let "COUNT++"
                    let "FAIL++"
                    echo "$COUNT - FAIL"
                fi

                rm mytext.txt
                rm greptext.txt

                echo "./s21_grep test1.txt -f test2.txt "
              
                ./s21_grep test1.txt -f test2.txt > mytext.txt
              
                grep test1.txt -f test2.txt > greptext.txt
                
                if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                then
                    let "COUNT++"
                    let "SUCCESS++"
                    echo "$COUNT - SUCCESS"
                else 
                    let "COUNT++"
                    let "FAIL++"
                    echo "$COUNT - FAIL"
                fi

                rm mytext.txt
                rm greptext.txt


                echo "./s21_grep -e English 34.txt "
              
                ./s21_grep -e English 34.txt > mytext.txt
              
                grep -e English 34.txt > greptext.txt
                
                if diff -q mytext.txt greptext.txt >/dev/null 2>&1;
                then
                    let "COUNT++"
                    let "SUCCESS++"
                    echo "$COUNT - SUCCESS"
                else 
                    let "COUNT++"
                    let "FAIL++"
                    echo "$COUNT - FAIL"
                fi

                rm mytext.txt
                rm greptext.txt

echo ""
echo "----------------------------"
echo "ALL: $COUNT, SUCCESS: $SUCCESS, FAIL: $FAIL"
echo "----------------------------"
echo ""
