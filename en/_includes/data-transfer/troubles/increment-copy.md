### Transaction race when running incremental copy {#increment-copy}

During incremental copy, there may be transaction races, i.e., situations when transactions are completed in a sequence different from the one they were run in. In that case, the transfer may ignore earlier transactions. For more information, see [Transaction completion timeout](../../../data-transfer/concepts/regular-incremental-copy.md#increment-delay).

**Solution**: Increase the transaction completion timeout in the [transfer settings](../../../data-transfer/operations/transfer.md#update). The recommended and default value is `15` seconds.
