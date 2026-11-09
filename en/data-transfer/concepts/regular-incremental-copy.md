# Regular incremental copy

{% include [include](../../_includes/dlp/transfer/regular-copy.md) %}

## Transaction completion timeout {#increment-delay}

A _transaction race_ may occur while incremental copy is in progress. This is a situation when transactions are completed in a sequence different from the one they were run in. As a result, earlier changes may be displayed after those which were made later. In that case, the transfer calculates the key column value based on the more recent changes while ignoring the older ones.

The issue is fixed with a transaction completion timeout. This is a delay between calculating the key column value and obtaining the actual data. When set, the transfer is waiting for the specified number of seconds for all transactions that might change the data in the output range to complete and only after that reads new data from the table.

Make sure the transaction completion timeout is:

* Longer than an average data insert or update transaction. In standard applications, it takes a few seconds to complete these transactions.
* Much shorter than the interval between transfer runs, as it directly impacts the transfer duration.

The recommended and default value is `15` seconds.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
