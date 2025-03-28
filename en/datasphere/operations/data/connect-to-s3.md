# Connecting to S3 using the `boto3` library

Follow this guide to connect to an S3 object storage in {{ jlab }} Notebook using the `boto3` library. To connect to an object storage, use an [S3 connector](s3-connectors.md):

{% include [fuse-disclaimer](../../../_includes/datasphere/fuse-disclaimer.md) %}

To set up an S3 connection from the notebook code:

1. [Create the secrets](secrets.md#create): `token` (with ID) and `key_value` (with a secret part of the [static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account).
1. {% include [include](../../../_includes/datasphere/ui-before-begin.md) %}
1. Import the libraries:

    ```python
    import boto3
    import os
    from os import path
    ```

1. Enter the name of your bucket in the storage:

    ```python
    bucket_name = '<bucket_name>'
    ```

1. Establish a connection:

    ```python
    session = boto3.session.Session()

    ENDPOINT = "https://{{ s3-storage-host }}"

    session = boto3.Session(
        aws_access_key_id=(os.environ['token']),
        aws_secret_access_key=(os.environ['key_value']),
        region_name="{{ region-id }}",
    )

    s3 = session.client(
        "s3", endpoint_url=ENDPOINT)
    ```

1. Enter the bucket name and retrieve a list of objects contained in it:

    ```python
    for key in s3.list_objects(Bucket='<bucket_name>')['Contents']:
        print(key['Key'])
    ```
