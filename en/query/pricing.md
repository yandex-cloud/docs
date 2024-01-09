# {{ yq-full-name }} pricing

In {{ yq-full-name }}, you are billed for the amount of data read from sources when executing queries. If data is read from multiple sources, the volumes sum up.

## Prices { #prices }




Individual conditions:
- If query execution is interrupted due to any system cause, you will not be charged for the query.
- If query execution is stopped by the user, billing will be based on the volume of data read by the time of the user intervention.
- If the total data read during query execution is less than 10 MB, it will be rounded up to 10 MB.


## Examples of cost calculation { #examples }

The examples given below disregard the free usage thresholds.




## Charges for using the resources of related systems { #cloud-systems }

The resources of related data storage and transfer systems used in {{ yq-full-name }} queries are billed separately.

|Resource|Description|
|--------|-----------|
|Reading and writing data in {{objstorage-full-name}}|[Rates](../storage/pricing.md)|
|Reading and writing data in {{yds-full-name}}|[Rates](../data-streams/pricing.md)|
