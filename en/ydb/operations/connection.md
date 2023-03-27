# Connecting to a database using the {{ ydb-short-name }} CLI

The {{ ydb-short-name }} CLI is a tool for managing your data in {{ ydb-full-name }} from the command line. You can use the {{ ydb-short-name }} CLI to perform actions with your database in systems that have no GUI or to automate your tasks using scripts.

Before you start, install the [{{ ydb-short-name }} CLI](https://ydb.tech/en/docs/reference/ydb-cli/install). To connect to your {{ ydb-full-name }} database from the {{ ydb-short-name }} CLI, specify the [endpoint and path](#endpoint-and-path) and [select and set up](#auth) authentication mode.

{% note warning %}

To connect to your DB in Dedicated mode from outside {{ yandex-cloud }}, allow incoming and outgoing traffic over TCP on port `2135`. Make sure the assigned [security group](../../vpc/concepts/security-groups.md) has the appropriate rule or add one.

{% endnote %}

## Get connection parameters {#endpoint-and-path}

You can get DB connection parameters in the {{ yandex-cloud }} management console or the {{ yandex-cloud }} CLI.

{% list tabs %}

- Management console

   1. Go to the [management console]({{ link-console-main }}).
   1. Select the folder with your DB and go to **{{ ydb-full-name }}**.
   1. Select the DB to get the endpoint and path for.

      * The DB endpoint is specified under **Connection** in the **Endpoint** line:

         > For example, the endpoint for a DB in Serverless mode is `{{ ydb.ep-serverless }}` and in Dedicated mode is `{{ ydb.ep-dedicated }}`.
      * The DB path is specified under **Connection** in the **Database** line.

         > Sample DB path: `{{ ydb.path-serverless }}`.

- YC CLI

   1. {% include [cli-install](../../_includes/cli-install.md) %}
   1. Get a list of databases in the folder:

      ```bash
      yc ydb database list
      ```

      Result:

      ```text
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      |          ID          |      NAME      | DESCRIPTION |                                                           ENDPOINT                                                            |     CREATED AT      | STATUS  |
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      | {{ ydb.id-serverless }} | {{ ydb.name-serverless }} |             | {{ ydb.ep-serverless }}/?database={{ ydb.path-serverless }}                  | 2022-05-29 21:10:35 | RUNNING |
      | {{ ydb.id-dedicated }} | {{ ydb.name-dedicated }}  |             | {{ ydb.ep-dedicated }}/?database={{ ydb.path-dedicated }} | 2022-05-31 10:10:12 | RUNNING |
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      ```

      DB connection parameters are specified in the `ENDPOINT` column.

      > For example, for a Serverless database:
      > * Endpoint: `{{ ydb.ep-serverless }}`.
      > * Path: `{{ ydb.path-serverless }}`.
      >
      > For a Dedicated database:
      > * Endpoint: `{{ ydb.ep-dedicated }}`.
      > * Path: `{{ ydb.path-dedicated }}`.

{% endlist %}

## Set up authentication {#auth}

Select one of the authentication modes:

* [OAuth token](../../iam/concepts/authorization/oauth-token.md): Lets you run commands on behalf of a [{{ yandex-cloud }} account](../../iam/concepts/index.md#passport) only. The token is valid for 1 year. This mode is not recommended for production environments.
* [IAM token](../../iam/concepts/authorization/iam-token.md): Recommended for performing one-time operations on behalf of a [{{ yandex-cloud }} account](../../iam/concepts/index.md#passport) or a [federated account](../../iam/concepts/index.md#saml-federation). The maximum lifetime of an IAM token is 12 hours.
* [Authorized access key](../../iam/concepts/authorization/key.md): Recommended for running {{ ydb-short-name }} CLI commands from outside {{ yandex-cloud }} under a [service account](../../iam/concepts/index#sa).
* [Metadata service](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md): The most secure and efficient mode. Used for running commands on VMs inside {{ yandex-cloud }}. Also supported by [{{ sf-full-name }}](../../functions/).

Set up the selected mode:

{% list tabs %}


- OAuth token

   Get an OAuth token by sending a [request]({{ link-cloud-oauth }}) and save it to a file. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your OAuth token in the `--yc-token-file` parameter.

   To avoid entering it every time you run commands, save the OAuth token value to the `YC_TOKEN` environment variable or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/en/docs/reference/ydb-cli/profile/create).

   Check that the connection is correct by requesting user information:

   ```bash
   {{ ydb.cli }} \
     --endpoint <endpoint> \
     --database <name> \
     --yc-token-file <path> \
     discovery whoami
   ```

   * `--endpoint`: DB endpoint.
   * `--database`: DB path.
   * `--yc-token-file`: Path to the OAuth token file.

   > Command example:
   >
   > ```bash
   > {{ ydb.cli }} \
   >  --endpoint {{ ydb.ep-serverless }} \
   >  --database {{ ydb.path-serverless }} \
   >  --yc-token-file oauth-token.txt \
   >  discovery whoami
   > ```
   >
   > Result:
   >
   > ```text
   > User SID: aje6o75au36h5d0yuv2g@as
   > ```


- IAM token

   1. Use the [{{ yandex-cloud }} CLI](../../cli/) to get an IAM token:

      ```bash
      yc iam create-token
      ```

   1. Save the received token to a file.
   1. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your IAM token in the `--iam-token-file` parameter.

      To avoid entering it every time you run commands, save the IAM token value to the `IAM_TOKEN` environment variable or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/en/docs/reference/ydb-cli/profile/create).
   1. Check that the connection is correct by requesting user information:

      ```bash
      {{ ydb.cli }} \
        --endpoint <endpoint> \
        --database <name> \
        --iam-token-file <path> \
        discovery whoami
      ```

      * `--endpoint`: DB endpoint.
      * `--database`: DB path.
      * `--iam-token-file`: Path to the IAM token file.

      > Command example:
      >
      > ```bash
      > {{ ydb.cli }} \
      >  --endpoint {{ ydb.ep-serverless }} \
      >  --database {{ ydb.path-serverless }} \
      >  --iam-token-file iam-token.txt \
      >  discovery whoami
      > ```
      >
      > Result:
      >
      > ```text
      > User SID: aje6o75au36h5d0yuv2g@as
      > ```

- Authorized access key

   1. {% include [cli-install](../../_includes/cli-install.md) %}
   1. [Create](../../iam/operations/sa/create.md) a service account to access your DB. The service account must be in the same folder as the database and have the `viewer` or `viewer` + `editor` role depending on what access to the DB is required.
   1. Use the [{{ yandex-cloud }} CLI](../../cli/) to create an authorized key for the service account:

      ```bash
      yc iam key create \
        --service-account-name <name> \
        --output <path>
      ```

      * `--service-account-name`: Name of the service account.
      * `--output`: Path to the file with the authorized key.

   1. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your service account's authorized access key in the `--sa-key-file` parameter.

      To avoid entering it every time you run commands, save the file path to the `SA_KEY_FILE` environment variable or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/en/docs/reference/ydb-cli/profile/create).

   1. Check that the connection is correct by requesting user information:

      ```bash
      {{ ydb.cli }} \
        --endpoint <endpoint> \
        --database <name> \
        --sa-key-file <path>\
        discovery whoami
      ```

      * `--endpoint`: DB endpoint.
      * `--database`: DB path.
      * `--sa-key-file`: Path to the file with the private key and public key ID.

      Command example:

      > ```bash
      > {{ ydb.cli }} \
      >  --endpoint {{ ydb.ep-serverless }} \
      >  --database {{ ydb.path-serverless }} \
      >  --sa-key-file sa-key-file.txt \
      >  discovery whoami
      > ```
      >
      > Result:
      >
      > ```text
      > User SID: aje6o75au36h5d0yuv2g@as
      > ```

- Metadata service

   When running a {{ ydb-short-name }} CLI command from a {{ yandex-cloud }} VM, specify the `--use-metadata-credentials` parameter. The {{ ydb-short-name }} CLI will get an IAM token via the metadata service.

   To avoid entering it every time you run commands, set the `USE_METADATA_CREDENTIALS` environment variable to `1` or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/en/docs/reference/ydb-cli/profile/create).

   Check that the connection is correct by requesting user information:

   ```bash
   {{ ydb.cli }} \
     --endpoint <endpoint> \
     --database <name> \
     --use-metadata-credentials \
     discovery whoami
   ```

   * `--endpoint`: DB endpoint.
   * `--database`: DB path.
   * `--use-metadata-credentials`: Use the metadata service.

   > Command example:
   >
   > ```bash
   > {{ ydb.cli }} \
   >  --endpoint {{ ydb.ep-serverless }} \
   >  --database {{ ydb.path-serverless }} \
   >  --use-metadata-credentials \
   >  discovery whoami
   > ```
   >
   > Result:
   >
   > ```text
   > User SID: aje6o75au36h5d0yuv2g@as
   > ```

{% endlist %}
