1. Create a directory to store the authentication data in and navigate to it: 

    For macOS and Linux:

    ```bash
    mkdir ~/.aws/
    ```

    For Windows:

    ```bash
    mkdir C:\Users\<username>\.aws\
    ```

1. In the `.aws` directory, create a file named `credentials`, copy the credentials you got when [creating a static access key](#key), and paste them into it:

    ```text
    [default]
    aws_access_key_id = <static_key_ID>
    aws_secret_access_key = <secret_key>
    ```

1. Create a file named `config` with the default region settings and copy the following information to it:

    ```text
    [default]
    region = {{ region-id }}
    endpoint_url = https://{{ postbox-host }}
    ```