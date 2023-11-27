# Resolving issues with joined tables when connecting to Bitrix



## Issue description {#issue-description}

* You cannot join tables when connecting Bitrix24
* When you try to join tables while connecting to Bitrix24, a new table fails to be added to the field, but replaces the old one.
* When trying to join several tables from different sources in the dataset, you see the error message:

```json

{
  "data": {
    "code": "ERR.DS_API.VALIDATION.FATAL",
    "dataset_errors": [],
    "message": "Source cannot be added to dataset"
  }
}

```

## Solution {#issue-resolution}

Perhaps you are trying to join tables from a Bitrix24 source.
There is a restriction for connecting to Bitrix24: you cannot join tables. This restriction does not apply to other connection types in DataLens, for example, to databases or files.

If you need to use the feature of joining Bitrix24 tables, consider the option of exporting source data to other formats. For importing data to DataLens, you can use CSV, Excel, or Google Sheets formats:

* [Guide for exporting data from Bitrix24](https://helpdesk.bitrix24.ru/open/1489089/)
* [Guide for creating a connection from a CSV file](../../../datalens/tutorials/data-from-csv-visualization.md)
* [Guide for creating a Google Sheets connection](../../../datalens/operations/connection/create-google-sheets.md)

In our "Community" section, you can also [vote](https://cloud.yandex.ru/features/2235) for implementation of  table joining functionality for Bitrix.

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help solve the issue, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. Link to the problematic dataset
2. [HAR-file](https://cloud.yandex.ru/docs/support/create-har) built when attempting to add a joined table to the dataset
3. Information about the data source whose tables you are trying to add to the dataset.
