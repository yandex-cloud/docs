---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-opensearch/cli-ref-beta/cluster/update.md
---

# yc beta managed-opensearch cluster update

Updates the specified OpenSearch cluster.

#### Command Usage

Syntax: 

`yc beta managed-opensearch cluster update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the OpenSearch cluster resource to update. To get the OpenSearch cluster ID, use a [ClusterService.List] request.|
|`--config-spec`|<b>`shorthand/json`</b><br/>New cluster configuration<br/>Shorthand Syntax:<br/>{<br/>access = {<br/>data-transfer = bool,<br/>serverless = bool<br/>},<br/>admin-password = str,<br/>dashboards-spec = {},<br/>opensearch-spec = {<br/>config = opensearch-config-2={<br/>fielddata-cache-size = str,<br/>max-clause-count = int,<br/>reindex-remote-whitelist = str<br/>},<br/>plugins = str,...,<br/>remove-keystore-settings = str,...,<br/>set-keystore-settings = [<br/>{<br/>name = str,<br/>value = str<br/>}, ...<br/>]<br/>},<br/>snapshot-management = {<br/>snapshot-max-age-days = int,<br/>snapshot-schedule = {<br/>schedule = daily-snapshot-schedule={<br/>hour = int,<br/>minute = int<br/>} \| hourly-snapshot-schedule={<br/>minute = int<br/>} \| weekly-snapshot-schedule={<br/>day = MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN,<br/>hour = int,<br/>minute = int<br/>}<br/>}<br/>},<br/>version = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"access": {<br/>"data-transfer": "bool",<br/>"serverless": "bool"<br/>},<br/>"admin-password": "str",<br/>"dashboards-spec": {},<br/>"opensearch-spec": {<br/>"config": {<br/>"opensearch-config-2": {<br/>"fielddata-cache-size": "str",<br/>"max-clause-count": "int",<br/>"reindex-remote-whitelist": "str"<br/>}<br/>},<br/>"plugins": [<br/>"str", ...<br/>],<br/>"remove-keystore-settings": [<br/>"str", ...<br/>],<br/>"set-keystore-settings": [<br/>{<br/>"name": "str",<br/>"value": "str"<br/>}, ...<br/>]<br/>},<br/>"snapshot-management": {<br/>"snapshot-max-age-days": "int",<br/>"snapshot-schedule": {<br/>"schedule": {<br/>"daily-snapshot-schedule": {<br/>"hour": "int",<br/>"minute": "int"<br/>},<br/>"hourly-snapshot-schedule": {<br/>"minute": "int"<br/>},<br/>"weekly-snapshot-schedule": {<br/>"day": "MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN",<br/>"hour": "int",<br/>"minute": "int"<br/>}<br/>}<br/>}<br/>},<br/>"version": "str"<br/>}"<br/>Fields:<br/>access -> (struct)<br/>Access policy for external services.<br/>data-transfer -> (bool)<br/>Determines whether the access to Data Transfer is allowed.<br/>serverless -> (bool)<br/>Determines whether the access to Serverless is allowed.<br/>admin-password -> (string)<br/>OpenSearch admin password.<br/>dashboards-spec -> (struct)<br/>Dashboards configuration.<br/>opensearch-spec -> (struct)<br/>OpenSearch configuration.<br/>plugins -> ([]string)<br/>Names of the cluster plugins.<br/>remove-keystore-settings -> ([]string)<br/>Keystore entries names to remove.<br/>set-keystore-settings -> ([]struct)<br/>Keystore settings to add/replace. Old entries not listed here will be left unchanged.<br/>name -> (string)<br/>Keystore entry name.<br/>value -> (string)<br/>Keystore entry value.<br/>config -> (oneof\<opensearch-config-2\>)<br/>Oneof config field<br/>opensearch-config-2 -> (struct)<br/>fielddata-cache-size -> (string)<br/>the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata<br/>max-clause-count -> (int)<br/>the maximum number of allowed boolean clauses in a query<br/>reindex-remote-whitelist -> (string)<br/>snapshot-management -> (struct)<br/>Snapshot management configuration<br/>snapshot-max-age-days -> (int)<br/>Snapshot max age in days<br/>snapshot-schedule -> (struct)<br/>Snapshot creation schedule<br/>schedule -> (oneof<daily-snapshot-schedule\|hourly-snapshot-schedule\|weekly-snapshot-schedule>)<br/>Oneof schedule field<br/>hourly-snapshot-schedule -> (struct)<br/>Hourly based snapshot schedule<br/>minute -> (int)<br/>The minute of the hour at which the backup should be created.<br/>daily-snapshot-schedule -> (struct)<br/>Daily based snapshot schedule<br/>hour -> (int)<br/>The hour of the day in UTC timezone at which the backup should be created.<br/>minute -> (int)<br/>The minute of the hour at which the backup should be created.<br/>weekly-snapshot-schedule -> (struct)<br/>Weekly based snapshot schedule<br/>day -> (enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>)<br/>Day of the week<br/>hour -> (int)<br/>The hour of the day in UTC timezone at which the backup should be created.<br/>minute -> (int)<br/>The minute of the hour at which the backup should be created.<br/>version -> (string)<br/>OpenSearch version.|
|`--deletion-protection`|Determines whether the cluster is protected from being deleted.|
|`--description`|<b>`string`</b><br/>New description of the OpenSearch cluster.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the OpenSearch cluster as 'key:value' pairs. For example, '"project": "mvp"' or '"source": "dictionary"'. The new set of labels completely replaces the old one. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set.|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>Cluster maintenance window. Should be defined by either one of the two options.<br/>Shorthand Syntax:<br/>{<br/>policy = anytime={} \| weekly-maintenance-window={<br/>day = MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN,<br/>hour = int<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"policy": {<br/>"anytime": {},<br/>"weekly-maintenance-window": {<br/>"day": "MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN",<br/>"hour": "int"<br/>}<br/>}<br/>}"<br/>Fields:<br/>policy -> (oneof<anytime\|weekly-maintenance-window>)<br/>Oneof policy field<br/>anytime -> (struct)<br/>An any-time maintenance window.<br/>weekly-maintenance-window -> (struct)<br/>A weekly maintenance window.<br/>day -> (enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>)<br/>Day of the week.<br/>hour -> (int)<br/>Hour of the day in the UTC timezone.|
|`--name`|<b>`string`</b><br/>New name for the cluster. The name must be unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the network to move the cluster to.|
|`--security-group-ids`|<b>`strings`</b><br/>User security groups|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account used to access Object Storage.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
