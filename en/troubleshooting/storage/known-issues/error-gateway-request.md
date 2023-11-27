# Resolving GATEWAY_REQUEST_ERROR



## **Problem description** {#issue-description}

When trying to change the ACL configuration of the {{ objstorage-short-name }} bucket, you see this error message:

```
message: Access Denied;
status: undefined;
description: Access Denied;
code: GATEWAY_REQUEST_ERROR;
Request ID: undefined;
Trace ID: undefined;
```

## **Solution** {#issue-resolution}

The `Access Denied` error most often arises due to a poorly configured access policy.
To change the ACL configuration of the bucket, you need the role of `storage.admin` or `storage.editor`.

Make sure that these two values are specified in the **Resource** field within the access policy: `bucket_name/*` and `bucket_name/`.

## **If the issue persists** {#if-issue-still-persists}

If the above actions did not help solve the problem, create a [request for technical support]({{ link-console-support }}).
When creating a request, please specify:

1. {{ objstorage-short-name }} bucket name.
2. Screenshot or full text of the error message.