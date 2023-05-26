setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
}

function cesar() {
    echo -e $1 | bash $SRC_DIR/cesar.bash
}

# ---------- happy case testing -------

@test "e HANS" {
        run cesar "e\nHANS"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "Encrypted message:"
        assert_output --partial "KDQV"
}

@test "e AZYC" {
        run cesar "e\nAZYC"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "Encrypted message:"
        assert_output --partial "DCBF"
}

@test "d DCBF" {
        run cesar "d\nDCBF"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "Decrypted message:"
        assert_output --partial "AZYC"
}

@test "d KDQV" {
        run cesar "d\nKDQV"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "Decrypted message:"
        assert_output --partial "HANS"
}

@test "e EIN MANN" {
        run cesar "e\nEIN MANN"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "Encrypted message:"
        assert_output --partial "HLQ PDQQ"
}

@test "d HLQ PDQQ" {
        run cesar "d\nHLQ PDQQ"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "Decrypted message:"
        assert_output --partial "EIN MANN"
}

# ---------- error case testing -------

@test "D" {
        run cesar "D"
        assert_output --partial "Enter a command:"
        assert_output --partial "Invalid command!"
}

@test "E" {
        run cesar "E"
        assert_output --partial "Enter a command:"
        assert_output --partial "Invalid command!"
}

@test "de" {
        run cesar "de"
        assert_output --partial "Enter a command:"
        assert_output --partial "Invalid command!"
}

@test "\n" {
        run cesar "\n"
        assert_output --partial "Enter a command:"
        assert_output --partial "Invalid command!"
}

@test "d AdSS" {
        run cesar "d\nAdSS"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}


@test "d HANS-MOSER" {
        run cesar "d\nHANS-MOSER"
        assert_output --partial "Enter a command:"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}
