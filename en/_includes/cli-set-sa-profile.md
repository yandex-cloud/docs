Configure the CLI to work on behalf of a service account:

1. {% include [cli-install](cli-install.md) %}
1. {% include [default-catalogue](default-catalogue.md) %}
1. Get a list of available service accounts in the default folder:

    ```bash
    yc iam service-accounts list
    ```

    Result:

    ```bash
    +----------------------+----------+--------+
    |          ID          |   NAME   | LABELS |
    +----------------------+----------+--------+
    | ajeb9l33h6mu******** | my-robot |        |
    +----------------------+----------+--------+
    ```

1. Create an [authorized key](../iam/concepts/authorization/key.md) for your service account and save it to the file:

    ```bash
    yc iam key create --output <key_file_path> --service-account-name <service_account_name>
    ```

    Where:

    * `--output`: Path to the file for saving the authorized key in JSON format. This is a required parameter.
    * `--service-account-name`: Service account name.

     For example:

     ```bash
     yc iam key create --output key.json --service-account-name my-service-account
     ```

     Result:

     ```bash
     id: aje4lue48687********
     service_account_id: ajeb9l33h6m********
     created_at: "2024-08-01T11:58:52.313177213Z"
     key_algorithm: RSA_2048
     ```

    For more information about the `yc iam key create` command, see the [CLI reference](../cli/cli-ref/iam/cli-ref/service-account/create.md).

1. Create a profile to execute operations on behalf of the service account:

    ```bash
    yc config profile create <profile_name>
    ```

1. Specify the authorized key of the service account in the profile configuration:

    ```bash
    yc config set service-account-key <key_file_path>
    ```