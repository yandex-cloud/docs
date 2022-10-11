### Stopping a transfer's master transaction session {#master-trans-stop}

Error message:

```text
Cannot set transaction snapshot:
ERROR: invalid snapshot identifier: "<snapshot ID>" (SQLSTATE 22023).
```

Possible cause:

* The source is running a cron job or other application that periodically concludes sessions that are too long.
* Someone manually terminated the master transaction.
* The source's CPU resources are insufficient to complete a query.

**Solution:** disable this cron job and add more CPU resources to the source. After you make the changes, [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
