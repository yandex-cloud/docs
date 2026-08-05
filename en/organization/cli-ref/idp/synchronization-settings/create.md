---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/organization-manager/cli-ref/idp/synchronization-settings/create/
---

# yc organization-manager idp synchronization-settings create

Create synchronization settings for the specified subject container

#### Command Usage

Syntax:

`yc organization-manager idp synchronization-settings create <SUBJECT-CONTAINER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--file` | `string`

Path to a file with a gRPC request to be executed, see proto files in the protobuf API specification: https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/organizationmanager/v1/idp/synchronization_service.proto ||
|| `--subject-container-id` | `string`

Subject container ID. ||
|| `--filter` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Filter configuration for synchronization.

Possible property names:

- `domain`: Domain to synchronize.

- `groups`: List of groups to synchronize.

- `organization-units`: List of organizational units to synchronize. ||
|| `--replacement-domain` | `string`

Domain replacement for synchronized users. ||
|| `--remove-user-behavior` | `string`

Behavior when removing users. Values: 'remove', 'block' ||
|| `--synchronization-interval` | `duration`

Interval between synchronization runs. ||
|| `--allow-to-capture-users` | Whether users can be captured during synchronization. ||
|| `--allow-to-capture-groups` | Whether groups can be captured during synchronization. ||
|| `--user-attribute-mappings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

User attribute mappings.

Possible property names:

- `source`: Source attribute name.

- `target`: Target attribute to map to. Values: 'full-name', 'given-name', 'family-name', 'email', 'phone-number', 'username', 'company-name', 'job-title', 'department', 'employee-id'

- `type`: Type of mapping. Values: 'direct', 'empty', 'direct-arbitrary-attribute' ||
|| `--group-attribute-mappings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Group attribute mappings.

Possible property names:

- `source`: Source attribute name.

- `target`: Target attribute to map to. Values: 'name', 'description'

- `type`: Type of mapping. Values: 'direct', 'empty', 'direct-arbitrary-attribute' ||
|| `--enable-password-writeback` | Enables password writeback feature. ||
|| `--ldap-settings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Settings for generic LDAP source. Empty for Active Directory source.

Possible property names:

- `external-id-attribute`: Name of the LDAP attribute that holds the unique entry identifier.

- `dn-attribute`: Name of the LDAP attribute that holds the DN of the entry.

- `user-object-class`: ObjectClass of users.

- `group-object-class`: ObjectClass of groups.

- `account-disabled-attribute`: Name of the LDAP attribute that stores the account status.

- `account-disabled-value`: Value of account-disabled-attribute meaning the account is disabled.

- `account-enabled-value`: Value of account-disabled-attribute meaning the account is enabled.

- `password-attribute`: Name of the LDAP attribute used for password writeback.

- `delta-sync-mode`: Delta synchronization mode. Values: 'ldap-delta-sync-mode-full-sync'

- `use-recursive-membership-filter`: Enables AD-extension matching rule for group-DN membership filter. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#