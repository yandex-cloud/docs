# Connecting to a database using the {{ ydb-short-name }} CLI

The {{ ydb-short-name }} CLI enables you to manage your data in {{ ydb-full-name }} from the command line. You can use it to operate your databases in systems without a GUI or to automate your tasks using scripts.

First, you need to install the [{{ ydb-short-name }} CLI]({{ ydb.docs }}/reference/ydb-cli/install). To connect to your {{ ydb-full-name }} database from the {{ ydb-short-name }} CLI, specify the [endpoint and path](#endpoint-and-path) and [select and set up](#auth) the authentication mode.

## Configuring security groups {#configuring-security-groups}

To connect to your database in {{ dd }} mode, allow incoming and outgoing traffic over TCP on port `{{ ydb.port-dedicated }}`. Make sure the assigned [security group](../../vpc/concepts/security-groups.md) has the relevant rule, or add one:

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ ydb.port-dedicated }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

## Get connection credentials {#endpoint-and-path}

To get the database connection credentials:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}) and select a folder containing your database.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the database for which you need to get the endpoint and path.
      
      * The database endpoint is specified under **{{ ui-key.yacloud.ydb.overview.section_connection }}** in the first part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`):

          >For example, the endpoint for a database in _serverless mode_ is `{{ ydb.ep-serverless }}`, and in _dedicated mode_, is `{{ ydb.ep-dedicated }}`.
      * The database path is specified under **{{ ui-key.yacloud.ydb.overview.section_connection }}** in the second part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`).
      
          >Example of a database path: `{{ ydb.path-serverless }}`.

- {{ yandex-cloud }} CLI {#cli}

  1. {% include [cli-install](../../_includes/cli-install.md) %}
  1. Get the list of databases in the folder:

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

      You can find the database connection credentials in the `ENDPOINT` column.

      >For example, for a _serverless_ database:
      >* Endpoint: `{{ ydb.ep-serverless }}`
      >* Path: `{{ ydb.path-serverless }}`
      >
      >For a _dedicated_ database:
      >* Endpoint: `{{ ydb.ep-dedicated }}`
      >* Path: `{{ ydb.path-dedicated }}`

- API {#api}

  Use the [get](../api-ref/Database/get.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Get](../api-ref/grpc/Database/get.md) gRPC API call and provide the database ID in the `databaseId` request parameter.

  You can find the database connection credentials in the `endpoint` column.

  >For example, for a _serverless_ database:
  >* Endpoint: `{{ ydb.ep-serverless }}`
  >* Path: `{{ ydb.path-serverless }}`
  >
  >For a _dedicated_ database:
  >* Endpoint: `{{ ydb.ep-dedicated }}`
  >* Path: `{{ ydb.path-dedicated }}`

  {% include [get-db-id](../../_includes/ydb/get-db-id.md) %}

{% endlist %}

## Set up authentication {#auth}

Select the authentication mode:

* [OAuth token](../../iam/concepts/authorization/oauth-token.md): Allows you to run commands only under a [{{ yandex-cloud }} account](../../iam/concepts/users/accounts.md#passport). The token is valid for 1 year. This mode is not recommended for production environments.
* [IAM token](../../iam/concepts/authorization/iam-token.md): Recommended for performing one-time operations under a [{{ yandex-cloud }} account](../../iam/concepts/users/accounts.md#passport) or a [federated account](../../iam/concepts/users/accounts.md#saml-federation). The maximum lifetime of an IAM token is 12 hours.
* [Authorized access key](../../iam/concepts/authorization/key.md): Recommended for running {{ ydb-short-name }} CLI commands from outside {{ yandex-cloud }} under a [service account](../../iam/concepts/index.md#sa).
* [Metadata service](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md): Most secure and efficient mode used for running commands on VMs inside {{ yandex-cloud }}. [{{ sf-full-name }}](../../functions/) supports it as well.

Set up the mode you selected:

{% list tabs %}

- OAuth token

  Get an OAuth token by sending a [request]({{ link-cloud-oauth }}) and save it to a file. In your {{ ydb-short-name }} CLI commands, provide the path to this file in the `--yc-token-file` parameter.

  To skip this step every time you run a command, save the OAuth token value to the `YC_TOKEN` environment variable or [set up a {{ ydb-short-name }} CLI profile]({{ ydb.docs }}/reference/ydb-cli/profile/create).

  Check the connection by requesting user information:

  ```bash
  {{ ydb.cli }} \
    --endpoint <endpoint> \
    --database <name> \
    --yc-token-file <path> \
    discovery whoami
  ```

  * `--endpoint`: Database endpoint.
  * `--database`: Path to the database.
  * `--yc-token-file`: Path to the OAuth token file.

  >Here is a command example:
  >
  >```bash
  >{{ ydb.cli }} \
  >  --endpoint {{ ydb.ep-serverless }} \
  >  --database {{ ydb.path-serverless }} \
  >  --yc-token-file oauth-token.txt \
  >  discovery whoami
  >```
  >
  >Result:
  >
  >```text
  >User SID: aje6o75au36h********@as
  >```

- IAM token

  1. Use the [{{ yandex-cloud }} CLI](../../cli/) to get an IAM token:

      ```bash
      yc iam create-token
      ```

  1. Save the token to a file.
  1. In your {{ ydb-short-name }} CLI commands, provide the path to this file in the `--iam-token-file` parameter.

      To skip this step every time you run a command, save the IAM token value to the `IAM_TOKEN` environment variable or [set up a {{ ydb-short-name }} CLI profile]({{ ydb.docs }}/reference/ydb-cli/profile/create).
  1. Check the connection by requesting user information:

      ```bash
      {{ ydb.cli }} \
        --endpoint <endpoint> \
        --database <name> \
        --iam-token-file <path> \
        discovery whoami
      ```

      * `--endpoint`: Database endpoint.
      * `--database`: Path to the database.
      * `--iam-token-file`: Path to the IAM token file.

      >Here is a command example:
      >
      >```bash
      >{{ ydb.cli }} \
      >  --endpoint {{ ydb.ep-serverless }} \
      >  --database {{ ydb.path-serverless }} \
      >  --iam-token-file iam-token.txt \
      >  discovery whoami
      >```
      >
      >Result:
      >
      >```text
      >User SID: aje6o75au36h********@as
      >```

- Authorized access key

  1. {% include [cli-install](../../_includes/cli-install.md) %}
  1. [Create](../../iam/operations/sa/create.md) a service account to access your database. The service account must be in the same folder as the database and have the `viewer` or `viewer` + `editor` role(s) depending on the database permissions you need.
  1. Use the [{{ yandex-cloud }} CLI](../../cli/) to create an authorized key for the service account:

      ```bash
      yc iam key create \
        --service-account-name <name> \
        --output <path>
      ```

      * `--service-account-name`: Service account name.
      * `--output`: Path to the authorized key file.

  1. In your {{ ydb-short-name }} CLI commands, provide the path to this authorized key file in the `--sa-key-file` parameter.

      To skip this step every time you run a command, save the file path to the `SA_KEY_FILE` environment variable or [set up a {{ ydb-short-name }} CLI profile]({{ ydb.docs }}/reference/ydb-cli/profile/create).

  1. Check the connection by requesting user information:

      ```bash
      {{ ydb.cli }} \
        --endpoint <endpoint> \
        --database <name> \
        --sa-key-file <path>\
        discovery whoami
      ```

      * `--endpoint`: Database endpoint.
      * `--database`: Path to the database.
      * `--sa-key-file`: Path to the file with the private key and public key ID.

      Here is a command example:

      >```bash
      >{{ ydb.cli }} \
      >  --endpoint {{ ydb.ep-serverless }} \
      >  --database {{ ydb.path-serverless }} \
      >  --sa-key-file sa-key-file.txt \
      >  discovery whoami
      >```
      >
      >Result:
      >
      >```text
      >User SID: aje6o75au36h********@as
      >```

- Metadata service

  When running a {{ ydb-short-name }} CLI command from a {{ yandex-cloud }} VM, provide the `--use-metadata-credentials` parameter. The {{ ydb-short-name }} CLI will get an IAM token via the metadata service.

  To skip this step every time you run a command, set the `USE_METADATA_CREDENTIALS` environment variable to `1` or [set up a {{ ydb-short-name }} CLI profile]({{ ydb.docs }}/reference/ydb-cli/profile/create).

  Check the connection by requesting user information:

  ```bash
  {{ ydb.cli }} \
    --endpoint <endpoint> \
    --database <name> \
    --use-metadata-credentials \
    discovery whoami
  ```

  * `--endpoint`: Database endpoint.
  * `--database`: Path to the database.
  * `--use-metadata-credentials`: Use the metadata service.

  >Here is a command example:
  >
  >```bash
  >{{ ydb.cli }} \
  >  --endpoint {{ ydb.ep-serverless }} \
  >  --database {{ ydb.path-serverless }} \
  >  --use-metadata-credentials \
  >  discovery whoami
  >```
  >
  >Result:
  >
  >```text
  >User SID: aje6o75au36h********@as
  >```

{% endlist %}
