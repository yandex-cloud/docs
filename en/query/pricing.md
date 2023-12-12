# {{ yq-full-name }} pricing policy

In {{ yq-full-name }}, the cost is based on the size of data read from data sources when running queries. If data is read from multiple sources, the total size counts.







Special conditions:
- If the execution of a query is interrupted due to any system reason, such a query is not charged.
- If the execution of a query is stopped by the user, the cost is based on the size of the data read up to the point when the query was stopped.
- If the total size of data read during a query is less than 10 MB, the size will be rounded up to 10 MB.

## Cost calculation examples { #examples }







## Payment for resources used in related systems { #cloud-systems }

Resources used in related data storage and transmission systems utilized in {{yq-full-name}} queries are billed separately.

|Resource|Description|
|--------|-----------|
|Reading and writing data in {{objstorage-full-name}}|[Rates](../storage/pricing.md)|
|Reading and writing data in {{yds-full-name}}|[Rates](../data-streams/pricing.md)|