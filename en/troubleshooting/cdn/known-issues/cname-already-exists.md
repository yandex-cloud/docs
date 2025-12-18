# Fixing the `CNAME already exists` error



## Issue description {#issue-description}

When creating a resource, you get this error:
```
cname:["CNAME cdn.<domain> already exists. Try another CNAME or contact support."]
```

## Solution {#issue-resolution}

The issue occurs because the CDN provider already has a resource with the same host name. Once it is deleted, you can create a resource with that name in {{ yandex-cloud }}.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, it may mean that some resources still remain, even if they are inactive. We recommend contacting [EdgeCDN support](https://edgecenter.ru) to delete unused resources.
