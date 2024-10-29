# Fixing HTTP 499 errors when working with a cloud function or serverless container


## Issue description {#issue-description}

* In the log of the cloud function or serverless container, you see messages like `Error: Code 499 Message: request cancelled`.

## Solution {#issue-resolution}

This behavior occurs when the function breaks the connection before a response from the server is sent to it. For instance, when the timeout per request in the function expires, the request is cancelled (which is why the log shows the "Request cancelled" line).

Carry out the following actions to solve the issue:

1. Add logging to the function code. We have prepared an example of setting up logging for Python cloud functions in the [documentation](../../../functions/lang/python/logging.md).

2. Revise your function logic. For instance, it is good practice to run different API methods by different service accounts. In case, for some reason (security systems, token expiration, etc.), the account that is using the API loses access, then only one or some methods of the function will have issues, rather than the entire function. Furthermore, this approach will help simplify diagnostic of the function if other issues arise with it in the future.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
Provide the following information in the request:

1. ID of the cloud function or serverless container
2. Content of the log of the cloud function or the serverless container (the function's operation logs are available in the **Logs** section on the function's page in the management console).
