---
title: YC CLI releases
description: This page provides a list of YC CLI releases and updates rolled out in each of them.
---

# YC CLI Releases

## Current version {#latest-release}

### Version 0.137.0 (01/11/24) {#version0.137.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ interconnect-name }} {#interconnect}

* Fixed the way the `get` commands run without parameters in {{ interconnect-name }} and Cloud Router.
* Fixed the format of the `list` commands' output in {{ interconnect-name }} and Cloud Router: now a table is returned.

##### {{ objstorage-name }} {#object-storage}

* Added the `yc storage s3api get-object-retention` and `yc storage s3api put-object-retention` commands to read and change the temporary lock.
* Added the `yc storage s3api get-object-legal-hold` and `yc storage s3api put-object-legal-hold` commands to read and change the indefinite lock (legal hold).

##### Managed database services {#managed-db}

**{{ mpg-name }}**

* Added the `17` value for the `--postgresql-version string` parameter to the `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore` commands. It enables you to create a {{ PG }} cluster version 17.

## Previous releases {#previous-releases}

### Version 0.136.0 (21/10/24) {#version0.136.0}

#### Changes to the CLI {#cli}

* The `yc init` command now does not offer the `ru-central1-c` zone because it is no longer in use.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ alb-name }} {#alb}

* The `yc application-load-balancer load-balancer add-stream-listener`, `yc application-load-balancer load-balancer update-stream-listener`, `yc application-load-balancer load-balancer add-stream-sni`, `yc application-load-balancer load-balancer update-stream-sni` commands have been updated with the `--idle-timeout` parameter allowing you to specify the connection inactivity timeout. 

##### {{ er-name }} {#eventrouter}

* Added parameter validation for the `yc serverless eventrouter` command.
* Fixed an error when running `yc serverless eventrouter put-event`.

##### {{ objstorage-name }} {#object-storage}

* Added the ability to set `--storage-endpoint` using `yc config set`. If the user did not explicitly specify `--storage-endpoint`, it will be obtained from `ApiEndpointService`.

##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the following parameters to the `yc managed-redis cluster create`, `yc managed-redis cluster restore`, `yc managed-redis cluster update-config` commands:
  * `--lua-time-limit`
  * `--repl-backlog-size-percent`
  * `--cluster-require-full-coverage`
  * `--cluster-allow-reads-when-down`
  * `--cluster-allow-pubsubshard-when-down`
  * `--lfu-decay-time`
  * `--lfu-log-factor`
  * `--turn-before-switchover`
  * `--allow-data-loss`

**{{ yc-mdb-mg }}, {{ yc-mdb-ch }}, {{ yc-mdb-gp }}, {{ yc-mdb-pg }}, {{ yc-mdb-rd }}, {{ yc-mdb-my }}, {{ yc-mdb-kf }}, {{ yc-mdb-es }}, {{ yc-mdb-os }}**

* Clarified the description of the `--disk-size` parameters; by default, disk size is specified in GB.

### Version 0.135.0 (07/10/24) {#version0.135.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* Added commands for working with {{ marketplace-name }} products in a {{ managed-k8s-name }} cluster: 
   * `yc managed-kubernetes marketplace helm-release install`: Installs the Helm chart of a {{ marketplace-name }} product to the specified {{ managed-k8s-name }} cluster.
   * `yc managed-kubernetes marketplace helm-release update`: Upgrades the Helm chart version for a {{ marketplace-name }} product.
   * `yc managed-kubernetes marketplace helm-release uninstall`: Deletes a Helm chart version of a {{ marketplace-name }} product.
   * `yc managed-kubernetes marketplace helm-release get`: Returns information about the Helm chart of a {{ marketplace-name }} product.
   * `yc managed-kubernetes marketplace helm-release list`: Returns a list of {{ marketplace-name }} Helm charts installed in a {{ managed-k8s-name }} cluster.

##### {{load-testing-name}}

* Added the `log-group-id` and `log-group-name` parameters to the `yc loadtesting agent create` command to specify a target log group for load testing agent logs.

### Version 0.134.0 (02/10/24) {#version0.134.0}

#### Changes to the CLI {#cli}

* Added the global `--jq` flag. It is used for filtering and converting the output with jq expressions. Examples:
  * `yc iam role list --jq '.[].id'`
  * `ID="instance_id" yc compute instance list --jq '.[] | select(.id == env.ID)'`

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ objstorage-name }} {#storage}

* Added basic support for object operations via the S3 API:
  * `yc storage s3api get-object`: Getting an object from a bucket.
  * `yc storage s3api put-object`: Uploading an object to a bucket.
  * `yc storage s3api delete-object`: Deleting an object.
  * `yc storage s3api copy-object`: Copying an existing bucket object.
  * `yc storage s3api head-object`: Getting object metadata.
  * `yc storage s3api delete-object`: Deleting an object group.

  To work with objects, in the `~/.config/yandex-cloud/config.yaml` YC CLI configuration file, specify the {{ objstorage-name }} endpoint.

  ```yaml
  ...
  profiles:
    default:
      ...
      storage-endpoint: https://{{ s3-storage-host }}/
  ```

##### {{ interconnect-name }} {#interconnect}

* Added the `yc cic point-of-presence get` and `yc cic point-of-presence list` commands to read points of presence.
* Added the `yc cic partner get` and `yc cic partner list` commands to read {{ interconnect-name }} partners.
* Added the `yc cic trunk-connection get` and `yc cic trunk-connection list` commands to read trunk connections.
* Added the `yc cic private-connection get` and `yc cic private-connection list` commands to read private connections.
* Added the `yc cic public-connection get` and `yc cic public-connection list` commands to read public connections.

##### {{ cloud-desktop-name }} {#cloud-desktop}

* Added the `--image-id` parameter to the `yc desktops group create` command to provide an image ID to a desktop group. 

##### {{ backup-name }} {#backup}

* Added the following commands:
  * `yc backup agent install`: Installing a backup agent and connecting a VM with OS Login to {{ backup-name }}.
  * `yc backup agent reinstall`: Re-installing a backup agent for a VM with OS Login.
  * `yc backup agent debug-info`: Getting backup agent installation logs for a VM with OS Login.
  * `yc backup provider activate`: Activating the service and connecting to a backup provider.

* When running commands, a {{ backup-name }} activation check is now performed on the folder.

##### {{ si-name }} {#serverless-integrations}

* Added {{ er-full-name }} support.

##### {{ iam-name }} {#iam}

* Changed the header in the `yc iam service accounts list` table output.

##### {{ org-name }} {#organization}

* Added the last user authentication time to the `yc organization-manager user list --organization-id` command output.

##### Managed database services {#managed-db}

**{{ mgp-name }}**

* `yc managed-greenplum cluster create` and `yc managed-greenplum cluster restore` now support `--master-host-group-ids` and `--segment-host-group-ids` options for specifying the dedicated host groups to place master hosts and {{ GP }} segments in.

**{{ mrd-name }}**

* Added the `yc managed-redis backup delete` command to delete backups.
* Changed the default {{ RD }} version to 7.2 as versions 6.2 and 7.0 will no longer be supported.

**{{ mkf-name }}**

*  Upgraded the `--permission` flag for the `yc managed-kafka cluster create`, `yc managed-kafka cluster update`, `yc managed-kafka cluster grant-permission`, and`yc managed-kafka cluster revoke-permission` commands. Its value is set in `key=value,...` format. As `key`, now you can use `allow_host`, which is the host that applies this rule to a user.

**{{ maf-name }}**

* Bug fixes and {{ maf-name }} performance improvements

### Version 0.133.0 (09/09/24) {#version0.133.0}

#### Changes to the CLI {#cli}

* Fixed the error that caused real error messages to be superseded with the `ERROR: Failed to retrieve data` text. Affected versions: 0.131.0–0.132.1.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ at-name }} {#audit-trails}

* Trail management commands now use the `filtering_policy` field instead of `filter`. You can still access the obsolete field by using the `--file` option to describe requests.

##### {{ compute-name }} {#compute}

* The `yc compute instance get`, `yc compute image get`, `yc compute disk get`, and `yc compute snapshot get` commands now display the `hardware_generation` property.
* Added the `--hardware-generation-id` and `--hardware-features` parameters to the `yc compute image create`, `yc compute disk create`, and `yc compute snapshot create` commands.

##### Managed database services {#managed-db}

* Added the ability to change the cluster network using the `--network-id` and `--network-name` parameters in the following commands:
  * `yc managed-mongodb cluster update`
  * `yc managed-clickhouse cluster update`
  * `yc managed-greenplum cluster update`
  * `yc managed-postgresql cluster update`
  * `yc managed-redis cluster update`
  * `yc managed-mysql cluster update`
  * `yc managed-kafka cluster update`
  * `yc managed-elasticsearch cluster update`
  * `yc managed-opensearch cluster update`.

**{{ mch-name }}**

* Added the `yc managed-clickhouse cluster [ clear-query-masking-rules | set-query-masking-rules ]` commands to enable the use of the `query_masking_rules` option in {{ CH }}. This option creates request rules to address confidential information leakage.
* Added the following parameters to the `yc managed-clickhouse cluster add-external-dictionary` command:
  * `--layout-max-array-size`: Determining the maximum number of dictionary keys.
  * `--http-header`: Adding HTTP headers for HTTP sources of external dictionaries.
* Added the `--secure` parameter to the`yc managed-clickhouse cluster add-external-dictionary --clickhouse-source` command to enable SSL in connections.
* Added the following parameters to the `yc managed-clickhouse cluster add-external-dictionary --mysql-source` command:
  * `--close-connection`: Closing the connection after each request.
  * `--share-connection`: Sharing the connection between multiple requests.

**{{ mrd-name }}**

* Added the `--websql-access` parameter to the `yc managed-redis cluster [ create | update | restore ]` commands allowing you to establish access via {{ websql-name }} in {{ RD }}.

**{{ mgp-name }}**

* To the `yc managed-greenplum cluster [ create | update | restore ]` commands allowing you to access the cluster from {{ yq-full-name }}.
* To the `yc managed-greenplum cluster [ create | update ]` commands, added the `--analyze-and-vacuum`, `--query-killer-idle`, `--query-killer-idle-in-transaction`, and `--query-killer-long-running` parameters allowing you to manage {{ mgp-name }} background processes.

**{{ maf-name }}**

* Added the following commands for {{ maf-name }}: `yc managed-airflow cluster [ get | list | delete | list-operations | start | stop | create | update ]`.

### Version 0.132.1 (28/08/24) {#version0.132.1}

#### Changes to the CLI {#cli}

* Fixed errors in the `--help` flag documentation.

### Version 0.132.0 (28/08/24) {#version0.132.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ iam-name }} {#iam}

* Added the `yc iam revoke-token` command to revoke compromised tokens.
* Added the `yc iam api-key list-scopes` command to get a list of scopes available when creating API keys.

##### {{ sf-name }} {#cloud-functions}

* Added the `--mount` parameter to the `yc serverless function version create` command to specify mounted resources, such as {{ objstorage-name }} buckets and ephemeral disks.
* In the `yc serverless function version create` command, the `--storage-mounts` parameter is marked as `deprecated`.

##### {{ serverless-containers-name }} {#serverless-containers}

* Added the `--mount` parameter to the `yc serverless container revision deploy` command to specify mounted resources, such as {{ objstorage-name }} buckets and ephemeral disks.
* In the `yc serverless container revision deploy` command, the `--storage-mounts` parameter is marked as `deprecated`.

##### {{ backup-name }} {#backup}

* Added the `--type` flag to the `backup vm list` command to specify the type of resources to return in the list.

##### {{ vpc-name }} {#vpc}

* Added the `yc vpc private-endpoint` command group to manage VPC Private Endpoint resources.

##### Managed database services {#managed-db}

**{{ mmg-name }}**

* Added the `--disk-size-autoscaling` parameter to the `yc managed-mongodb cluster create` and `yc managed-mongodb cluster update` commands to enable automatic disk scaling.

**{{ mrd-name }}**

* In the `yc managed-redis cluster create` and `yc managed-redis cluster update` commands, the `disk-size-limit` measurement units for `--disk-size-autoscaling` were changed from bytes to gigabytes.

### Version 0.131.1 (15/08/24) {#version0.131.1}

#### Changes to the CLI {#cli}

* Fixed an error handling issue where `_` was replaced with `-` in some error messages.

### Version 0.131.0 (14/08/24) {#version0.131.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ backup-name }} {#backup}

* Added the `backup policy execute` command to create a backup of a virtual machine according to the specified backup policy.

##### {{ iam-name }} {#iam}

* Added support for the `--agent` option to the `add-access-binding` and `remove-access-binding` commands.
* Added the `yc iam workload-identity` command tree to manage workload identity federation.
* The `yc iam service-account list` and `yc iam service-account get` commands now show the time of the last service account authentication.

##### {{ container-registry-name }} {#container-registry}

* Added the `--secure` option to the `yc container registry create` command to create a registry with security settings.

##### Managed database services {#managed-db}

**{{ mgp-name }}**

* Added the `yc managed-greenplum cluster move` command to migrate a cluster to a different folder.

### Version 0.130.0 (01/08/24) {#version0.130.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ data-transfer-name }}

* Added the `--cluster-name` flag to the `yc datatransfer endpoint create clickhouse-source` command to specify the name of the ClickHouse cluster for data transfer.

##### {{ marketplace-name }}

* Added the `yc marketplace reset-password` command that was accidentally left out of the previous release.

##### {{ iam-name }} {#iam}

* Deleted the `pause` and `resume` commands from the `yc iam service-control` command tree.

##### {{ compute-name }}

* Added the `--host-id` flag to the `yc compute host-group list-instances` command to specify the host ID in a host group for VM listing.

##### {{ load-testing-name }}

* In the `yc loadtesting agent create` command, added the option to wait for the created agent to connect to {{ load-testing-name }}:
  * `--wait-ready` flag: Do not terminate the command until the agent has the `READY FOR TEST` status.
  * `--wait-ready-timeout` parameter: Maximum wait time for `--wait-ready` (default: 5m).

#### Changes to the CLI {#cli}

* Changed the federated account authorization protocol to Authorization Code Flow with Proof Key for Code Exchange (PKCE).

### Version 0.129.0 (16/07/24) {#version0.129.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ load-testing-name }}

* Fixed an error for tests without a tabular report in the `yc loadtesting test get-report-table` command.

##### {{ captcha-name }}

Added support for {{ captcha-name }}:

* The `yc smartcaptcha captcha` group commands allow managing CAPTCHAs.

##### {{ sws-name }}

Added support for {{ sws-name }}:

* The `yc smartwebsecurity security-profile` group commands allow managing security profiles.

##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the `--disk-size-autoscaling` parameter to the `yc managed-redis cluster create` and `yc managed-redis cluster update` commands to enable automatic disk scaling.

**{{ mch-name }}**

* Added the `yc managed-kafka user grant-permission` and `yc managed-kafka user revoke-permission` permission management commands.
* Added the `{{ yc-mdb-ch }} hosts add` and `{{ yc-mdb-ch }} shards add` commands. The `copy-schema` parameter is enabled by default.
* Added the `yc managed-clickhouse backup delete` backup delete command.
* Added the `--disk-type` parameter to the `yc managed-kafka cluster update` command.
* Added the `--backup-retain-period-days` parameter to configure the automatic backup storage period.

##### {{ marketplace-name }} {#marketplace}

* Added the `yc marketplace reset-password` command to reset passwords on virtual machines with the password reset agent installed.


### Version 0.128.0 (02/07/24) {#version0.128.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ api-gw-name }} {#api-gw}

Added the `--execution-timeout` parameter to the `yc serverless api-gateway create` and `yc serverless api-gateway update` commands to limit the processing time for requests to an API gateway.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Added the `--convert-tables-to-replicated` parameter for converting tables into replicated ones when adding them to a {{ ZK }} cluster.

**{{ mgp-name }}**

* Added the `delay-redistribution`, `parallel`, and `close-cluster` options to the `yc managed-greenplum cluster expand` command.

### Version 0.127.0 (17/06/24) {#version0.127.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ iam-name }} {#iam}

* Added the `yc iam service-account add-labels` and `yc iam service-account remove-labels` label management commands.
* The `yc iam service-account create` and `yc iam service-account update` commands now have the `--labels` parameter, which specifies a set of DB labels.

##### {{ org-name }} {#organization}

* Added the following label management commands:
  * `yc organization-manager organization add-labels`
  * `yc organization-manager organization remove-labels`
  * `yc organization-manager federation saml add-labels`
  * `yc organization-manager federation saml remove-labels`
* Added the `--labels` parameter to the following commands to define the set of DB labels:
  * `yc organization-manager organization update`
  * `yc organization-manager federation saml create`
  * `yc organization-manager federation saml update`

#### Managed database services {#managed-db}

* Added the option to set parameters for the `disk-size-autoscaling` configuration to the `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands.

##### {{ resmgr-name }} {#resmgr}

* Added the `yc resource-manager cloud add-labels` and `yc resource-manager cloud remove-labels` label management commands.
* The `yc resource-manager cloud update` command now has the `--labels` parameter, which specifies a set of DB labels.

##### {{ iot-name }} {#iot}

* Added the `yc iot registry enable` and `yc iot registry disable` commands to enable and disable registries.

##### {{ sf-name }} {#cloud-functions}

* Added a new `concurrency` flag for the `yc serverless function version create` command.

### Version 0.126.0 (04/06/24) {#version0.126.0}

#### Changes to the CLI {#cli}

* Added the `region` field to the profile to manage different regions.
* Added the `--region` flag to the `init` command to initialize the CLI with a specific region.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ resmgr-name }} {#resmgr}

* Added the `yc resource-manager cloud create` command for creating a cloud.
   * The `--billing-account-id` flag allows you to automatically link a new cloud to a billing account.
* Added the `yc resource-manager cloud delete` command for deleting a cloud.
   * The `--delete-after` flag allows you to delete a cloud after a specified period of time.
* Added the `--delete-after` flag to the `yc resource-manager folder delete` command for delayed deletion after a specified period of time.

##### {{ load-testing-name }} {#load-testing}

* Added the `--platform-id` flag to the `yc loadtesting agent create` command to create a VM on a specified platform.
* Added the following parameters to the `yc loadtesting test create` command to manage the export of agent artifacts to {{ objstorage-name }}:
  * `--artifacts-output-bucket`: To specify the name of the bucket to export the artifacts to.
  * `--artifacts-make-archive`: To specify whether to export the artifacts as a single archive or separately.
  * `--artifacts`: To list specific files for export.

##### {{ mos-name }} {#mos}

* Added the optional `--keystore-settings` parameter to the `yc managed-opensearch cluster create` and `yc managed-opensearch cluster restore` commands to specify the contents of the {{ OS }} keystore.
* Added the following optional `--set-keystore-settings` and `--remove-keystore-settings` parameters to the `yc managed-opensearch cluster update` command:
   * `--set-keystore-settings`: To list records you want to add or replace. Keystore records not specified in this parameter will remain unchanged.
   * `--remove-keystore-settings`: To list records you want to delete from the keystore.

##### {{ sf-name }} {#cloud-functions}

* In the `yc serverless function allow-unauthenticated-invoke` command, the deprecated `serverless.functions.invoker` role has been replaced by the new `functions.functionInvoker` role.
* The `yc serverless function deny-unauthenticated-invoke` command now deletes the deprecated `serverless.functions.invoker` role and the new `functions.functionInvoker` role.

##### {{ serverless-containers-name }} {#serverless-containers}

* In the `yc serverless container allow-unauthenticated-invoke` command, the deprecated `serverless.containers.invoker` role has been replaced by the new `serverless-containers.containerInvoker` role.
* The `yc serverless container deny-unauthenticated-invoke` command now deletes the deprecated `serverless.containers.invoker` role and the new `serverless-containers.containerInvoker` role.

### Version 0.125.0 (20/05/24) {#version0.125.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }}
* Added the `--public-address` flag to the `yc compute ssh` command to connect to a VM via SSH using only a public address.
* By default, the `yc compute ssh` command will use a public address to connect to a VM. If the VM has no public address, an internal address will be used instead.

##### {{ iam-name }}

* Added the optional `--scope` and `--expires_at` parameters to the `yc iam api-key create` command:
  * `--scope`: Allows you to set the scope of an API key, i.e., the services in which you can use it. If the parameter is not set, the scope of the key will have no limitations.
  * `--expires_at`: Allows you to specify the API key expiration date. If the parameter is not set, the key will have no expiration date.

##### {{ sf-name }} {#serverless-functions}

* `yc serverless trigger create` command.

  The `--gateway-name`, `--gateway-id`, and `--gateway-websocket-broadcast-path` flags allow you to specify parameters for the trigger to send messages to the {{ api-gw-name }} websocket connections.

##### {{ org-name }} {#organization}

* Added the `yc organization-manager oslogin profile` group of commands for managing OS Login user profiles.
* Fixed the `--expires-at` flag for interval values in the `yc organization-manager oslogin user-ssh-key create` and `yc organization-manager oslogin user-ssh-key update` commands. For example, `5h` now supplies a value in the future.

### Version 0.124.0 (22/04/24) {#version0.124.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mgp-name }}**

* Added the `yc managed-greenplum hba-rules` command tree with the `get`, `list`, `delete`, `create`, and `update` commands.

**{{ mch-name }}**

* The `--shard-name` parameter of the `yc managed-clickhouse cluster create` command is marked as deprecated. We recommend using the `shard-name` argument of the `--host` parameter.

### Version 0.123.0 (08/04/24) {#version0.123.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Added the optional `shard-name` argument for the `--host` parameter of the `yc managed-clickhouse cluster restore` command.

**{{ mmg-name }}**

* Added the `hidden`, `priority`, and `secondary-delay-secs` parameters to the `yc managed-mongodb hosts add --host` command.
* Added the new `yc managed-mongodb hosts update` command to modify the `hidden`, `priority`, and `secondary-delay-secs` parameters.

##### {{ sf-name }} {#serverless-functions}

* Changed batching limits for the `yc serverless trigger create` command.

##### {{ backup-name }} {#backup}

* Added the `RESULT CODE` field to the output of the `backup resource list-tasks` command to display the VM operation completion code.

#### Changes to the CLI {#cli}

* Added the documentation and installation script fixes to help configure autocompletion for `yc` in CentOS-based Linux distributions.

### Version 0.122.0 (27/03/24) {#version0.122.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ sf-name }} {#serverless-functions}

* Added the `--tmpfs-size` parameter to the `yc serverless function version create` command to mount the `/tmp` directory from memory when allocating 1 GB of memory or more to the function.
* Deleted the `yc serverless trigger create cloud-logs` command.

##### {{ data-transfer-name }}

Added the following commands to create and modify {{ yds-full-name }} endpoints:
* `yc datatransfer endpoint create yds-source`
* `yc datatransfer endpoint create yds-target`
* `yc datatransfer endpoint update yds-source`
* `yc datatransfer endpoint update yds-target`

##### {{ dns-name }} {#dns}

Added the `--deletion-protection` parameter to the following commands to protect the DNS zone from accidental deletion:
* `yc dns zone create`
* `yc dns zone update`

##### {{ compute-name }}

* Added the `yc compute instance attach-network-interface` command to add a network interface to an existing VM.
* Added the `yc compute instance detach-network-interface` command to delete a network interface from an existing VM.

### Version 0.121.0 (12/03/24) {#version0.121.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ mgp-name }} {#mgp}

* Added the `yc managed-greenplum pxf-datasource` command tree with the `get`, `list`, and `delete` commands.
* Added the `yc managed-greenplum pxf-datasource s3` and `yc managed-greenplum pxf-datasource jdbc` command trees with the `create` and `update` commands.
* Added the `--pxf-connection-timeout`, `--pxf-upload-timeout`, `--pxf-max-threads`, `--pxf-pool-allow-core-thread-timeout`, `--pxf-poll-core-size`, `--pxf-pool-queue-capacity`, `--pxf-pool-max-size`, `--pxf-xmx`, and `--pxf-xms` flags for the `yc managed-greenplum cluster update` command.

##### {{ org-name }} {#organization}

* Added the `yc organization-manager oslogin` group of commands for managing OS Login settings and custom SSH keys.

##### {{ container-registry-name }} {#container-registry}

* Added the `origin` and `type` fields to the `yc container image list-vulnerabilities` result.

##### {{ load-testing-name }} {#load-testing}

* Added the `yc loadtesting test wait` command to wait for the end of the load test.
* Added the `--wait` and `--wait-idle-timeout` flags to the `yc loadtesting test create` command to wait for the end of the created load test.
* Added the `--configuration agent-by-filter=""` and `--configuration anonymous-agent=true` flags to the `yc loadtesting test create` command for selecting a load testing agent by filter or an anonymous agent, respectively.
* Added the `--filter` flag to the `yc loadtesting agent list` command to filter the agent list.

##### {{ vpc-name }} {#vpc}

* Added the `--dns-record` flag to the `yc vpc address create` command for providing DNS specifications of the address.
* Added the following flags to the `yc vpc address update` command:

  * `--dns-record`: To provide DNS specifications of the address.
  * `--clear-dns-records`: To delete all DNS specifications of the address.

### Version 0.120.0 (01/03/24) {#version0.120.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }}

* The `yc compute connect-to-serial-port` command supports authorization through OS Login.

##### {{ at-name }}

* Added the `yc audit-trails trail` command tree with the `get`, `list`, `create`, `update`, `delete`, `list-operations`, `list-access-bindings`, `set-access-bindigns`, `add-access-binding`, and `remove-access-binding` commands to manage trails.

### Version 0.119.0 (27/02/24) {#version0.119.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ iam-name }} {#iam}

* Added the `yc iam service-control` command tree with the `get`, `list`, `enable`, `pause`, `resume`, and `disable` commands to manage the access of services to resources in the cloud.

##### {{ compute-name }}

* Added support for serial port settings in the `yc compute instance create` and `yc compute instance update` commands.

### Version 0.118.0 (14/02/24) {#version0.118.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ mgp-name }}

* Added the `yc managed-greenplum backups` command tree with the `get`, `list`, and `delete` commands to manage backups.
* Added the `yc managed-greenplum cluster backup` command for creating a backup.

##### {{ compute-name }}

* Added the `--identity-file` flag to the `yc compute ssh` command to connect to the VM via SSH by specifying a user key.

##### {{ data-transfer-name }}

- Added the `--file` flag for the following commands to specify a YAML file for request configuration:
  * `yc datatransfer transfer create`
  * `yc datatransfer transfer update`
  * `yc datatransfer endpoint create`
  * `yc datatransfer endpoint update`

##### {{ org-name }} {#organization}

* Added the `yc organization-manager federation saml delete-user-accounts` command to delete federated users.

##### {{ load-testing-name }}

Added the `yc loadtesting test get-report-table` command to get a tabular report on the completed load test.

##### {{ dns-name }} {#dns}

* Added the `--page-token` parameter to the `yc dns zone list-records` command to enable pagination by page token.

### Version 0.117.0 (30/01/24) {#version0.117.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mgp-name }}**

Added the `restore-only` flag for the `yc managed-greenplum cluster restore` command to restore only specified objects.

##### {{ iot-name }} {#iot}

Added the following parameters to the `yc iot registry create`, `yc iot registry update`, `yc iot broker create`, and `yc iot broker update` commands:

* `--no-logging`: Disables logging from a registry or a broker.
* `--log-group-id`, `--log-group-name`: ID or name of the log group to deliver the logs to.
* `--log-folder-id`, `--log-folder-name`: ID or name of the folder the default log group of which will receive the logs.
* `--min-log-level`: Minimum record logging level.

##### {{ managed-k8s-name }} {#k8s}

Fixed the error in the `k8s cluster update` command occurring when `cluster-id` is transferred as a positional argument.

### Version 0.116.0 (15/01/24) {#version0.116.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Networks in serverless computing services {#serverless}

Added the `yc serverless network` command group to manage networks used in serverless computing services ({{ sf-name }}, {{ serverless-containers-name }}, and {{ api-gw-name }}):

  * `yc serverless network get-used`: Get information about the network connected to the resources of serverless computing services.
  * `yc serverless network list-used`: Get a list of networks connected to the resources of serverless computing services.
  * `yc serverless network list-connections`: Get a list of resources of serverless computing services connected to any network in the specified area (network, directory, or cloud).
  * `yc serverless network trigger-used-cleanup`: Initiate an early cleanup of the network from system subnets if it is no longer used in serverless computing services.

##### {{ iam-name }} {#iam}

* Added support for listing more than 1,000 resources via the `limit` parameter to the `iam`, `resource-manager`, and `organization-manager` command tree.

##### {{ objstorage-name }}

* Added the `AND` (`andOperation`) operator support to the `yc storage bucket update` command for the `--lifecycle-rules/` and `--lifecycle-rules-from-file` parameters to merge conditions in the object filter.
* Added the `--encryption key-id=<key_ID>` parameter to the `yc storage bucket update` command to modify the encryption key currently in use and the `--remove-encryption` parameter which disables bucket encryption.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Now you can specify the `cloud-storage-data-cache-max-size` parameter in the `{{ yc-mdb-ch }} cluster update` command in an easy-to-read format.

##### {{ cdn-name }} {#cdn}

Added the following parameters to the `yc cdn resource update` and `yc cdn resource create` commands to configure the *ip address acl* option:

* `--policy-type`: Client IP-based access policy, either *allow* or *deny*.
* `--acl-excepted-values`: List of IP addresses for which access will be allowed or denied depending on the specified policy type.

##### {{ load-testing-name }}

Added the `yc loadtesting` command tree to manage the load testing service:

* `yc loadtesting agent`: Managing load testing agents.
* `yc loadtesting test-config`: Managing load test configuration templates.
* `yc loadtesting test`: Running load tests and managing completed load tests.

### Version 0.115.0 (18/12/23) {#version0.115.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mgp-name }}**

* Added the `--backup-retain-period-days` flag to the `yc managed-greenplum cluster create` and `yc managed-greenplum cluster update` commands.

**{{ mch-name }}**

* The `network-id` parameter for `yc clickhouse cluster restore` is now optional.

##### {{ alb-name }} {#alb}

* Added the `--security-profile-id` parameter to the `yc alb virtual-host create` and `yc alb virtual-host update` commands to specify a security profile from {{ sws-name }}.

##### {{ compute-name }} {#compute}

* `yc compute instance`, `yc compute disk`, `yc compute image`, `yc compute snapshot`, `yc compute snapshot-schedule`, `yc compute placement-group`, `yc compute host-group`, `yc compute disk-placement-group`, `yc compute filesystem`, and `yc compute gpu-cluster` commands: Now you can display and manage access permissions using `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.
* Added the `yc compute instance simulate-maintenance-event` command.

### Version 0.114.0 (05/12/23) {#version0.114.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ objstorage-name }}

* Fixed supplying the bucket name to the `yc storage bucket create`, `yc storage bucket update`, and `yc storage bucket set-https` commands.

#### {{ sf-name }} {#serverless-functions}

Added the following parameter to the `yc serverless function version create` command to specify the mounting of buckets to a function:

* `--storage-mounts`, example: `--storage-mounts mount-point=dir,bucket=user-bucket,read-only=false`.

#### {{ serverless-containers-name }} {#serverless-containers}

Added the following parameter to the `yc serverless container revision deploy` command to specify the mounting of buckets to a container:

* `--storage-mounts`, example: `--storage-mounts mount-point-path=/data,bucket=user-bucket,read-only=false`.

##### {{ compute-name }} {#compute}

* In the `yc compute ssh` command, all temporary certificates are saved to the user's home directory.
* In the `yc compute ssh` command, user parameters are now placed at the end of the executed `ssh` command.
* The `yc compute disk relocate` and `yc compute instance relocate` commands now enable relocation of non-replicated disks with specified placement groups and VMs with such disks.
* Added the `--maintenance-policy` and `--maintenance-grace-period` parameters to the `yc compute instance create` and `yc compute instance update` commands.
* Added a check for simultaneous use of the `--spread-strategy` and `--partitions` flags when creating a placement group.
* PAGER now runs correctly when requesting `help`. Now when you run a command with the `--help` flag, the `less` window opens.

##### {{ cloud-logging-name }} {#cloud-logging}

* Fixed the error when a response contained no more than 1,000 rows with a limit of over 1,000 rows set.

#### {{ cdn-name }} {#cdn}

Added the following parameters to the `yc cdn resource update` and `yc cdn resource create` commands for configuring access to a resource via a _secure token_:

* `--secure-key`: Secret key to generate custom links.
* `--enable-ip-url-signing`: Optional parameter to restrict access to resources by IP address.
* `--clear-secure-key`: Parameter to disable access to a resource via a secure token.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Extended the list of fields in the default list of shards and clusters.
* Added backup type and size info to the list of backups.
* Fixed a bug that occurred when attempting to restore a cluster with enabled hybrid storage or SQL Management using the `yc clickhouse cluster restore` command.

### Version 0.113.0 (31/10/23) {#version0.113.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* Added the `--location` parameter to the `yc k8s node-group update` command. This parameter allows changing the [availability zone](../overview/concepts/geo-scope.md) in which a node group is deployed.

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands: The `--unmanaged-topics` flag is marked as `deprecated`. The relevant field is no longer sent in API requests, but the flag is kept for backward compatibility.

**{{ mos-name }}**

* Added the `yc managed-opensearch` command group to manage {{ mos-name }} databases.

**{{ mch-name }}**

* Added the `options` setting for the `yc managed-clickhouse cluster --mongodb-source` command.
* Added the `level` setting for the `yc managed-clickhouse cluster set-compression` command.

##### {{ compute-name }} {#compute}

* You can now replace environment variables in templates uploaded using the `--metadata-from-file` command.

##### {{ vpc-name }} {#vpc}

* Added the `yc vpc subnet relocate` command.

### Version 0.112.0 (12/10/23) {#version0.112.0}

#### Changes to {{ yandex-cloud }} services {#services}

###### {{ compute-name }} {#compute}

* Added support for a CentOS 7 connection using the `yc compute ssh` command.
* Added the `yc compute instance relocate` and `yc compute disk relocate` commands to move VMs and disks between availability zones.

### Version 0.111.0 (21/09/23) {#version0.111.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }} {#compute}

* Added support for the `--network-interface` parameter in the `yc compute instance relocate` command.
* Added the `yc compute ssh` command group to connect to a VM using a certificate issued using OS Login and to export this certificate. OS Login is used to provide users with SSH access to VMs through {{ iam-short-name }}.

##### {{ mpg-name }}

* Added the `16` value for the `--postgresql-version string` flag to the `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore` commands. It enables you to create a {{ PG }} cluster version 16.


##### {{ iot-name }} {#iot}

* Added the `yc iot registry yds-export` command group to manage export of messages from IoT to Data Streams.



##### {{ cloud-logging-name }} {#cloud-logging}

* Fixed the `yc logging read` output error for JSON and JSON-REST formats.



##### {{ sf-name }} {#serverless-functions}

Added the following asynchronous call parameters to the `yc serverless function version create` command:
* `--async-max-retries`: To specify the maximum number of function call attempts.
* `--async-service-account-id`: To specify a service account for calling a function.
* `--async-success-ymq-arn`: To specify a queue for a successful result.
* `--async-success-sa-id`: To specify a service account to write to the successful result queue.
* `--async-failure-ymq-arn`: To specify a queue for an unsuccessful result.
* `--async-failure-sa-id`: To specify a service account to write to the unsuccessful result queue.


### Version 0.110.0 (14/09/23) {#version0.110.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ api-gw-name }} {#api-gw}

* Added the following parameters to the `yc serverless api-gateway create` and `yc serverless api-gateway update` commands:
  * `--variables`: To set specification parameter values.
  * `--canary-weight`: To set the ratio of incoming requests processed by the gateway canary release.
  * `--canary-variables`: To set specification parameter values for the canary release.

* Added the `yc serverless api-gateway release-canary` command to replace the specification parameters with the parameters of the canary release and delete the latter.

* Added the `yc serverless api-gateway rollback-canary` command to disable the canary release by setting the `weight` parameter to `0`.



##### {{ iam-name }} {#iam}

* Deleted the `yc iam federation` and `yc iam certificate` command groups used for managing SAML-compatible federations at the folder level. Now you should use the `yc organization-manager federation` command group to work with SAML-compatible federations.


##### {{ ig-name }} {#instance-groups}

Fixed the `yc compute instance-group update` command issue where the VM group name failed to be processed if a YAML file was used for configuration.

##### {{ compute-name }} {#compute}

* Added the `--placement-group-partition` flag to the `yc compute instance create` and `yc compute instance update` commands to specify the partition number in a placement group.


##### {{ cloud-logging-name }} {#cloud-logging}

* Removed a limit for the `--limit` flag in the `yc logging read` command. You can now output more than 1,000 records.


##### Managed database services {#managed-db}

**{{ mmg-name }}**

* You can now create sharded clusters. If a configuration contains the appropriate host types, a cluster will be created automatically.
* Added the `--performance-diagnostics` parameter to the `yc mongodb cluster create`, `yc mongodb cluster update`, and `yc mongodb cluster restore` commands.

**{{ mpg-name }}**

* Added the `yc managed-postgresql backup delete` command for deleting manual backups.
* Added the following flags to the `yc managed-postgresql cluster update` command:
  * `--disk-size-autoscaling`: To manage the automatic disk size expansion service settings.
  * `--yandexquery-access`: To enable cluster access from {{ yq-full-name }}.

**{{ mch-name }}**

* Added the `--cloud-storage-prefer-not-to-merge` flag to the `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster update` commands to disable merging of data parts in {{ objstorage-name }}.

### Version 0.109.0 (10/08/23) {#version0.109.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ sf-name }} {#cloud-functions}

* You can now set up a bucket to save email attachments using the `yc serverless trigger create mail` command.
* Added the the following parameters to the `yc serverless trigger create iot-devices`, `yc serverless trigger create iot-broker`, `yc serverless trigger create object-storage`, `yc serverless trigger create container-registry`, and `yc serverless trigger create mail` commands:
  * `--batch-size`: To specify message group size.
  * `--batch-cutoff`: To specify the maximum group formation time.
* Added the `--stream-names` parameter to the `yc serverless trigger create logging` command for filtering by log stream name.
* Added the `yc serverless function version delete` command to delete function versions.

##### {{ kms-name }} {#kms}

* Added the `--inform` and `--outform` parameters to the `yc kms asymmetric-encryption-crypto decrypt`, `yc kms asymmetric-signature-crypto sign`, and `yc kms asymmetric-signature-crypto sign-hash` commands to specify input and output data formats.
* In the `yc kms asymmetric-signature-crypto sign` and `yc kms asymmetric-signature-crypto sign-hash` commands, the `--signature-file` parameter, which indicates the file to save the resulting signature value to, has been renamed to `--signature-output-file`.

##### {{ managed-k8s-name }} {#k8s}

* Added the `--gpu-cluster-id` parameter to the `yc k8s node-group create` command to add a node from a node group to a cluster with a GPU.
* Added the `--gpu-environment` parameter to the `yc k8s node-group create` command to set up a pre-installed environment for nodes with GPUs.

##### {{ compute-name }} {#compute}

* Added the `--strategy` parameter to the `yc compute disk-placement-group create` command to specify a placement strategy. Its possible values are `SPREAD` or `PARTITION`.
* Added the `--partition-count` flag to the `yc compute disk-placement-group create` command. The flag sets the number of partitions for a group with the `PARTITION` strategy.
* Added the `--disk-placement-group-partition` flag to the `yc compute disk create` command to specify the partition number in a placement group.
* Added the `PLACEMENT GROUP` column to the table with a list of disks you get using the `yc compute disk list` command.
* Added the `STRATEGY` column to the table with a list of disk placement groups you get using the `yc compute disk-placement-group list` command.

##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `yc logging sink` group.

##### {{ ig-name }} {#instance-groups}

* Added the `yc compute instance-group rolling-restart` and `yc compute instance-group rolling-recreate` commands to restart and recreate VMs in a group based on the group's limits.

##### {{ dns-name }} {#dns}

* Added the `yc dns zone update-private-networks` command to make atomic changes to a list of networks for private zones.

##### Managed database services {#managed-db}

**{{ mmg-name }}**

* Added the `yc managed-mongodb backup delete` command for deleting backups.

### Version 0.108.1 (06/07/23) {#version0.108.1}

#### Changes to the CLI {#cli}

* Temporarily deleted the `oslogin` command.

### Version 0.108.0 (04/07/23) {#version0.108.0}

#### Changes to the CLI {#cli}

* Added the `oslogin` command to get the username of the current OS user.
* Disabled the display of global flags for all commands by default when running `yc [command] -h`. To view global flags, run `yc help [command]`.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ kms-name }} {#kms}

* {{ kms-full-name }} now supports operations with asymmetric cryptographic keys. The functionality is at the [Preview](../overview/concepts/launch-stages.md) stage. Read more about the service in the [documentation](../kms/).

### Version 0.107.0 (15/06/23) {#version0.107.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }} {#compute}

* Added the `--partitions` parameter to the `yc compute placement-group create` command to specify the number of partitions in `partitionPlacementStrategy`.

##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Unified the configuration parameters of {{ mrd-name }} clusters for different {{ RD }} versions.

**{{ mgp-name }}**

* Added the following parameter to the `yc managed-greenplum cluster restore` command:
  * `--segment-host-count`: To specify the number of segment hosts in a restored cluster.
  * `--segment-in-host`: To specify the number of segments per host in a restored cluster.

**{{ mmy-name }}**

* Added the `--global-permissions` parameter to the `yc managed-mysql user update` command enabling you to grant the `FLUSH_OPTIMIZER_COSTS` and `SHOW_ROUTINE` privileges.

### Version 0.106.0 (19/05/23) {#version0.106.00}

#### Changes to the CLI {#cli}

* Added the `--force-authn` flag to the `yc organization-manager federation saml` command.
* Added the `fed-auth-browser-skip` configuration option to skip the browser opening confirmation (by pressing **Enter**) when authenticating as a federated user. Its value is either `true` or `false`.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* Added the `audit-enabled` flag to the `--master-logging` parameter to enable or disable uploading {{ k8s }} cluster audit logs to {{ cloud-logging-full-name }}.

##### {{ backup-name }} {#backup}

* Added the `yc backup` group commands to manage VM connections to {{ backup-full-name }}, VM backups, and backup policies.

### Version 0.105.0 (15/05/23) {#version0.105.00}

#### Changes to the CLI {#cli}

* Added the `--impersonate-service-account-id` parameter to perform actions on behalf of a service account. This parameter is used to provide the service account ID. The value data type is string.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ cloud-logging-name }} {#cloud-logging}

* Fixed the way the `yc logging read` command runs when the `--follow` flag is set.

##### {{ managed-k8s-name }} {#k8s}

Added the `--container-network-settings` parameter to the `yc k8s node-group create` command to configure a container network of cluster nodes. You can provide the MTU value for pods in this parameter in the `pod-mtu` property.

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added support for {{ KF }} 3.x, starting from 3.3.

### Version 0.104.0 (19/04/23) {#version0.104.00}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ sf-name }} {#serverless-functions}

* Added the `--payload` parameter to the `yc serverless trigger timer create` command to link user data to an event triggered by a timer.

##### {{ cloud-desktop-name }} {#cloud-desktop}

* The `yc cloud-desktop` command group is renamed to `yc desktops`.
* Added the `[PREVIEW]` mark to the `yc desktops` command group.
* Added the `yc desktops desktop restart` command to restart a desktop.

##### {{ compute-name }} {#compute}

* Fixed the listing for large numbers of folder objects for all {{ compute-short-name }} entities.

##### Managed database services {#managed-db}

**{{ mch-name }}**

Added the `yc managed-clickhouse cluster list-external-dictionaries` command to list added external dictionaries.

##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `SINCE` and `FILTER` positional parameters to the `yc logging read` command, e.g.: `yc logging read default 1d "level = INFO"`.
* Added the `MESSAGE` and `JSON-PAYLOAD` positional parameters to the `yc logging write` command, e.g.: `yc logging write default test "{\"key\":\"value\"}"`.

##### {{ sf-name }} {#functions}

* Added the `SINCE` and `FILTER` positional parameters to the `yc serverless function logs` and `yc serverless function version logs` commands, e.g.: `yc serverless function logs default 1d "level = INFO"`.

##### {{ iot-name }} {#iot}

Added the `SINCE` and `FILTER` positional parameters to the `yc iot broker logs` command, e.g.: `yc iot broker logs default 1d "level = INFO"`.

### Version 0.103.0 (15/03/23) {#version0.103.00}



#### Changes to {{ yandex-cloud }} services {#services}

##### {{ api-gw-name }} {#api-gw}

Added the following parameters to the `yc serverless api-gateway create` and `yc serverless api-gateway update` commands:

* `--no-logging`: To disable logging from an API gateway.
* `--log-group-id` and `--log-group-name`: To specify the log group to send the logs to.
* `--log-folder-id` and `--log-folder-name`: To send the logs to the default log group of the specified folder.
* `--min-log-level`: To specify the minimum record logging level.



##### {{ compute-name }} {#compute}

* Added the `yc compute gpu-cluster` command group to manage GPU clusters.
* Added the `--gpu-cluster-id` and `--gpu-cluster-name` parameters to the `yc compute instance create` command to create a virtual machine in a GPU cluster.


### Version 0.102.0 (09/02/23) {#version0.102.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ ig-name }} {#instance-groups}

Fixed the `update` `instance-group` issue when specified via `name`.

##### {{ alb-name }} {#alb}

Added support for command line arguments to search for the `--regex-path-match` and `--regex-fqmn-match` regular expression matches. These are used the same way as `exact` and `prefix`:
* `yc alb virtual-host insert-http-route --regex-path-match my_cool_regex`
* `yc alb virtual-host insert-grpc-route --regex-fqmn-match my_cool_regex`

Added the `--rewrite-request-id` flag, which overwrites the `x-request-id` header with a new value, to the following commands:
* `yc application-load-balancer load-balancer add-listener`
* `yc application-load-balancer load-balancer update-listener`
* `yc application-load-balancer load-balancer add-sni`
* `yc application-load-balancer load-balancer update-sni`


#### Managed database services {#managed-db}

**{{ mpg-name }}**

Added the following parameters to the `yc managed-postgresql user create` and `yc managed-postgresql user update` commands:
* `--statement-timeout`: Allows you to set `statement_timeout` in milliseconds for the specified user.
* `--idle-in-transaction-session-timeout`: Allows you to set `idle_in_transaction_session_timeout` in milliseconds for the specified user.
* `--wal-sender-timeout`: Allows you to set `wal_sender_timeout` in milliseconds for the specified user.

### Version 0.101.0 (16/01/23) {#version0.101.0}



#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#managed-kubernetes}

Added the `--master-logging` parameter with the following properties to the `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update` commands to configure logging:

* `enabled`: Flag to send the logs to {{ cloud-logging-name }}.
* `log-group-id`: ID of the [log group](../logging/concepts/log-group.md) to send the logs to.
* `folder-id`: ID of the folder to send the logs to. The logs will be sent to the log group of the default folder.
* `kube-apiserver-enabled`: Flag to send the `kube-apiserver` logs to {{ cloud-logging-name }}.
* `cluster-autoscaler-enabled`: Flag to send the `cluster-autoscaler` logs to {{ cloud-logging-name }}.
* `events-enabled`: Flag to send the {{ k8s }} events to {{ cloud-logging-name }}.

If log sending is enabled but neither `log-group-id` nor `folder-id` is specified, the logs will be sent to the default log group in the cluster folder. You cannot specify both `log-group-id` and `folder-id` at the same time.

##### {{ network-load-balancer-name }} {#network-load-balancer}

Added the `--deletion-protection` flag to the `yc load-balancer network-load-balancer create` and `yc load-balancer network-load-balancer update` commands to protect the load balancer from accidental deletion.



##### {{ serverless-containers-name }} {#serverless-containers}

Added the following parameters to the `yc serverless container revision deploy` command:

* `--no-logging`: Flag to disable logging from a container.
* `--log-group-id` and `--log-group-name`: ID or name of the [log group](../logging/concepts/log-group.md) to send the logs to.
* `--log-folder-id` and `--log-folder-name`: ID or name of the folder to send the logs to. The logs will be sent to the log group of the default folder.
* `--min-log-level`: Minimum logging level.



##### {{ vpc-name }} {#vpc}

Added the `--deletion-protection` flag to the `yc vpc address create` and `yc vpc address update` commands to protect the static public IP address from accidental deletion.


### Version 0.100.0 (27/12/22) {#version0.100.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ compute-name }} {#compute}

* You can now edit the placement rules for hosts in the `yc compute instance update` command.



##### {{ serverless-containers-name }} {#serverless-containers}

Added the following flags to the `yc serverless container revision deploy` command:
* `--zone-instances-limit`: Maximum number of container instances per availability zone.
* `--zone-requests-limit`: Maximum number of simultaneous container invocations per availability zone.



##### Managed database services {#managed-db}

**{{ mgp-name }}**

* Added the `yc managed-greenplum cluster restore` command to restore a cluster from a backup.
* Added the `yc managed-greenplum cluster list-backups` command to view cluster backups.
* Added the `--assign-public-ip` flag to the `yc managed-greenplum update` command to assign or revoke a cluster's public IP address.


### Version 0.99.0 (01/12/22) {#version0.99.0}

#### Changes to the CLI {#cli}

**{{ objstorage-name }}**

* Added support for {{ objstorage-name }} (control plane). List of features:
  * Creating buckets with an option to specify the storage class, maximum bucket size, and ACL.
  * Updating bucket settings: `ACL`, `policy`, `website settings`, `CORS`, `anonymous access flags`, `lifecycle settings`, `maximum bucket size`, and `storage class`.
  * Deleting a bucket.
  * Linking/unlinking an HTTPS certificate for a bucket.

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ alb-name }} {#alb}

* Added the `yc application-load-balancer load-balancer logging` command to customize load balancer logs. Command parameters:
  * `--log-group-id`, `--log-group-name`: To set a {{ cloud-logging-name }} log group.
  * `--enable` and `--disable`: To enable and disable load balancer logging to a {{ cloud-logging-name }} log group.
  * `--discard`: To set up discard rules for some logs based on HTTP or gRPC codes.


##### Managed database services {#managed-db}


**{{ mes-name }}**

* In the `{{ yc-mdb-es }} cluster restore` command with the `--folder-id` flag, you can provide a folder for cluster recovery.

**{{ mmg-name }}**

* In the `{{ yc-mdb-mg }} cluster restore` command with the `--folder-id` flag, you can provide a folder for cluster recovery.


**{{ mmy-name }}**

* In the `{{ yc-mdb-my }} cluster restore` command with the `--folder-id` flag, you can provide a folder for cluster recovery.


**{{ mrd-name }}**

* In the `{{ yc-mdb-rd }} cluster restore` command with the `--folder-id` flag, you can provide a folder for cluster recovery.


**{{ mms-name }}**

* In the `{{ yc-mdb-ms }} cluster restore` command with the `--folder-id` flag, you can provide a folder for cluster recovery.




##### {{ sf-name }} {#serverless-functions}

Added the following parameters to the `yc serverless function version create` command:
* `--no-logging`: Disables logging for a function.
* `--log-group-id` and `--log-group-name`: Sends the logs to the specified log group.
* `--log-folder-id` and `--log-folder-name`: Sends the logs to the default log group of the specified folder.
* `--min-log-level`: Sets minimum record logging level.


### Version 0.98.0 (09/11/22) {#version0.98.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added the `yc managed-kafka connector-s3-sink` group commands that enable you to manage S3 Sink connectors, namely to create and update them.

* Added the `sasl-enabled-mechanisms` parameter to the `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands to set and change the configuration of Kafka brokers.

* Fixed the bug with altering of the `properties` field of connectors.

**{{ mpg-name }}**

* Added the `15` value for the `--postgresql-version string` flag to the `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore` commands. It enables you to create a {{ PG }} cluster version 15.

* For the `yc managed-postgresql cluster create` command, changed the default value for the version of the new {{ PG }} cluster. The new default value is `15`.

* Added the ability to restore a {{ PG }} cluster to a specified folder to the `yc managed-postgresql cluster restore` command.

### Version 0.97.0 (10/10/22) {#version0.97.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ api-gw-name }} {#api-gw}

* The `domainId` parameter of the `add-domain` command is no longer supported.


#### Managed database services {#managed-db}


**{{ mgp-name }}**

* Added the `yc managed-greenplum cluster expand` command, which allows you to expand the existing {{ mgp-name }} cluster. Command parameters:

  * `--segment-host-count`: Number of hosts added to a cluster.
  * `--add-segments-per-host-count`: Number of segments added per cluster host.
  * `--duration-seconds`: Maximum duration of a data distribution session in seconds.


**{{ mkf-name }}**

* {{ KF }} 2.1 and 2.6 are no longer supported.

### Version 0.96.0 (19/09/22) {#version0.96.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ alb-name }} {#alb}

* Added the `yc application-load-balancer load-balancer autoscale` command to manage the number of load balancer resource units.
  The command includes the following parameters:
  * `--min-zone-size`: Minimum number of resource units in a single zone.
  * `--max-size`: Maximum total number of resource units in all zones.

* Added the following flags to the `yc alb load-balancer create` command:
  * `--log-group-id`, `--log-group-name`: To set a {{ cloud-logging-name }} log group.
  * `--disable-logging`: To create a load balancer without logging to a {{ cloud-logging-name }} log group.

* Added the following flags to the `yc alb load-balancer update` command:
  * `--log-group-id`, `--log-group-name`: To set a {{ cloud-logging-name }} log group.
  * `--enable-logging` and `--disable-logging`: To enable and disable load balancer logging to a {{ cloud-logging-name }} log group.

##### {{ compute-name }} {#compute}

* Added the `yc compute snapshot-schedule` command group to manage scheduled disk snapshots.
* Added the `--metadata-options` flag to the `yc compute instance create` command to manage VM metadata access.

###### {{ dns-name }} {#dns}

* The `yc dns zone list-records` command now offers filtering by record name and type using the `--record-name` and `--record-type` parameters.


##### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore` commands: Added the `11-1c`, `12-1c`, `13-1c`, and `14-1c` values for the `--postgresql-version string` flag to create a {{ PG }} cluster of versions 11-1c, 12-1c, 13-1c, and 14-1c.


##### {{ iot-name }} {#iot}

* Added the `yc compute gpu-cluster` command group to manage an MQTT broker.

##### {{ sf-name }} {#serverless-functions}

Added the following commands:

* `yc serverless trigger create iot-broker`: To create triggers for MQTT brokers.
* `yc serverless trigger create iot-broker`: To create triggers for email.

Added the `--secret` parameter to the `yc serverless function version create` command to add [secrets](../lockbox/) to a version.

##### {{ serverless-containers-name }} {#serverless-containers}

Added the following flags to the `yc serverless container revision deploy` command:
* `--secret`: To add secrets to a revision.
* `--min-instances`: To specify the minimum number of prepared container instances.


### Version 0.95.0 (02/09/22) {#version0.95.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ api-gw-name }} {#api-gw}

* Added the following parameters to the `yc serverless api-gateway add-domain` command:

  * `--domain`: To specify the FQDN of a [domain](../certificate-manager/concepts/domains/index.md) from {{ certificate-manager-name }} you are connecting.
  * `--certificate-id`: To specify the ID of a certificate from {{ certificate-manager-name }}.

  The `--domain-id` parameter is considered obsolete. Use the `--domain` and `--certificate-id` parameters instead.

* Added the following `yc serverless api-gateway websocket` command group to manage WebSocket connections:

  * `yc serverless api-gateway websocket get`: Getting information about a connection.
  * `yc serverless api-gateway websocket send`: Sending data in a connection.
  * `yc serverless api-gateway websocket disconnect`: Connection break.



##### {{ certificate-manager-name }} {#certificate-manager}

* Added the `--key-format` parameter to the `yc certificate-manager certificate content` command to select the private key format: `PKCS1` or `PKCS8`.

##### {{ compute-name }} {#compute}

* Added the `--os-type` parameter to the `yc compute image create` command to specify the OS type for the new image: `linux` or `windows`.

##### {{ dns-name }} {#dns}

* The `yc dns zone add-records`, `yc dns zone update-records`, `yc dns zone delete-records` and `yc dns zone replace-records` commands now return a list of completed changes.

##### {{ iam-name }} {#iam}

* Fixed an error in the `yc iam federation` command group which occurred when providing the name of a SAML-compatible federation as a positional argument.



##### {{ iot-name }} {#iot}

* The `yc iot registry logs` and `yc iot device logs` commands now return logs from {{ cloud-logging-name }}. Added the following parameters to the commands:

  * `--levels`: To search for records with the specified logging levels.
  * `--filter`: To filter records.

  For more information about the possible values of the new parameters, see [{#T}](../logging/concepts/filter.md).


##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added support for {{ KF }} 3.0, 3.1, and 3.2.


**{{ mrd-name }}**

* {{ RD }} 5.0 and 6.0 are no longer supported.




##### {{ org-name }} {#organization}

* Added the `--organization-id` parameter to the `yc organization-manager federation saml` group commands to specify the organization ID. Fixed an error that occurred in these commands when specifying the name of a SAML-compatible identity federation as a positional argument.
* Added the `yc organization-manager group` command group to manage [user groups](../organization/operations/manage-groups.md).


### Version 0.94.0 (16/08/22) {#version0.94.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `--stream-name` parameter to the `yc logging read` and `yc logging write` commands.


##### Managed database services {#managed-db}


**{{ mgp-name }}**

* Added support for the commands:

  * `yc managed-greenplum cluster update`: Allows updating the settings of existing clusters.
  * `yc managed-greenplum cluster update-config`: Allows updating the configuration parameters of existing clusters.




**{{ mrd-name }}**

* Added the following flags to the `yc managed-redis cluster create`, `yc managed-redis cluster restore`,
  `yc managed-redis hosts add`, `yc managed-redis hosts update`, and `yc managed-redis shards add` commands:

  * `--assign-public-ip=true|false`: Links or deletes a host's public IP address.
  * `--replica-priority=50`: Sets the replica priority (for non-sharded clusters only).


**{{ mch-name }}**

* Added the following flags to the `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster update` commands:

  * `--cloud-storage-move-factor`: To specify the free space percentage on the local disk to initiate data transmission to {{ objstorage-name }}.
  * `--cloud-storage-data-cache`: To allow the use of local cache for {{ objstorage-name }}.
  * `--cloud-storage-data-cache-max-size`: To specify the maximum size of local cache for {{ objstorage-name }}.

**{{ mkf-name }}**

* Added the `yc managed-kafka connector` command group allowing you to manage connectors using the `get`, `list`, `delete`, `pause`, and `resume` commands.
* Added the `yc managed-kafka connector-mirrormaker` command group allowing you to manage the MirrorMaker type connectors using the `create` and `update` commands.
* Added these parameters to the `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands to specify and modify broker host configuration settings:
  - `message-max-bytes`
  - `replica-fetch-max-bytes`
  - `offsets-retention-minutes`
  - `ssl-cipher-suites`


##### {{ vpc-name }} {#vpc}

* Added the `yc vpc gateway` command group to manage routing gateways.
* Added the ability to specify a gateway as a route destination to the `yc vpc route-table` group commands.


### Version 0.93.0 (19/07/22) {#version0.93.0}

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

* `yc managed-postgresql database create`, `yc managed-postgresql database list`, and `yc managed-postgresql database get` commands.

  Added support for templates when creating a database using `--template-db string`.


**{{ mmg-name }}**

* When creating a new cluster, MongoDB version 5.0 is selected by default.



##### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update` commands:

  * Added the `--node-name` flag, which allows you to specify the naming pattern for nodes in a group.

  * Added the `--template-labels` and `--template-labels-from-files` flags that allow you to specify [{{ yandex-cloud }} resource labels](../resource-manager/concepts/labels.md) for group node VMs (not to be confused with [{{ k8s }} node labels](../managed-kubernetes/concepts/index.md#node-labels)).



##### {{ serverless-containers-name }} {#serverless-containers}

* Added the `--network-id` and `--network-name` flags to the `yc serverless container revision deploy` command to specify the network the container revision will use. Also added the `--subnets` flag to the command to get a detailed list of subnets.


### Version 0.92.0 (05/07/22) {#version0.92.0}

#### Changes to the CLI {#cli}

* Fixed the `yc` run error when transmitting large numbers of arguments.

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ certificate-manager-name }} {#certificate-manager}

* Added the `--deletion-protection` flag to the `yc certificate-manager certificate create` command to enable certificate deletion protection.

* Added the `--deletion-protection` flag to the `yc certificate-manager certificate request` command to enable certificate deletion protection.

* Added the `--deletion-protection` and `--no-deletion-protection` flags to the `yc certificate-manager certificate update` command to enable/disable certificate deletion protection.



##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the `--client-output-buffer-limit-normal` and `--client-output-buffer-limit-pubsub` flags to the `yc managed-redis cluster` command group for `create`, `restore`, `update` (see redis.conf for a description). 

**{{ mgp-name }}**

Added commands for {{ mgp-name }} primary support:
* The `yc managed-greenplum cluster` command group allows managing clusters.
* The `yc managed-greenplum cluster` command group allows managing hosts.


**{{ mms-name }}**

* Added the `yc managed-sqlserver hosts update <HOST> --assign-public-ip=true|false` command which assigns or deletes a host's public IP address.




### Version 0.91.0 (12/05/22) {#version0.91.0}



#### Changes to {{ yandex-cloud }} services {#services}


##### {{ alb-name }} {#alb}

* Fixed the `--name` parameter processing error in the `yc alb lb add-location` and `yc alb lb target-states` commands. Now the parameter allows you to search for a load balancer by name correctly.

##### {{ cloud-desktop-name }} {#cloud-desktop}

* Added the `yc cloud-desktop group` command group to manage desktop groups.
* Added the `yc cloud-desktop desktop` command group to manage desktops.

##### {{ sf-name }} {#functions}

* Added the `--max-response-size` parameter to the `yc serverless function logs` and `yc serverless function version logs` commands to limit the size of incoming logs.

##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `--max-response-size` parameter to the `yc logging read` command to limit the size of incoming logs.

##### {{ dns-name }} {#dns}

* Added the `yc dns bind-file migrate-to-terraform` command that generates a specification for {{ TF }} from the BIND file and prints it to standard output.

##### {{ serverless-containers-name }} {#serverless-containers}

* Added the `yc serverless containers rollback` command that rolls a container back to the specified revision.

##### {{ ydb-name }} {#ydb}

* Added the `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding` commands to the `yc ydb database` command group to set and view a list of DB roles.
* Added the `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding` commands to the `yc ydb backup` command group to set and view a list of roles for DB backups.


##### Managed database services {#managed-db}

**{{ mes-name }}**

* Added the `yc managed-elasticsearch extension` command group to manage user extensions for clusters.

**{{ mmy-name }}**

* Added the `--host-group-ids` parameter to the `yc managed-mysql cluster create` command listing the hosts to host a cluster on dedicated servers.
* Added the following to the `yc managed-mysql cluster restore` command:

  * The `--host-group-ids` parameter listing the hosts to host a cluster on dedicated servers.
  * The `--deletion-protection` flag that allows restoring a cluster with deletion protection enabled directly.

**{{ mpg-name }}**

* Added the `--host-group-ids` parameter to the `yc managed-postgresql cluster create` command listing the hosts to host a cluster on dedicated servers.
* Added the following parameters to the `yc managed-postgresql cluster restore` command:

  * `--host-group-ids` to provide a list of hosts on dedicated servers to allocate to a cluster.
  * The `--deletion-protection` flag that allows restoring a cluster with deletion protection enabled directly.


**{{ mms-name }}**

* Added the `--service-account-id` parameter to the `yc managed-sqlserver create` and `yc managed-sqlserver update` commands to assign a service account to {{ MS }} cluster hosts.
* Added the `yc managed-sqlserver database backup-export` and `yc managed-sqlserver database backup-import` commands to export and import DB backups to/from custom storage.
* Added the `yc managed-sqlserver cluster start-failover` command to manually change the master in a cluster.


**{{ mkf-name }}**

* Added the `--assign-public-ip` flag to the `yc managed-kafka cluster update` command to manage public access to brokers.

### Version 0.90.0 (13/04/22) {#version0.90.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ dataproc-name }} {#dataproc}

* Added the `--initialization-action` flag to the `yc dataproc cluster create` command to specify the initialization script for the cluster.

##### {{ compute-name }} {#compute}

* Added the `--attach-local-disk` flag to the `yc compute instance create` command to create an instance with a local disk attached to it.

##### {{ alb-name }} {#alb}

* Added the `--enable-proxy-protocol` flag to the `yc alb backend-group add-stream-backend` and `yc alb backend-group update-stream-backend` commands to enable a proxy protocol for a backend.

##### {{ dns-name }} {#dns}

* Added the `--clear-network-ids` flag to the `yc dns zone update` command to delete a list of virtual networks that show internal DNS zone records.


##### Managed database services {#managed-db}

**{{ mch-name }}**

* Added the `--folder-id` flag to the `yc managed-clickhouse cluster restore` command to specify the folder to create the restored cluster in.

* Added the following flags to the `yc managed-clickhouse cluster update` command:


  * `--yandexquery-access`: To enable cluster access from {{ yq-full-name }}.


**{{ mmy-name }}**


* Added the `--performance-diagnostics` flag to the `yc managed-mysql cluster update` command to manage the settings of the performance diagnostic service.


### Version 0.89.0 (23/03/22) {#version0.89.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ compute-name }} {#compute}

* Added the `yc compute filesystem resize` command to resize a file storage.
* Added the `--preemptible` flag to the `yc compute instance update` command to turn a regular VM into a preemptible one and vice versa.

##### {{ sf-name }} {#functions}

* The `yc serverless function logs` and `yc serverless function version logs` commands now return logs from {{ cloud-logging-name }}. Added the following parameters to the commands:

  * `--levels`: To search for records with the specified logging levels.
  * `--filter`: To filter records.

  For more information about the possible values of the new parameters, see [{#T}](../logging/concepts/filter.md).


##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the `--persistence-mode` parameter for selecting the persistence level of a {{ RD }} cluster to the following commands:

  * `yc managed-redis cluster create`
  * `yc managed-redis cluster restore`
  * `yc managed-redis cluster update`

  The last command also got the `--force` flag required when disabling cluster persistence.

**{{ mch-name }}**

* Added the `yc managed-clickhouse hosts update` command to edit {{ CH }} cluster hosts. The command has the `--assign-public-ip` parameter to manage public access to the host: `true` means the host can be reached via a public IP address, and `false` means public access is disabled.
* Added the `--datatransfer-access` and `--yandexquery-access` flags to the `yc managed-clickhouse cluster create` command to manage cluster host access from {{ data-transfer-name }} and {{ yq-full-name }}, respectively.
* The `--backup-id` parameter of the `yc managed-clickhouse cluster restore` command now accepts a list of values to restore a sharded cluster.

**{{ mmy-name }}**

* Added the `PRIORITY` column to the `yc managed-postgresql cluster restore` command output.
* Added the `--priority` parameter to the `yc managed-mysql hosts update` command to change a host's priority when switching a master.

### Version 0.88.0 (16/02/22) {#version0.88.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ data-transfer-name }}

* Added the following `list` commands for `endpoint` and `transfer`:

  * `yc datatransfer endpoint list`
  * `yc datatransfer transfer list`

* Added the following commands for updating `endpoint` and `transfer`:

  * `yc datatransfer endpoint update postgres-source`
  * `yc datatransfer endpoint update postgres-target`
  * `yc datatransfer endpoint update mysql-source`
  * `yc datatransfer endpoint update mysql-target`
  * `yc datatransfer transfer update`


##### {{ cdn-name }} {#cdn}

* Added the ability to purge a resource cache: `yc cdn cache purge --all`.
* Fixed resource creation when the source is a bucket or balancer.

##### {{ api-gw-name }} {#api-gw}

* Added the `--network-id` and `--network-name` flags to the `yc serverless api-gateway create` and `yc serverless api-gateway update` commands to specify the API gateway network as well as the `--subnet-id` and `--subnet-name` flags for a detailed subnet list.

##### {{ compute-name }} {#compute}

* Added the `yc compute disk move` and `yc compute instance move` commands to move disks and instances between folders.

##### Managed database services {#managed-db}

**{{ mms-name }}**

* Added the `confirm-payment` flag to the `yc managed-sqlserver update` and `yc managed-sqlserver start` commands to confirm acceptance of license charges.


### Version 0.87.0 (18/01/22) {#version0.87.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ dataproc-name }} {#dataproc}

* Added the command: `yc dataproc job cancel <JOB-ID>|<JOB-NAME>`.

  Now you can cancel unfinished jobs.


##### Managed database services {#managed-db}

**{{ mes-name }}**

* Added information about the current maintenance window and the scheduled maintenance operation to the cluster information.
* Added the `--maintenance-window-anytime` and `--maintenance-window-weekly` flags to the `yc managed-elasticsearch cluster update` command to specify the maintenance window parameters.
* Added the `yc managed-elasticsearch cluster reschedule-maintenance` command to manage a scheduled cluster maintenance task.
* Added the `yc managed-elasticsearch cluster backup` command to take a cluster snapshot.
* Added the `yc managed-elasticsearch cluster restore` command to restore a cluster from a backup.
* Added the `yc managed-elasticsearch cluster list-backups` command to view the cluster's backups.
* Added the `yc managed-elasticsearch backup list` command to view the backups of all clusters in the folder.
* Added the `yc managed-elasticsearch backup get` command to view information about a specific backup.
* Added the `--host-group-ids` flag to the `yc managed-sqlserver cluster create` and `yc managed-sqlserver cluster restore` commands listing the hosts to host a cluster on dedicated servers.
* Added the `--deletion-protection` flag to the `yc managed-sqlserver cluster restore` command to set up protection against accidental cluster deletion.

### Version 0.86.0 (15/12/21) {#version0.86.0}


#### Changes to the CLI {#cli}

* Added the ability to transfer an [IAM token](../iam/concepts/authorization/iam-token.md) via the `YC_IAM_TOKEN` environment variable.


#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* Added the `--maintenance-window` parameter to the `yc managed-kafka cluster update` command to set maintenance window parameters.
* Added the `yc managed-kafka cluster reschedule-maintenance` command, which allows you to change the start time of a scheduled cluster maintenance task.


##### {{ alb-name }} {#alb}

* Added the `private-ip-address` key for the `--target` parameter in the `yc application-load-balancer target-group {add,update,remove}-targets` commands allowing you not to specify subnet IDs for addresses from private ranges.
* Added commands to manage TCP handlers of L7 load balancers:
  * `yc alb load-balancer add-stream-listener`
  * `yc alb load-balancer update-stream-listener`
  * `yc alb load-balancer add-stream-sni`
  * `yc alb load-balancer update-stream-sni`
* Added synonyms (aliases) of commands to manage L7 load balancer handlers:
  * `yc alb load-balancer add-listener`: `add-http-listener`
  * `yc alb load-balancer update-listener`: `update-http-listener`
  * `yc alb load-balancer add-sni`: `add-http-sni`
  * `yc alb load-balancer update-sni`: `update-http-sni`
  * `yc alb load-balancer remove-listener`: `remove-http-listener`, `remove-stream-listener`
  * `yc alb load-balancer remove-sni`: `remove-http-sni`, `remove-stream-sni`

##### {{ cdn-name }} {#cdn}

* Added commands to manage {{ cdn-name }} resources:
  * `yc cdn resource create`
  * `yc cdn resource update`

##### {{ cloud-logging-name }} {#cloud-logging}

* Added the `--data-stream` parameter to the `yc logging group {create,update}` commands to support {{ yds-full-name }}.

##### {{ vpc-name }} {#vpc}

* Added the `yc vpc subnet add-range` and `remove-range` commands to add or delete address ranges in subnets.

##### {{ ydb-name }} {#ydb}

* The `yc ydb database create` command now has the `--labels` parameter, which specifies a set of DB labels.
* The `yc ydb database update` command now has the `--labels` parameter, which changes the entire set of DB labels.
* Added the `yc ydb database add-labels` and `yc ydb database remove-labels` label management commands.


### Version 0.85.0 (29/11/21) {#version0.85.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### Managed database services {#managed-db}

**{{ mkf-name }}**

* `yc managed-kafka cluster update` command.

  Added the `--version` flag allowing you to update the {{ KF }} cluster version.


##### {{ managed-k8s-name }} {#k8s}

* `yc k8s cluster update` command.

  Added the `--node-ipv4-mask-size` parameter that calculates the size of `CIDR` allocated to each cluster node.

##### {{ alb-name }} {#alb}

* Added commands for operating Stream backends:
  * Adding a Stream backend: `yc application-load-balancer backend-group add-stream-backend`.
  * Updating a Stream backend: `yc application-load-balancer backend-group update-stream-backend`.
  * Deleting a Stream backend: `yc application-load-balancer backend-group delete-stream-backend`.

##### {{ resmgr-name }} {#resmgr}

* Added the `yc resource-manager folder delete` command, which allows you to delete a folder.


#### Changes to the CLI {#cli}

Fixed an error in the `yc init` command. Now, when checking the availability of endpoints, proxy settings are not ignored.

### Version 0.84.0 (16/11/21) {#version0.84.0}

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

* Added the `BACKUP PRIORITY` column to the `yc managed-mysql hosts list` command output.

**{{ mch-name }}**

Added the following new flags to the `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster restore` commands:
* `--embedded-keeper`: Allows you to create a cluster using {{ CH }} instead of {{ ZK }}.


##### {{ dataproc-name }} {#dataproc}

* `yc dataproc cluster create` command, `--subcluster` flag.

  Added the `assign-public-ip` parameter, which allows you to allocate public IP addresses to all the subcluster hosts.


### Version 0.83.0 (26/10/21) {#version0.83.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ cdn-name }} {#cdn}

* Added command groups to support the {{ cdn-full-name }} service that allows you to enable content delivery to end users over the Content Delivery Network (CDN):
  * `yc cdn origin`: To manage origins.
  * `yc cdn origin-group`: To manage origin groups.
  * `yc cdn provider`: To connect to a CDN provider.
  * `yc cdn cache`: To manage caching of CDN resource content.

##### {{ alb-name }} {#alb}

* Added the `yc application-load-balancer load-balancer start` and `yc application-load-balancer load-balancer stop` commands to run and stop an L7 load balancer.

##### {{ ydb-name }} {#ydb}

* Added the `yc ydb database start` and `yc ydb database stop` commands to run and stop a DB.


##### Managed database services {#managed-db}

**{{ mrd-name }}**

* Added the `--hostnames` parameter to the `yc managed-redis cluster start-failover` command to specify the cluster hosts to switch the master from. You can use this parameter with sharded clusters as well.

**{{ mkf-name }}**

* Added the `yc managed-kafka cluster list-logs` command to get a cluster log.

**{{ mmy-name }}**

* Added the following parameters to the `yc managed-mysql hosts update` command:
  * `--assign-public-ip`: To manage public access to the host: `true` means the host can be reached via a public IP address, and `false` means public access is disabled.
  * `--backup-priority`: To change the host priority when creating cluster backups.

**{{ mpg-name }}**

* The `yc managed-postgresql hosts update` command now has the `--assign-public-ip` parameter to manage public access to the host: `true` means the host can be reached via a public IP address, and `false` means public access is disabled.

### Version 0.82.0 (23/09/21) {#version0.82.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ compute-name }} {#compute}

* Added the `--pooled` flag to the `yc compute image create` command to create a deployment-optimized image.
* Added the `yc compute gpu-cluster` command group to manage file storages.
* Added new commands to attach and detach file storages to/from VMs: `yc compute instance attach-filesystem` and `yc compute instance detach-filesystem`.
* Added the `--attach-filesystem` parameter to the `yc compute instance create` command to create a VM with an attached file storage.

##### {{ managed-k8s-name }} {#k8s}

* The `yc k8s node-group update` command now has the `--node-labels` parameter, which changes the entire set of labels for the nodes in the group.
* Added the `yc k8s node-group add-node-labels` command to add labels to nodes in the group.
* Added the `yc k8s node-group remove-node-labels` command to remove labels from nodes in the group.

##### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create yds` command to create triggers for {{ yds-name }}.

##### {{ serverless-containers-name }} {#serverless-containers}

* Added the `yc serverless containers` command group to support {{ serverless-containers-full-name }}, which allows you to run containers without using {{ k8s }} or deploying VMs.

##### {{ vpc-name }} {#vpc}

* Added the `yc vpc network list-route-tables` command to list routing tables in the network.
* Added the `yc vpc network list-security-groups` command to list security groups in the network.

#### {{ dataproc-name }} {#dataproc}

* Added the `--log-group-id` parameter to the `yc dataproc cluster create` and `yc dataproc cluster update` commands to link a {{ cloud-logging-name }} log group to a cluster. To stop sending cluster logs to {{ cloud-logging-name }}, specify an empty value as the log group ID: `--log-group-id=""`.

##### {{ ydb-name }} {#ydb}

* Added the following parameters to manage DB limits in Serverless mode to the `yc ydb database create` and `yc ydb database update` commands:
  * `--sls-storage-size`
  * `--sls-throttling-rcu`
  * `--sls-enable-throttling-rcu`
  * `--sls-provisioned-rcu`


##### {{ mrd-name }}

* The default value of the `--redis-version` parameter in the `yc managed-redis cluster create` command is changed to 6.2.

##### {{ mmy-name }}

* Enabled the display of the `replication source` setting in the `yc managed-mysql hosts list` command.

##### {{ mpg-name }}

* Enabled the display of the `replication source` setting in the `yc managed-postgresql hosts list` command.

##### {{ data-transfer-name }}

* Added the `yc datatransfer endpoint` and `yc datatransfer transfer` command groups to manage endpoints and transfers for {{ data-transfer-full-name }}.

### Version 0.81.0 (06/09/21) {#version0.81.0}

#### Changes to the CLI {#cli}

* Added a description of flags and commands in auto-completion by default.
* `yc completion <SHELL>` command.

  Added the `--without-desc` flag to disable descriptions in autocompletion.
* Autocompletion is supported for the following flags: `folder-id`, `folder-name`, `cloud-id`, `format`, and `profile`.

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create billing-budget` command to create triggers for {{ billing-name }} events.
* Added commands to control connections to managed databases:
  * `yc serverless mdbproxy update clickhouse`
  * `yc serverless mdbproxy create clickhouse`

##### {{ cloud-logging-name }} {#logging}

* Excluded the `get-default` subcommand from `logging group`.


### Version 0.80.0 (19/08/21) {#version0.80.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ ig-name }} {#instance-groups}

* Added the following new flags for the VM group update command (`yc compute instance-group update`):
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

* Added the `yc serverless trigger create logging` command to create triggers on {{ cloud-logging-name }}.

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

* `yc <managed DB service name> cluster create` and `yc <managed DB service name> cluster update` commands

  The `--deletion-protection` flag allows you to enable protection against accidental cluster deletion. To disable cluster deletion protection, specify `--deletion-protection=false`.

**{{ mmg-name }}**

* Added the `{{ yc-mdb-mg }} hosts stepdown` command.

  It switches the selected master to replica mode so that the available replica becomes the master host.
* `{{ yc-mdb-mg }} cluster get` and `{{ yc-mdb-mg }} cluster update` commands.

  Added the `backup-retain-period-days` field representing the number of days to retain automatic backups.

**{{ mrd-name }}**

* Added support for {{ RD }} version 6.2.

**{{ mmy-name }}**

* `yc managed-mysql hosts update` command.

  Added the `yc managed-mysql hosts update HOST --replication-source HOST` command to set the replication source for a cascading replica.


**{{ mms-name }}**

* Added the `yc managed-sqlserver database restore` command.

  It allows you to restore the specified database on an existing cluster from a backup. You can restore it under a different name.


**{{ mkf-name }}**

* Added support for {{ KF }} 2.8.


##### {{ dataproc-name }} {#dataproc}

* `yc dataproc cluster create` and `yc dataproc cluster update` commands.

  The `--deletion-protection` flag allows you to enable/disable cluster protection against accidental deletion.

  To disable cluster deletion protection, specify `--deletion-protection=false`.

##### {{ resmgr-name }} {#resmgr}

* `yc resource-manager cloud list` command.

  Added the display of an organization linked to a cloud.

##### {{ org-name }} {#organization}

Added support for {{ org-full-name }}.

{{ org-name }} is an enterprise solution that you can use to connect your organization to {{ yandex-cloud }} services and manage employee access to these services.

{{ org-name }} is at the [Preview stage](../overview/concepts/launch-stages.md). Read more about the service in the [documentation](../organization/).

##### {{ sf-name }} {#serverless-functions}

* `yc serverless trigger create` command.

  The `--invoke-container-name`, `--invoke-container-id`, and `--invoke-container-path` flags allow you to specify a {{ serverless-containers-name }} container for a trigger.


### Version 0.79.0 (13/07/21) {#version0.79.0}

#### Changes in {{ yandex-cloud }} services


#### {{ cloud-logging-name }} {#logging}

Added support for {{ cloud-logging-full-name }}.

{{ cloud-logging-name }} is a service for reading and recording service logs and user applications.

{{ cloud-logging-name }} is at the [Preview](../overview/concepts/launch-stages.md) stage. If you want to learn more about the service, see [our relevant documentation](../logging/).

#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless function set-scaling-policy` command to specify the function scaling settings.
* Added the `yc serverless function list-scaling-policies` command to view the function scaling settings.
* Added the `yc serverless function remove-scaling-policy` command to delete the function scaling settings.
* `yc serverless function version create` command.

  Fixed directory processing for the `--source-path` flag on Windows.


#### Managed database services {#managed-db}

**{{ mch-name }}**

* `yc managed-clickhouse cluster update` command.

  Added the `--cloud-storage` flag to enable data storage in {{ objstorage-name }}.

### Version 0.78.0 (29/06/21) {#version0.78.0}



#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update` commands.

  Added the `--network-acceleration-type` flag, which allows you to specify a network type for a node group: standard or software-accelerated.

* `yc managed-kubernetes cluster create` command.

  Added the `--cilium` flag to create a cluster that supports tunnel mode and uses Cilium CNI.

#### {{ dataproc-name }} {#dataproc}

* `yc dataproc job create-<JOB-TYPE>` command.

  Now, after starting a job, its execution log is displayed in the terminal.


### Version 0.77.0 (07/06/21) {#version0.77.0}


**{{ compute-name }}**

* `yc compute instance` command.

  Added the `dns-record-spec` and `ipv6-dns-record-spec` keys to `network_interface`.

**{{ api-gw-name }}**

* Added the `yc serverless api-gateway add-domain` command to add a domain to an API gateway.
* Added the `yc serverless api-gateway remove-domain` command to remove a domain from an API gateway.


#### Managed database services {#managed-db}

**{{ mes-name }}**

* `yc managed-elasticsearch cluster list-logs` command.

  Added the `--service-type` flag to generate Kibana logs.

* `yc managed-elasticsearch cluster create` and `yc managed-elasticsearch cluster update` commands.

  Added the `--service-account` flag.

**{{ mkf-name }}**

* `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands.

  Added the `--num-partitions` and `--default-replication-factor` flags to set and edit configuration settings of {{ KF }} brokers.

**{{ mrd-name }}**

* `yc managed-redis cluster create\update` commands.

  Added the `--slowlog-log-slower-than`, `--slowlog-max-len`, `--databases`, and `--notify-keyspace-events` flags (see redis.conf for a description).

### Version 0.76.0 (19/05/21) {#version0.76.0}

**{{ mpg-name }}**

* `yc managed-postgresql cluster update` command.

  Added the `--serverless-access` flag for accessing {{ mpg-full-name }} cluster hosts from {{ sf-full-name }}.


**{{ vpc-name }}**

* Added the `yc vpc address move` command to move an address between cloud folders.

**{{ compute-name }}**

* `yc compute instance-group` command.

  Instance groups can now return the group status.


### Version 0.75.0 (13/04/21) {#version0.75.0}

#### Changes in {{ yandex-cloud }} services


#### {{ compute-name }} {#compute}

* `yc compute create-with-container` command.

  Added the `--gpus` flag, which allows you to create a {{ coi }} with a GPU.


#### Managed database services {#managed-db}

**{{ mrd-name }}**

* `yc managed-redis cluster create` command.

  Added the `--disk-type-id [local-ssd|network-ssd]` key you can use to set the disk type.

**{{ mmy-name }}**

* `yc managed-mysql cluster list-logs` command.

  Logs are now printed as-is by default. To enable the previous log format, use the `--format=yaml` flag.

**{{ mes-name }}**

* `yc managed-elasticsearch cluster create` and `yc managed-elasticsearch cluster update` commands.

  Added flags for cluster administrator password management (`admin` user):
  * `--admin-password`: Allows you to set a password manually.
  * `--generate-admin-password`: Allows you to generate a password automatically.
  * `--read-admin-password`: Allows you to set a password from a file.
* Deleted the `yc serverless trigger create cloud-logs` commands. You can now perform user management using native {{ ES }} tools as the `admin` user.
* `yc managed-elasticsearch create` command.

  Added the `--edition [basic|gold|platinum]` flag, which allows you to specify the {{ ES }} edition when creating a cluster.

**{{ mkf-name }}**

* `yc managed-kafka cluster create` command.

  Added the `--host-group-ids` flag that controls cluster hosting on dedicated servers.


#### {{ dataproc-name }} {#dataproc}

* `yc dataproc cluster create` command.

  Added the `--host-group-ids` flag that controls cluster hosting on dedicated servers.


### Version 0.74.0 (29/03/21) {#version0.74.0}

* Added support for macOS/arm64 (Apple Silicon M1) and linux/arm64.


#### Changes in {{ yandex-cloud }} services

#### {{ dataproc-name }} {#dataproc}

* `yc dataproc cluster create` and `yc dataproc cluster update` commands.

  Added the `--security-group-ids` flag, which allows you to specify a set of security groups for a cluster.


### Version 0.73.0 (17/03/21) {#version0.73.0}

#### Changes in {{ yandex-cloud }} services


#### {{ container-registry-name }} {#container-registry}

Added commands for managing the allowed IP addresses for pushing and pulling Docker images:
* `yc container registry add-ip-permissions`: Adds IP addresses.
* `yc container registry list-ip-permissions`: Allows viewing IP addresses.
* `yc container registry set-ip-permissions`: Sets IP addresses.
* `yc container registry remove-ip-permissions`: Deletes IP addresses.

#### {{ sf-name }} {#cloud-functions}

* `yc serverless function version create` command.

  Added default values for flags:
  * `--execution-timeout`: 3 seconds
  * `--memory`: 128 MB
* `yc serverless function version create` command.

  Added the `--add-service-account` flag to specify additional service accounts for the version.

#### {{ cloud-logs-name }} {#logs}

* Added the `yc logs` command.


#### Managed database services {#managed-db}

**{{ mkf-name }}**

* `yc managed-kafka cluster create` command.

  The `--disk-size`, `--disk-type`, `--resource-preset`, `--zookeeper-disk-size`, `--zookeeper-disk-type`, and `--zookeeper-resource-preset` flags no longer have default values. If no values are specified, the default values set on the server are used.
* `yc managed-kafka cluster create` command.

  Added the `--unmanaged-topics` flag, which allows you to enable management of {{ KF }} topics via AdminAPI.

  Added the `--auto-create-topics-enable` flag, which allows you to enable automatic creation of {{ KF }} topics.

* `yc managed-kafka user create` command.

  Added the `admin` role, which allows you to enable {{ KF }} cluster topic management via AdminAPI.

**{{ mrd-name }}**

* `yc managed-redis cluster create` command.

  Added the `--enable-tls` flag, which allows you to enable TLS when creating a {{ RD }} cluster.

* `yc managed-redis cluster restore` command.

  Added the `--enable-tls` flag, which allows you to enable TLS when creating a {{ RD }} cluster from a backup.

### Version 0.72.0 (11/02/21)



#### Changes in {{ yandex-cloud }} services

#### {{ alb-name }} {#alb}

Added primary support for {{ alb-full-name }}:
* The `yc alb backend-group` group commands allow managing a backend group.
* The `yc alb http-router` group commands allow managing HTTP routers.
* The `yc alb load-balancer` group commands allow managing an L7 load balancer.
* The `yc alb target-group` group commands allow managing target groups.
* The `yc alb virtual-host` group commands allow managing virtual hosts.

#### {{ compute-name }} {#compute}

* The `yc compute instance|disk|image list` commands now return more than 1,000 elements.


### Version 0.71.0 (03/02/21) {#version0.71.0}

#### Changes in {{ yandex-cloud }} services


#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes node-group create` command.

  Added the `--placement-group` flag, which allows you to specify a `placement policy group` for a node group when creating it.


#### Managed database services {#managed-db}

**{{ mpg-name }}**

* `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore` commands.

  Added the `13` value for the `--postgresql-version string` flag to create a {{ PG }} cluster version 13.

**{{ mmy-name }}**

* `yc managed-mysql cluster update` command.

  Added the `--mysql-version` flag, which allows you to update the {{ MY }} server version.

**{{ mes-name }}**

* Added the `yc managed-elasticsearch hosts create` and `yc managed-elasticsearch hosts delete` commands to add and delete hosts.


**{{ mms-name }}**

Added primary support for {{ mms-full-name }}:
* The `yc managed-sqlserver cluster` group commands allow managing clusters.
* The `yc managed-sqlserver database` group commands allow managing DBs.
* The `yc managed-sqlserver user` group commands allow managing users.


**{{ mch-name }}**

* `yc managed-clickhouse host add` and `yc managed-clickhouse shards add` commands.

  Added the `--copy-schema` flag, which allows you to copy the schema of other {{ CH }} hosts.

### Version 0.70.0 (22/12/20) {#version0.70.0}


#### Changes to the CLI {#cli}

**Improved**

* `yc container registry configure-docker` command.

  Added the `--disable` flag, which allows you to disable integration with the Docker credential helper.


#### Changes in {{ yandex-cloud }} services


#### {{ iam-name }} {#iam}

Added the `yc iam federation list-user-accounts` command for listing federation users.


#### Managed database services {#managed-db}

**{{ mmy-name }}, {{ mpg-name }}, {{ mch-name }}, {{ mrd-name }}, {{ mmg-name }}, {{ mkf-name }}**

* `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster update`, and `yc <managed DB service name> cluster restore` commands.

  You can use the `--security-group-ids` flag to specify security groups for a cluster.

**{{ mkf-name }}**

* `yc managed-kafka cluster create` and `yc managed-kafka cluster update` commands.

  Added the following flags to set and edit configuration settings of {{ KF }} brokers: `--compression-type`, `--log-flush-interval-messages`, `--log-flush-interval-ms`, `--log-flush-scheduler-interval-ms`, `--log-retention-bytes`, `--log-retention-hours`, `--log-retention-minutes`, `--log-retention-ms`, `--log-segment-bytes`, `--log-preallocate`.
* `yc managed-kafka topic create` and `yc managed-kafka topic update` commands.

  Added the following flags to set and edit topic settings: `--cleanup-policy`, `--compression-type`, `--delete-retention-ms`, `--file-delete-delay-ms`, `--flush-messages`, `--flush-ms`, `--min-compaction-lag-ms`, `--retention-bytes`, `--retention-ms`, `--max-message-bytes`, `--min-insync-replicas`, `--segment-bytes`, `--preallocate`.

**{{ mes-name }}**

Added primary support for {{ mes-name }}:
* The `yc managed-elasticsearch cluster` group commands allow managing clusters.
* The `yc managed-elasticsearch user` group commands allow managing users.

### Version 0.69.0 (02/12/20) {#version0.69.0}

#### Changes in {{ yandex-cloud }} services


#### {{ managed-k8s-name }} {#k8s}

* Fixed the `ipv6-address` flag parsing for network specification of node groups.


#### Managed database services {#managed-db}

**{{ mkf-name }}**

Added primary support for {{ mkf-name }}:
* The `yc managed-kafka cluster` group commands allow managing clusters.
* The `yc managed-kafka topic` group commands allow managing topics.
* The `yc managed-kafka user` group commands allow managing users.

**{{ mmy-name }}**

* `yc managed-mysql user grant-permission` command.

  The `--permissions` flag supports the `REFERENCES` privilege.

**{{ mmy-name }}, {{ mpg-name }}**

* `yc <managed DB service name> cluster update` command.

  Added the `--websql-access` flag to manage access from the [management console]({{ link-console-main }}).

### Version 0.68.0 (03/11/20) {#version0.68.0}

#### Changes in {{ yandex-cloud }} services


#### {{ compute-name }} {#compute}

* You can now specify the size of a unit for disks when creating a VM.

#### {{ kms-name }} {#kms}

* `yc kms symmetric-key create` command.

  Added the `--deletion-protection` flag to enable key deletion protection.
* `yc kms symmetric-key update` command.

  Added flags to enable/disable key deletion protection: `--deletion-protection` and `--no-deletion-protection`.


#### Managed database services {#managed-db}

**{{ mch-name }}**

* `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore`, and `yc managed-clickhouse cluster update` commands.

  Added the flags:
  * `--admin-password`, `--generate-admin-password`, and `--read-admin-password`: Sets the `admin` user password used when user management via SQL is enabled.
  * `--enable-sql-database-management`: Enables DB management via SQL.
  * `--enable-sql-user-management`: Enables user and access permission management via SQL.

**{{ mmy-name }}**

* `yc managed-mysql user grant-permission` command.

  Added the `--permissions` flag that supports `ALL_PRIVILEGES` (synonym for `ALL`).


#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster create` command.

  Added the `--cluster-ipv6-range`, `--dual-stack`, and `--service-ipv6-range` flags that allow you to create {{ k8s }} clusters with concurrent use of IPv4 and IPv6.
* `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update` commands.

  Added the `--security-group-ids` flag that sets a security group for the cluster.
* `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update` commands.

  Added the `--network-interface` flag, which allows you to set network specification for nodes in more detail. For example, you can manage security group settings for network interfaces and configure node interfaces for concurrent use of IPv4 and IPv6 in {{ k8s }} clusters.


### Version 0.67.0 (05/10/20) {#version0.67.0}



#### Changes in {{ yandex-cloud }} services

#### {{ compute-name }} {#compute}

**Fixed**

* Fixed the issue of it being impossible to add a VM to an existing placement group.

#### {{ container-registry-name }} {#container-registry}

* Added the `yc container image list-vulnerabilities` and `yc container image scan` commands to scan Docker images.


### Version 0.66.0 (28/09/20) {#version0.66.0}

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ compute-name }} {#compute}

* Added the `yc compute host-group` command, which allows you to manage dedicated hosts.
* Added the `yc compute host-type` command, which allows you to manage dedicated host types.
* Added the `yc compute disk-placement-group` command, which allows you to manage groups of non-replicated disks.


#### Managed database services {#managed-db}

**{{ mmg-name }}**

* `yc managed-mongodb cluster restore --help` command.

  Added an example of using the `--recovery-target-timestamp` flag.

### Version 0.65.0 (22/09/20) {#version0.65.0}

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ dataproc-name }} {#dataproc}

Added UI Proxy support:
* Added the `yc dataproc cluster list-ui-links` command, which allows you to get a list of links to access {{ dataproc-name }} cluster interfaces.
* `yc dataproc cluster create` and `yc dataproc cluster update` commands.
  Added the `--ui-proxy` parameter, which allows you to enable the UI Proxy functionality for a {{ dataproc-full-name }} cluster.
* `yc dataproc cluster create`, `yc dataproc subcluster create`, and `yc dataproc subcluster update` commands.
  Added the following flags for auto-scalable subclusters: `--autoscaling-decommission-timeout`, `--cpu-utilization-target`, `--max-hosts-count`, `--measurement-duration`, `--preemptible`, `--stabilization-duration`, and `--warmup-duration`.
* `yc dataproc subcluster list` command.
  The response now contains the `instance group id` field with VM group IDs of auto-scalable subclusters.

#### {{ certificate-manager-name }} {#certificate-manager}

* Added the `yc certificate-manager certificate content` command to get the certificate contents.

  It allows you to upload a certificate chain and a private key you can use by yourself to configure a web server on a VM.


#### Managed database services {#managed-db}

**{{ mmg-name }}**

* `{{ yc-mdb-mg }} cluster get` and `{{ yc-mdb-mg }} cluster update` commands.

  Added the `backup-retain-period-days` field representing the number of days to retain automatic backups.
* `{{ yc-mdb-mg }} cluster list-backups` and `{{ yc-mdb-mg }} backup list` commands.

  Added the `SIZE` and `TYPE` fields containing the backup size and type.
* `{{ yc-mdb-mg }} cluster list-logs` command.

  Added the `filter` parameter to filter requested entries.

  If the `follow` parameter is set, the default value of the `limit` parameter is ignored. In which case the explicitly specified `limit` parameter value limits the number of returnable entries.

### Version 0.64.0 (08/09/20) {#version0.64.0}

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ compute-name }} {#compute}

* `yc compute instance-group` command.

  * Added the ability to set and view a list of roles for a VM group: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.
  * Added commands for deleting and stopping VMs in a VM group: `stop-instances` and`delete-instances`.


#### Managed database services {#managed-db}

* The `yc <managed DB service name> cluster list-logs` command uses new `StreamLogs` API methods across all managed DBs.

  All commands now have the `--follow` flag, which allows you to get new log entries as they are created.

**{{ mch-name }}**

* Added the `yc managed-clickhouse versions list` command to get a list of versions available for installation.
* `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster restore` commands.

  Added the `--cloud-storage` flag to enable data storage in {{ objstorage-name }}.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 4.4.
* `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster enable-sharding` commands.

  For [sharded](../managed-mongodb/concepts/sharding.md) clusters, you can now set the `mongoinfra` host type.


#### {{ certificate-manager-name }} {#certificate-manager}

Added support for the TLS certificate management service: {{ certificate-manager-full-name }}.

You can use {{ certificate-manager-name }} to obtain and update TLS certificates from Let's Encrypt® and import your own certificates.

These certificates can be used in {{ yandex-cloud }} services to provide connection security.

{{ certificate-manager-name }} is at the [Preview](../overview/concepts/launch-stages.md) stage. Read more about the service in the [documentation](../certificate-manager/).


### Version 0.63.0 (28/08/20) {#version0.63.0}

#### Changes to the CLI {#cli}

**Fixed**

* Fixed the issue with federated user authorization when initializing a new YC CLI profile.


#### Changes to {{ yandex-cloud }} services {#services}

#### {{ vpc-name }} {#vpc}

* Added the `yc vpc address` command group for [IP address](../vpc/concepts/address.md#public-addresses) management.


### Version 0.62.0 (20/08/20) {#version0.62.0}

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ sf-name }} {#serverless-functions}

* `yc serverless function version create` command.
  * Added the `--source-version-id` flag to specify a function's source version.
  * Added the `--network-id` and `--network-name` flags to specify a network for the function version. You can use the `--subnet-id` and `--subnet-name` flags to provide a detailed list of subnets.


#### Managed database services {#managed-db}

**{{ mmy-name }}**

* `yc managed-mysql user update` command.

  The `--global-permissions` flag allows you to grant the `PROCESS` privilege.

**{{ mch-name }}, {{ mmy-name }}, {{ mpg-name }}, {{ mrd-name }}, {{ mmg-name }}**

* `yc <managed DB service name> cluster update` command.

  Added the `--maintenance-window-anytime` and `--maintenance-window-weekly` flags to specify maintenance window parameters. They will be used to schedule cluster maintenance.
* Added the `yc <managed DB service name> cluster reschedule-maintenance` command to manage a scheduled cluster maintenance job.

**{{ mmg-name }}**

* `yc managed-mongodb cluster restore` command.

  Added the `--recovery-target-timestamp` flag to specify the backup recovery point.

### Version 0.61.0 (03/08/20) {#version0.61.0}



#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster create` command.

  The `--version` flag value is now used correctly when creating a regional cluster.

##### {{ compute-name }} {#compute}

* `yc compute instance update-network-interface` command.

  The `--security-group-id` flag now accepts a comma-separated list of values.

* `yc compute instance create-with-container` and `yc compute instance update-container` commands.

  Added the `--coi-spec-file` flag to provide the [image specification](../cos/concepts/coi-specifications.md#coi-spec-example).

  Added the `--coi-spec-file` flag to provide the image specification.

##### {{ vpc-name }} {#vpc}

* `yc vpc subnet create` and `yc vpc subnet update` commands.

  The `--domain-name-server` and `--ntp-server` flags now accept comma-separated lists of values.
* Added the `yc vpc subnet list-used-addresses` command.

  It returns a list of addresses used in a subnet.


### Version 0.60.0 (20/07/20) {#version0.60.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ compute-name }} {#compute}

* Added the `yc compute instance update-network-interface` command.

  It allows you to change the network interface settings on created VMs.

##### {{ sf-name }} {#serverless-functions}

* `yc serverless function logs` command.

  The use of the `--follow` flag now ensures that you get the latest function version logs with the tag provided.


##### Managed database services {#managed-db}

**{{ mch-name }}**

* `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster update`, and `yc managed-clickhouse cluster restore` commands.

  Added the `--service account` flag to select a service account linked to hosts.
* Added commands for managing `yc managed-clickhouse shard-groups` shard groups.

### Version 0.59.0 (02/07/20) {#version0.59.0}



#### Changes to {{ yandex-cloud }} services {#services}

#### {{ api-gw-name }} {#api-gw}

Added support for {{ api-gw-full-name }}.

{{ api-gw-name }} is an API gateway management service supporting [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) and extensions for compatibility with other cloud services.

{{ api-gw-name }} is at the [Preview](../overview/concepts/launch-stages.md) stage. If you want to learn more about the service, see [our relevant documentation](../api-gateway/).

#### {{ iam-name }} {#iam}

* Added the following flags to the `yc iam federation create` and `yc iam federation update` commands:
  * `--encrypted-assertions`: To enable encryption of SAML assertions.
  * `--case-insensitive-name-ids`: To enable case-insensitive user name IDs.


### Version 0.58.0 (16/06/20) {#version0.58.0}

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ sf-name }} {#serverless-functions}

* Added commands to stop and resume the `yc serverless trigger pause` and `yc serverless trigger resume` triggers.
* `yc serverless function invoke` command.

  Increased the waiting time for a function invoke result from 30 seconds to 25 minutes.

##### {{ vpc-name }} {#vpc}

* `yc vpc subnet create` and `yc vpc subnet update` commands.

  Added flags for configuring DHCP options: `--domain-name`, `--domain-name-server`, and `--ntp-server`.

##### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update` commands.

  Added the `--gpus=GPUS` flag to specify the number of GPUs on the nodes.

##### {{ container-registry-name }} {#container-registry}

* Added the `yc container repository lifecycle-policy` commands to manage automatic deletion policies for Docker images.


##### Managed database services {#managed-db}

**{{ mch-name }}**

* Added the `yc managed-mysql cluster add-labels` and `yc managed-mysql cluster remove-labels` commands to manage labels.

**{{ mrd-name }}**

* Added support for {{ RD }} version 6.

### Version 0.57.0 (26/05/20) {#version0.57.0}


#### Changes to the CLI {#cli}

**Fixed**

* Fixed usage of a Docker credential helper with HTTPS addresses. You can now get authentication data for `https://{{ registry }}` type addresses.


#### Changes to {{ yandex-cloud }} services {#services}


#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create container-registry` command to create triggers for {{ container-registry-full-name }}.

#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes node-group create` command.

  Changed the default platform and number of cores used when creating a node group. The Intel Cascade Lake (`standard-v2`) platform is now used in a dual-core (`cores: 2`) configuration.


#### Managed database services {#managed-db}

**{{ mch-name }}**

* Added the `{{ yc-mdb-ch }} format-schema` command.

  It allows you to manage the Cap'n Proto and Protobuf schemas in {{ CH }} clusters.

**{{ mmg-name }}**

* Added the `{{ yc-mdb-mg }} hosts resetup` command.

  The command reloads data on the selected host. First it deletes all the data and then restores it from a replica.

### Version 0.56.0 (23/04/20) {#version0.56.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### All services {#all}

* You can now use the `get` and `delete` commands to provide multiple resource IDs or names.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* `yc managed-clickhouse user create` and `yc managed-clickhouse user update` commands.

  The `settings` flag parameters are now described in Help.

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* `yc <managed DB service name> host list` command.

  Added a column with `assign_public_ip` values to the output.

**{{ mrd-name }}**

* `yc managed-redis host list` command.

  The output now includes columns with the `type` and `shard_name` values.


##### {{ coi }} {#coi}

* `yc compute instance create-with-container` and `yc compute instance update-container` commands.

  When you send a file with environment variables using the `--container-env-file` flag, the `=` characters in variable values are now processed correctly.


### Version 0.55.0 (13/04/20) {#version0.55.0}

#### Changes to the CLI {#cli}

**Improved**

* Added support for authentication when using `http_proxy`.
* Added autocompletion for the `zsh` command shell.
* When terminating an operation using **Ctrl** + **C**, `yc` displays information about the ongoing operation.

**Fixed**

* Fixed the 30-second wait if no `folder-id` or `folder-name` property is specified in the current profile.

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster create` command.

  Added the `--node-ipv4-mask-size` flag to configure the size of `CIDR` allocated to each cluster node.
* `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update` commands.

  Added the `--max-unavailable` and `--max-expansion` flags to control the number of nodes deleted and created when updating the group.


#### Managed database services {#managed-db}

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster restore`, and `yc <managed DB service name> host add` commands.

  Added the `subnet-name` property to the `--host` flag to specify a subnet by name.

**{{ mmg-name }}, {{ mch-name }}, {{ mrd-name }}**

* `yc <managed DB service name> cluster list-logs` command.

  Added formatting for log lines.


#### {{ coi }} {#coi}

* `yc compute instance create-with-container` command.

  Added mounting of `docker volumes` into a Docker container created in {{ coi }} by using the `container-volume-tmpfs` and `container-volume-host-path` flags.
* `yc compute instance update-container` command.

  Now you can update `docker volumes` in a Docker container created in {{ coi }}.


### Version 0.54.0 (24/03/20) {#version0.54.0}

#### Changes to the CLI {#cli}

**Improved**

* Error messages thrown by commands and flags are now more intuitive.


#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster create` command.

  Added the `--kms-key-id` and `--kms-key-name` flags for creating a {{ k8s }} cluster with secret encryption in KMS.


### Version 0.53.0 (04/03/20) {#version0.53.0}

#### Changes to the CLI {#cli}

**Improved**

* When running `yc` on a VM inside {{ yandex-cloud }}, if `folder-id` is not specified in the `yc` config, the folder in which the VM was created will be used.
* Added the `--version` flag, in addition to the `yc version` command.

**Fixed**

* Fixed updating via `yc components update` on WSL 1.
* Fixed abnormal termination on invoking `yc help`.

#### Changes to {{ yandex-cloud }} services {#services}


##### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster get-credentials` command.

  Added a check and alert feature if a `kubectl` version below 1.11 is used because such versions do not support the authentication method specified by this command.


##### Managed database services {#managed-db}

**{{ mch-name }}**

* `{{ yc-mdb-ch }} user` command.

  Added user quota management.
* `{{ yc-mdb-ch }} cluster` command.

  Added the `metrica-access`, `datalens-access`, and `websql-access` flags to cluster creation, restoration, and editing commands.
* Added the `{{ yc-mdb-ch }} ml-model` commands.

  It allows you to manage ML models in {{ CH }} clusters.

**{{ mmg-name }}, {{ mpg-name }}, {{ mmy-name }}, {{ mrd-name }}**

* `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster update`, and `yc <managed DB service name> cluster restore` commands.

  Added the `datalens-access` flag to manage {{ datalens-full-name }} access to a cluster.

### Version 0.52.1 (21/02/20) {#version0.52.1}

#### Changes to the CLI {#cli}

**Fixed**

* During installation, WARN not shown for non-existent problems.

### Version 0.52.0 (21/02/20) {#version0.52.0}

#### Changes to the CLI {#cli}

**Improved**

* When you run `yc` with the `--help` or `-h` flag, interactive help opens: in `less` (`$PAGER`) on Linux and macOS and in `more` on Windows. Now you no longer have to scroll up through the help result.
* The execution and API interaction debug logs are now saved to the `$HOME/.config/yandex-cloud/logs` configuration directory instead of the installation directory. This fixes the issue where `yc`, installed as a stand-alone binary file, would suddenly try to save its log in the same directory without proper authorization.
* Debug logs are also saved for successful requests. When reporting an issue with a `yc` command, attach your saved log file so we can help you faster.

**Fixed**
* No update notice is shown when running the `yc components ...` commands.


#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* `yc compute instance create` command.

  Added the `nat-address` parameter to the `--network-interface` flag, which allows you to assign a specific NAT address for the new instance.
* Added the `yc compute instance add-one-to-one-nat` and `yc compute instance remove-one-to-one-nat` commands.

  These commands allow you to manage NAT on the existing instances.
* `yc compute instance create` and `yc compute instance update` commands.

  Added the `--network-settings` flag, which allows changing network type to `Software accelerated` and back to `Standard`.

#### {{ kms-name }} {#kms}

* `yc kms symmetric-key` command.

  Added commands to manage roles for individual keys: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, `remove-access-binding`.

#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster create` command.

  Added the `--enable-network-policy` flag to create a {{ k8s }} cluster with [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) support.
* `yc k8s cluster get-credentials` command.

  Added the `--context-name` flag that allows the user to specify the name of the `context` created in `kubeconfig`.

  The default new context name is now more intuitive: `yc-<cluster-name>`.

  An explanation of the result is returned.


### Version 0.51.0 (12/02/20) {#version0.51.0}

#### Changes to the CLI {#cli}

**Improved**

* `yc <service> <resource> create` commands.

  Added an option to provide resource names as command arguments. Now the `yc <service> <resource> create --name <resource name>` and `yc <service> <resource> create <resource name>` commands are equal.

  For example, instead of the `yc managed-kubernetes cluster create --name my-cluster ...` command, you can now use the `yc managed-kubernetes cluster create my-cluster ...` command.
* ` yc <service> <resource> set-access-binding` commands.

  Added a warning that the command deletes assigned roles. If the user runs the command directly (rather than using another command or script), they are asked for confirmation.

**Fixed**

* `yc init` command.

  The values of the `--cloud-id`, `--folder-id`, and `--folder-name` flags are now properly recognized.
* Disabled messages about there being a new `yc` version when invoking a command in non-interactive mode.


#### Changes to {{ yandex-cloud }} services {#services}

#### {{ iam-name }} {#iam}

* Added commands for creating and managing SAML-compatible identity federations and their certificates: `yc iam federation` and `yc iam certificate`. Learn more about SAML-compatible identity federations in [our documentation](../organization/concepts/add-federation.md).


### Version 0.50.0 (27/01/20) {#version0.50.0}



#### Changes to {{ yandex-cloud }} services {#services}

* For [resources that you can assign roles for](../iam/concepts/access-control/resources-with-access-control.md).

  Added the following alternatives to the `--subject` flag for role management commands: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login`, and `--all-authenticated-users`.

#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes node-group create` command.

  Added the `--auto-scale` flag allowing to create a dynamic-size node group controlled by [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### {{ compute-name }} {#compute}

* `yc compute instance create` command.

  If you set the `--gpus` flag, the `gpu-standard-v1` platform is automatically selected.


### Version 0.49.0 (21/01/20) {#version0.49.0}

#### Changes to the CLI {#cli}

**Improved**

* When running the YC CLI with the `--debug` flag, the API call response log line now returns the gRPC status code as well as its description.


#### Changes to {{ yandex-cloud }} services {#services}

#### {{ kms-name }} {#kms}

Support for the cryptographic key management service: {{ kms-full-name }}.

{{ kms-name }} allows you to create encryption keys and implement data protection schemas in your applications and services.

Use the keys to protect your secrets, private data, and other confidential information you store in the cloud.

{{ kms-name }} is at the [Preview](../overview/concepts/launch-stages.md) stage. Read more about the service in the [documentation](../kms/).


### Version 0.48.0 (27/12/19) {#version0.48.0}

#### Changes to the CLI {#cli}

**Improved**

* When updating YC CLI, the current version to be installed is now displayed.

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ compute-name }} {#compute}

* Added the ability to work with the `yc compute placement-group --help` placement group.
* `yc compute instance create` and `yc compute instance update` commands.

  The platform flag is renamed from `--platform-id` to `--platform`. The old flag name is still supported.
* `yc compute instance create` command.

  The SSH key added using the `--ssh-key` flag is saved to the metadata with the `ssh-keys` key instead of `ec2-user-data`.


#### Managed database services {#managed-db}

**{{ mmy-name }}**

* Added support for creating a cluster with {{ MY }} version 8.0.
* Added a command to manually switch the master for a specified cluster: {{ MY }} `{{ yc-mdb-my }} cluster start-failover`.
* `{{ yc-mdb-my }} cluster update` command.

  Added the ability to rename a cluster using the `--new-name` flag.

**{{ mpg-name }}**

* Added a command to manually switch the master for a specified cluster: {{ PG }} `{{ yc-mdb-pg }} cluster start-failover`.
* `{{ yc-mdb-pg }} cluster update` command.

  Added the ability to rename a cluster using the `--new-name` flag.

**{{ mch-name }}**

* `{{ yc-mdb-ch }} cluster update` command.

  Added the ability to rename a cluster using the `--new-name` flag.

**{{ mrd-name }}**

* `{{ yc-mdb-rd }} cluster update` command.

  Added the ability to rename a cluster using the `--new-name` flag.

### Version 0.47.0 (17/12/19) {#version0.47.0}



#### Changes to the CLI {#cli}

**Improved**

* Added the ability to [authenticate using a federation](operations/authentication/federated-user.md) when invoking `yc` in non-interactive mode. This mode is used when the CLI is not started by the user directly, e.g., in a script or `kubectl`.


### Version 0.46.0 (13/12/19) {#version0.46.0}



#### Changes to the CLI {#cli}

**Improved**

* To facilitate authorization diagnostics, CRC32 of the sent [IAM token](../iam/concepts/authorization/iam-token.md) is written to the request debug log.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create object-storage` command for subscription to bucket updates in {{ objstorage-full-name }}.


### Version 0.45.0 (03/12/19) {#version0.45.0}

#### Changes to the CLI {#cli}

**Improved**

* Increased the time between reconnection attempts if any resource involved in the execution of a command is unavailable.


#### Changes to {{ yandex-cloud }} services {#services}

#### {{ iot-name }} {#iot}

* Added the following commands for password management: `yc iot registry password` and `yc iot device password`.
* `yc iot registry create` and `yc iot device create` commands.

  Added flags to enable login and password authorization: `--password`, `--read-password`, and `--generate-password`.
* `yc iot mqtt publish` and `yc iot mqtt subscribe` commands.

  Added flags to enable login and password authorization: `--username` and `--password`.


### Version 0.44.0 (19/11/19) {#version0.44.0}


#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create timer` command to call functions using a timer.


#### Changes to the CLI {#cli}

**Fixed**

* Fixed an error that in rare cases would cause several `debug` log lines to get into `stdout`.

**Improved**

* Disabled the display of the `Status.details` field for gRPC errors: its info is duplicated in the `Status.message` field, shown as the main error message.

### Version 0.43.1 (14/11/19)



#### Changes to the CLI {#cli}

**Fixed**

* For Windows Subsystem for Linux (WSL), the browser now opens correctly when logging in to the CLI using [SAML-compatible identity federations](../organization/concepts/add-federation.md).


### Version 0.43.0 (11/11/19) {#version0.43.0}


#### Changes to the CLI {#cli}

* Added CLI authentication using [SAML-compatible identity federations](../organization/concepts/add-federation.md).

  To use the CLI as a federated user, run the `yc init --federation-id=<FEDERATION_ID>` command.


#### Changes to {{ yandex-cloud }} services {#services}


#### {{ compute-name }} {#compute}

* Added details to the logged data and error text on [authorization from within a VM](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (using an IAM token from the metadata).

* Added details to the logged data and error text on authorization from within a VM (using an IAM token from the metadata).


#### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* Added support for creating {{ PG }} version 12 databases.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 4.2.

### Version 0.42.0 (21/10/19) {#version0.42.0}


#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Added the `yc compute instance-group start` and `yc compute instance-group stop` commands to run and stop a VM group.

#### {{ container-registry-name }} {#container-registry}

* `yc compute instance create-with-container` and `yc compute instance update-container` commands.

  Added these alternative spellings for the "always", "never", and "on-failure" `--container-restart-policy` flag values: "Always", "Never", "OnFailure".

#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster create` command.

  Deleted the `--default-gateway-v4-address` flag.


#### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore` commands.

  Added the `10_1s` value for the `--postgresql-version string` flag to create the {{ PG }} cluster version 10-1c.

### Version 0.41.1 (26/09/19) {#version0.41.1}

* Minor fixes and updates.

### Version 0.41.0 (25/09/19) {#version0.41.0}



#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

* `yc compute instance create-with-container` command.

  The `--create-boot-disk` flag no longer supports `snapshot-*` parameters.

#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster create` command.

  Added flags for master type management: `--regional`, `--region`, and `--master-location`.
* `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update` commands.

  Added flags for maintenance policy management: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.
* `yc managed-kubernetes node-groups update` command.

  Added flags for maintenance policy management: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.


### Version 0.40.0 (20/09/19) {#version0.40.0}

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ container-registry-name }} {#container-registry}

* Added a command to get detailed registry information: `yc container registry repository get`.
* `yc container registry repository list` command.

  Added unique registry ID to the result.


#### Managed database services {#managed-db}

**All managed database services**

* `yc <managed DB service name> create clusters` command.

  For the `--*resource-preset` flags, added a default value: s2.micro.

**{{ mmg-name }}**

* `{{ yc-mdb-mg }} create clusters` command.

  For the `--mongodb-version` flag, changed the default value from 3.6 to 4.0.

### Version 0.39.0 (16/09/19) {#version0.39.0}

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ container-registry-name }} {#container-registry}

* `yc container registry` command.

  Added the ability to set and view a list of roles for the Docker image registry: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.


#### Managed database services {#managed-db}

**All managed database services**

* `yc <managed DB service name> users list` command.

  The unique cluster ID is no longer displayed when viewing a list of users.

### Version 0.38.0 (09/09/19) {#version0.38.0}

#### Changes to the CLI {#cli}

**Improved**

* Improved the return of fields when viewing a list of API keys.

### Version 0.37.0 (06/09/19) {#version0.37.0}

#### Changes to the CLI {#cli}

**Improved**

* Added API endpoint availability checks for {{ iam-full-name }}, {{ resmgr-full-name }}, and {{ compute-full-name }}. If an endpoint is unavailable, an error is returned.
* Added detailed error reporting.

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ container-registry-name }} {#container-registry}

**Improved**

* Added Windows support for the Docker credential helper.
* Added a detailed error when using `docker login` in parallel with the Docker credential helper.

#### {{ ig-name }} {#instance-groups}

* Added commands to manage VM group metadata: `yc compute instance-group add-metadata` and `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster update` command.

  Added the `--node-service-account-id` and `--node-service-account-name` flags to add or change service accounts for nodes in an existing {{ k8s }} cluster.
* `yc managed-kubernetes node-group update` command.

  Added flags to edit existing node group parameters: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, `--preemptible`.
* Added commands to manage labels: `yc managed-kubernetes node-group add-labels` and `yc managed-kubernetes node-group remove-labels`.
* Added commands to manage node group metadata: `yc managed-kubernetes node-group add-metadata` and `yc managed-kubernetes node-group remove-metadata`.


#### Managed database services {#managed-db}

**{{ mpg-name }}**

* `{{ yc-mdb-pg }} cluster update` command.

  Added the `--connection-pool-discard` flag to disable the connection pooler.
* `{{ yc-mdb-pg }} user create` and `yc managed-postgresql user update` commands.

  You can now specify a login and set user access permissions using the `--login` and `--grants` flags.

### Version 0.36.0 (27/08/19) {#version0.36.0}



#### Changes to {{ yandex-cloud }} services {#services}

#### {{ resmgr-name }} {#resmgr}

* `yc resource-manager cloud update` command.

  Added the ability to rename clouds.


### Version 0.35.1 (16/08/19) {#version0.35.1}

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**All managed database services**

* `yc <managed DB service name> cluster create` command.

  Renamed the default disk types as follows: `network-nvme` to `network-ssd`, `local-nvme` to `local-ssd`.

### Version 0.35.0 (09/08/19) {#version0.35.0}

#### Changes to the CLI {#cli}

**Improved**

* Added a link to the documentation with release descriptions in the message about the new CLI version.

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* `{{ yc-mdb-pg }} cluster create` command.

  Added the following parameters for the `--user` flag: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, `log-statement`.

### Version 0.34.0 (26/07/19) {#version0.34.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mrd-name }}**

* `{{ yc-mdb-rd }} shards` command.

  Added shard support for {{ RD }} clusters.

**{{ mch-name }}**

* `{{ yc-mdb-ch }} cluster add-external-dictionary` command.

  Added {{ PG }} dictionary support. Flags for working with dictionaries: `--postgresql-source`, `--postgresql-source-hosts`, and `--postgresql-invalidate-query`.

**{{ mmy-name }}**

* `{{ mmy-name }} cluster update-config --set` command.

  Added an option to set the SQL mode globally using the `sql_mode` parameter.

### Version 0.33.0 (19/07/19) {#version0.33.0}

#### Changes to the CLI {#cli}

**Improved**

* Changed the command progress indicator from dots to a [throbber](https://en.wikipedia.org/wiki/Throbber).

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* `{{ yc-mdb-pg }} user create` and `{{ yc-mdb-pg }} user update` commands.

  Now you can set up user parameters using flags, including `--lock_timeout` and `--log_min_duration_statement`.

### Version 0.32.0 (05/07/19) {#version0.32.0}

#### Changes to the CLI {#cli}

**Improved**

* `yc <service> <resource>list` commands to display a list of elements.

  Increased the maximum number of output elements from 100 to 1,000.

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mmg-name }}**

* `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster update-config` commands.

  In [sharded](../managed-mongodb/concepts/sharding.md) clusters, you can now change the `mongos` and `mongocfg` component parameters.

### Version 0.31.0 (01/07/19) {#version0.31.0}

#### Changes to the CLI {#cli}

**Improved**

* When using the CLI on a VM launched under a service account, the CLI is authorized under this service account by default.

**Fixed**

* Attempts to get a resource by specifying its unique ID would fail if the `folder-id` parameter was not specified in the CLI configuration.
* Attempts to get a folder by specifying its unique ID would fail if the user did not have the `viewer` role for the folder in {{ yandex-cloud }}.
* The `yc init` command would fail if the user did not have the `viewer` role in {{ yandex-cloud }}.

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ network-load-balancer-name }} {#load-balancer}

* `yc load-balancer network-load-balancer create` and `yc load-balancer network-load-balancer update` commands.

  For the `--listener` flag, you can now set the `target-port` parameter, which allows you to configure NAT so that target resources receive traffic on a port other than the `listener` port.


#### Managed database services {#managed-db}

**{{ mch-name }}**

* `{{ yc-mdb-ch }} user create` and `{{ yc-mdb-ch }} user update` commands.

  Added the `--settings` flag, which allows you to specify user settings.

### Version 0.30.0 (18/06/19) {#version0.30.0}



#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* `yc compute instance update` command.

  Added the `--node-service-account-id` and `--node-service-account-name` flags to add or change a service account for an existing VM.
* `yc compute instance create` command.

  Changed the default number of cores used when creating a VM based on Intel Cascade Lake (`standard-v2`). Now it is `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

* `yc managed-kubernetes cluster update` command.

  Added the `--default-gateway-v4-address` flag, which allows you to update the gateway address for an existing {{ k8s }} cluster.


### Version 0.29.0 (11/06/19) {#version0.29.0}

* Minor fixes and updates.

### Version 0.28.0 (05/06/19) {#version0.28.0}

#### Changes to the CLI {#cli}

* Added automatic reconnect if any resource involved in the execution of a command is unavailable. The CLI will try to reconnect five times; the retry frequency is calculated using exponential backoff.

#### Changes to {{ yandex-cloud }} services {#services}


#### {{ compute-name }} {#compute-cloud}

* `yc compute instance create` command.

  Added the `--gpus` flag, which allows you to specify the number of the virtual machine's GPUs.


#### Managed database services {#managed-db}

**All managed database services**

* `yc <managed DB service name> cluster get` command.

  Improved cluster information printout.
* `yc <managed DB service name> cluster create` command.

  Added the `--backup-window-start` flag, which allows you to set the daily cluster backup time when creating a cluster.

**{{ mch-name }}**

* `{{ yc-mdb-ch }} cluster add-zookeeper` command.

  Added the ability to add {{ ZK }} hosts.
* `{{ yc-mdb-ch }} shards add` command.

  Changed the logic of creating shards:
  * If the `--host` flag is not specified, the shard parameters are copied from the oldest shard.
  * If the `--host` flag is specified, all parameters must be entered.
  * If there are no shards, all parameters have to be entered to create a shard.


{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
