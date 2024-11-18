### Transfer interruption with the _can't index document_ error {#indexation}

Error message:

```text
Push failed: can't index document: got an indexation error
```

In audit logs of different services, the `details` field may contain data of different types. In {{ OS }}, the `details` target field only accepts data of the type that comes first. The rest of the data cannot be accepted due to type incompatibility, thus interrupting the transfer.

**Solution:** split the stream for data from different services to get into different indexes.

To do this, when creating a transfer under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**:

  * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.title }}**: Select **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.table_splitter.title }}**.
  * Set **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}** to `event_source`.