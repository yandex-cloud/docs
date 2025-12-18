# Fixing HTTP 499 errors when working with a cloud function or {{ serverless-containers-name }} container



## Issue description {#issue-description}

The log of your cloud function or {{ serverless-containers-name }} container shows such messages as `Error: Code 499 Message: request cancelled`.

## Solution {#issue-resolution}

This error appears because of the timeout on the side of the client that calls the function. When an application sends a request to run a function, it waits for response for a certain time frame. This time limit is often 60 seconds by default. If the function fails to complete processing and retrieve the result within this time, the client aborts the connection.

In this case, you may want to try:
- Increasing the timeout on the side of the client that calls the function, if you can do so.
- Breaking down a job that takes a long time to complete into multiple functions triggered by timer. This may come in handy when you cannot change the client timeout.

If the above solutions did not help, adding logging to the function code and analyzing the logs. We have some examples of setting up logging for Python cloud functions that are available here:
- [Logging running functions on Python](../../../functions/lang/python/logging)
- [Writing to the function execution log](../../../functions/operations/function/logs-write)

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of your cloud function or container in {{ serverless-containers-name }}.
1. Contents of the log of your cloud function or container. You can find the function logs in the **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** section on the function's page in the [management console]({{ link-console-main }}).
