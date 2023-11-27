# Fixing the "CNAME already exists" error



## Issue description {#issue-description}

When creating a resource, you see this error:
```
cname:["CNAME cdn.<domain> already exists. Try another CNAME or contact support."]
```

## Solution {#issue-resolution}

The problem is that the CDN provider already has a resource with the same host name. Once it is removed, you can create a resource with that name in Yandex Cloud.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, the problem might be that some unused resources, even inactive ones, still exist. We recommend contacting [EdgeCDN support](https://edgecenter.ru) to delete unused resources.
