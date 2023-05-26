#!/usr/bin/env bash
# enigma stage 4

MESSAGE_REGEX='^[A-Z ]+$'

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
    echo "Enter the filename:"
    read filename
    [[ $filename =~ ^[A-Za-z.]+$ ]] && $1 $filename || echo "File name can contain letters and dots only!"
}

create() {
  echo "Enter a message:"
  read message
  [[ $message =~ $MESSAGE_REGEX ]] && write_it "$message" $1 || echo "This is not a valid message!"
}

write_it() {
  echo $1 > $2
  echo "The file was created successfully!"
}

read_it() {
  [[ -e $1 ]] && echo "File content:" && cat $1 || echo "File not found!"
}

encrypt() {
  echo "Not implemented!"
}

decrypt() {
  echo "Not implemented!"
}

echo "Welcome to the Enigma!"
print_menu
read choice
while [[ ! $choice == "0" ]]; do
  case $choice in
    "1") file create;;
    "2") file read_it;;
    "3") encrypt;;
    "4") decrypt;;
    *) echo "Invalid option!";;
  esac
  print_menu
  read choice
done
echo "See you later!"
