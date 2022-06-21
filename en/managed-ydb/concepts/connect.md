# Connecting to and authenticating with a database using {{ iam-short-name }}

To connect to the {{ ydb-full-name }} database from the YDB CLI or an application using the {{ ydb-short-name }} SDK, you'll need to provide the following data:

* Endpoint.
* Database path.
* Authentication information.

## Endpoint {#endpoint}

An endpoint is a string structured as `protocol://host:port` and provided by a YDB cluster owner for proper routing of client queries to its databases by way of a network infrastructure as well as for proper network connections. Cloud databases display the endpoint in the management console on the requisite DB page and also normally send it via the cloud provider's CLI. In corporate environments, the names of YDB endpoints are provided by administrators or can also be obtained in the internal cloud management console.

To find out the value of the DB endpoint parameter in {{ ydb-name }}:

{% list tabs %}

- Management console

  1. Go to the [management console]({{ link-console-main }}).
  1. Select the desired folder and go to **{{ ydb-full-name }}**.
  1. Select the desired database in the list of databases.
  1. On the **Overview** tab, go to the **YDB endpoint** section.

      The endpoint value is in the **Endpoint** line. To get the value of the DB connection parameter, add the protocol name at the beginning.

- CLI

  Run the [Yandex Cloud CLI](../../cli/index.yaml) command:

  ```bash
  yc ydb database list
  ```

  Result:

  ```bash
  +----------------------+------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
  |          ID          | NAME | DESCRIPTION |                                                   ENDPOINT                                                   |     CREATED AT      | STATUS  |
  +----------------------+------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
  | etn01lrprvnlnhv8v5kj | test |             | grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj | 2021-11-26 12:06:55 | RUNNING |
  +----------------------+------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
  ```

  The parameter value is in the `ENDPOINT` column: `grpcs://ydb.serverless.yandexcloud.net:2135`.

{% endlist %}

## Database path {#database}

Database path (`database`) is a string that defines where the queried database is located in the YDB cluster. Has the format [path](https://en.wikipedia.org/wiki/Path_(computing)) and uses the `/` character as separator. It always starts with a `/`.

A YDB cluster may have multiple databases deployed, and their paths are defined by the cluster configuration. Like the endpoint, the path is displayed in the management console on the desired database page and can also be obtained via the YC CLI.

To find out the value of the DB `database` parameter in {{ ydb-name }}:

{% list tabs %}

- Management console

  1. Go to the [management console]({{ link-console-main }}).
  1. Select the desired folder and go to **{{ ydb-full-name }}**.
  1. Select the desired database in the list of databases.
  1. On the **Overview** tab, go to the **YDB endpoint** section.

      The parameter value is in the **Database** line.

- CLI

  Run the [Yandex Cloud CLI](../../cli/index.yaml) command:

  ```bash
  yc ydb database list
  ```

  Result:

  ```bash
  +----------------------+------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
  |          ID          | NAME | DESCRIPTION |                                                   ENDPOINT                                                   |     CREATED AT      | STATUS  |
  +----------------------+------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
  | etn01lrprvnlnhv8v5kj | test |             | grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj | 2021-11-26 12:06:55 | RUNNING |
  +----------------------+------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
  ```

  The parameter value is in the `ENDPOINT` column: `/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj`.

{% endlist %}

{% note warning %}

Applications should not in any way interpret the number and value of `database` directories, since they are set in the YDB cluster configuration. For example, when working with {{ ydb-name }}, the `database` current structure is `region_name/cloud_id/database_id`. However, this format may be changed in the future for new databases.

{% endnote %}

## Authentication information {#auth}

Once a network connection is established, the server starts to accept client requests with authentication information for processing. The server uses it to identify the client's account and to verify access to execute the query.

The basic operation model assumes that there is a separate system for managing credentials and permissions: [IAM (Identity and Access Management)](https://en.wikipedia.org/wiki/Identity_management). IAM issues a token linked to the account, which the YDB client passes to the server along with a request. The YDB server accesses the IAM system to verify the token and permission to perform the requested operation and caches the result.

YDB also supports username and password based authentication without interacting with IAM, but using this model in practice is limited to simple configurations, primarily local ones.

### Authentication modes {#auth-modes}

YDB clients (CLI or SDK) support the following token selection modes to pass tokens in requests:

* **Anonymous**: Empty token passed in a request.
* **Access Token**: Fixed token set as a parameter for the client (SDK or CLI) and passed in requests.
* **Refresh Token**: [OAuth token](https://auth0.com/blog/refresh-tokens-what-are-they-and-when-to-use-them/) of a user's personal account set as a parameter for the client (SDK or CLI), which the client periodically sends to the IAM API in the background to rotate a token (obtain a new one) to pass in requests.
* **Service Account Key**: Service account attributes and a signature key set as parameters for the client (SDK or CLI), which the client periodically sends to the IAM API in the background to rotate a token (obtain a new one) to pass in requests.
* **Metadata**: Client (SDK or CLI) periodically accessing a local service to rotate a token (obtain a new one) to pass in requests.

Any owner of a valid token can get access to perform operations; therefore, the principal objective of the security system is to ensure that a token remains private and to protect it from being compromised.

Authentication modes with token rotation, such as **Refresh Token** and **Service Account Key**, provide a higher level of security compared to the **Access Token** mode that uses a fixed token, since only secrets with a short validity period are transmitted to the YDB server over the network.

The highest level of security and performance is provided when using the **Metadata** mode, since it eliminates the need to work with secrets when deploying an application and allows accessing the IAM system and caching a token in advance, before running the application.

When choosing the authentication mode among those supported by the server and environment, follow the recommendations below:

* **Anonymous** is usually used on self-deployed local YDB clusters that are inaccessible over the network.
* **You would use Access Token** when other modes are not supported server side or for setup/debugging purposes. It does not require that the client access IAM. However, if the IAM system supports an API for token rotation, fixed tokens issued by this IAM usually have a short validity period, which makes it necessary to update them manually in the IAM system on a regular basis.
* **Refresh Token** can be used when performing one-time manual operations under a personal account, for example, related to DB data maintenance, performing ad-hoc operations in the CLI, or running applications from a workstation. You can manually obtain this token from IAM once to have it last a long time and save it in an environment variable on a personal workstation to use automatically and with no additional authentication parameters on CLI launch.
* **Service Account Key** is mainly used for applications designed to run in environments where the **Metadata** mode is supported, when testing them outside these environments (for example, on a workstation). It can also be used for applications outside these environments, working as an analog of **Refresh Token** for service accounts. Unlike a personal account, service account access objects and roles can be restricted.
* **Metadata** is used when deploying applications in clouds. Currently, this mode is supported on VMs and in Yandex Cloud Functions.

The token to specify in request parameters can be obtained in the IAM system that the specific YDB installation is associated with. In particular, for the YDB service, Yandex Cloud uses Yandex.Passport OAuth and Yandex Cloud service accounts. When using YDB in a corporate context, centralized authentication systems that are standard for the company can be used.

To prepare data for authenticating in the Yandex Cloud YDB database for the selected mode, follow these steps:

{% list tabs %}

- Access Token

  * In Access Token mode, a [Yandex Cloud IAM token](../../iam/concepts/authorization/iam-token.md) is used. For information about how to get it, see [Getting an IAM token for a Yandex account](../../iam/operations/iam-token/create.md).

- Refresh Token

  * In Refresh Token mode, an [OAuth token of a user account on Yandex](../../iam/concepts/authorization/oauth-token.md) is used. To get one, follow the [link](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).

- Service Account Key

  * In Service Account Key mode, a file with [an authorized key](../../iam/concepts/authorization/key.md) [of a service account](../../iam/concepts/users/service-accounts.md) is used.

      [Create](../../iam/operations/sa/create.md) a service account. Assign it the `viewer` or `viewer` + `editor` role depending on the access to the DB in the selected folder to be provided.

      [Create an authorized key](../../iam/operations/authorized-key/create.md) of the service account and save it to a file.

- Metadata

  * In Metadata mode, a [service account](../../iam/concepts/users/service-accounts.md) is used, which is linked to the VM where you run your application or YDB CLI commands or to the function in Yandex Cloud Functions where you execute your application code.

      [Create](../../iam/operations/sa/create.md) a service account and assign it the `viewer` or `viewer` + `editor` role depending on the access to the DB in the selected folder to be provided.

      Link the service account [to the VM](../../compute/operations/vm-connect/auth-inside-vm#link-sa-with-instance.md) or the [function in Yandex Cloud Functions](../../functions/operations/function/function-create.md).

{% endlist %}

For information about how to use the generated artifacts, see [Client side authentication configuration](#client-config) below in this article.

When using modes in which the YDB client accesses the IAM system, the IAM URL that provides an API for issuing tokens can be set additionally. By default, the existing SDK and CLI make an attempt to access the Yandex Cloud IAM API hosted at `iam.api.cloud.yandex.net:443`.
