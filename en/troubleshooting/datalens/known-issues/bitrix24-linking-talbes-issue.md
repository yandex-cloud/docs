# Resolving issues with joined tables when connecting to Bitrix24



## Issue description {#issue-description}

* You cannot join tables when connecting to Bitrix24.
* When you try to join tables while connecting to Bitrix24, a new table replaces the old one instead of being added.
* When trying to join multiple tables from different sources in the dataset, you see this error message:

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

Not being able to join tables is a known restriction when connecting to Bitrix24. However, this restriction does not apply to other connection types in {{ datalens-name }}, e.g., to databases or files.

If you need to use this feature in Bitrix24, consider exporting source data to other formats. {{ datalens-name }} supports CSV and Google Sheets:

* [How to export data from Bitrix24](https://helpdesk.bitrix24.ru/open/1489089/)
* [How to create a connection from a CSV file](../../../datalens/tutorials/data-from-csv-visualization.md)
* [How to create a connection to Google Sheets](../../../datalens/operations/connection/create-google-sheets.md)

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Link to the dataset in question.
1. [HAR-file](../../../support/create-har.md) built when attempting to add a joined table to the dataset.
1. Information about the data source whose tables you are trying to add to the dataset.
