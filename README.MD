# IDEA EDU Course ...

Implemented in the Track 'Introduction to Command Line and Unix Shell' of hyperskill.org's JetBrains Academy.

## Technology / External Libraries

- bash 5.2.15 on macOS
- bash testing suite BATS (bats-core, bats-assert, bats-support)
- gnu-sed (brew installed ...)

## Repository Contents

The sources of main project tasks (6 stages) and testing.

## Run all tests

```bash
./runtests
```

## Program description

The toy project implements a bash script program for encrypting messages and files.

Stage 1: message read in and syntax check

Stage 2: Encryption of single letters

Stage 3: Caesar Cipher Encryption and Decryption of messages

Stage 4: Menu based file creation and read application

Stage 5: Menu based application to create, encrypt, decrypt and read message files

Stage 6: Encrypt and decrypt arbitrary files now using AES-256 algorithm.

Run tests using bats

Have fun!

## Project completion

Project was completed on 23.10.23.

## Progress

04.05.23 Project started - gitHub repo and project structure setup.

04.05.23 Stage 1 completed - just regexp-check of message input

07.05.23 Stage 2 completed - Encryption of letters

07.05.23 Stage 3 completed - Caesar Cipher Encryption and Decryption of messages. Use `$(cmd)` or `` `cmd` `` to get
the output of a function as return value

26.05.23 Stage 4 completed - Menu - based application to write message to a file and read it

26.05.23 Stage 5 completed - Expand the menu to encrypt and decrypt previously created files with Caesar cipher. bats
testing with custom assertions checking file existence and contents

26.05.23 Final Stage 6 completed - Use `openssl enc` with AES-256 algorithm to encode and decode arbitrary files now.