### Transfer failure {#ambiguous-resolution-es}

Error messages:

```text
object field starting or ending with a [.] makes object resolution ambiguous <field description>

Index -1 out of bounds for length 0
```

The transfer is aborted because the keys in the documents being transferred are not valid for the {{ ES }} target. Invalid keys are empty keys and keys that:

* Consist of spaces.
* Consist of periods.
* Have a period at the beginning or end.
* Have two or more periods in a row.
* Include periods separated by spaces.

**Solution:**

In the [target endpoint additional settings](../../../../data-transfer/operations/endpoint/target/elasticsearch.md#additional-settings), enable **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.sanitize_doc_keys.title }}** and [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
