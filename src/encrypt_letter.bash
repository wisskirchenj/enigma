#!/usr/bin/env bash
# enigma stage 2

function exit_invalid() {
  echo "Invalid key or letter!" && exit
}

function validate() {
  upper_letter_re='^[A-Z]$'
  number_re='^[0-9]$'
  [[ $1 =~ $upper_letter_re ]] && [[ $2 =~ $number_re ]] || exit_invalid
}

function encrypt() {
    ascii_letter=$(printf "%d" \'$1)
    ascii_encrypted=$(( $ascii_letter + $2 ))
    # while bigger then 'Z' (ascii 90) subtract 26
    while [ $(($ascii_encrypted)) -gt 90 ]; do
      ascii_encrypted=$(( $ascii_encrypted - 26 ))
    done
    printf "\x$(printf %x $ascii_encrypted)"
}

echo "Enter an uppercase letter:"
read letter
echo "Enter a key:"
read key
validate $letter $key
encrypted=$(encrypt $letter $key)
echo "Encrypted letter: $encrypted"