# Resolving error 403 (header is not provided when using the OPTION method)



## Issue description {#issue-description}

When the `CORS` parameter is set up, the headers that come in response from the server, do not include `Access-Control-Allow-Origin` when using the `OPTION` method, and code 403 is returned.

## Solution {#issue-resolution}


For `CORS` to work, you need to specify the `HEADER Origin: <domain>` in the requests, where the domain is listed in the `CORS` settings under `allowed origins`.


You can read more about `CORS` in simple terms [here](https://habr.com/ru/company/macloud/blog/553826/). To enable the transfer of additional headers, list them in the `Allowed Headers` parameter or allow everything using the asterisk (*) symbol.