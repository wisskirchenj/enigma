setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
}

function encrypt_letter() {
    echo -e $1 | bash $SRC_DIR/encrypt_letter.bash
}

# ---------- happy case testing -------

@test "A 2" {
        run encrypt_letter "A 2"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Encrypted letter: C"
}

@test "Z 2" {
        run encrypt_letter "Z 2"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Encrypted letter: B"
}

@test "F 0" {
        run encrypt_letter "F 0"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Encrypted letter: F"
}

@test "S 9" {
        run encrypt_letter "S 9"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Encrypted letter: B"
}

# ---------- error case testing -------

@test "a 2" {
        run encrypt_letter "a 2"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Invalid key or letter!"
}

@test "a s" {
        run encrypt_letter "a s"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Invalid key or letter!"
}

@test "A s" {
        run encrypt_letter "A s"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Invalid key or letter!"
}

@test "A 22" {
        run encrypt_letter "A 22"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Invalid key or letter!"
}

@test ", 2" {
        run encrypt_letter ", 2"
        assert_output --partial "Enter an uppercase letter:"
        assert_output --partial "Enter a key:"
        assert_output --partial "Invalid key or letter!"
}