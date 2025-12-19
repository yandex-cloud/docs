1. Create a directory to store the authentication data in and navigate to it: 

    For macOS and Linux:

    ```bash
    mkdir ~/.aws/
    ```

    For Windows:

    ```bash
    mkdir C:\Users\<username>\.aws\
    ```

1. In the `.aws` directory, create a file named `credentials` and copy the credentials [received earlier](#before-you-begin) into it:

    ```text
    [default]
    aws_access_key_id = <static_key_ID>
    aws_secret_access_key = <secret_key>
    ```

1. Create a file named `config` with the default region settings and copy the following information to it:

    ```text
    [default]
    region = {{ region-id }}
    endpoint_url = https://{{ s3-storage-host }}
    ```

    {% note info %}

    Some apps designed to work with Amazon S3 do not allow you to specify the region; this is why {{ objstorage-name }} may also accept the main AWS region value, which is the [first row in the table of regions](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).

    {% endnote %}