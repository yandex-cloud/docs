### Stopping a transfer's master transaction session {#master-trans-stop}

Error message:

```text
Cannot set transaction snapshot:
ERROR: invalid snapshot identifier: "<snapshot_ID>" (SQLSTATE 22023).
```

Possible causes:

* The source is running a cron job or other application that periodically terminates sessions that are too long.
* Someone manually terminated the master transaction.
* The source's CPU resources are insufficient to execute a query.
* The [Session duration timeout](../../../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout) parameter in the {{ PG }} cluster sets a limit for the active session lifetime.

**Solution:** Disable this cron job and add more CPU resources to the source; also set the **Session duration timeout** parameter to `0` for the duration of the transfer. After you make the changes, [re-activate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
