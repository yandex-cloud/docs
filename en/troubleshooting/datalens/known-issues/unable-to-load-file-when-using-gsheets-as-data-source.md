# Error when creating a connection to a Google Sheets table from DataLens

## Issue description {#issue-description}

You are unable to create a connection to Google Sheets: when you enter a document link and wait for a while, you see this error message:

```
Couldn't upload the file
Request ID: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXX
```

# Solution {#issue-resolution}

Check whether your Google Sheets table meets one or more of these criteria:
* Exceeded the limit of 200 MB of resulting data per sheet in a Google Sheets table.
* Exceeded the limit of 300 columns per sheet in a Google Sheets table.
* At least one sheet in the table has a single populated row. You need at least two data rows because the first row includes column names which are used as headers for dataset fields.
* Name of the Google Sheets table includes `+` or `/` characters.

If the Google Sheets table you are trying to set up a connection to meets one or more of these criteria, create a copy of this table and edit it to comply with the DataLens limits and mechanics.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. Full text of the error message with Request ID.
2. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with DataLens servers.
