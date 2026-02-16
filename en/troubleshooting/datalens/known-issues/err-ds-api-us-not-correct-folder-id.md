# Fixing the `ERR.DS_API.US Not correct folder_id` error


## Issue description {#issue-description}

When saving a {{ datalens-name }} object to a folder, you get this error:

```
ERR.DS_API.US Not correct folder_id
```

## Solution {#issue-resolution}

You are probably saving the connection to a non-existent {{ datalens-name }} folder. Try saving it to another folder.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Link to the object in question from the browser address bar.
1. Full text of the error message with the `Request ID`.
1. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with {{ datalens-name }} servers.