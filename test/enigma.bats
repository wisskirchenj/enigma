setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
    TEST_FILE=out.test
    PASS=secret
}

enigma() {
    echo -e $1 | bash $SRC_DIR/enigma.bash
}

file_written() {
    [[ -e $1 ]] && return 0 || return 1
}

check_file_content() {
    [[ `cat $1` = $2 ]] && return 0 || return 1
}

# ---------- happy case testing -------

@test "menu/welcome/bye" {
        run enigma "0\n"
        assert_output --partial "Welcome to the Enigma!"
        assert_output --partial "See you later!"
        assert_output --partial """
0. Exit
1. Create a file
2. Read a file
3. Encrypt a file
4. Decrypt a file
Enter an option:"""
}

@test "create out.test" {
        rm -f $TEST_FILE
        refute file_written $TEST_FILE
        run enigma "1\n$TEST_FILE\nA NEW MESSAGE\n0"
        assert_output --partial "The file was created successfully!"
        assert_output --partial "Enter a message:"
        assert_output --partial "Enter the filename:"
        assert file_written $TEST_FILE
}

@test "read out.test" {
        run enigma "2\n$TEST_FILE\n0"
        assert_output --partial "File content:"
        assert_output --partial "A NEW MESSAGE"
        assert_output --partial "Enter the filename:"
}

@test "encrypt out.test" {
        assert file_written $TEST_FILE
        run enigma "3\n$TEST_FILE\n$PASS\n0"
        assert_output --partial "Success"
        assert_output --partial "Enter password:"
        refute file_written $TEST_FILE
        assert file_written $TEST_FILE.enc
}

@test "decrypt out.test.enc" {
        assert file_written $TEST_FILE.enc
        run enigma "4\n$TEST_FILE.enc\n$PASS\n0"
        assert_output --partial "Success"
        refute file_written $TEST_FILE.enc
        assert file_written $TEST_FILE
        assert check_file_content $TEST_FILE "A NEW MESSAGE"
}

# ---------- error case testing -------

@test "out of menu" {
        run enigma "5\n0"
        assert_output --partial "Invalid option!"
}

@test "letter for menu" {
        run enigma "F\n0"
        assert_output --partial "Invalid option!"
}

@test "read not existent" {
        run enigma "2\nnot.there\n0"
        assert_output --partial "File not found!"
}

@test "wrong filename -" {
        run enigma "1\nnot-allowed\n0"
        assert_output --partial "File name can contain letters and dots only!"
}

@test "wrong filename 1" {
        run enigma "1\nnot1.allowed\n0"
        assert_output --partial "File name can contain letters and dots only!"
}

@test "decrypt wrong password" {
        run enigma "3\n$TEST_FILE\n$PASS\n0"
        assert file_written $TEST_FILE.enc
        run enigma "4\n$TEST_FILE.enc\nwrong\n0"
        assert_output --partial "Fail"
        assert file_written $TEST_FILE.enc
        refute file_written $TEST_FILE
}