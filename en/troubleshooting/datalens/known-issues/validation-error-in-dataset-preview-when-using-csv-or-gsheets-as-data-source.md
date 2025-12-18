# Fixing the `ERR.DS_API.SOURCE_CONFIG.TABLE_NOT_CONFIGURED` error


## Issue description {#issue-description}

When loading a Google Sheets spreadsheet or a CSV file, the dataset preview shows this error:

```
"code": "ERR.DS_API.SOURCE_CONFIG.TABLE_NOT_CONFIGURED",
"message": "Table is not ready yet",
"level": "error"
```

## Solution {#issue-resolution}

This error means the dataset's schema has just been changed. Wait until the preview table is recreated. This may take a few minutes.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Full text of the error message with the `Request ID`.
1. [HAR file](../../../support/create-har.md) with the recorded communications between the browser and {{ datalens-name }} servers.
