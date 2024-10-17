# Connecting to a database using the {{ ydb-short-name }} CLI

The {{ ydb-short-name }} CLI is a tool for managing your data in {{ ydb-full-name }} from the command line. You can use the {{ ydb-short-name }} CLI to perform actions with your database in systems that have no GUI or to automate your tasks using scripts.

Before you start, install the [{{ ydb-short-name }} CLI](https://ydb.tech/docs/en/reference/ydb-cli/install). To connect to your {{ ydb-full-name }} database from the {{ ydb-short-name }} CLI, specify the [endpoint and path](#endpoint-and-path) and [select and set up](#auth) authentication mode.

## Configuring security groups {#configuring-security-groups}

To connect to your DB in {{ dd }} mode, allow incoming and outgoing traffic over TCP on port `{{ ydb.port-dedicated }}`. Make sure the assigned [security group](../../vpc/concepts/security-groups.md) contains the appropriate rule, or add one:

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ ydb.port-dedicated }}`
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

## Get connection details {#endpoint-and-path}

To get the database connection details:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [management console]({{ link-console-main }}).
   1. Select the folder hosting your DB and go to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Select the DB you want to get the endpoint and path for.

      * The DB endpoint is specified under **{{ ui-key.yacloud.ydb.overview.section_connection }}** in the first part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`):

         > For example, the endpoint for a DB in Serverless mode is `{{ ydb.ep-serverless }}` and in Dedicated mode is `{{ ydb.ep-dedicated }}`.
      * The DB path is specified under **{{ ui-key.yacloud.ydb.overview.section_connection }}** in the second part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`).

         > Sample DB path: `{{ ydb.path-serverless }}`.

- {{ yandex-cloud }} CLI {#cli}

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

      DB connection details are specified in the `ENDPOINT` column.

      > For example, for a Serverless database:
      > * Endpoint: `{{ ydb.ep-serverless }}`.
      > * Path: `{{ ydb.path-serverless }}`.
      >
      > For a Dedicated database:
      > * Endpoint: `{{ ydb.ep-dedicated }}`.
      > * Path: `{{ ydb.path-dedicated }}`.

- API {#api}

   Use the [get](../api-ref/Database/get.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Get](../api-ref/grpc/database_service.md#Get) gRPC API call and provide the database ID in the `databaseId` request parameter.

   Database connection details are specified in the `endpoint` parameter.

   > For example, for a Serverless database:
   > * Endpoint: `{{ ydb.ep-serverless }}`.
   > * Path: `{{ ydb.path-serverless }}`.
   >
   > For a Dedicated database:
   > * Endpoint: `{{ ydb.ep-dedicated }}`.
   > * Path: `{{ ydb.path-dedicated }}`.

   {% include [get-db-id](../../_includes/ydb/get-db-id.md) %}

{% endlist %}

## Set up authentication {#auth}

Select one of the authentication modes:

* [OAuth token](../../iam/concepts/authorization/oauth-token.md): Allows you to run commands only on behalf of a [{{ yandex-cloud }} account](../../iam/concepts/users/accounts.md#passport). The token is valid for 1 year. This mode is not recommended for production environments.
* [IAM token](../../iam/concepts/authorization/iam-token.md): Recommended for performing one-time operations on behalf of a [{{ yandex-cloud }} account](../../iam/concepts/users/accounts.md#passport) or a [federated account](../../iam/concepts/users/accounts.md#saml-federation). IAM token's maximum lifetime is 12 hours.
* [Authorized access key](../../iam/concepts/authorization/key.md): Recommended for running {{ ydb-short-name }} CLI commands from outside {{ yandex-cloud }} under a [service account](../../iam/concepts/index#sa).
* [Metadata service](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md): The most secure and efficient mode. Used for running commands on VMs inside {{ yandex-cloud }}. Also supported by [{{ sf-full-name }}](../../functions/).

Set up the selected mode:

{% list tabs %}


- OAuth token

   Get an OAuth token by sending a [request]({{ link-cloud-oauth }}) and save it to a file. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your OAuth token in the `--yc-token-file` parameter.

   To avoid entering it every time you run commands, save the OAuth token value to the `YC_TOKEN` environment variable or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/docs/en/reference/ydb-cli/profile/create).

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
   > User SID: aje6o75au36h********@as
   > ```


- IAM token

   1. Use the [{{ yandex-cloud }} CLI](../../cli/) to get an IAM token:

      ```bash
      yc iam create-token
      ```

   1. Save the token to a file.
   1. When running a {{ ydb-short-name }} CLI command, specify the path to the file with your IAM token in the `--iam-token-file` parameter.

      To avoid entering it every time you run commands, save the IAM token value to the `IAM_TOKEN` environment variable or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/docs/en/reference/ydb-cli/profile/create).
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
      > User SID: aje6o75au36h********@as
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

      To avoid entering it every time you run commands, save the file path to the `SA_KEY_FILE` environment variable or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/docs/en/reference/ydb-cli/profile/create).

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
      > User SID: aje6o75au36h********@as
      > ```

- Metadata service

   When running a {{ ydb-short-name }} CLI command from a {{ yandex-cloud }} VM, specify the `--use-metadata-credentials` parameter. The {{ ydb-short-name }} CLI will get an IAM token via the metadata service.

   To avoid entering it every time you run commands, set the `USE_METADATA_CREDENTIALS` environment variable to `1` or [set up a {{ ydb-short-name }} CLI profile](https://ydb.tech/docs/en/reference/ydb-cli/profile/create).

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
   > User SID: aje6o75au36h********@as
   > ```

{% endlist %}
