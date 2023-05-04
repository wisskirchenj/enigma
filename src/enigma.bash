#!/usr/bin/env bash
# enigma stage 1

echo "Enter a message:"
read message
upper_re='^[A-Z ]+$'
if [[ $message =~ $upper_re ]]; then
    echo "This is a valid message!"
else
    echo "This is not a valid message!"
fi