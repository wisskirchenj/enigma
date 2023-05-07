setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
}

function validate_message() {
    echo -e $1 | bash $SRC_DIR/validate_message.bash
}

# ---------- happy case testing -------

@test "SOME TEXT" {
        run validate_message "SOME TEXT"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

@test "SOME" {
        run validate_message "SOME"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

@test "A   LOT     SPACE" {
        run validate_message "SOME"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

@test "   SPACE AFTER     " {
        run validate_message "   SPACE AFTER     "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

# ---------- error case testing -------

@test "something little" {
        run validate_message "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}

@test "BIG 2 BIG" {
        run validate_message "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}

@test "BIG AnD BIG" {
        run validate_message "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}

@test "     " {
        run validate_message "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}
