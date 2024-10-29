### Exceeding the maximum number of fields limit {#exceeding-fields-limit}

Error message:

```text
Limit of total fields [<limit_value>] has been exceeded
```

The transfer will be interrupted if the number of columns in the source database exceeds the maximum number of fields in the target database {{ OS }} indexes.

**Solution:** [Increase](../../../../data-transfer/operations/endpoint/target/opensearch.md#prepare) the maximum field number in the target database using the `index.mapping.total_fields.limit` parameter.
