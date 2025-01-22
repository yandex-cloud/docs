# Resolving ERR.DS_API.REQUEST_TIMEOUT error



## Issue description {#issue-description}

* Building the chart ends with the `ERR.DS_API.REQUEST_TIMEOUT` error after a long wait.

## Solution {#issue-resolution}

You cannot increase the data wait time threshold on the DataLens side. Try breaking up the most resource-consuming tasks into parts or use data filtering to reduce their number.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
When creating a request, specify:

1. A link to the problem object in DataLens (chart or dashboard);
2. The Request ID of the problem query (you can find it on the error page).
