#!/usr/bin/env bash
# enigma stage 5

print_menu() {
  echo """
0. Exit
1. Create a file
2. Read a file
3. Encrypt a file
4. Decrypt a file
Enter an option:"""
}

file() {
  echo "Enter the filename:" && read filename
  [[ $filename =~ ^[A-Za-z.]+$ ]] && $1 $filename || echo "File name can contain letters and dots only!"
}

create() {
  echo "Enter a message:" && read message
  [[ $message =~ ^[A-Z\ ]+$ ]] && write_it "$message" $1 || echo "This is not a valid message!"
}

write_it() {
  echo $1 > $2
  echo "The file was created successfully!"
}

read_it() {
  [[ -e $1 ]] && echo "File content:" && cat $1 || echo "File not found!"
}

crypt_it() {
  [[ -e $2 ]] && crypt_message $1 $2 || echo "File not found!"
}

crypt_message() {
  # for encrypt add 3 for decrypt add 23 to ASCII
  key=`[ $1 = "enc" ] && echo 3 || echo 23`
  message=`cat $2`
  unset encrypted
  for ((i=0;i<${#message};i++)); do
      char=${message:i:1}
      encrypted=${encrypted}`crypt_char $char`
  done
  [ $1 = "enc" ] && echo $encrypted > $2.$1 || echo $encrypted > ${2%.enc}
  rm $2 && echo Success
}

crypt_char() {
  if [ ! $1 = " " ]; then
    ascii_letter=$(printf %d \'$1)
    ascii_encrypted=$(( $ascii_letter + $key ))
    # rotate alphabet if encrypted > Ascii('Z')
    if [ $(($ascii_encrypted)) -gt 90 ]; then
      ascii_encrypted=$(( $ascii_encrypted - 26 ))
    fi
    echo $(printf "\x`printf %x $ascii_encrypted`")
  else # don't cipher spaces
    echo " "
  fi
}

echo "Welcome to the Enigma!"
print_menu && read choice
while [[ ! $choice = "0" ]]; do
  case $choice in
    "1") file create;;
    "2") file read_it;;
    "3") file "crypt_it enc";;
    "4") file "crypt_it dec";;
    *) echo "Invalid option!";;
  esac
  print_menu && read choice
done
echo "See you later!"
