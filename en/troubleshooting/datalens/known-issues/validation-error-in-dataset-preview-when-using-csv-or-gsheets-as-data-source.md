# Fixing the ERR.DS_API.SOURCE_CONFIG.TABLE_NOT_CONFIGURED error in DataLens

## Issue description {#issue-description}

When you load a table from Google Sheets or a CSV file, the data set preview shows the error:
```
        "code": "ERR.DS_API.SOURCE_CONFIG.TABLE_NOT_CONFIGURED",
        "message": "Table is not ready yet",
        "level": "error"
```

## Solution {#issue-resolution}

This error means that the dataset's schema has just been changed. Wait until the preview table is recreated (this may take several minutes).

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. Full text of the error message with Request ID.
2. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with DataLens servers.
