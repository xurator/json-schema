# json-schema

A public, stable repository of [JSON Schema](https://json-schema.org/) files.

## Layout of Schema files

Schema files are stored in versioned collections, with collections organised by publisher.

The layout of Schema files is:

    {publisher}/
        {collection}@{version}/
            schema files

Where:

* `{publisher}` is a domain name
* `{collection}` is a valid [Debian package name](https://www.debian.org/doc/debian-policy/ch-controlfields.html#source)
  * (which is naturally also a valid [Fedora package name](https://fedoraproject.org/wiki/Packaging:Naming))
* `{version}` is an [ISO 8601 Date](https://www.iso.org/iso-8601-date-and-time-format.html) string
* `schema files` may be contained in subdirectories as required

The newest version of a collection must use a later date than all previous versions.

This prescriptive layout ensures a consistent, opinionated mapping to:

* [Absolute URIs for Schemas](https://json-schema.org/draft/2020-12/json-schema-core.html#name-base-uri-anchors-and-derefe)
* Package names for distributing Schemas
* The layout of files on systems where Schemas are installed

### Absolute URIs for Schemas

The mapping to absolute [URI](https://www.rfc-editor.org/info/rfc3986) is:

    {scheme}://json-schema.{publisher}/{collection}/{schema file}

### Package names

The mapping to package name is:

    json-schema-{collection}

### Installed layout of files

The mapping to installed [files on Linux systems](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) is:

    /usr/share/json-schema/{collection}/{schema file}

## Examples

If I:

* publish at domain `foo.bar`
* decide to call my collection `baz-thud`
* have schema files `quux.json` and `wibble.json`
* whose first versions I declare against 25th December 2022 (`2022-12-25`)

Then the layout of schema files will be:

    foo.bar/
        baz-thud@2022-12-25/
            quux.json
            wibble.json

Using scheme `https` the absolute URIs will be:

    https://json-schema.foo.bar/baz-thud/quux.json
    https://json-schema.foo.bar/baz-thud/wibble.json

The package name will be:

    json-schema-baz-thud

The installed files on Linux systems will be:

    /usr/
        share/
            json-schema/
                baz-thud/
                    quux.json
                    wibble.json
