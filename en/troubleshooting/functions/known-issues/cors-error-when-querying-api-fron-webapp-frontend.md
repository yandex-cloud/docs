# Resolving the `CORS` error when accessing the {{ speechkit-short-name }}, {{ vision-short-name }}, or {{ translate-short-name }} API from a web application frontend


## Issue description {#issue-description}

When you try to access the {{ speechkit-short-name }}, {{ vision-short-name }}, or {{ translate-short-name }} API, you get a `CORS` error:

```
Access to XMLHttpRequest at '<https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze>' 
from origin '...' has been blocked by CORS policy: Response to preflight request doesn't
pass access control check: No 'Access-Control-Allow-Origin'
```

## Solution {#issue-resolution}

You cannot enable direct interaction between an application running in a frontend environment, and the API. Our AI services cannot handle cross-domain requests because their APIs are not arranged to respond the `OPTIONS` request.

You can use {{ sf-name }} for this. You will need to [create a cloud function](../../../functions/operations/function/function-create.md) with an API in it that will deliver requests to {{ speechkit-short-name }}, {{ vision-short-name }}, or {{ translate-short-name }}.