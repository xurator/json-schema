# Human-readable layout of files is specified at:
LAYOUT_URL=https://github.com/xurator/json-schema

# regexp for valid directory names: {collection}@{version}
CV_REGEXP='([a-z0-9\.\+\-]+)\@([0-9]{4}-[0-9]{2}-[0-9]{2})'

# filter collection names for valid directory names
function collection-from-dirname () {
    sed -nE 's,^'${CV_REGEXP}'$,\1,p'
}

# filter collection versions for valid directory names
function version-from-dirname () {
    sed -nE 's,^'${CV_REGEXP}'$,\2,p'
}

# construct path to schema files for collection version
function collection-root () {
    local -r publisher="$1"
    local -r collection="$2"
    local -r version="$3"
    echo "${publisher}/${collection}@${version}"
}

# construct absolute URI for collection
function collection-uri () {
    local -r scheme="$1"
    local -r publisher="$2"
    local -r collection="$3"
    printf '%s://json-schema.%s/%s/' "$scheme" "$publisher" "$collection"
}

# construct absolute https URL for collection
function collection-url-https () {
    local -r publisher="$1"
    local -r collection="$2"
    collection-uri "https" "$publisher" "$collection"
}

# construct package name for collection
function collection-package () {
    local -r collection="$1"
    printf 'json-schema-%s' "$collection"
}
