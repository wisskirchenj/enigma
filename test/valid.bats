setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
}

function enigma() {
    echo -e $1 | bash $SRC_DIR/enigma.bash
}

# ---------- happy case testing -------

@test "SOME TEXT" {
        run enigma "SOME TEXT"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

@test "SOME" {
        run enigma "SOME"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

@test "A   LOT     SPACE" {
        run enigma "SOME"
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

@test "   SPACE AFTER     " {
        run enigma "   SPACE AFTER     "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is a valid message!"
}

# ---------- error case testing -------

@test "something little" {
        run enigma "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}

@test "BIG 2 BIG" {
        run enigma "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}

@test "BIG AnD BIG" {
        run enigma "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}

@test "     " {
        run enigma "      "
        assert_output --partial "Enter a message:"
        assert_output --partial "This is not a valid message!"
}
