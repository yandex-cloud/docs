# How to migrate data from an {{ objstorage-name }} bucket to ice storage


## Case description {#case-description}

You need to migrate data from a standard or cold storage in an {{ objstorage-name }} bucket to ice storage.

## Solution {#case-resolution}

You cannot use lifecycle rules to change the storage class of objects in an {{ objstorage-name }} bucket to `ICE`. There are two workarounds to do that:

* Copy the objects.
* Set a lifecycle using the AWS CLI. 

{% list tabs %}

- Copying objects with the AWS CLI

    To copy objects to a different bucket using the AWS CLI, follow these steps:

    1. [Change the storage class](../../../storage/concepts/storage-class.md#changing-storage-class) for your bucket to `ICE`.
    1. [Install and configure the AWS CLI](../../../storage/tools/aws-cli.md).
    1. Run the `aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3://*\$OLD_BUCKET_NAME\ s3://*\$NEW_BUCKET_NAME\` command.

    {% note tip %}

    In the provided example, replace `$OLD_BUCKET_NAME` with the source bucket name and `$NEW_BUCKET_NAME`, with the target bucket name.

    {% endnote %}

    In this case, moving data between storage classes occurs directly within {{ objstorage-name }}, without downloading objects to a local host running the AWS CLI. You can also specify the storage class for an object using the `--storage-class` option in the AWS CLI:
    
    ```
    aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3://*\$OLD_BUCKET_NAME\ s3://*\$NEW_BUCKET_NAME\ --storage-class GLACIER
    ```

    Any of the above options will only change storage type for objects in the bucket. No duplicate objects will be created in the bucket as a result of this operation.

- Setting a lifecycle using the AWS CLI

    To set up a lifecycle using the AWS CLI, follow these steps:

    1. Create a `transition`-type lifecycle via the [management console]({{ link-console-main }}) web UI.
    1. Save the current lifecycle rule configuration to the `lifecycles.json` file with the AWS CLI:  

        ```bash
        aws s3api get-bucket-lifecycle-configuration \
        --endpoint-url=https://storage.yandexcloud.net \
        --bucket <$BUCKET_NAME> > lifecycles.json  
        ```

        In the provided example, replace `$BUCKET_NAME` with the name of your {{ objstorage-name }} bucket.
    
    1. Edit `lifecycles.json`, changing the storage class from `COLD` to `ICE`.
    1. Apply the new configuration using the AWS CLI:

        ```bash
        aws s3api put-bucket-lifecycle-configuration \
        --bucket <$BUCKET_NAME> \
        --endpoint-url=https://storage.yandexcloud.net \
        --lifecycle-configuration file://lifecycles.json
        ```

        In the provided example, replace `$BUCKET_NAME` with the name of your {{ objstorage-name }} bucket.

{% endlist %}