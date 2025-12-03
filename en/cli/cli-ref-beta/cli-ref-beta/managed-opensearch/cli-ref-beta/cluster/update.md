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
|`--cluster-id`|<b>`string`</b><br/>ID of the OpenSearch cluster resource to update.<br/>To get the OpenSearch cluster ID, use a [ClusterService.List] request.|
|`--config-spec`|<b>`shorthand/json`</b><br/>New cluster configuration<br/><br/>Example:|
|`--config-spec`|<b>`access={data-transfer=true,`</b><br/>serverless=true}, admin-password=value, dashboards-spec={}, opensearch-spec={config={opensearch-config-2={fielddata-cache-size=value, max-clause-count=42, reindex-remote-whitelist=value}}, plugins=value, remove-keystore-settings=value, set-keystore-settings=[{name=value, value=value}]}, snapshot-management={snapshot-max-age-days=42, snapshot-schedule={schedule={daily-snapshot-schedule={hour=1, minute=1}}}}, version=value<br/><br/>Shorthand Syntax:<br/>{access={data-transfer=bool, serverless=bool}, admin-password=str, dashboards-spec={}, opensearch-spec={config={opensearch-config-2={fielddata-cache-size=str, max-clause-count=int, reindex-remote-whitelist=str}}, plugins=str,..., remove-keystore-settings=str,..., set-keystore-settings=[{name=str, value=str},...]}, snapshot-management={snapshot-max-age-days=int, snapshot-schedule={schedule={daily-snapshot-schedule={hour=int, minute=int} \| hourly-snapshot-schedule={minute=int} \| weekly-snapshot-schedule={day=MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN, hour=int, minute=int}}}}, version=str}<br/>Fields:<br/>access               struct            — Access policy for external services.<br/>data-transfer  bool  — Determines whether the access to Data Transfer is allowed.<br/>serverless     bool  — Determines whether the access to Serverless is allowed.<br/>admin-password       string  required  — OpenSearch admin password.<br/>dashboards-spec      struct            — Dashboards configuration.<br/>opensearch-spec      struct            — OpenSearch configuration.<br/>plugins                   []string                    — Names of the cluster plugins.<br/>remove-keystore-settings  []string                    — Keystore entries names to remove.<br/>set-keystore-settings     []struct                    — Keystore settings to add/replace. Old entries not listed here will be left unchanged.<br/>name   string  — Keystore entry name.<br/>value  string  — Keystore entry value.<br/>config                    oneof\<opensearch-config-2\>  — Oneof config field<br/>opensearch-config-2  struct  —<br/>fielddata-cache-size      string  — the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata<br/>max-clause-count          int     — the maximum number of allowed boolean clauses in a query<br/>reindex-remote-whitelist  string  —<br/>snapshot-management  struct            — Snapshot management configuration<br/>snapshot-max-age-days  int     — Snapshot max age in days<br/>snapshot-schedule      struct  — Snapshot creation schedule<br/>schedule  oneof<daily-snapshot-schedule\|hourly-snapshot-schedule\|weekly-snapshot-schedule>  — Oneof schedule field<br/>hourly-snapshot-schedule  struct  — Hourly based snapshot schedule<br/>minute  int  — The minute of the hour at which the backup should be created.<br/>daily-snapshot-schedule   struct  — Daily based snapshot schedule<br/>hour    int  — The hour of the day in UTC timezone at which the backup should be created.<br/>minute  int  — The minute of the hour at which the backup should be created.<br/>weekly-snapshot-schedule  struct  — Weekly based snapshot schedule<br/>day     enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>  — Day of the week<br/>hour    int                                — The hour of the day in UTC timezone at which the backup should be created.<br/>minute  int                                — The minute of the hour at which the backup should be created.<br/>version              string            — OpenSearch version.<br/>|
|`--deletion-protection`|Determines whether the cluster is protected from being deleted.|
|`--description`|<b>`string`</b><br/>New description of the OpenSearch cluster.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the OpenSearch cluster as 'key:value' pairs.<br/>For example, '"project": "mvp"' or '"source": "dictionary"'.<br/><br/>The new set of labels completely replaces the old one. To add a label, request the current<br/>set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set.|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>Cluster maintenance window. Should be defined by either one of the two options.<br/><br/>Example:<br/>--maintenance-window policy={anytime={}}<br/><br/>Shorthand Syntax:<br/>{policy={anytime={} \| weekly-maintenance-window={day=MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN, hour=int}}}<br/>Fields:<br/>policy  oneof<anytime\|weekly-maintenance-window>  — Oneof policy field<br/>anytime                    struct  — An any-time maintenance window.<br/>weekly-maintenance-window  struct  — A weekly maintenance window.<br/>day   enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>  — Day of the week.<br/>hour  int                                — Hour of the day in the UTC timezone.<br/>|
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
