# Resolving the "409 BucketAlreadyExists" error



## Issue description {#issue-description}

You see this error when trying to create a bucket:
```
409 BucketAlreadyExists, The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.
```

## Solution {#issue-resolution}

Bucket names are unique across the entire Object Storage, so you cannot create two buckets with the same name, even in different folders of different clouds. Specify a different bucket name and try again.

For more details about naming buckets, see the [documentation](../../../storage/concepts/bucket#naming).
