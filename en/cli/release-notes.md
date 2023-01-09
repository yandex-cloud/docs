# YC CLI Releases

## Current version {#latest-release}

### Version 0.99.0 (01.12.22) {#version0.99.0}

#### Changes to the CLI {#cli}

**{{ objstorage-name }}**

* Added support for {{ objstorage-name }} (control plane). List of features:
   * Creating buckets with an option to specify the storage class, maximum bucket size, and ACL.
   * Updating the bucket parameters: `ACL`, `policy`, `website settings`, `CORS`, `anonymous access flags`, `Lifecycle settings`, `Maximum bucket size`, and `storage class`.
   * Deleting a bucket.
   * Linking/unlinking an HTTPS certificate for a bucket.

#### Changes to {{ yandex-cloud }} services {#services}

{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ alb-name }} {#alb}

* Added the command `yc application-load-balancer load-balancer logging` to set up load balancer logs. Command parameters:
   * `--log-group-id`, `--log-group-name`: Specify a log group from {{ cloud-logging-name }}.
   * `--enable` and `--disable`: Enable and disable load balancer logging to a log group from {{ cloud-logging-name }}.
   * `--discard`: Set up discard rules for certain logs based on HTTP or GRPC codes.

{% endif %}

##### Managed database services {#managed-db}

{% if product == "yandex-cloud" %}

**{{ mes-name }}**

* Using `{{ yc-mdb-es }} cluster restore` with the `--folder-id` option, you can pass a folder to recover your cluster to.

**{{ mmg-name }}**

* Using `{{ yc-mdb-mg }} cluster restore` with the `--folder-id` option, you can pass a folder to recover your cluster to.

{% endif %}

**{{ mmy-name }}**

* Using `{{ yc-mdb-my }} cluster restore` with the `--folder-id` option, you can pass a folder to recover your cluster to.

{% if product == "yandex-cloud" %}

**{{ mrd-name }}**

* Using `{{ yc-mdb-rd }} cluster restore` with the `--folder-id` option, you can pass a folder to recover your cluster to.

**{{ mms-name }}**

* Using `{{ yc-mdb-ms }} cluster restore` with the `--folder-id` option, you can pass a folder to recover your cluster to.

##### {{ sf-name }} {#serverless-functions}

Added the following parameters to the `yc serverless function version create` command:
* `--no-logging`: Disables logging in the function.
* `--log-group-id`, `--log-group-name`: Sends the logs to the log group specified.
* `--log-folder-id`, `--log-folder-name`: Sends the logs to the default log group in the folder.
* `--min-log-level`: Sets the minimum level of entry logging.

{% endif %}

## Previous releases {#previous-releases}

### Version 0.98.0 (09.11.22) {#version0.98.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added the `yc managed-kafka connector-s3-sink` group commands that enable you to manage S3 Sink connectors, namely to create and update them.

* Added the `sasl-enabled-mechanisms` parameter for setting and changing the configuration settings of Kafka brokers to the `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands.

* Fixed the bug with the `properties` field change on connectors.

**{{ mpg-name }}**

* Added the `15` value for the `--postgresql-version string` flag to the `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore` commands. It enables you to create a {{ PG }} cluster version 15.

* For the `yc managed-postgresql cluster create` command, changed the default value for the version of the created {{ PG }} cluster. The new default value is `15`.

* Added the ability to restore a {{ PG }} cluster to a specified folder to the `yc managed-postgresql cluster restore` command.

### Version 0.97.0 (10.10.22) {#version0.97.0}

#### Changes to {{ yandex-cloud }} services {#services}

{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ api-gw-name }} {#api-gw}

* Discontinued support for the `domainId` parameter of the `add-domain` command.

{% endif %}

#### Managed database services {#managed-db}

{% if product == "yandex-cloud" %}

**{{ mgp-name }}**

* Added the `yc managed-greenplum cluster expand` command that lets you expand existing {{ mgp-name }} clusters. Command parameters:

   * `--segment-host-count`: The number of hosts added to a cluster.
   * `--add-segments-per-host-count`: The number of segments added per cluster host.
   * `--duration-seconds`: The maximum duration of a data distribution session in seconds.

{% endif %}

**{{ mkf-name }}**

* {{ KF }} 2.1 and 2.6 are no longer supported.

### Version 0.96.0 (19.09.22) {#version0.96.0}

#### Changes to {{ yandex-cloud }} services {#services}

{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ alb-name }} {#alb}

* Added the `yc application-load-balancer load-balancer autoscale` command to manage the number of load balancer resource units.
   The command includes the following parameters:
   * `--min-zone-size`: Minimum number of resource units in a single zone.
   * `--max-size`: Maximum total number of resource units in all zones.

* Added the following flags the `yc alb load-balancer create` command:
   * `--log-group-id`, `--log-group-name`: Specify a log group from {{ cloud-logging-name }}.
   * `--disable-logging`: Create a load balancer without logging to a log group from {{ cloud-logging-name }}.

* Added the following flags to the `yc alb load-balancer update` command:
   * `--log-group-id`, `--log-group-name`: Specify a log group from {{ cloud-logging-name }}.
   * `--enable-logging` and `--disable-logging`: Enable and disable load balancer logging to a log group from {{ cloud-logging-name }}.

{% endif %}

{% if audience != "internal" %}

##### {{ compute-name }} {#compute}

* Added the `yc compute snapshot-schedule` set of commands to manage scheduled disk snapshots.
* Added the `--metadata-options` flag to the `yc compute instance create` command to manage VM metadata access.

{% endif %}

{% if audience != "internal" %}

###### {{ dns-name }} {#dns}

* Added the ability to filter by record name and type to the `yc dns zone list-records` command using the `--record-name` and `--record-type` parameters.

{% endif %}

##### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore`: added the `11-1c`, `12-1c`, `13-1c`, and `14-1c` values for the `--postgresql-version string` flag to create {{ PG }} clusters with versions 11-1c, 12-1c, 13-1c, and 14-1c.

{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ iot-name }} {#iot}

* Added the `yc iot broker` command group to manage the MQTT broker.

{% endif %}

{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ sf-name }} {#serverless-functions}

Added the following commands:

* `yc serverless trigger create iot-broker`: Create triggers for MQTT brokers.
* `yc serverless trigger create mail`: Create mail triggers.

`yc serverless function version create`: Added the `--secret` parameter to add [secrets](../lockbox/) to the version.

{% endif %}

{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ serverless-containers-name }} {#serverless-containers}

Added the following flags to the `yc serverless container revision deploy` command:
* `--secret`: Add secrets to the revision.
* `--min-instances`: Specify the minimum number of prepared container instances.

{% endif %}

### Version 0.95.0 (02.09.22) {#version0.95.0}

#### Changes to {{ yandex-cloud }} services {#services}

{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ api-gw-name }} {#api-gw}

* Added the following parameters to the `yc serverless api-gateway add-domain` command:

   * `--domain` to indicate the FQDN of a connected [domain](../certificate-manager/concepts/domains/index.md) from {{ certificate-manager-name }}.
   * `--certificate-id` to indicate the ID of a certificate from {{ certificate-manager-name }}.

   The `--domain-id` parameter is considered obsolete. Use the `--domain` and `--certificate-id` parameters instead.

* Added a group of `yc serverless api-gateway websocket` commands to manage WebSocket connections:

   * `yc serverless api-gateway websocket get`: Getting connection data.
   * `yc serverless api-gateway websocket send`: Sending connection data.
   * `yc serverless api-gateway websocket disconnect`: Terminating a connection.

{% endif %}


{% if audience != "internal" %}

##### {{ certificate-manager-name }} {#certificate-manager}

* Added the `--key-format` parameter to the `yc certificate-manager certificate content` command to select the primary key format: `PKCS1` or `PKCS8`.

{% endif %}


{% if audience != "internal" %}

##### {{ compute-name }} {#compute}

* Added the `--os-type` parameter to the `yc compute image create` command to specify the OS type for an image you create: `linux` or `windows`.

{% endif %}


{% if audience != "internal" %}

##### {{ dns-name }} {#dns}

* The `yc dns zone add-records`, `yc dns zone update-records`, `yc dns zone delete-records`, and `yc dns zone replace-records` commands now return a list of changes made.

{% endif %}


{% if audience != "internal" %}

##### {{ iam-name }} {#iam}

* Fixed an error in the `yc iam federation` command group, which occurred when specifying the name of a SAML-compatible identity federation as a positional argument.

{% endif %}


{% if product == "yandex-cloud" and audience != "internal" %}

##### {{ iot-name }} {#iot}

* The `yc iot registry logs` and `yc iot device logs` commands now return logs from {{ cloud-logging-name }}. Added the following parameters to the commands:

   * `--levels` to search for records with the specified logging level.
   * `--filter` to filter records.

   {% if audience != "internal" %}For more information about possible values of new parameters, see [{#T}](../logging/concepts/filter.md). {% endif %}

{% endif %}


##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added support for {{ KF }} 3.0, 3.1, and 3.2.

{% if product == "yandex-cloud" %}

**{{ mrd-name }}**

* {{ RD }} 5.0 and 6.0 are no longer supported.

{% endif %}


{% if audience != "internal" %}

##### {{ org-name }} {#organization}

* Added the `--organization-id` parameter to the commands of the `yc organization-manager federation saml` group to specify organization IDs. Fixed an error that occurred in these commands when specifying the name of a SAML-compatible identity federation as a positional argument.
* Added a group of `yc organization-manager group` commands to manage [user groups](../organization/manage-groups.md).

{% endif %}

### Version 0.94.0 (16.08.22) {#version0.94.0}

#### Changes to {{ yandex-cloud }} services {#services}

{% if product == "yandex-cloud" %}

##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `--stream-name` parameter to the `yc logging read` and `yc logging write` commands.

{% endif %}

##### Managed database services {#managed-db}

{% if product == "yandex-cloud" %}

**{{ mgp-name }}**

* Added support for the commands:

   * `yc managed-greenplum cluster update`: Lets you change the settings of existing clusters.
   * `yc managed-greenplum cluster update-config`: Lets you change the configuration parameters of existing clusters.

* Added the `--datatransfer-access` flag to the `yc managed-greenplum create cluster` command to allow access from {{ data-transfer-name }}.

{% endif %}

{% if product == "yandex-cloud" %}

**{{ mrd-name }}**

* Added the flags to the `yc managed-redis cluster create`, `yc managed-redis cluster restore`,
   `yc managed-redis hosts add`, `yc managed-redis hosts update`, and `yc managed-redis shards add` commands:

   * `--assign-public-ip=true|false`: Assigns or deletes a host's public IP address.
   * `--replica-priority=50`: Sets the replica priority (for non-sharded clusters only).

{% endif %}

**{{ mch-name }}**

* Added the flags to the `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster update` commands:

   * `--cloud-storage-move-factor`: To specify the percentage of free space on the local disk at which data will be transmitted to {{ objstorage-name }}.
   * `--cloud-storage-data-cache`: To allow the use of local cache for {{ objstorage-name }}.
   * `--cloud-storage-data-cache-max-size`: To specify the maximum volume of local cache for {{ objstorage-name }}.

**{{ mkf-name }}**

* Added the `yc managed-kafka connector` command group, which can be used to manage connectors using the `get`, `list`, `delete`, `pause`, and `resume` commands.
* Added the `yc managed-kafka connector-mirrormaker` command group, which can be used to manage MirrorMaker connectors using the `create` and `update` commands.
* Added the parameters for setting and changing the configuration settings of host brokers to the `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands:
   - `message-max-bytes`
   - `replica-fetch-max-bytes`
   - `offsets-retention-minutes`
   - `ssl-cipher-suites`

##### {{ vpc-name }} {#vpc}

* Added the `yc vpc gateway` command group to manage routing gateways.
* Added the ability to specify a gateway as a route destination to the `yc vpc route-table` group commands.

### Version 0.93.0 (19.07.22) {#version0.93.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mch-name }}**

* In the `yc managed-clickhouse cluster restore` command, the following arguments were made optional:

   * `--name`
   * `--description`
   * `--host`
   * `--user`

   If these parameters are not specified, they are taken from the original cluster.
   **{{ CH }}** and **{{ ZK }}** hosts will be restored with the same configuration as in the source cluster.
   **{{ CH }}** hosts will only be restored for the shards whose backups are specified for restoration.

**{{ mpg-name }}**

* The `yc managed-postgresql database create`, `yc managed-postgresql database list`, and `yc managed-postgresql database get` commands.

   Added support for templates when creating a database using `--template-db string`.

{% if product == "yandex-cloud" %}

**{{ mmg-name }}**

* When creating a new cluster, MongoDB version 5.0 is selected by default.

{% endif %}

##### {{ managed-k8s-name }} {#k8s}

* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`.


   * Added the `--node-name` flag that can be used to specify a node name template within a group.

   * Added the `--template-labels` and `--template-labels-from-files` flags that can be used to specify {% if audience == "external" %}[{{ yandex-cloud }} resource labels](../overview/concepts/services.md#labels){% endif %}{% if audience == "internal" %}{{ yandex-cloud }} resource labels{% endif %} for VMs — group nodes (not to be confused with {% if audience == "external" %}[{{ k8s }} node labels](../managed-kubernetes/concepts/index.md#node-labels){% endif %}{% if audience == "internal" %}{{ k8s }} node labels{% endif %}).

{% if product == "yandex-cloud" %}

##### {{ serverless-containers-name }} {#serverless-containers}

* Added the `--network-id` and `--network-name` flags to the `yc serverless container revision deploy` command to specify the network that the container revision will use. Also added the `--subnets` flag, which can be used to get a detailed list of subnets, to the command.

{% endif %}

### Version 0.92.0 (05.07.22) {#version0.92.0}

#### Changes to the CLI {#cli}

* Fixed the error running `yc` with a large number of arguments passed.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ certificate-manager-name }} {#certificate-manager}

* Added the `--deletion-protection` flag to the `yc certificate-manager certificate create` command to enable certificate deletion protection.

* Added the `--deletion-protection` flag to the `yc certificate-manager certificate request` command to enable certificate deletion protection.

* Added the `--deletion-protection` and `--no-deletion-protection` flags to the `yc certificate-manager certificate update` command to enable and disable certificate deletion protection, respectively.


{% if product == "yandex-cloud" %}

##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the `--client-output-buffer-limit-normal` and `--client-output-buffer-limit-pubsub` flags for `create`, `restore`, and `update` to the `yc managed-redis cluster` command group (see the description in redis.conf).

**{{ mgp-name }}**

Added commands for {{ mgp-name }} primary support:
* Commands in the `yc managed-greenplum cluster` group let you manage clusters.
* Commands in the `yc managed-greenplum hosts` group let you manage hosts.

**{{ mms-name }}**

* Added the `yc managed-sqlserver hosts update <HOST> --assign-public-ip=true|false` command that assigns or deletes a host's public IP address.

{% endif %}

### Version 0.91.0 (12.05.22){#version0.91.0}

{% if product == "cloud-il" %}

This is the first CLI version available for {{ yandex-cloud }}.

{% endif %}


{% if product == "yandex-cloud" %}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ alb-name }} {#alb}

* In the `yc alb lb add-location` and `yc alb lb target-states` commands, fixed the error that occurred when processing the `--name` parameter. Now the parameter lets you search for a load balancer by name correctly.

##### {{ cloud-desktop-name }} {#cloud-desktop}

* Added a group of `yc cloud-desktop group` commands to manage desktop groups.
* Added a group of `yc cloud-desktop desktop` commands to manage desktops.

##### {{ sf-name }} {#functions}

* Added the `--max-response-size` parameter to the `yc serverless function logs` and `yc serverless function version logs` commands to limit the size of logs received.

##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `--max-response-size` parameter to the `yc logging read` command to limit the size of logs received.

##### {{ dns-name }} {#dns}

* Added the `yc dns bind-file migrate-to-terraform` command that generates a specification for {{ TF }} from the BIND file and prints it to standard output.

##### {{ serverless-containers-name }} {#serverless-containers}

* Added the `yc serverless containers rollback` command that rolls a container back to the specified revision.

##### {{ ydb-name }} {#ydb}

* Added the `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding` commands to the `yc ydb database` command group to set and view a list of DB roles.
* Added the `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding` commands to the `yc ydb backup` command group to set and view a list of roles for DB backups.

##### Managed database services {#managed-db}

**{{ mes-name }}**

* Added a group of `yc managed-elasticsearch extension` commands to manage user-defined extensions for clusters.

**{{ mmy-name }}**

* Added the `--host-group-ids` parameter to the `yc managed-mysql cluster create` command to set a list of hosts for hosting a cluster on dedicated servers.
* Added the following to the `yc managed-mysql cluster restore` command:

   * The `--host-group-ids` parameter that sets a list of hosts for hosting a cluster on dedicated servers.
   * The `--deletion-protection` flag that lets you restore a cluster with deletion protection enabled.

**{{ mpg-name }}**

* Added the `--host-group-ids` parameter to the `yc managed-postgresql cluster create` command to set a list of hosts for hosting a cluster on dedicated servers.
* Added the following to the `yc managed-postgresql cluster restore` command:

   * The `--host-group-ids` parameter that sets a list of hosts for hosting a cluster on dedicated servers.
   * The `--deletion-protection` flag that lets you restore a cluster with deletion protection enabled.

**{{ mms-name }}**

* Added the `--service-account-id` parameter to the `yc managed-sqlserver create` and `yc managed-sqlserver update` commands to assign a service account to {{ MS }} cluster hosts.
* Added the `yc managed-sqlserver database backup-export` and `yc managed-sqlserver database backup-import` commands to export and import DB backups to/from custom storage.
* Added the `yc managed-sqlserver cluster start-failover` command to manually change the master in a cluster.

**{{ mkf-name }}**

* Added the `--assign-public-ip` flag to the `yc managed-kafka cluster update` command to manage public access to brokers.

{% endif %}


{% if product == "yandex-cloud" %}

### Version 0.90.0 (13.04.22) {#version0.90.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ dataproc-name }} {#dataproc}

* Added the `--initialization-action` flag to the `yc dataproc cluster create` command to specify a cluster initialization script.

##### {{ compute-name }} {#compute}

* Added the `--attach-local-disk` flag to the `yc compute instance create` command to create an instance with a local disk attached to it.

##### {{ alb-name }} {#alb}

* Added the `--enable-proxy-protocol` flag to the `yc alb backend-group add-stream-backend` and `yc alb backend-group update-stream-backend` commands to enable a proxy protocol for the backend.

##### {{ dns-name }} {#dns}

* Added the `--clear-network-ids` flag to the `yc dns zone update` command to delete a list of virtual networks that show internal DNS zone records.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Added the `--folder-id` flag to the `yc managed-clickhouse cluster restore` command to specify the folder to create a restored cluster in.

* Added the following flags to the `yc managed-clickhouse cluster update` command:
   * `--datatransfer-access` to enable cluster access from {{ data-transfer-name }}.
   * `--yandexquery-access` to enable cluster access from {{ yq-full-name }}.

**{{ mkf-name }}**

* Added the `--datatransfer-access` flag to the `yc managed-kafka cluster [ create | update ]` commands to enable cluster access from {{ data-transfer-name }}.

**{{ mmg-name }}**

* Added the `--datatransfer-access` flag to the `yc managed-mongodb cluster [ create | restore | update ]` commands to enable cluster access from {{ data-transfer-name }}.

**{{ mmy-name }}**

* Added the `--datatransfer-access` flag to the `yc managed-mysql cluster [ create | restore | update ]` commands to enable cluster access from {{ data-transfer-name }}.

* Added the `--performance-diagnostics` flag to the `yc managed-mysql cluster update` command to allow managing the settings of the performance diagnostics service.

**{{ mpg-name }}**

* Added the `--datatransfer-access` flag to the `yc managed-postgresql cluster [ create | restore | update ]` commands to enable cluster access from {{ data-transfer-name }}.

### Version 0.89.0 (23.03.22) {#version0.89.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }} {#compute}

* Added the `yc compute filesystem resize` command to resize the file system storage.
* Added the `--preemptible` flag to the `yc compute instance update` command to enable you to make regular VMs preemptible and vice versa.

##### {{ sf-name }} {#functions}

* The `yc serverless function logs` and `yc serverless function version logs` commands now return logs from {{ cloud-logging-name }}. Added the following parameters to the commands:

   * `--levels` to search for records with the specified logging level.
   * `--filter` to filter records.

   {% if audience != "internal" %}For more information about possible values of new parameters, see [{#T}](../logging/concepts/filter.md). {% endif %}

##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the `--persistence-mode` parameter for selecting the persistence level of a {{ RD }} cluster to the following commands:

   * `yc managed-redis cluster create`;
   * `yc managed-redis cluster restore`;
   * `yc managed-redis cluster update`.

   The latter command is also added the `--force` flag that is mandatory when disabling cluster persistence.

**{{ mch-name }}**

* Added the `yc managed-clickhouse hosts update` command to edit {{ CH }} cluster hosts. The command has the `--assign-public-ip` parameter to manage public access to a host: `true` means the host is reachable by a public IP address and `false` means public access is disabled.
* Added the `--datatransfer-access` and `--yandexquery-access` flags to the `yc managed-clickhouse cluster create` command to manage cluster host access from {{ data-transfer-name }} and {{ yq-full-name }}, respectively.
* The `--backup-id` parameter of the `yc managed-clickhouse cluster restore` command now accepts a list of values to restore a sharded cluster.

**{{ mmy-name }}**

* Added the `PRIORITY` column to the result of the `yc managed-mysql hosts list` command.
* Added the `--priority` parameter to the `yc managed-mysql hosts update` command to change a host's priority when switching a master.

### Version 0.88.0 (16.02.22) {#version0.88.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ data-transfer-name }}

* Added the `list` command for `endpoint` and `transfer`:

   * `yc datatransfer endpoint list`;
   * `yc datatransfer transfer list`;

* Added commands for updating `endpoint` and `transfer`:

   * `yc datatransfer endpoint update postgres-source`;
   * `yc datatransfer endpoint update postgres-target`;
   * `yc datatransfer endpoint update mysql-source`;
   * `yc datatransfer endpoint update mysql-target`;
   * `yc datatransfer transfer update`;

##### {{ cdn-name }} {#cdn}

* Added the ability to purge a resource cache: `yc cdn cache purge --all`.
* Fixed resource creation when the source is a bucket or balancer.

##### {{ api-gw-name }} {#api-gw}

* Added the `--network-id` and `--network-name` flags to the `yc serverless api-gateway create` and `yc serverless api-gateway update` commands to specify the API gateway network, and the `--subnet-id` and `--subnet-name` flags to get a detailed list of subnets.

##### {{ compute-name }} {#compute}

* Added the `yc compute disk move` and `yc compute instance move` to move disks and instances between folders.

##### Managed database services {#managed-db}

**{{ mms-name }}**

* For the `yc managed-sqlserver update` and `yc managed-sqlserver start` commands, added the `confirm-payment` flag to confirm the acceptance of license fees.

### Version 0.87.0 (18.01.22) {#version0.87.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ dataproc-name }} {#dataproc}

* Added the `yc dataproc job cancel <JOB-ID>|<JOB-NAME>` command.

   Now you can cancel unfinished tasks.

##### Managed database services {#managed-db}

**{{ mes-name }}**

* Added information about the current maintenance window and the scheduled maintenance operation to the cluster information.
* Added the `--maintenance-window-anytime` and `--maintenance-window-weekly` flags to the `yc managed-elasticsearch cluster update` command to specify the parameters of the maintenance window.
* Added the `yc managed-elasticsearch cluster reschedule-maintenance` command to manage a scheduled cluster maintenance task.
* Added the `yc managed-elasticsearch cluster backup` command to take a cluster snapshot.
* Added the `yc managed-elasticsearch cluster restore` command to restore a cluster from a backup.
* Added the `yc managed-elasticsearch cluster list-backups` command to view backups of a given cluster.
* Added the `yc managed-elasticsearch backup list` command to view backups of all clusters in the folder.
* Added the `yc managed-elasticsearch backup get` command to view information about a specific backup.
* Added the `--host-group-ids` flag, which sets the list of hosts for hosting the cluster on dedicated servers, to the `yc managed-sqlserver cluster create` and `yc managed-sqlserver cluster restore` commands.
* Added the `--deletion-protection` flag, which lets you set up protection against accidental cluster deletion, to the `yc managed-sqlserver cluster restore` command.

### Version 0.86.0 (15.12.21) {#version0.86.0}

#### Changes to the CLI {#cli}

* Added the option to transfer an {% if audience != "internal" %} [IAM token](../iam/concepts/authorization/iam-token.md) {% else %} IAM token {% endif %} via the `YC_IAM_TOKEN` environment variable.

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added the `--maintenance-window` parameter, which lets you set up parameters of the maintenance window, to the `yc managed-kafka cluster update` command.
* Added the `yc managed-kafka cluster reschedule-maintenance` command, which lets you change the start time of a scheduled cluster maintenance task.

##### {{ alb-name }} {#alb}

* Added the `private-ip-address` key, which lets you not specify subnet IDs for addresses from private ranges, for the `--target` parameter in the `yc application-load-balancer target-group {add,update,remove}-targets` commands.
* Added commands to manage TCP handlers of L7 load balancers:
   * `yc alb load-balancer add-stream-listener`
   * `yc alb load-balancer update-stream-listener`
   * `yc alb load-balancer add-stream-sni`
   * `yc alb load-balancer update-stream-sni`
* Added synonyms (aliases) of commands to manage L7 load balancer handlers:
   * `yc alb load-balancer add-listener` — `add-http-listener`
   * `yc alb load-balancer update-listener` — `update-http-listener`
   * `yc alb load-balancer add-sni` — `add-http-sni`
   * `yc alb load-balancer update-sni` — `update-http-sni`
   * `yc alb load-balancer remove-listener` — `remove-http-listener`, `remove-stream-listener`
   * `yc alb load-balancer remove-sni` — `remove-http-sni`, `remove-stream-sni`

##### {{ cdn-name }} {#cdn}

* Added commands to manage {{ cdn-name }} resources:
   * `yc cdn resource create`
   * `yc cdn resource update`

##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `--data-stream` parameter to the `yc logging group {create,update}` commands to support {{ yds-full-name }}.

##### {{ vpc-name }} {#vpc}

* Added the `yc vpc subnet add-range` and `remove-range` commands to add or remove address ranges in subnets.

##### {{ ydb-name }} {#ydb}

* Added the `--labels` parameter, which defines a set of database labels, to the `yc ydb database create` command.
* Added the `--labels` parameter, which changes the entire set of database labels, to the `yc ydb database update` command.
* Added the `yc ydb database add-labels` and `yc ydb database remove-labels` commands to manage labels.

### Version 0.85.0 (29.11.21) {#version0.85.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Command `yc managed-kafka cluster update`.

   Added the `--version` flag that lets you update the {{ KF }} cluster version.

##### {{ managed-k8s-name }} {#k8s}

* Command `yc k8s cluster update`.

   Added the `--node-ipv4-mask-size` parameter that calculates the size of `CIDR` allocated to each cluster node.

##### {{ alb-name }} {#alb}

* Added commands for operating Stream backends:
   * Adding a Stream backend: `yc application-load-balancer backend-group add-stream-backend`.
   * Changing a Stream backend: `yc application-load-balancer backend-group update-stream-backend`.
   * Removing a Stream backend: `yc application-load-balancer backend-group delete-stream-backend`.

##### {{ resmgr-name }} {#resmgr}

* Added the `yc resource-manager folder delete` command to delete a folder.

#### Changes to the CLI {#cli}

Fixed a bug in the `yc init` command. Now, when checking the availability of endpoints, proxy settings are not ignored.

### Version 0.84.0 (16.11.21) {#version0.84.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ cdn-name }} {#cdn}

* Added the `yc cdn resource` command to manage {{ cdn-name }} resources (get, list, delete, and get-provider-cname).

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added the `yc managed-kafka cluster move` command.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 5.0.
* Added the `{{ yc-mdb-mg }} hosts restart` command to reboot specified hosts.

**{{ mmy-name }}**

* Added the `BACKUP PRIORITY` column to the result of the `yc managed-mysql hosts` list command.

**{{ mch-name }}**

Added new flags to the `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster restore` commands:
* `--embedded-keeper`: Lets you create a cluster using {{ CH }} instead of {{ ZK }}.

##### {{ dataproc-name }} {#dataproc}

* The `yc dataproc cluster create` command, the `--subcluster` flag.

   Added the `assign-public-ip` parameter to allocate public IP addresses to all the subcluster hosts.

### Version 0.83.0 (26.10.21) {#version0.83.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ cdn-name }} {#cdn}

* Added command groups to support the {{ cdn-full-name }} service that lets you enable content delivery to end users over the Content Delivery Network (CDN):
   * `yc cdn origin`: To manage origins.
   * `yc cdn origin-group`: To manage origin groups.
   * `yc cdn provider`: To connect to a CDN provider.
   * `yc cdn cache`: To manage caching of CDN resource content.

##### {{ alb-name }} {#alb}

* Added the `yc application-load-balancer load-balancer start` and `yc application-load-balancer load-balancer stop` commands to start and stop the L7 load balancer.

##### {{ ydb-name }} {#ydb}

* Added the `yc ydb database start` and `yc ydb database stop` commands to start and stop the database.

##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the `--hostnames` parameter to the `yc managed-redis cluster start-failover` command to specify the cluster hosts to switch the master from. This parameter can be used with sharded clusters as well.

**{{ mkf-name }}**

* Added the `yc managed-kafka cluster list-logs` command to get cluster logs.

**{{ mmy-name }}**

* Added the following parameters to the `yc managed-mysql hosts update` command:
   * `--assign-public-ip` to manage public access to the host: `true` — the host is reachable by a public IP address, `false` — the public access is disabled.
   * `--backup-priority` to change the host priority when creating cluster backups.

**{{ mpg-name }}**

* Added the `--assign-public-ip` parameter to the `yc managed-postgresql hosts update` command to manage public access to the host: `true` — the host is reachable by a public IP address, `false` — public access is disabled.

### Version 0.82.0 (23.09.21) {#version0.82.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }} {#compute}

* Added the `--pooled` flag to the `yc compute image create` command to create a deployment-optimized image.
* Added the `yc compute filesystem` group of commands to manage file stores.
* Added new commands to attach and detach file storages to/from VM instances: `yc compute instance attach-filesystem` and `yc compute instance detach-filesystem`.
* Added the `--attach-filesystem` parameter to the `yc compute instance create` command to create a VM instance with attached file storage.

##### {{ managed-k8s-name }} {#k8s}

* Added the `--node-labels` parameter to the `yc k8s node-group update` command: it changes the entire set of labels for the nodes in the group.
* Added the `yc k8s node-group add-node-labels` command to add labels to nodes in the group.
* Added the `yc k8s node-group remove-node-labels` command to remove labels from nodes in the group.

##### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create yds` command to create triggers for {{ yds-name }}.

##### {{ serverless-containers-name }} {#serverless-containers}

* Added the `yc serverless containers` group of commands to support {{ serverless-containers-full-name }}: it lets you run containers without using {{ k8s }} or deploying VMs.

##### {{ vpc-name }} {#vpc}

* Added the `yc vpc network list-route-tables` command to list routing tables in the network.
* Added the `yc vpc network list-security-groups` command to list security groups in the network.

#### {{ dataproc-name }} {#dataproc}

* Added the `--log-group-id` parameter to the `yc dataproc cluster create` and `yc dataproc cluster update` commands to link a {{ cloud-logging-name }} log group to the cluster. To stop sending cluster logs to {{ cloud-logging-name }}, specify an empty value as the log group ID: `--log-group-id=""`.

##### {{ ydb-name }} {#ydb}

* Added parameters to manage database limits in Serverless mode to the `yc ydb database create` and `yc ydb database update` commands:
   * `--sls-storage-size`
   * `--sls-throttling-rcu`
   * `--sls-enable-throttling-rcu`
   * `--sls-provisioned-rcu`

##### {{ mrd-name }}

* Changed the default value of the `--redis-version` parameter in the `yc managed-redis cluster create` command to 6.2.

##### {{ mmy-name }}

* Added display for the `replication source` setting to the `yc managed-mysql hosts list` command.

##### {{ mpg-name }}

* Added display for the `replication source` setting to the `yc managed-postgresql hosts list` command.

##### {{ data-transfer-name }}

* Added the `yc datatransfer endpoint` and `yc datatransfer transfer` command groups to manage endpoints and transfers for {{ data-transfer-full-name }}.

### Version 0.81.0 (06.09.21) {#version0.81.0}

#### Changes to the CLI {#cli}

* Added a description of flags and commands in auto-completion by default.
* Command `yc completion <SHELL>`.

   Added the `--without-desc` flag to disable descriptions in autocompletion.
* Autocompletion is supported for the flags: `folder-id`, `folder-name`, `cloud-id`, `format`, `profile`.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create billing-budget` command to create triggers for billing events.
* Added commands to control connections to managed databases:
   * `yc serverless mdbproxy update clickhouse`
   * `yc serverless mdbproxy create clickhouse`

##### {{ cloud-logging-name }} {#logging}

* Excluded the `get-default` subcommand from `logging group`.

### Version 0.80.0 (19.08.21) {#version0.80.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ ig-name }} {#instance-groups}

* Added new flags for the update instance group command (`yc compute instance-group update`):
   * `--new-name`
   * `--description`
   * `--labels`
   * `--variables`
   * `--service-account-name`
   * `--service-account-id`
   * `--scale-policy-fixed-scale-size`
   * `--scale-policy-auto-scale-min-zone-size`
   * `--scale-policy-auto-scale-max-size`
   * `--template-name`
   * `--template-description`
   * `--template-labels`
   * `--template-metadata`
   * `--template-metadata-files`
   * `--template-memory`
   * `--template-cores`
   * `--template-core-fraction`
   * `--template-gpus`
   * `--template-platform`
   * `--template-placement-group`
   * `--template-service-account`

##### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create logging` command to create triggers in {{ cloud-logging-name }}.

##### {{ alb-name }} {#alb}

* Added commands for working with gRPC routes:
   * `yc application-load-balancer virtual-host append-grpc-route`
   * `yc application-load-balancer virtual-host prepend-grpc-route`
   * `yc application-load-balancer virtual-host insert-grpc-route`
   * `yc application-load-balancer virtual-host remove-grpc-route`
   * `yc application-load-balancer virtual-host update-grpc-route`
* Added the `yc application-load-balancer virtual-host update-http-route` command to update HTTP routes.

##### Managed database services {#managed-db}

**{{ mch-name }}, {{ mes-name }}, {{ mkf-name }}, {{ mmg-name }}, {{ mmy-name }}, {{ mpg-name }}, {{ mrd-name }}, {{ mms-name }}**

* Commands `yc <managed DB service name> cluster create` and `yc <managed DB service name> cluster update`.

   The `--deletion-protection` flag lets you set up protection against accidental cluster deletion. To disable cluster protection from deletion, specify `--deletion-protection=false`.

**{{ mmg-name }}**

* Added the `{{ yc-mdb-mg }} hosts stepdown` command.

   It switches the selected master to replica mode so that the available replica becomes the master host.
* Commands `{{ yc-mdb-mg }} cluster get` and `{{ yc-mdb-mg }} cluster update`.

   Added the `backup-retain-period-days` field that shows the number of days for retaining automatic backups.

**{{ mrd-name }}**

* Added support for {{ RD }} version 6.2.

**{{ mmy-name }}**

* Command `yc managed-mysql hosts update`.

   Added the `yc managed-mysql hosts update HOST --replication-source HOST` command to set the replication source for a cascading replica.

**{{ mms-name }}**

* Added the `yc managed-sqlserver database restore` command.


   It lets you restore the specified database on an existing cluster from a backup. You can restore it under a different name.

**{{ mkf-name }}**

* Added support for {{ KF }} 2.8.

##### {{ dataproc-name }} {#dataproc}

* Commands `yc dataproc cluster create` and `yc dataproc cluster update`.

   The `--deletion-protection` flag lets you enable/disable cluster protection against accidental deletion.


   To disable cluster protection from deletion, specify `--deletion-protection=false`.

##### {{ resmgr-name }} {#resmgr}

* Command `yc resource-manager cloud list`.

   Added the display of an organization linked to a cloud.

##### {{ org-name }} {#organization}

Added support for {{ org-full-name }}.

{{ org-name }} is an enterprise solution that you can use to connect your organization to {{ yandex-cloud }} services and manage employee access to these services.

{% if audience != "internal" %}The {{ org-name }} service is at the [Preview](../overview/concepts/launch-stages.md) stage. {% endif %}Read more about the service in the [documentation](../organization/).

##### {{ sf-name }} {#serverless-functions}

* Command `yc serverless trigger create`.

   The `--invoke-container-name`, `--invoke-container-id`, and `--invoke-container-path` flags let you specify a {{ serverless-containers-name }} container for a trigger.

### Version 0.79.0 (13.07.21) {#version0.79.0}

#### Changes to {{ yandex-cloud }} services

#### {{ cloud-logging-name }} {#logging}

Added support for {{ cloud-logging-full-name }}.

{{ cloud-logging-name }} is a service for reading and recording service logs and user applications.

{% if audience != "internal" %}The {{ cloud-logging-name }} service is at the [Preview](../overview/concepts/launch-stages.md) stage. {% endif %}Read more about in the [documentation](../logging/).

#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless function set-scaling-policy` command to configure a function's scaling settings.
* Added the `yc serverless function list-scaling-policies` command to view a function's scaling settings.
* Added the `yc serverless function remove-scaling-policy` command to delete a function's scaling settings.
* Command `yc serverless function version create`.

   Fixed the directory processing for the `--source-path` flag on Windows.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Command `yc managed-clickhouse cluster update`.

   Added the `--cloud-storage` flag to enable data storage in {{ objstorage-name }}.

### Version 0.78.0 (29.06.21) {#version0.78.0}

#### {{ managed-k8s-name }} {#k8s}

* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`.


   Added the `--network-acceleration-type` flag, which lets you specify a network type for node groups: standard or software-accelerated.

* Command `yc managed-kubernetes cluster create`.

   Added the `--cilium` flag to create a cluster that supports tunnel mode and uses Cilium CNI.

#### {{ dataproc-name }} {#dataproc}

* Command `yc dataproc job create-<JOB-TYPE>`.

   Now, after starting a task, its execution log is displayed in the terminal.

### Version 0.77.0 (07.06.21) {#version0.77.0}

**{{ compute-name }}**

* Command `yc compute instance`.

   Added the `dns-record-spec` and `ipv6-dns-record-spec` keys to `network_interface`.

**{{ api-gw-name }}**

* Added the `yc serverless api-gateway add-domain` command to add a domain to an API gateway.
* Added the `yc serverless api-gateway remove-domain` command to remove a domain from an API gateway.

#### Managed database services {#managed-db}

**{{ mes-name }}**

* Command `yc managed-elasticsearch cluster list-logs`.

   Added the `--service-type` flag to generate Kibana logs.

* Commands `yc managed-elasticsearch cluster create` and `yc managed-elasticsearch cluster update`.

   Added the `--service-account` flag.

**{{ mkf-name }}**

* Commands `yc managed-kafka cluster create` and `yc managed-kafka cluster update`.

   Added the `--num-partitions` and `--default-replication-factor` flags to set and edit configuration settings of {{ KF }} brokers.

**{{ mrd-name }}**

* Commands `yc managed-redis cluster create\update`.

   Added the `--slowlog-log-slower-than`, `--slowlog-max-len`, `--databases`, and `--notify-keyspace-events` flags (see description in redis.conf).

### Version 0.76.0 (19.05.21) {#version0.76.0}

**{{ mpg-name }}**

* Command `yc managed-postgresql cluster update`.

   Added the `--serverless-access` flag for accessing {{ mpg-full-name }} cluster hosts from {{ sf-full-name }}.

**{{ vpc-name }}**

* Added the `yc vpc address move` command to move an address between cloud folders.

**{{ compute-name }}**

* Command `yc compute instance-group`.

   Instance groups can now return the group status.

### Version 0.75.0 (13.04.21) {#version0.75.0}

#### Changes to {{ yandex-cloud }} services

#### {{ compute-name }} {#compute}

* Command `yc compute create-with-container`.

   Added the `--gpus` flag that lets you create a {{ coi }} with a GPU.

#### Managed database services {#managed-db}

**{{ mrd-name }}**

* Command `yc managed-redis cluster create`.

   Added the `--disk-type-id [local-ssd|network-ssd]` key that lets you select the disk type.

**{{ mmy-name }}**

* Command `yc managed-mysql cluster list-logs`.

   Logs are now printed in "as-is" format by default. To enable the previous log format, use the `--format=yaml` flag.

**{{ mes-name }}**

* Commands `yc managed-elasticsearch cluster create` and `yc managed-elasticsearch cluster update`.

   Added flags for cluster `admin` password management:
   * `--admin-password` that lets you set a password manually.
   * `--generate-admin-password` to generate a password automatically.
   * `--read-admin-password` that lets you set a password from a file.
* Removed the `yc managed-elasticsearch user` commands. User management is now available with native {{ ES }} tools through the `admin` user.
* Command `yc managed-elasticsearch create`.

   Added the `--edition [basic|gold|platinum]` flag that lets you specify the {{ ES }} edition when creating a cluster.

**{{ mkf-name }}**

* Command `yc managed-kafka cluster create`.

   Added the `--host-group-ids` flag that controls cluster hosting on dedicated servers.

#### {{ dataproc-name }} {#dataproc}

* Command `yc dataproc cluster create`.

   Added the `--host-group-ids` flag that controls cluster hosting on dedicated servers.

### Version 0.74.0 (29.03.21) {#version0.74.0}

* Added support for macOS/arm64 (Apple Silicon M1) and linux/arm64.

#### Changes to {{ yandex-cloud }} services

#### {{ dataproc-name }} {#dataproc}

* Commands `yc dataproc cluster create` and `yc dataproc cluster update`.

   Added the `--security-group-ids` flag that lets you specify a set of security groups for a cluster.

### Version 0.73.0 (17.03.21) {#version0.73.0}

#### Changes to {{ yandex-cloud }} services

#### {{ container-registry-name }} {#container-registry}

Added commands for managing the allowed IP addresses for pushing and pulling Docker images:
* `yc container registry add-ip-permissions` adds IP addresses.
* `yc container registry list-ip-permissions` lets you view IP addresses.
* `yc container registry set-ip-permissions` sets IP addresses.
* `yc container registry remove-ip-permissions` removes IP addresses.

#### {{ sf-name }} {#cloud-functions}

* Command `yc serverless function version create`.

   Added default values for flags:
   * `--execution-timeout`: three seconds.
   * `--memory`: 128 MB.
* Command `yc serverless function version create`.

     Added the `--add-service-account` flag to specify additional service accounts for the version.

#### {{ cloud-logs-name }} {#logs}

* Added the `yc logs` command.

#### Managed database services {#managed-db}

**{{ mkf-name }}**

* Command `yc managed-kafka cluster create`.

    Default values are no longer set for the flags `--disk-size`, `--disk-type`, `--resource-preset`, `--zookeeper-disk-size`, `--zookeeper-disk-type` and `--zookeeper-resource-preset`. If no values are specified, the default values set on the server are used.
* Command `yc managed-kafka cluster create`.

   Added the `--unmanaged-topics` flag to enable management of {{ KF }} topics via AdminAPI.

   Added the `--auto-create-topics-enable` flag to enable automatic {{ KF }} topic creation.

* Command `yc managed-kafka user create`.

    Added the `admin` role to enable management of {{ KF }} cluster topics via AdminAPI.

**{{ mrd-name }}**

* Command `yc managed-redis cluster create`.

   Added the `--enable-tls` flag to enable TLS when creating {{ RD }} clusters.

* Command `yc managed-redis cluster restore`.

   Added the `--enable-tls` flag to enable TLS when creating {{ RD }} clusters from backups.

### Version 0.72.0 (11.02.21)

#### Changes to {{ yandex-cloud }} services

#### {{ alb-name }} {#alb}

Added primary support for {{ alb-full-name }}:
* Commands in the `yc alb backend-group` group let you manage a backend group.
* Commands in the `yc alb http-router` group let you manage HTTP routers.
* Commands in the `yc alb load-balancer` group let you manage L7 load balancers.
* Commands in the `yc alb target-group` group let you manage target groups.
* Commands in the `yc alb virtual-host` group let you manage virtual hosts.

#### {{ compute-name }} {#compute}

* Commands `yc compute instance|disk|image list` now return more than 1000 items.

### Version 0.71.0 (03.02.21) {#version0.71.0}

#### Changes to {{ yandex-cloud }} services

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes node-group create`.

   Added the `--placement-group` flag that lets you set a `placement policy group` for a node group when creating it.

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Commands `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore`.

   Added the value `13` for the `--postgresql-version string` flag to create {{ PG }} cluster version 13.

**{{ mmy-name }}**

* Command `yc managed-mysql cluster update`.

   Added the `--mysql-version` flag that lets you update the {{ MY }}-server version.

**{{ mes-name }}**

* Added the `yc managed-elasticsearch hosts create` and `yc managed-elasticsearch hosts delete` commands to add and delete hosts, respectively.

**{{ mms-name }}**

Added primary support for {{ mms-full-name }}:
* Commands of the `yc managed-sqlserver cluster` group let you manage clusters.
* Commands of the `yc managed-sqlserver database` group let you manage databases.
* Commands of the `yc managed-sqlserver user` group let you manage users.

**{{ mch-name }}**

* Commands `yc managed-clickhouse host add` and `yc managed-clickhouse shards add`.

   Added the `--copy-schema` flag that lets you copy the schema of other {{ CH }} hosts.

### Version 0.70.0 (22.12.20) {#version0.70.0}

#### Changes to the CLI {#cli}

**Improved**

* Command `yc container registry configure-docker`.

   Added the `--disable` flag that lets you disable integration with Docker Credential Helper.

#### Changes to {{ yandex-cloud }} services

#### {{ iam-name }} {#iam}

Added the `yc iam federation list-user-accounts` command for listing federation users.

#### Managed database services {#managed-db}

**{{ mmy-name }}, {{ mpg-name }}, {{ mch-name }}, {{ mrd-name }}, {{ mmg-name }}, {{ mkf-name }}**

* Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster update`, and `yc <managed DB service name> cluster restore`.

   The `--security-group-ids` flag lets you specify a set of security groups for a cluster.

**{{ mkf-name }}**

* Commands `yc managed-kafka cluster create` and `yc managed-kafka cluster update`.

   Added flags for setting and updating {{ KF }} broker configuration settings: `--compression-type`, `--log-flush-interval-messages`, `--log-flush-interval-ms`, `--log-flush-scheduler-interval-ms`, `--log-retention-bytes`, `--log-retention-hours`, `--log-retention-minutes`, `--log-retention-ms`, `--log-segment-bytes`, and `--log-preallocate`.
* Commands `yc managed-kafka topic create` and `yc managed-kafka topic update`.

   Added flags for setting and updating topic settings: `--cleanup-policy`, `--compression-type`, `--delete-retention-ms`, `--file-delete-delay-ms`, `--flush-messages`, `--flush-ms`, `--min-compaction-lag-ms`, `--retention-bytes`, `--retention-ms`, `--max-message-bytes`, `--min-insync-replicas`, `--segment-bytes`, and `--preallocate`.

**{{ mes-name }}**

Added primary support for {{ mes-name }}:
* Commands in the `yc managed-elasticsearch cluster` group let you manage clusters.
* Commands in the `yc managed-elasticsearch user` group let you manage users.

### Version 0.69.0 (02.12.20) {#version0.69.0}

#### Changes to {{ yandex-cloud }} services

#### {{ managed-k8s-name }} {#k8s}

* Fixed `ipv6-address` flag parsing for network specifications of node groups.

#### Managed database services {#managed-db}

**{{ mkf-name }}**

Added primary support for {{ mkf-name }}:
* Commands in the `yc managed-kafka cluster` group let you manage clusters.
* Commands in the `yc managed-kafka topic` group let you manage topics.
* Commands in the `yc managed-kafka user` group let you manage users.

**{{ mmy-name }}**

* Command `yc managed-mysql user grant-permission`.

   The `--permissions` flag supports the `REFERENCES` privilege.

**{{ mmy-name }}, {{ mpg-name }}**

* Command `yc <managed DB service name> cluster update`.

   Added the `--websql-access` flag to control access from the [management console]({{ link-console-main }}).

### Version 0.68.0 (03.11.20) {#version0.68.0}

#### Changes to {{ yandex-cloud }} services

#### {{ compute-name }} {#compute}

* You can now specify the size of a unit for disks when creating a VM.

#### {{ kms-name }} {#kms}

* Command `yc kms symmetric-key create`.

   Added the `--deletion-protection` flag to enable key protection from deletion.
* Command `yc kms symmetric-key update`.

   Added flags to enable or disable key protection from deletion: `--deletion-protection` and `--no-deletion-protection`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore`, and `yc managed-clickhouse cluster update`.

   Added flags:
   * `--admin-password`, `--generate-admin-password`, and `--read-admin-password` to set the `admin` user password that is used when user management via SQL is enabled.
   * `--enable-sql-database-management` to enable database management via SQL.
   * `--enable-sql-user-management` to enable user and access right management via SQL.

**{{ mmy-name }}**

* Command `yc managed-mysql user grant-permission`.

   Added the `--permissions` flag that supports the `ALL_PRIVILEGES` privileges (a synonym for `ALL`).

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`.

   Added the `--cluster-ipv6-range`, `--dual-stack`, and `--service-ipv6-range` flags that let you create {{ k8s }} clusters with concurrent use of IPv4 and IPv6.
* Commands `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update`.

   Added the `--security-group-ids` flag to set cluster security groups.
* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`.


   Added the `--network-interface` flag that lets you configure more detailed network specifications for nodes. For example, manage security group settings for network interfaces and configure node interfaces for concurrent use of IPv4 and IPv6 in {{ k8s }} clusters.

### Version 0.67.0 (05.10.20) {#version0.67.0}

#### Changes to {{ yandex-cloud }} services

#### {{ compute-name }} {#compute}

**Fixed**

* Fixed the issue when it was not possible to add a VM to an existing placement group.

#### {{ container-registry-name }} {#container-registry}

* Added the `yc container image list-vulnerabilities` and `yc container image scan` commands to scan Docker images.

### Version 0.66.0 (28.09.20) {#version0.66.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Added the `yc compute host-group` command that lets you manage dedicated hosts.
* Added the `yc compute host-type` command that lets you manage dedicated host types.
* Added the `yc compute disk-placement-group` command that lets you manage groups of non-replicated disks.

#### Managed database services {#managed-db}

**{{ mmg-name }}**

* Command `yc managed-mongodb cluster restore --help`.

   Added an example of using the `--recovery-target-timestamp` flag.

### Version 0.65.0 (22.09.20) {#version0.65.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ dataproc-name }} {#dataproc}

Added UI Proxy support:
* Added the `yc dataproc cluster list-ui-links` command that lets you get a list of links to access {{ dataproc-name }} cluster interfaces.
* Commands `yc dataproc cluster create` and `yc dataproc cluster update`.
   Added the `--ui-proxy` parameter that lets you enable the UI Proxy functionality for {{ dataproc-full-name }} clusters.
* Commands `yc dataproc cluster create`, `yc dataproc subcluster create`, and `yc dataproc subcluster update`.
   Added flags for auto-scalable subclusters: `--autoscaling-decommission-timeout`, `--cpu-utilization-target`, `--max-hosts-count`, `--measurement-duration`, `--preemptible`, `--stabilization-duration`, and `--warmup-duration`.
* Command `yc dataproc subcluster list`.
   A response now contains the `instance group id` field with IDs of instance groups in auto-scalable subclusters.

#### {{ certificate-manager-name }} {#certificate-manager}

* Added the `yc certificate-manager certificate content` command to get certificate contents.

   It lets you upload a certificate chain and a private key to use on your own when configuring a web server on a VM.

#### Managed database services {#managed-db}

**{{ mmg-name }}**

* Commands `{{ yc-mdb-mg }} cluster get` and `{{ yc-mdb-mg }} cluster update`.

   Added the `backup-retain-period-days` field that shows the number of days for retaining automatic backups.
* Commands `{{ yc-mdb-mg }} cluster list-backups` and `{{ yc-mdb-mg }} backup list`.

   Added the `SIZE` and `TYPE` fields that specify the size and type of backups, respectively.
* Command `{{ yc-mdb-mg }} cluster list-logs`.

   Added the `filter` parameter to filter requested entries.

   If the `follow` parameter is set, the default value of the `limit` parameter is ignored. In this case, the explicitly specified `limit` parameter value limits the number of entries to return.

### Version 0.64.0 (08.09.20) {#version0.64.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Command `yc compute instance-group`.

   * Added the ability to set and view a list of roles for an instance group: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.
   * Added commands for stopping and deleting VM instances in an instance group: `stop-instances` and `delete-instances`.

#### Managed database services {#managed-db}

* Command `yc <managed DB service name> cluster list-logs` for all managed DBs uses new `StreamLogs` API methods for streaming logs.

   All commands now have the `--follow` flag that lets you get new log entries as they appear.

**{{ mch-name }}**

* Added the `yc managed-clickhouse versions list` command to get a list of versions that can be installed.
* Commands `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster restore`.

   Added the `--cloud-storage` flag to enable data storage in {{ objstorage-name }}.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 4.4.
* Commands `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster enable-sharding`.

   In [sharded](../managed-mongodb/concepts/sharding.md) clusters, you can now set the `mongoinfra` host type.

#### {{ certificate-manager-name }} {#certificate-manager}

Added support for the TLS certificate management service: {{ certificate-manager-full-name }}.

You can use {{ certificate-manager-name }} to obtain and update TLS certificates from Let's Encrypt® and import your own certificates.

These certificates can be used in {{ yandex-cloud }} services to provide connection security.

{% if audience != "internal" %}The {{ certificate-manager-name }} service is at the [Preview](../overview/concepts/launch-stages.md) stage. {% endif %}Read more about the service in the [documentation](../certificate-manager/).

### Version 0.63.0 (28.08.20) {#version0.63.0}

#### Changes to the CLI {#cli}

**Fixed**

* Fixed the issue with federated user authorization when initializing a new YC CLI profile.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ vpc-name }} {#vpc}

* Added a group of `yc vpc address` commands to manage {% if audience != "internal" %}[IP addresses](../vpc/concepts/address.md#public-addresses){% else %}IP addresses{% endif %}.

### Version 0.62.0 (20.08.20) {#version0.62.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Command `yc serverless function version create`.
   * Added the `--source-version-id` flag to specify a function's source version.
   * Added the `--network-id` and `--network-name` flags to specify a function version's network. You can give a detailed list of subnets using the `--subnet-id` and `--subnet-name` flags.

#### Managed database services {#managed-db}

**{{ mmy-name }}**

* Command `yc managed-mysql user update`.

   The `--global-permissions` flag lets you grant the `PROCESS` privilege.

**{{ mch-name }}, {{ mmy-name }}, {{ mpg-name }}, {{ mrd-name }}, {{ mmg-name }}**

* Command `yc <managed DB service name> cluster update`.

   Added the `--maintenance-window-anytime` and `--maintenance-window-weekly` flags to specify maintenance window parameters. They will be used to schedule cluster maintenance.
* Added the command `yc <managed DB service name> cluster reschedule-maintenance` to reschedule cluster maintenance.

**{{ mmg-name }}**

* Command `yc managed-mongodb cluster restore`.

   Added the `--recovery-target-timestamp` flag to specify a backup's recovery timestamp.

### Version 0.61.0 (03.08.20) {#version0.61.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`.

   The `--version` flag value is now correctly considered when creating a regional cluster.

##### {{ compute-name }} {#compute}

* Command `yc compute instance update-network-interface`.

   The `--security-group-id` flag now accepts a comma-separated list of values.

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`.

   {% if audience != "internal" %}

   Added the `--coi-spec-file` flag to pass an [image specification](../cos/concepts/coi-specifications.md#coi-spec-example).

   {% else %}

   Added the `--coi-spec-file` flag to pass an image specification.

   {% endif %}

##### {{ vpc-name }} {#vpc}

* Commands `yc vpc subnet create` and `yc vpc subnet update`.

   The `--domain-name-server` and `--ntp-server` flags now accept comma-separated lists of values.
* Added the `yc vpc subnet list-used-addresses` command.

   It returns a list of addresses used in a subnet.

### Version 0.60.0 (20.07.20) {#version0.60.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }} {#compute}

* Added the `yc compute instance update-network-interface` command.

   It lets you change the network interface settings on created VMs.

##### {{ sf-name }} {#serverless-functions}

* Command `yc serverless function logs`.

   The use of the `--follow` flag now ensures that you get the logs of the latest function version with the passed tag.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster update`, and `yc managed-clickhouse cluster restore`.

   Added the `--service account` flag to select service accounts linked to hosts.
* Added the `yc managed-clickhouse shard-groups` command for managing shard groups.

### Version 0.59.0 (02.07.20) {#version0.59.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ api-gw-name }} {#api-gw}

Added support for {{ api-gw-full-name }}.

{{ api-gw-name }} is a service for managing API gateways that supports [OpenAPI Specification 3.0](https://github.com/OAI/OpenAPI-Specification) and a set of extensions for interacting with other cloud services.

{% if audience != "internal" %}The {{ api-gw-name }} service is at the [Preview](../overview/concepts/launch-stages.md) stage. {% endif %}Read more about in the [documentation](../api-gateway/).

#### {{ iam-name }} {#iam}

* Added the following flags to commands `yc iam federation create` and `yc iam federation update`:
   * `--encrypted-assertions` to enable encryption of SAML assertions.
   * `--case-insensitive-name-ids` to enable case-insensitive user name IDs.

### Version 0.58.0 (16.06.20) {#version0.58.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ sf-name }} {#serverless-functions}

* Added commands to pause and resume triggers: `yc serverless trigger pause` and `yc serverless trigger resume`.
* Command `yc serverless function invoke`.

   Increased the waiting time for a function invoke result from 30 seconds to 25 minutes.

##### {{ vpc-name }} {#vpc}

* Commands `yc vpc subnet create` and `yc vpc subnet update`.

   Added flags for configuring DHCP options: `--domain-name`, `--domain-name-server`, and `--ntp-server`.

##### {{ managed-k8s-name }} {#k8s}

* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`.


   Added the `--gpus=GPUS` flag to specify the number of GPUs on the nodes.

##### {{ container-registry-name }} {#container-registry}

* Added the `yc container repository lifecycle-policy` command to manage policies for automatically deleting Docker images.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Added commands for managing labels: `yc managed-mysql cluster add-labels` and `yc managed-mysql cluster remove-labels`.

**{{ mrd-name }}**

* Added support for {{ RD }} version 6.

### Version 0.57.0 (26.05.20) {#version0.57.0}

#### Changes to the CLI {#cli}

**Fixed**

* Fixed usage of a Docker Credential helper with HTTPS addresses. You can now get authentication data for `https://cr.yandex` addresses.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create container-registry` command to create triggers for {{ container-registry-full-name }}.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes node-group create`.

   Changed the default platform and number of cores used when creating a node group. The default is now Intel Cascade Lake (`standard-v2`) in the dual-core configuration `cores: 2`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Added the `{{ yc-mdb-ch }} format-schema` command.

   It lets you manage Cap'n Proto and Protobuf schemas in {{ CH }} clusters.

**{{ mmg-name }}**

* Added the `{{ yc-mdb-mg }} hosts resetup` command.

   The command reloads data on the selected host. First it deletes all the data and then restores it from a replica.

### Version 0.56.0 (23.04.20) {#version0.56.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### All services {#all}

* You can now use the `get` and `delete` commands to pass multiple resource IDs or names.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `yc managed-clickhouse user create` and `yc managed-clickhouse user update`.

   The `settings` flag parameters are now described in Help.

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Command `yc <managed DB service name> host list`.

   The result now includes the column with `assign_public_ip` values.

**{{ mrd-name }}**

* Command `yc managed-redis host list`.

   The result now includes columns with `type` and `shard_name` values.

##### {{ coi }} {#coi}

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`.

   When you pass a file with environment variables using the `--container-env-file` flag, the `=` characters in variable values are now processed correctly.

### Version 0.55.0 (13.04.20) {#version0.55.0}

#### Changes to the CLI {#cli}

**Improved**

* Authentication now supported for `http_proxy`.
* Autocomplete added for the `zsh` command shell.
* When an operation is terminated by **Ctrl** + **C**, `yc` shows the details for the operation running.

**Fixed**

* Fixed the 30-second wait if no `folder-id` or `folder-name` property is specified in the profile you use.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`.

   Added the `--node-ipv4-mask-size` flag to configure the size of `CIDR` allocated to each cluster node.
* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`.


   Added the `--max-unavailable` and `--max-expansion` flags to control the number of nodes deleted and created at instance group update.

#### Managed database services {#managed-db}

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster restore`, and `yc <managed DB service name> host add`.

   Added the `subnet-name` property to the `--host` flag to specify a subnet by its name.

**{{ mmg-name }}, {{ mch-name }}, {{ mrd-name }}**

* Command `yc <managed DB service name> cluster list-logs`.

   Added formatting for log lines.

#### {{ coi }} {#coi}

* Command `yc compute instance create-with-container`.

   Added mounting of `docker volumes` into a Docker container created in {{ coi }} by using the `container-volume-tmpfs` and `container-volume-host-path` flags.
* Command `yc compute instance update-container`.

   Added ability to update `docker volumes` in a Docker container created in {{ coi }}.

### Version 0.54.0 (24.03.20) {#version0.54.0}

#### Changes to the CLI {#cli}

**Improved**

* Error messages thrown by commands and flags are now more intuitive.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`.

   Added the `--kms-key-id` and `--kms-key-name` flags for creating {{ k8s }} clusters with secrets encryption in KMS.

### Version 0.53.0 (04.03.20) {#version0.53.0}

#### Changes to the CLI {#cli}

**Improved**

* When `yc` starts on a VM inside {{ yandex-cloud }} with no `folder-id` specified in the `yc` config, the folder hosting the VM is used.
* Added the `--version` flag for the `yc version` command.

**Fixed**

* Fixed updating using `yc components update` on WSL 1.
* Fixed abnormal termination on invoking `yc help`.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster get-credentials`.

   Added checking and warning if the user runs `kubectl` versions earlier than 1.11 because they don't support the authentication method set by this command.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} user`.

   Added user quota management.
* Command `{{ yc-mdb-ch }} cluster`.

   Added the `metrica-access`, `datalens-access`, and `websql-access` flags to the cluster create, restore, and update commands.
* Added `{{ yc-mdb-ch }} ml-model` commands.

   It lets you manage ML models in {{ CH }} clusters.

**{{ mmg-name }}, {{ mpg-name }}, {{ mmy-name }}, {{ mrd-name }}**

* Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster update`, and `yc <managed DB service name> cluster restore`.

   Added the `datalens-access` flag to manage {{ datalens-full-name }} access to clusters.

### Version 0.52.1 (21.02.20) {#version0.52.1}

#### Changes to the CLI {#cli}

**Fixed**

* During installation, WARN not shown for non-existent problems.

### Version 0.52.0 (21.02.20) {#version0.52.0}

#### Changes to the CLI {#cli}

**Improved**

* When you start `yc` with the `--help` or `-h` flag, interactive help opens: in `less` (`$PAGER`) on Linux and macOS and in `more` on Windows. Now you no longer have to scroll up through the help result.
* The execution debug logs and API interaction debug logs are now saved to the
   `$HOME/.config/yandex-cloud/logs` configuration directory rather than the installation directory. This fixes the issue when `yc`, which was installed as a stand-alone binary file, suddenly tries to save its log in the same directory without the rights to it.
* Debug logs are also saved for successful requests. If you contact support about an issue with a `yc` command, we can help you faster if you attach your log file.

**Fixed**
* When running `yc components ...` commands, no update notice is shown.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Command `yc compute instance create`.

   Added the `nat-address` parameter to the `--network-interface` flag to assign a specific NAT address for the instance created.
* Added the commands `yc compute instance add-one-to-one-nat` and `yc compute instance remove-one-to-one-nat`.

   These commands let you manage NAT on already existing instances.
* Commands `yc compute instance create` and `yc compute instance update`.

   Added the `--network-settings` flag to change the network type to `Software accelerated` and back to `Standard`.

#### {{ kms-name }} {#kms}

* Command `yc kms symmetric-key`.

   Added commands to manage roles for individual keys: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`.

   Added the `--enable-network-policy` flag to create a {{ k8s }} cluster with [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) support.
* Command `yc k8s cluster get-credentials`.

   Added the `--context-name` flag to let the user specify the name of the `context` created in `kubeconfig`.

   The default name at context creation is now more intuitive: `yc-<cluster-name>`.

   An explanation of the result is returned.

### Version 0.51.0 (12.02.20) {#version0.51.0}

#### Changes to the CLI {#cli}

**Improved**

* Command `yc <service> <resource> create`.

   Added the ability to pass resource names as command arguments. Commands like `yc <service> <resource> create --name <resource name>` and `yc <service> <resource> create <resource name>` are now the same.

   For example, instead of the `yc managed-kubernetes cluster create --name my-cluster ...` command, you can now use the `yc managed-kubernetes cluster create my-cluster ...` command.
* Command `yc <service> <resource> set-access-binding`.

   Added a warning that the command deletes assigned roles. If the user runs the command directly (rather than using another command or script), they're asked for confirmation.

**Fixed**

* Command `yc init`.

   The values of the flags `--cloud-id`, `--folder-id`, and `--folder-name` are now properly recognized.
* Disabled messages about the availability of a new version of `yc` when invoking of a non-interactive command.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ iam-name }} {#iam}

* Added commands for creating and managing SAML-compatible identity federations and their certificates: `yc iam federation` and `yc iam certificate`. {% if audience != "internal" %}Learn more about SAML-compatible identity federations in the [documentation](../organization/add-federation.md){% endif %}.

### Version 0.50.0 (27.01.20) {#version0.50.0}

#### Changes to {{ yandex-cloud }} services {#services}

* {% if audience != "internal" %}For [resources that you can assign roles for](../iam/concepts/access-control/resources-with-access-control.md). {% else %}For resources that you can assign roles for.{% endif %}

   Added alternatives to the `--subject` flag for role management commands: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login`, and `--all-authenticated-users`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes node-group create`.

   Added the `--auto-scale` flag for creating a group of nodes whose size is dynamically adjusted by [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### {{ compute-name }} {#compute}

* Command `yc compute instance create`.

   If you specify the `--gpus` flag, the `gpu-standard-v1` platform is automatically selected.

### Version 0.49.0 (21.01.20) {#version0.49.0}

#### Changes to the CLI {#cli}

**Improved**

* When running the YC CLI with the `--debug` flag, the API call response log line now returns the gRPC status code as well as its description.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ kms-name }} {#kms}

Support for the cryptographic key management service: {{ kms-full-name }}.

{{ kms-name }} lets you create encryption keys and implement data protection models in your applications and services.

Use the keys to protect your secrets, private data, and other confidential information you store in the cloud.

{% if audience != "internal" %}The {{ kms-name }} service is at the [Preview](../overview/concepts/launch-stages.md) stage. {% endif %}Read more about the service in the [documentation](../kms/).

### Version 0.48.0 (27.12.19) {#version0.48.0}

#### Changes to the CLI {#cli}

**Improved**

* When updating YC CLI, the current version to be installed is now displayed.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Added handling of placement groups: `yc compute placement-group --help`.
* Commands `yc compute instance create` and `yc compute instance update`.

   The flag used for specifying the platform is renamed from `--platform-id` to `--platform`. The old flag name is still supported.
* Command `yc compute instance create`.

   SSH keys added using the `--ssh-key` flag are saved to the metadata with the `ssh-keys` key instead of `ec2-user-data`.

#### Managed database services {#managed-db}

**{{ mmy-name }}**

* Added support for creating a cluster with {{ MY }} version 8.0.
* Added a command to manually switch the master for a specified cluster: {{ MY }} `{{ yc-mdb-my }} cluster start-failover`.
* Command `{{ yc-mdb-my }} cluster update`.

   Added the ability to rename clusters using the `--new-name` flag.

**{{ mpg-name }}**

* Added the command to manually switch the master for the specified cluster {{ PG }} `{{ yc-mdb-pg }} cluster start-failover`.
* Command `{{ yc-mdb-pg }} cluster update`.

   Added the ability to rename clusters using the `--new-name` flag.

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} cluster update`.

   Added the ability to rename clusters using the `--new-name` flag.

**{{ mrd-name }}**

* Command `{{ yc-mdb-rd }} cluster update`.

   Added the ability to rename clusters using the `--new-name` flag.

### Version 0.47.0 (17.12.19) {#version0.47.0}

#### Changes to the CLI {#cli}

**Improved**

{% if audience != "internal" %}

* [Federated authentication](operations/authentication/federated-user.md) is now supported for non-interactive `yc` calls. This mode is used when the CLI is not started directly by the user, like when it is started via a script or `kubectl` when working with [{{ k8s }} clusters](../managed-kubernetes/concepts/index.md#kubernetes-cluster) in {{ managed-k8s-full-name }}.

{% else %}

* [Federated authentication](operations/authentication/federated-user.md) is now supported for non-interactive `yc` calls. This mode is used when the CLI is not started directly by the user, like when it is started via a script or `kubectl` when working with {{ k8s }} clusters in {{ managed-k8s-name }}.

{% endif %}

### Version 0.46.0 (13.12.19) {#version0.46.0}

#### Changes to the CLI {#cli}

**Improved**

{% if audience != "internal" %}

* To facilitate authorization diagnostics, CRC32 of the sent [IAM token](../iam/concepts/authorization/iam-token.md) is written to the request debug log.

{% endif %}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create object-storage` command to subscribe to bucket updates in {{ objstorage-full-name }}.

### Version 0.45.0 (03.12.19) {#version0.45.0}

#### Changes to the CLI {#cli}

**Improved**

* Increased the time between reconnection attempts if any resource involved in the execution of a command is unavailable.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ iot-name }} {#iot}

* Added commands for managing passwords: `yc iot registry password` and `yc iot device password`.
* Commands `yc iot registry create` and `yc iot device create`.

   Added flags to enable login and password authorization: `--password`, `--read-password`, and `--generate-password`.
* Commands `yc iot mqtt publish` and `yc iot mqtt subscribe`.

   Added flags to enable login and password authorization: `--username` and `--password`.

### Version 0.44.0 (19.11.19) {#version0.44.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Added the command `yc serverless trigger create timer` to call functions using a timer.

#### Changes to the CLI {#cli}

**Fixed**

* Fixed an error that in rare cases caused several lines of the `debug` log to result in `stdout`.

**Improved**

* Disabled the display of the `Status.details` field for gRPC errors. Information from it is duplicated in the `Status.message` field, which is shown as the main error message.

### Version 0.43.1 (14.11.19)

{% if audience != "internal" %}

#### Changes to the CLI {#cli}

**Fixed**

* For Windows Subsystem for Linux (WSL), the browser now opens correctly when logging in to the CLI using [SAML-compatible identity federations](../organization/add-federation.md).

{% endif %}

### Version 0.43.0 (11.11.19) {#version0.43.0}

{% if audience != "internal" %}

#### Changes to the CLI {#cli}

* Added CLI authentication using [SAML-compatible identity federations](../organization/add-federation.md).

   To do this, run the `yc init --federation-id=<FEDERATION_ID>` command to use the CLI on behalf of the federated user.

{% endif %}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

{% if audience != "internal" %}

* Added details to the logged data and error text on [authorization from within a VM](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (using an IAM token from the metadata).

{% else %}

* Added details to the logged data and error text on authorization from within a VM (using an IAM token from the metadata).

{% endif %}

#### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* Added support for creating {{ PG }} version 12 databases.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 4.2.

### Version 0.42.0 (21.10.19) {#version0.42.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Added commands `yc compute instance-group start` and `yc compute instance-group stop` for starting and stopping instance groups.

#### {{ container-registry-name }} {#container-registry}

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`.

   Added alternative spellings for `--container-restart-policy` flag values "always"," never", and "on-failure": "Always", "Never", "OnFailure".

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`.

   Deleted the `--default-gateway-v4-address` flag.

#### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* Commands `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore`.

   Added the value 10_1s for the `-- postgresql-version string` flag to create {{ PG }} cluster version `10-1C`.

### Version 0.41.1 (26.09.19) {#version0.41.1}

* Minor fixes and updates.

### Version 0.41.0 (25.09.19) {#version0.41.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

* Command `yc compute instance create-with-container`.

   The `--create-boot-disk` flag no longer supports `snapshot-*` parameters.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`.

   Added flags to control the master type: `--regional`, `--region`, and `--master-location`.
* Commands `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update`.

   Added flags to manage the maintenance policy: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.
* Command `yc managed-kubernetes node-groups update`.

   Added flags to manage the maintenance policy: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.

### Version 0.40.0 (20.09.19) {#version0.40.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

* Added a command to obtain detailed registry information: `yc container registry repository get`.
* Command `yc container registry repository list`.

   Added unique registry ID to the result.

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> create clusters`.

   For `--*resource-preset` flags, added a default value: s2.micro.

**{{ mmg-name }}**

* Command `{{ yc-mdb-mg }} create clusters`.

   For the `--mongodb-version` flag, changed the default value from 3.6 to 4.0.

### Version 0.39.0 (16.09.19) {#version0.39.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

* Command `yc container registry`.

   Added the ability to set and view a list of roles for the Docker image registry: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> users list`.

   The unique cluster ID is no longer displayed when viewing a list of users.

### Version 0.38.0 (09.09.19) {#version0.38.0}

#### Changes to the CLI {#cli}

**Improved**

* Improved the return of fields when viewing a list of API keys.

### Version 0.37.0 (06.09.19) {#version0.37.0}

#### Changes to the CLI {#cli}

**Improved**

* Added API endpoint availability checks for {{ iam-full-name }}, {{ resmgr-full-name }}, {{ compute-full-name }}. If an endpoint is unavailable, an error is returned.
* Added detailed error reporting.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

**Improved**

* Added Windows support for Docker Credential helper.
* Added a detailed error when using `docker login` in parallel with Docker Credential helper.

#### {{ ig-name }} {#instance-groups}

* Added commands for managing instance group metadata: `yc compute instance-group add-metadata` and `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster update`.

   Added `--node-service-account-id` and `--node-service-account-name` flags to add or change service accounts for nodes in an existing {{ k8s }} cluster.
* Command `yc managed-kubernetes node-group update`.

   Added flags to edit existing node group parameters: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, and `--preemptible`.
* Added commands for label management: `yc managed-kubernetes node-group add-labels` and `yc managed-kubernetes node-group remove-labels`.
* Added commands for node group metadata management: `yc managed-kubernetes node-group add-metadata` and `yc managed-kubernetes node-group remove-metadata`.

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Command `{{ yc-mdb-pg }} cluster update`.

   Added flag `--connection-pool-discard` to disable the connection pooler.
* Commands `{{ yc-mdb-pg }} user create` and `yc managed-postgresql user update`.

   Added ability to specify a user's login and set their access rights using the`--login` and `--grants` flags.

### Version 0.36.0 (27.08.19) {#version0.36.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ resmgr-name }} {#resmgr}

* Command `yc resource-manager cloud update`.

   Added the ability to rename clouds.

### Version 0.35.1 (16.08.19) {#version0.35.1}

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> cluster create`.

   Renamed default disk types: `network-nvme` is now `network-ssd` and `local-nvme` is now `local-ssd`.

### Version 0.35.0 (09.08.19) {#version0.35.0}

#### Changes to the CLI {#cli}

**Improved**

* Added a link to the documentation with release descriptions in the message about the new CLI version.

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Command `{{ yc-mdb-pg }} cluster create`.

   Added the following parameters to the `--user` flag: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, and `log-statement`.

### Version 0.34.0 (26.07.19) {#version0.34.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mrd-name }}**

* Command `{{ yc-mdb-rd }} shards`.

   Added shard support for {{ RD }} clusters.

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} cluster add-external-dictionary`.

   Added {{ PG }} dictionary support. Flags for working with dictionaries: `--postgresql-source`, `--postgresql-source-hosts`, and `--postgresql-invalidate-query`.

**{{ mmy-name }}**

* Command `{{ mmy-name }} cluster update-config --set`.

   Added the ability to globally set the SQL mode using `sql_mode`.

### Version 0.33.0 (19.07.19) {#version0.33.0}

#### Changes to the CLI {#cli}

**Improved**

* Changed the command progress indicator from dots to a [throbber]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Троббер){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Throbber){% endif %}.

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Commands `{{ yc-mdb-pg }} user create` and `{{ yc-mdb-pg }} user update`.

   Added ability to set user parameters with flags such as `--lock_timeout` and `--log_min_duration_statement`.

### Version 0.32.0 (05.07.19) {#version0.32.0}

#### Changes to the CLI {#cli}

**Improved**

* Commands for displaying a list of elements `yc <service> <resource> list`.

   Increased the maximum number of elements to return from 100 to 1000.

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mmg-name }}**

* Commands `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster update-config`.

   In [sharded](../managed-mongodb/concepts/sharding.md) clusters, you can now change `mongos` and `mongocfg` component parameters.

### Version 0.31.0 (01.07.19) {#version0.31.0}

#### Changes to the CLI {#cli}

**Improved**

* When using the CLI on a VM launched under a service account, the CLI is authorized under this service account by default.

**Fixed**

* Attempts to get resources by specifying their unique ID failed if the CLI configuration did not specify a `folder-id` parameter.
* Attempts to get folders by specifying their unique ID failed if the user didn't have the `viewer` role for the folder in {{ yandex-cloud }}.
* The `yc init` command failed if the user didn't have the `viewer` role in {{ yandex-cloud }}.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ network-load-balancer-name }} {#load-balancer}

* Command `yc load-balancer network-load-balancer create` and `yc load-balancer network-load-balancer update`.

   For the `--listener` flag, you can now set the `target-port` parameter, which lets you configure NAT so that target resources receive traffic on a port other than `listener`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `{{ yc-mdb-ch }} user create` and `{{ yc-mdb-ch }} user update`.

   Added the `--settings` flag that lets you pass user settings.

### Version 0.30.0 (18.06.19) {#version0.30.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Command `yc compute instance update`.

   Added the `--service-account-id` and `--service-account-name` flags that let you add and change service accounts for existing VMs.
* Command `yc compute instance create`.

   Changed the default number of cores used when creating a VM with the Intel Cascade Lake platform (`standard-v2`). It's now `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster update`.

   Added the `--default-gateway-v4-address` flag that lets you update the gateway address for an existing {{ k8s }} cluster.

### Version 0.29.0 (11.06.19) {#version0.29.0}

* Minor fixes and updates.

### Version 0.28.0 (05.06.19) {#version0.28.0}

#### Changes to the CLI {#cli}

* Added automatic reconnect if any resource involved in the execution of a command is unavailable. The CLI will try to reconnect 5 times, and the retry frequency is calculated using exponential backoff.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute-cloud}

* Command `yc compute instance create`.

   Added the `--gpus` flag, which lets you specify the number of GPUs in a virtual machine.

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> cluster get`.

   Improved cluster information printout.
* Command `yc <managed DB service name> cluster create`.

   Added the `--backup-window-start` flag, which lets you set the daily cluster backup time when creating a cluster.

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} cluster add-zookeeper`.

   Added the ability to add {{ ZK }} hosts.
* Command: `{{ yc-mdb-ch }} shards add`.

   Changed the logic of creating shards:
   * If the `--host` flag is not specified, the shard parameters are copied from the old shard.
   * If the `--host` flag is specified, all parameters must be entered.
   * If there are no shards, all parameters have to be entered to create a shard.

{% endif %}
