### Error when transfering tables without primary keys {#primary-keys}

Error message:

```text
Primary key check failed: 14 Tables errors: Table no key columns found
```

For _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers, tables without primary keys are not transferred.

**Solution:** Prepare the source as described in [Preparing for the transfer](../../../data-transfer/operations/prepare.md).
