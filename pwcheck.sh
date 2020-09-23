#!/bin/bash

FILE="$1"
SCORE=0
read -r PW<"$1"

#Password has less than 6, or more than 32 characters

if [ ${#PW} -gt 32 ] || [ ${#PW} -lt 6 ] ; then
  echo "Error: Password length invalid."
else
  SCORE=${#PW}
  if egrep -q "[#$+%@]" $FILE; then
      let SCORE=$SCORE+5
  fi
  #if contains a number
  if egrep -q "[0-9]" $FILE; then
    let SCORE=$SCORE+5
  fi
   #if contains alpha character
  if egrep -q "[A-Za-z]" $FILE; then
    let SCORE=$SCORE+5
  fi
  #if contains repeated alphanumeric
  if egrep -q "([A-Za-z0-9])\1+" $FILE; then
    let SCORE=$SCORE-10
  fi
  #if lower case more than 3 times
  if egrep -q "[a-z]{3,}" $FILE; then
    let SCORE=$SCORE-3
  fi
  #if upper case more than 3 times
  if egrep -q "[A-Z]{3,}" $FILE; then
    let SCORE=$SCORE-3
  fi
  #if numbers more than 3 times
  if egrep -q "[0-9]{3,}" $FILE; then
    let SCORE=$SCORE-3
  fi
  echo "Password Score: $SCORE"
fi
