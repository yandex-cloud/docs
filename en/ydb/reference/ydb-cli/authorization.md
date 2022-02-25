---
sourcePath: en/ydb/overlay/reference/ydb-cli/authorization.md
---
# Authorization in the {{ ydb-short-name }} CLI

To make queries to {{ ydb-full-name }} in {{ yandex-cloud }} using the {{ ydb-short-name }} CLI, you need to log in. Choose one of the available methods:

* If you're using a [Yandex account](../../../iam/concepts/index.md#passport), log in with an [OAuth token](../../../iam/concepts/authorization/oauth-token.md).
* If you're using a [federated account](../../../iam/concepts/index.md#saml-federation), log in with an [IAM token](../../../iam/concepts/authorization/iam-token.md).
* To log in from a [VM](../../../compute/concepts/vm.md), use the [metadata service](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md).
* If you want to run commands as a [service account](../../../iam/concepts/index#sa), use an [authorized access key](../../../iam/concepts/authorization/key.md).

{% list tabs %}

- OAuth token

  Get an OAuth token by sending a [request]({{ link-cloud-oauth }}) and save it to a file. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your OAuth token in the `--yc-token-file` parameter.

  To avoid entering this parameter every time you run commands, save the OAuth token value to the `YC_TOKEN` environment variable or [set up a profile](profile/create.md) of the {{ ydb-short-name }} CLI.

  Check that the authorization is correct by requesting user information:

  ```bash
  {{ ydb-cli }} \
    --endpoint <endpoint> \
    --database <database> \
    --yc-token-file <path> \
    discovery whoami \
    --groups
  ```

  * `--endpoint`: DB endpoint.
  * `--database`: Full DB path.
  * `--yc-token-file`: Path to the OAuth token file.
  * `--groups`: Add a list of groups that the user is in to the output.

  Command example:

  ```bash
  {{ ydb-cli }} \
    --endpoint ydb.serverless.yandexcloud.net:2135 \
    --database /ru-central1/b1gia87mbaomkfvscrup/etn02j1mlm4vgjhij03e \
    --yc-token-file oauth-token.txt \
    discovery whoami \
    --groups
  ```

  Result example:

  ```text
  User SID: aje6o75au36h5d0tnr8k@as
  
  User has no groups
  ```

- IAM token

  1. Using the [{{ yandex-cloud }} CLI](../../../cli/index.yaml), get an IAM token:

      ```bash
      yc iam create-token
      ```

  1. Save the received token to a file.
  1. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your IAM token in the `--iam-token-file` parameter.

      To avoid entering this parameter every time you run commands, save the IAM token value to the `IAM_TOKEN` environment variable or [set up of a {{ ydb-short-name }} CLI profile](profile/create.md).
  1. Check that the authorization is correct by requesting user information:

      ```bash
      {{ ydb-cli }} \
        --endpoint <endpoint> \
        --database <database> \
        --iam-token-file <path> \
        discovery whoami \
        --groups
      ```

      * `--endpoint`: DB endpoint.
      * `--database`: Full DB path.
      * `--iam-token-file`: Path to the IAM token file.
      * `--groups`: Add a list of groups that the user is in to the output.

      Command example:

      ```bash
      {{ ydb-cli }} \
        --endpoint ydb.serverless.yandexcloud.net:2135 \
        --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
        --iam-token-file iam-token.txt \
        discovery whoami \
        --groups
      ```

      Result example:

      ```text
      User SID: aje6o75au36h5d0tnr8k@as
      
      User has no groups
      ```

  {% note alert %}

  [The lifetime](../../../iam/concepts/authorization/iam-token.md#lifetime) of an IAM token is no more than 12 hours.

  {% endnote %}

- Metadata service

  When running a {{ ydb-short-name }} CLI command from a VM in {{ yandex-cloud }}, specify the `--use-metadata-credentials` parameter. {{ ydb-cli }} will receive an IAM token using the metadata service.

  To avoid entering this parameter every time you run a command, set the `USE_METADATA_CREDENTIALS` environment variable to `1` or [set up a  {{ ydb-short-name }} CLI profile](profile/create.md).

  Check that the authorization is correct by requesting user information:

  ```bash
  {{ ydb-cli }} \
    --endpoint <endpoint> \
    --database <database> \
    --use-metadata-credentials \
    discovery whoami \
    --groups
  ```

  * `--endpoint`: DB endpoint.
  * `--database`: Full DB path.
  * `--use-metadata-credentials`: Use the metadata service.
  * `--groups`: Add a list of groups that the user is in to the output.

  Command example:

  ```bash
  {{ ydb-cli }} \
    --endpoint ydb.serverless.yandexcloud.net:2135 \
    --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
    --use-metadata-credentials \
    discovery whoami \
    --groups
  ```

  Result example:

  ```text
  User SID: aje6o75au36h5d0tnr8k@as
  
  User has no groups
  ```

- Authorized access key

  1. Using the [{{ yandex-cloud }} CLI](../../../cli/index.yaml), create an authorized key of your service account:

      ```bash
      yc iam key create \
        --service-account-name <service_account_name> \
        --output <filename>
      ```

      * `--service-account-name`: Service account name.
      * `--output`: Name of the file where the authorized key is saved.

  1. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your service account's authorized access key in the `--sa-key-file` parameter.

      To avoid entering this parameter every time you run commands, save the file path to the `SA_KEY_FILE` environment variable or [set up a {{ ydb-short-name }} CLI profile](profile/create.md).

  1. Check that the authorization is correct by requesting user information:

      ```bash
      {{ ydb-cli }} \
        --endpoint <endpoint> \
        --database <database> \
        --sa-key-file <key file path> \
        discovery whoami \
        --groups
      ```

      * `--endpoint`: DB endpoint.
      * `--database`: Full DB path.
      * `--sa-key-file`: Path to the file with the private key and public key ID.
      * `--groups`: Add a list of groups that the user is in to the output.

      Command example:

      ```bash
      {{ ydb-cli }} \
        --endpoint ydb.serverless.yandexcloud.net:2135 \
        --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
        --sa-key-file sa-key-file.txt \
        discovery whoami \
        --groups
      ```

      Result example:

      ```text
      User SID: aje6o75au36h5d0tnr8k@as
      
      User has no groups
      ```

{% endlist %}
