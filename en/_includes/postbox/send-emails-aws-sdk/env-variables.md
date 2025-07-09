By default, the AWS SDK for Go uses authentication data from environment variables if they are set. These variables have priority over authentication data from the `.aws/credentials` file.

The following environment variables are supported:

* `AWS_ACCESS_KEY_ID`: Static key ID.
* `AWS_SECRET_ACCESS_KEY`: Secret key.

To set environment variables, depending on your operating system, follow these steps:

{% list tabs group=operating_system %}

- Linux/macOS

    In the terminal, run this command:

    ```bash
    export AWS_ACCESS_KEY_ID=<static_key_ID>
    export AWS_SECRET_ACCESS_KEY=<secret_key>
    ```

- Windows

    In PowerShell, run:

    ```powershell
    $Env:AWS_ACCESS_KEY_ID=<static_key_ID>
    $Env:AWS_SECRET_ACCESS_KEY=<secret_key>
    ```

{% endlist %}