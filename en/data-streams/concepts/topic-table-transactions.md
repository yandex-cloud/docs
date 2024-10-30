# Transactions involving data streams and tables

{{ yds-name }} supports transactions that involve {{ ydb-short-name }} data streams and tables. Any data stream or table involved in such a transaction must be located in the same {{ ydb-short-name }} DB. In this way, you can employ transactions to move data from tables to data streams and vice versa. Also, you can do so between data streams to avoid your data beings lost or duplicated even under unforeseen circumstances.

To learn more about transactional operations involving data streams, see [the YDB documentation]({{ ydb.docs }}/concepts/transactions#topic-table-transactions). 
