[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [managed-opensearch](../index.md) > [auth-settings](index.md) > update

# yc managed-opensearch auth-settings update

Update authorization settings for a managed OpenSearch cluster.

#### Command Usage

Syntax:

`yc managed-opensearch auth-settings update <CLUSTER-NAME>|<CLUSTER-ID> [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--id` | `string`

ID of the OpenSearch cluster. ||
|| `--name` | `string`

Name of the OpenSearch cluster. ||
|| `--saml` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Settings for authentication through SAML.

Possible property names:

- `enabled`: Enable authentication through SAML.

- `idp-entity-id`: The entity ID of your IdP. Required.

- `idp-metadata-file`: The path to the SAML 2.0 metadata file of your IdP. Required

- `sp-entity-id`: The entity ID of the service provider. Required.

- `dashboards-url`: The OpenSearch Dashboards base URL. Required.

- `subject-key`: The attribute in the SAML response where the subject is stored. Optional. If not configured, the NameID attribute is used.

- `roles-key`: The attribute in the SAML response where the roles are stored. Optional. If not configured, no roles are used.

- `jwt-default-expiration-timeout`: Default jwt expiration timeout. Optional. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#