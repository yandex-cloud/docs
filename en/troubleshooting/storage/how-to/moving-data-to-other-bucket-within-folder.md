# Moving bucket contents to another bucket in the same folder

## Issue description {#case-description}
You need to move your bucket contents to another bucket in the same folder.

## Solution {#case-resolution}
You can't move your bucket contents to another folder or cloud directly, but you can use the [AWS CLI](../../../storage/tools/aws-cli.md) utility to copy the contents.

Object Storage supports the Server Side Copy functionality.
To copy the data, use the command:
`aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3:bucket1/ s3:bucket2/`

Before running the above command, make the following substitutions:
- `bucket1` is your source bucket (you copy data from it).
- `bucket2` is your target bucket (you copy data to it).

When you use AWS CLI for copying data, objects will be transmitted between the buckets directly.
The host where you run `aws s3 cp` and Object Storage servers will only exchange metadata (i.e., the keys of objects transmitted to Object Storage). You pay neither for the incoming nor for the outgoing Object Storage traffic because this traffic is internal from the Object Storage viewpoint.

{% note info %}

Similarly, you can copy bucket contents not only to another folder in the same cloud, but to a folder in another cloud as well.
In this case, your IAM account needs to have write access to both buckets.

{% endnote %}
