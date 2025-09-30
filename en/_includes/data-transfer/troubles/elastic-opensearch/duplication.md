### Document duplication on the target {#duplication}

When repeatedly transferring data, documents get duplicated on the target.

All documents transferred from the same source table end up under the same index named `<schemaName.tableName>` on the target. In which case the target automatically generates document IDs (`_id`) by default. As a result, identical documents get different IDs and get duplicated.

There is no duplication if the primary keys are specified in the source table or endpoint conversion rules. Document IDs are then generated at the transfer stage using the primary key values.

Generation is performed as follows:

1. If the key value contains a period (`.`), it is escaped with `\`: `some.key` --> `some\.key`.
1. All the primary key values are converted into a string: `<some_key1>.<some_key2>.<...>`.
1. The resulting string is converted by the [url.QueryEscape](https://pkg.go.dev/net/url#QueryEscape) function.
1. If the resulting string does not exceed 512 characters in length, it is used as the `_id`. If longer than 512 characters, it is hashed with [SHA-1](https://datatracker.ietf.org/doc/html/rfc3174), and the resulting hash is used as the `_id`.

As a result, documents with the same primary keys will receive the same ID when the data is transferred again, and the document transferred last will overwrite the existing one.

**Solution:**

1. Set the primary key for one or more columns in the source table or in the endpoint conversion rules.
1. [Run](../../../../data-transfer/operations/transfer.md#activate) the transfer.