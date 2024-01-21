#!/bin/bash

SUCCESS=0
FAIL=0
COUNT=0

gcc -Werror -Wextra -Wall s21_cat.c -o s21_cat

flags=("-b" "-e" "-n" "-s" "-t" "-v" )
files=("test1.txt" "test3.txt" )

echo ""
echo "---------------------------"
echo "--- ONE FLAG, ONE FILES ---"
echo "---------------------------"
echo ""

for flag in "${flags[@]}"
do
    for file in "${files[@]}"
    do
        echo "./s21_cat $flag $file"
        ./s21_cat "$flag" "$file" > mytext.txt
        cat "$flag" "$file" > cattext.txt
            
        if diff -q mytext.txt cattext.txt >/dev/null 2>&1;
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
        rm cattext.txt
    done
done

echo ""
echo "---------------------------"
echo "--- ONE FLAG, TWO FILES ---"
echo "---------------------------"
echo ""

for flag in "${flags[@]}"
do
    for file_1 in "${files[@]}"
    do
        for file_2 in "${files[@]}"
        do
                if [ $file_1 != $file_2 ]
                then
                echo "./s21_cat $flag $file_1 $file_2"

                ./s21_cat "$flag" "$file_1" "$file_2"> mytext.txt
                
                cat "$flag" "$file_1" "$file_2"> cattext.txt
                
                if diff -q mytext.txt cattext.txt >/dev/null 2>&1;
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
                rm cattext.txt
                fi
        done
    done
done


echo ""
echo "----------------------------"
echo "--- MANY FLAG, ONE FILES ---"
echo "----------------------------"
echo ""

for flag_1 in "${flags[@]}"
do
    for flag_2 in "${flags[@]}"
    do
        for flag_3 in "${flags[@]}"
        do
            for flag_4 in "${flags[@]}"
            do
                for flag_5 in "${flags[@]}"
                do
                    for flag_6 in "${flags[@]}"
                    do
                        for file in "${files[@]}"
                        do
                            if [ $flag_1 != $flag_2 ] && [ $flag_1 != $flag_3 ] && [ $flag_1 != $flag_4 ]&& [ $flag_1 != $flag_5 ] && [ $flag_1 != $flag_6 ]&&[ $flag_2 != $flag_3 ] && [ $flag_2 != $flag_4 ]&& [ $flag_2 != $flag_5 ]&& [ $flag_2 != $flag_6 ]&& [ $flag_3 != $flag_4 ]&& [ $flag_3 != $flag_5 ] && [ $flag_3 != $flag_6 ]&& [ $flag_4 != $flag_5 ] && [ $flag_4 != $flag_6 ]&& [ $flag_5 != $flag_6 ]
                            then
                            echo "./s21_cat $flag_1 $flag_2 $flag_3 $flag_4 $flag_5 $flag_6 $file"

                            ./s21_cat $flag_1 $flag_2 $flag_3 $flag_4 $flag_5 $flag_6 $file> mytext.txt
                            
                            cat $flag_1 $flag_2 $flag_3 $flag_4 $flag_5 $flag_6 $file> cattext.txt
                            
                            if diff -q mytext.txt cattext.txt >/dev/null 2>&1;
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
                            rm cattext.txt
                            fi
                        done   
                    done
                done
            done
        done
    done
done

echo ""
echo "---------------------------"
echo "---  NE STANDART INPUT  ---"
echo "---------------------------"
echo ""
        echo "./s21_cat $file $flag"
            ./s21_cat "$file" "$flag"  > mytext.txt
            cat  "$file" "$flag" > cattext.txt
            
        if diff -q mytext.txt cattext.txt >/dev/null 2>&1;
        then
            let "COUNT++"
            let "SUCCESS++"
            echo "$COUNT- SUCCESS"
        else 
            let "COUNT++"
            let "FAIL++"
            echo "$COUNT - FAIL"
        fi
            rm mytext.txt
            rm cattext.txt
echo ""
echo "----------------------------"
echo "ALL: $COUNT, SUCCESS: $SUCCESS, FAIL: $FAIL"
echo "----------------------------"
echo ""
