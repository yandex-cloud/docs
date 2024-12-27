In {{ objstorage-short-name }}, [create buckets](../../../storage/operations/buckets/create.md) and [configure access](../../../storage/operations/buckets/edit-acl.md) to them:

1. Create a bucket for the input data and grant the `READ` permission for this bucket to the cluster service account.
1. Create a bucket for the processing output and grant the cluster service account `READ and WRITE` permissions for this bucket.
