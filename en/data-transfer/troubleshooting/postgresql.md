# {{ PG }}

## Stopping a master transaction session {#master-trans-stop}

In certain cases, _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ type transfers return the error `Cannot set transaction snapshot: ERROR: invalid snapshot identifier: "<snapshot ID>" (SQLSTATE 22023).`

This error results from the termination of a _master transaction_ session: a special transaction that {{ data-transfer-name }} creates at the start of a transfer. A master transaction is used to read data from tables during a transfer, and its session is always in the `idle` state.

Master transaction sessions most frequently terminate for the following reasons:

* The source is running a cron job or other application that periodically concludes sessions that are too long.
* Someone manually terminated the master transaction.
* The source's CPU resources are insufficient to complete a query.

To resolve the issue, disable this cron job and add more CPU resources to the source.

After you make the changes, [re-activate](../operations/transfer.md#activate) the transfer.

## Exceeding the connection time-to-live quota {#conn-duration-quota}

{{ mpg-full-name }} has a connection time-to-live quota of 12 hours. If transfering a database requires more time, please contact [technical support](../../support/overview.md) to have your quota increased.
