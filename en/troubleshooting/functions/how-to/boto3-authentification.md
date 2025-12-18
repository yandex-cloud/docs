# How to set up `boto3` authentication


## Case description {#case-description}

* You need to create a cloud function that saves its results to an AWS-compatible data storage.
* You need to find out how to authenticate and authorize in the relevant service from the cloud function code using `boto3`.

## Solution {#case-resolution}

To access AWS-compatible services, you need [static access keys](../../../iam/concepts/authorization/access-key.md).

{% note info %}

AWS-compatible services include:

* [{{ yds-full-name }}](../../../data-streams/)
* [{{ objstorage-full-name }}](../../../storage/) 
* [{{ message-queue-full-name }}](../../../message-queue/) 
* [{{ ydb-full-name }}](../../../ydb/)

{% endnote %}

Metadata only stores the {{ iam-short-name }} token, not AWS keys. Therefore, you need to use either [environment variables](../../../functions/operations/function/environment-variables-add.md) to explicitly specify the key and secret, or [set up integration with {{ lockbox-short-name }}](../../../lockbox/operations/serverless/functions.md).

{% cut "Example of setting up `boto3` for S3 access using environment variables" %}

```python
import os, boto3


s3 = boto3.client('s3',
    endpoint_url            = 'https://storage.yandexcloud.net',
    aws_access_key_id       = os.environ['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key   = os.environ['AWS_SECRET_ACCESS_KEY'],
    region_name             = os.environ['AWS_DEFAULT_REGION']
)

def handler(event, context):
    return s3.list_buckets()['Buckets']
```

{% endcut %}
