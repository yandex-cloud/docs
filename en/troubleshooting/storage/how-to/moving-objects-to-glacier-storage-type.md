# Moving data from an Object Storage bucket to a glacier storage

## Issue description {#case-description}
You need to move data from a standard or cold storage in an Object Storage bucket, to a glacier storage.

## Solution {#case-solution}
For now, you cannot use lifecycle rules to change the object storage class in your object storage bucket to glacier storage.

The best option is to copy objects using the AWS CLI utility to the target bucket. In this case, you'll have to specify the storage parameters in the CLI or change the storage type first in the bucket settings.
Follow these steps:

1. Change your bucket to the [glacier storage type](../../../storage/concepts/storage-class.md#changing-storage-class).
2. [Install and set up the AWS CLI utility](../../../storage/tools/aws-cli.md).
3. Run this command: `aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3:*\<BUCKET_NAME>\ s3:*\<BUCKET_NAME\>`.

{% note info %}

Before running the command, make sure to replace `<BUCKET_NAME>` with your bucket name in Object Storage.

{% endnote %}

In such a case, data transfer between storage types will occur directly within Object Storage, without first downloading objects to the local host running the AWS CLI.
You can also specify the storage type for your object using the `--storage-class` option in the AWS CLI:
`aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3:*\<BUCKET_NAME\> s3:*\<BUCKET_NAME\> --storage-class GLACIER`

Any of the above options will only change storage type for objects in the bucket.
No duplicate objects will be created in the bucket as a result of this operation.
