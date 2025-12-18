# Fixing error 403 (header is not retrieved when using the `OPTION` method)



## Issue description {#issue-description}

When the `CORS` parameter is set up, headers provided in response from the server, do not include `Access-Control-Allow-Origin` when using the `OPTION` method, and code 403 is returned.

## Solution {#issue-resolution}

For `CORS` to work, you need to specify `HEADER Origin: <domain>` in requests where the domain is listed in the `CORS` settings under `allowed origins`.

You can learn more about `CORS` in [this article](https://habr.com/ru/company/macloud/blog/553826/). To provide additional headers, list them in the `Allowed Headers` parameter or allow everything using the asterisk symbol (`*`).