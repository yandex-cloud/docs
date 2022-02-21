---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/as_tagged.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/as_tagged.md
---

## AsTagged, Untag {#as-tagged}

Wraps the value in the [Tagged data type](../../../types/special.md) with the specified tag, preserving the physical data type. `Untag`: the reverse operation.

Required arguments:

1. Value of any type.
2. Tag name.

Returns a copy of the value from the first argument with the specified tag in the data type.

Examples of use cases:

* Returns to the client's web interface the media files from BASE64-encoded strings.
* Additional refinements at the level of returned columns types.
