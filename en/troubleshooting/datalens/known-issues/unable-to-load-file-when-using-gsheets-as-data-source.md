# Troubleshooting connection to a Google Sheets spreadsheet from {{ datalens-name }}


## Issue description {#issue-description}

You fail to create a connection to Google Sheets: when you enter a document URL and wait for a while, you get this error message:
```
Could not upload file
Request ID: ********-****-****-****-**********
``` 

# Solution {#issue-resolution}

Check whether your spreadsheet meets any of these conditions:

* The limit of 200 MB of resulting data per sheet has been exceeded.
* The limit of 300 columns per sheet has been exceeded.
* At least one sheet of your spreadsheet has only one populated row. You need at least two rows with data because the first row includes column names which are used as headers for dataset fields.
* Your spreadsheet name includes `+` or `/`.

If the Google Sheets spreadsheet you are trying to set up a connection to meets any of these conditions, create a copy of this spreadsheet and edit it to comply with the {{ datalens-name }} limits and technical restrictions.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Full text of the error message with the `Request ID`.
1. [HAR file](../../../support/create-har.md) with the recorded browser interactions with {{ datalens-name }} servers.
