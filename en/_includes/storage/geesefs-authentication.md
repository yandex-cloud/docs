{% list tabs group=operating_system %}

- Linux/macOS {#linux}

  * Using the `credentials` [file](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html), which you need to put into the `~/.aws/` folder:

      1. Create a directory:

          ```bash
          mkdir ~/.aws
          ```

      1. Create a file named `credentials` with the following contents:

          ```text
          [default]
          aws_access_key_id = <key_ID>
          aws_secret_access_key = <secret_key>
          ```

          If the key file is located elsewhere, specify its path in the `--shared-config` parameter when mounting the bucket:

          ```bash
          geesefs \
            --shared-config <path_to_key_file> \
            <bucket_name> <mount_point>
          ```

          The key file must have the same structure as `~/.aws/credentials`.

  * Using environment variables:

    ```bash
    export AWS_ACCESS_KEY_ID=<key_ID>
    export AWS_SECRET_ACCESS_KEY=<secret_key>
    ```

  {% note info %}

  You can run the `geesefs` command with superuser privileges (`sudo`). In this case, make sure to send information about the key either in the `--shared-config` parameter or using environment variables.

  {% endnote %}

- Windows {#windows}

  * Using the `credentials` [file](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html), which you need to put into the `users/<current_user>/.aws/` folder:

    ```text
    [default]
    aws_access_key_id = <key_ID>
    aws_secret_access_key = <secret_key>
    ```

    If the key file is located elsewhere, specify its path in the `--shared-config` parameter when mounting the bucket:

    ```cmd
    geesefs ^
      --shared-config <path_to_key_file> ^
      <bucket_name> <mount_point>
    ```

    The key file must have the same structure as `~/.aws/credentials`.

    Specify an existing folder as the mount point.

  * Using environment variables:

    ```cmd
    set AWS_ACCESS_KEY_ID=<key_ID>
    set AWS_SECRET_ACCESS_KEY=<secret_key>
    ```

{% endlist %}

When using GeeseFS on a {{ compute-name }} VM that has a [linked service account](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance), you can enable simplified authentication that does not require a static access key. To do this, use the `--iam` parameter when mounting the bucket.