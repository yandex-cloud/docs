# Fixing the `GATEWAY_REQUEST_ERROR` error



## Issue description {#issue-description}

When editing the ACL configuration of the {{ objstorage-short-name }} bucket, you get this error message:

```
message: Access Denied;
status: undefined;
description: Access Denied;
code: GATEWAY_REQUEST_ERROR;
Request ID: undefined;
Trace ID: undefined;
```

## Solution {#issue-resolution}

The `Access Denied` error most often occurs due to a poorly configured access policy. To edit the ACL configuration of the bucket, you need the `storage.admin` role.

Make sure the **Resource** field within the access policy contains these two values: `bucket_name/*` and `bucket_name/`.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ objstorage-short-name }} bucket name.
1. Screenshot or full text of the error message.
