### Cluster access error {#transfer-error}

Text of the error that occurs when creating a transfer:

```text
Cannot retrieve table information from the source database: failed to resolve storage: failed to create a PostgreSQL storage: unable to get master host: unable to create postgres service client: All hosts are unavailable:
```
**Solution:** Check whether the cluster is accessible in your [subnet](../../../../data-transfer/concepts/network.md).
Most often, the issue is due to missing security group rules that are required.