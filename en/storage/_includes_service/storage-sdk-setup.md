1. Go to the `~/.aws/` directory (for macOS and Linux) or `C:\Users\<username>\.aws\` (for Windows).
1. Create a file named `credentials` with the credentials for {{ objstorage-name }} and copy the following information to it:

    ```text
    [default]
      aws_access_key_id = <static_key_ID>
      aws_secret_access_key = <secret_key>
    ```

1. Create a file named `config` with the default region settings and copy the following information to it:

    ```text
    [default]
      region={{ region-id }}
      endpoint_url=https://{{ s3-storage-host }}
    ```

    {% note info %}

    Some apps designed to work with Amazon S3 do not allow you to specify the region; this is why {{ objstorage-name }} may also accept the `us-east-1` value.

    {% endnote %}