---
sourcePath: en/ydb/overlay/getting_started/auth.md
---
# Authentication

The article describes a simple method for authenticating in {{ ydb-full-name }} with an IAM token. Read more about authentication modes in the [documentation](../concepts/connect.md#auth).

1. Using the [{{ yandex-cloud }} CLI](../../cli/index.yaml), get an IAM token:

    ```bash
    yc iam create-token
    ```

1. Use the obtained token in one of the following ways:

    {% list tabs %}

    - {{ ydb-short-name }} CLI

      * Save the token to a file and specify the path to the file in the `--iam-token-file` parameter every time you run a command.
      * Save the token to the `IAM_TOKEN` environment variable to avoid specifying this parameter every time commands are run.
      * Save the token to a file and specify the path to the file by selecting the `[1] Use IAM token (iam-token)` option when [setting up a profile](../reference/ydb-cli/profile/create.md) in the {{ ydb-short-name }} CLI.

    - {{ ydb-short-name }} SDK

      * Save the token to the `YDB_ACCESS_TOKEN_CREDENTIALS` environment variable.
      * [Transfer the token](../reference/ydb-sdk/auth.md#auth-provider) in **Access token** mode as described for the SDK in your programming language by passing the token value as a parameter.

    {% endlist %}

{% note alert %}

[The lifetime](../../iam/concepts/authorization/iam-token.md#lifetime) of an IAM token is no more than 12 hours.

{% endnote %}
