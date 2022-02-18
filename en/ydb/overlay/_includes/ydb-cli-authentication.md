To make queries to {{ ydb-full-name }} in {{ yandex-cloud }} using the {{ ydb-short-name }} CLI, you need to authenticate. Choose one of the available authentication methods.

{% list tabs %}

- OAuth token

    When running a {{ ydb-short-name }} CLI command, in the `--yc-token-file` parameter, specify the path to the file with your [OAuth token](../../iam/concepts/authorization/oauth-token.md).

    To avoid entering this parameter every time you run commands, save the OAuth token value to the `YC_TOKEN` environment variable or [set up a profile](../ydb-cli/profile/create.md) of the {{ ydb-short-name }} CLI.

- IAM token

    When running a {{ ydb-short-name }} CLI command, in the `--iam-token-file` parameter, specify the path to the file with your [IAM token](../../iam/concepts/authorization/iam-token.md).

    To avoid specifying this option every time you run commands, save the IAM token value to the `IAM_TOKEN` environment variable or [set up a {{ ydb-short-name }} CLI profile](../ydb-cli/profile/create.md).

    {% note alert %}

    [The lifetime](../../iam/concepts/authorization/iam-token.md#lifetime) of an IAM token is no more than 12 hours.

    {% endnote %}

- Metadata service

    When running a {{ ydb-short-name }} CLI command, specify the `--use-metadata-credentials` parameter, and {{ ydb-cli }} will get an [IAM token](../../iam/concepts/authorization/iam-token.md) via the [metadata service](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md) if you're working from a VM in {{ yandex-cloud }}.

    To avoid specifying this option every time you run a command, set the `USE_METADATA_CREDENTIALS` environment variable to `1` or [set up a {{ ydb-short-name }} CLI profile](../ydb-cli/profile/create.md).

- Authorized access key

    When running a {{ ydb-short-name }} CLI command, in the `--sa-key-file` parameter, specify the path to the file with the private [authorized access key](../../iam/concepts/authorization/access-key.md) of the service account.

    To avoid specifying this option every time you run a command, save the file path to the `SA_KEY_FILE` environment variable or [set up a {{ ydb-short-name }} CLI profile](../ydb-cli/profile/create.md).

{% endlist %}
