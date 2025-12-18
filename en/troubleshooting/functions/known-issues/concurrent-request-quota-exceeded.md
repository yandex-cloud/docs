
# Fixing the `No node can serve the request (concurrent requests exceeded)` error


## Issue description {#issue-description}

When calling a function in {{ sf-name }} the function code is not run, and the function log contains this entry:

```
 429 Message: No node can serve the request: Concurrent requests exceeded` 
```

## Solution {#issue-resolution}

You get this error because one or more quotas listed below are exceeded:

* **Number of concurrent operations on all functions and their versions per folder**
* **Number of concurrent operations on a single function and its versions**
* **Number of concurrent calls**

Check your current consumption against the quotas listed above in the [management console]({{ link-console-quotas }}) and request a quota increase in your cloud if needed.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of your cloud function or container in {{ serverless-containers-name }}.
1. Full text of the error message from the cloud function or container log.