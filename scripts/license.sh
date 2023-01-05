# extract SPDX identifier from license
function license-spdx-identifier () {
    local -r license="$1"
    sed -nE 's/^SPDX-License-Identifier: (.+)$/\1/p' "$license"
}

# extract (free-form) copyright text from license
function license-copyrights () {
    local -r license="$1"
    sed -nE 's/^Copyright (.*)$/\1/p' "$license"
}

# extract all other text from license
function license-text () {
    local -r license="$1"
    sed -e '/^SPDX-License-Identifier:/d' \
        -e '/^Copyright /d' "$license" |
    sed '/./,$!d' # discard leading blank lines
}
