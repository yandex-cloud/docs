# Fixing error 409: `BucketAlreadyExists`



## Issue description {#issue-description}

When creating a bucket, you get this error:
```
409 BucketAlreadyExists, The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.
```

## Solution {#issue-resolution}

Bucket names are unique throughout {{ objstorage-name }}, i.e., you cannot create two buckets with the same name, even in different folders of different clouds. Enter a different bucket name and try again.

For more details about naming buckets, see [this guide](../../../storage/concepts/bucket.md#naming).