#!/usr/bin/env bash
# enigma stage 6

OPEN_SSL="openssl enc -aes-256-cbc -pbkdf2 -nosalt"

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
  echo $1 > $2 && echo "The file was created successfully!"
}

read_it() {
  [[ -e $1 ]] && echo "File content:" && cat $1 || echo "File not found!"
}

crypt_it() {
  [[ -e $2 ]] && crypt_message $1 $2 || echo "File not found!"
}

crypt_message() {
  echo "Enter password:" && read pw
  [[ $1 == "enc" ]] && { opt="-e"; out=$2.$1; } || { opt="-d"; out=${2%.enc}; }
  $OPEN_SSL -in $2 $opt -out $out -pass pass:"$pw" &> /dev/null \
        && { echo "Success"; rm $2; } ||  { echo "Fail"; rm $out; }
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
