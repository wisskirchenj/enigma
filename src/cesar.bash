#!/usr/bin/env bash
# enigma stage 3

function get_message() {
  echo "Enter a message:"
  read message
  upper_re='^[A-Z ]+$'
  if [[ ! $message =~ $upper_re ]]; then
      echo "This is not a valid message!"
      exit
  fi
}

function encrypt() {
  if [ ! $1 = " " ]; then
    ascii_letter=$(printf "%d" \'$1)
    ascii_encrypted=$(( $ascii_letter + $key ))
    if [ $(($ascii_encrypted)) -gt 90 ]; then
      ascii_encrypted=$(( $ascii_encrypted - 26 ))
    fi
    echo $(printf "\x$(printf %x $ascii_encrypted)")
  else
    echo " "
  fi
}

function encrypt_message() {
  key=$([ $1 = "e" ] && echo 3 || echo 23)
  get_message
  for ((i=0;i<${#message};i++)); do
      char=${message:i:1}
      encrypted=${encrypted}$(encrypt $char)
  done
  [ $1 = "e" ] && echo "Encrypted message:" || echo "Decrypted message:"
  echo $encrypted
}


echo -e "Type 'e' to encrypt, 'd' to decrypt a message:\nEnter a command:"
read cmd
if [[ $cmd =~ ^[de]$ ]]; then
  encrypt_message $cmd
else
  echo "Invalid command!"
fi