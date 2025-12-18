# How to transfer bucket contents to another bucket in the same folder


## Case description {#case-description}

You need to move your bucket contents to another bucket in the same folder. 

## Solution {#case-resolution}

You cannot move your bucket contents to another folder or cloud directly; however, you can use the [AWS CLI](../../../storage/tools/aws-cli.md) to copy the contents.

{{ objstorage-short-name }} supports the *server side copy* feature. 


To move the data, use this command:

```
aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3://bucket1/ s3://bucket2/
```

For this command to run successfully, you need to provide the following instead of the `bucket1` and `bucket2` placeholders:

* `bucket1`: Source bucket to move or copy the data from.
* `bucket2`: Target bucket to move or copy the data to.

When you use the AWS CLI for copying data, all objects will be transferred between the buckets directly. The host where you are running `aws s3 cp` and {{ objstorage-short-name }} servers will only exchange metadata, i.e., the keys of the objects you transfer. You pay neither for the incoming nor for the outgoing {{ objstorage-short-name }} traffic because this traffic is considered internal as per the object storage logic.

Similarly, you can copy bucket contents not only to another folder in the same cloud, but also to a folder in another cloud. In this case, your {{ iam-short-name }} account must have write permissions to both buckets.



{% note info %}

If [encryption](../../../security/standard/encryption.md#storage-at-rest) is enabled in the bucket, all uploaded files will be encrypted with the KMS key specified in the bucket settings.
This process does not involve the *server side copy*. When copying objects from one bucket to another, they will be uploaded to an intermediate host with the S3 client first, and only then, to the target bucket.

{% endnote %}
