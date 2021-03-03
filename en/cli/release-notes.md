# YC CLI Releases

## Version 0.72.0 (11.02.21) {#latest-release}

### Changes to {{ yandex-cloud }} services

#### {{ alb-name }} {#alb}

Added primary support for {{ alb-name }}:

* Commands in the `yc alb backend-group` group let you manage a backend group.
* Commands in the `yc alb http-router` group let you manage HTTP routers.
* Commands in the `yc alb load-balancer` group let you manage L7 load balancers.
* Commands in the `yc alb target-group` group let you manage target groups.
* Commands in the `yc alb virtual-host` group let you manage virtual hosts.

#### {{ compute-name }} {#compute}

* Commands `yc compute instance|disk|image list` now return more than 1000 items.

## Previous releases {#previous-releases}

### Version 0.71.0 (03.02.21) {#version0.71.0}

#### Changes to {{ yandex-cloud }} services

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes node-group create`

    Added the `--placement-group` flag that lets you set a `placement policy group` for a node group when creating it.

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Commands `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore`

  Added the value `13` for the `--postgresql-version string` flag to create {{ PG }} cluster version 13.

**{{ mmy-name }}**

* Command `yc managed-mysql cluster update`

  Added the `--mysql-version` flag that lets you update the MySQL server version.

**{{ mes-name }}**

* Added the `yc managed-elasticsearch hosts create` and `yc managed-elasticsearch hosts delete` commands to add and delete hosts, respectively.

**{{ mms-name }}**

Added primary support for {{ mms-name }}:

* Commands of the `yc managed-sqlserver cluster` group let you manage clusters.
* Commands of the `yc managed-sqlserver database` group let you manage databases.
* Commands of the `yc managed-sqlserver user` group let you manage users.

**{{ mch-name }}**

* Commands `yc managed-clickhouse host add` and `yc managed-clickhouse shards add`

    Added the `--copy-schema` flag that lets you copy the schema of other {{ CH }} hosts.

### Version 0.70.0 (22.12.20) {#version0.70.0}

#### Changes to the CLI {#cli}

**Improved**

* Command `yc container registry configure-docker`

  Added the `--disable` flag that lets you disable integration with Docker Credential Helper.

#### Changes to {{ yandex-cloud }} services

#### {{ iam-name }} {#iam}

Added the `yc iam federation list-user-accounts` command for listing federation users.

#### Managed database services {#managed-db}

**{{ mmy-name }}, {{ mpg-name }}, {{ mch-name }}, {{ mrd-name }}, {{ mmg-name }}, {{ mkf-name }}**

- Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster update`, and `yc <managed DB service name> cluster restore`

    The `--security-group-ids` flag lets you specify a set of security groups for a cluster.

**{{ mkf-name }}**

* Commands `yc managed-kafka cluster create` and `yc managed-kafka cluster update`

  Added flags for setting and updating Kafka broker configuration settings: `--compression-type`, `--log-flush-interval-messages`, `--log-flush-interval-ms`, `--log-flush-scheduler-interval-ms`, `--log-retention-bytes`, `--log-retention-hours`, `--log-retention-minutes`, `--log-retention-ms`, `--log-segment-bytes`, and `--log-preallocate`.

* Commands `yc managed-kafka topic create` and `yc managed-kafka topic update`

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

- Command `yc managed-mysql user grant-permission`

    The `--permissions` flag supports the `REFERENCES` privilege.

**{{ mmy-name }}, {{ mpg-name }}**

- Command `yc <managed DB service name> cluster update`

    Added the `--websql-access` flag to control access from the [management console]({{ link-console-main }}).

### Version 0.68.0 (03.11.20) {#version0.68.0}

#### Changes to {{ yandex-cloud }} services

#### {{ compute-name }} {#compute}

* You can now specify the size of a unit for disks when creating a VM.

#### {{ kms-name }} {#kms}

* Command `yc kms symmetric-key create`
Added the `--deletion-protection` flag to enable key protection from deletion.

* Command `yc kms symmetric-key update`
Added flags to enable or disable key protection from deletion: `--deletion-protection` and `--no-deletion-protection`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore`, and `yc managed-clickhouse cluster update`
Added flags:
  * `--admin-password`, `--generate-admin-password`, and `--read-admin-password` to set the `admin` user password that is used when user management via SQL is enabled.
  * `--enable-sql-database-management` to enable database management via SQL.
  * `--enable-sql-user-management` to enable user and access right management via SQL.

**{{ mmy-name }}**

* Command `yc managed-mysql user grant-permission`
Added the `--permissions` flag that supports the `ALL_PRIVILEGES` privileges (a synonym for `ALL`).

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`
Added the `--cluster-ipv6-range`, `--dual-stack`, and `--service-ipv6-range` flags that let you create {{ k8s }} clusters  with concurrent use of IPv4 and IPv6.

* Commands `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update`
Added the `--security-group-ids` flag to set cluster security groups.

* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`
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

* Command `yc managed-mongodb cluster restore --help`
Added an example of using the `--recovery-target-timestamp` flag.

### Version 0.65.0 (22.09.20) {#version0.65.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ dataproc-name }} {#dataproc}

Added UI Proxy support:

* Added the `yc dataproc cluster list-ui-links` command that lets you get a list of links to access {{ dataproc-name }} cluster interfaces.
* Commands `yc dataproc cluster create` and `yc dataproc cluster update`
Added the `--ui-proxy` parameter that lets you enable the UI Proxy functionality for {{ dataproc-name }} clusters.
* Commands `yc dataproc cluster create`, `yc dataproc subcluster create`, and `yc dataproc subcluster update`
Added flags for auto-scalable subclusters: `--autoscaling-decommission-timeout`, `--cpu-utilization-target`, `--max-hosts-count`, `--measurement-duration`, `--preemptible`, `--stabilization-duration`, and `--warmup-duration`.
* Command `yc dataproc subcluster list`
A response now contains the `instance group id` field with IDs of instance groups in auto-scalable subclusters.

#### {{ certificate-manager-name }} {#certificate-manager}

* Added the `yc certificate-manager certificate content` command to get certificate contents.
It lets you upload a certificate chain and a private key to use on your own when configuring a web server on a VM.

#### Managed database services {#managed-db}

**{{ mmg-name }}**

* Commands `{{ yc-mdb-mg }} cluster get` and `{{ yc-mdb-mg }} cluster update`
Added the `backup-retain-period-days` field that shows the number of days for retaining automatic backups.

* Commands `{{ yc-mdb-mg }} cluster list-backups` and `{{ yc-mdb-mg }} backup list`

    Added the `SIZE` and `TYPE` fields that specify the size and type of backups, respectively.

* Command `{{ yc-mdb-mg }} cluster list-logs`

    Added the `filter` parameter to filter requested entries.

    If the `follow` parameter is set, the default value of the `limit` parameter is ignored. In this case, the explicitly specified `limit` parameter value limits the number of entries to output.

### Version 0.64.0 (08.09.20) {#version0.64.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Command `yc compute instance-group`
    - Added the ability to set and view a list of roles for an instance group: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.
    - Added commands for stopping and deleting VM instances in an instance group: `stop-instances` and `delete-instances`.

#### Managed database services {#managed-db}

* Command `yc <managed DB service name> cluster list-logs` for all managed DBs uses new `StreamLogs` API methods for streaming logs.

    All commands now have the `--follow` flag that lets you get new log entries as they appear.

**{{ mch-name }}**

* Added the `yc managed-clickhouse versions list` command to get a list of versions that can be installed.

* Commands `yc managed-clickhouse cluster create` and `yc managed-clickhouse cluster restore`

    Added the `--cloud-storage` flag to enable data storage in {{ objstorage-full-name }}.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 4.4.

* Commands `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster enable-sharding`

    In [sharded](../managed-mongodb/concepts/sharding.md) clusters, you can now set the `mongoinfra` host type.

#### {{ certificate-manager-name }} {#certificate-manager}

Added support for the TLS certificate management service: {{ certificate-manager-full-name }}.

You can use {{ certificate-manager-full-name }} to obtain and update TLS certificates from Let's Encrypt® and import your own certificates.
These certificates can be used in {{ yandex-cloud }} services to provide connection security.

The {{ certificate-manager-full-name }} service is at the Preview stage. Read more about the service in the [documentation](../certificate-manager/).

### Version 0.63.0 (28.08.20) {#version0.63.0}

#### Changes to the CLI {#cli}

**Fixed**

* Fixed the issue with federated user authorization when initializing a new YC CLI profile.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ vpc-name }} {#vpc}

* Added a group of `yc vpc address` commands to manage [IP addresses](../vpc/concepts/address.md#public-addresses).

### Version 0.62.0 (20.08.20) {#version0.62.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Command `yc serverless function version create`
    - Added the `--source-version-id` flag to specify a function's source version.
    - Added the `--network-id` and `--network-name` flags to specify a function version's network. You can give a detailed list of subnets using the `--subnet-id` and `--subnet-name` flags.

#### Managed database services {#managed-db}

**{{ mmy-name }}**

* Command `yc managed-mysql user update`

    The `--global-permissions` flag lets you grant the `PROCESS` privilege.

**{{ mch-name }}, {{ mmy-name }}, {{ mpg-name }}, {{ mrd-name }}, {{ mmg-name }}**

* Command `yc <managed DB service name> cluster update`

    Added the `--maintenance-window-anytime` and `--maintenance-window-weekly` flags to specify maintenance window parameters. They will be used to schedule cluster maintenance.

* Added the command `yc <managed DB service name> cluster reschedule-maintenance` to reschedule cluster maintenance.

**{{ mmg-name }}**

* Command `yc managed-mongodb cluster restore`

    Added the `--recovery-target-timestamp` flag to specify a backup's recovery timestamp.

### Version 0.61.0 (03.08.20) {#version0.61.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster create`

  The `--version` flag value is now correctly considered when creating a regional cluster.

##### {{ compute-name }} {#compute}

* Command `yc compute instance update-network-interface`

   The `--security-group-id` flag now accepts a comma-separated list of values.

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`

   Added the `--coi-spec-file` flag to pass an [image specification](../cos/concepts/index.md#coi-spec-example).

##### {{ vpc-name }} {#vpc}

* Commands `yc vpc subnet create` and `yc vpc subnet update`

   The `--domain-name-server` and `--ntp-server` flags now accept comma-separated lists of values.

* Added the `yc vpc subnet list-used-addresses` command.

   It outputs a list of addresses used in a subnet.

### Version 0.60.0 (20.07.20) {#version0.60.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ compute-name }} {#compute}

* Added the `yc compute instance update-network-interface` command.

  It lets you change the network interface settings on created VMs.

##### {{ sf-name }} {#serverless-functions}

* Command `yc serverless function logs`

    The use of the `--follow` flag now ensures that you get the logs of the latest function version with the passed tag.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster update`, and `yc managed-clickhouse cluster restore`

    Added the `--service account` flag to select service accounts linked to hosts.

* Added the `yc managed-clickhouse shard-groups` command for managing shard groups.

### Version 0.59.0 (02.07.20) {#version0.59.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ api-gw-name }} {#api-gw}

Added support for {{ api-gw-full-name }}.

{{ api-gw-full-name }} is a service for managing API gateways that supports [OpenAPI Specification 3.0](https://github.com/OAI/OpenAPI-Specification) and a set of extensions for interacting with other cloud services.

The {{ api-gw-full-name }} service is at the Preview stage. Read more about the service in the [documentation](https://cloud.yandex.com/docs/api-gateway/).

#### {{ iam-name }} {#iam}

* Added the following flags to commands `yc iam federation create` and `yc iam federation update`:
   * `--encrypted-assertions` to enable encryption of SAML assertions.
   * `--case-insensitive-name-ids` to enable case-insensitive user name IDs.

### Version 0.58.0 (16.06.20) {#version0.58.0}

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ sf-name }} {#serverless-functions}

* Added commands to pause and resume triggers: `yc serverless trigger pause` and `yc serverless trigger resume`.

* Command `yc serverless function invoke`

    Increased the waiting time for a function invoke result from 30 seconds to 25 minutes.

##### {{ vpc-name }} {#vpc}

* Commands `yc vpc subnet create` and `yc vpc subnet update`

    Added flags for configuring DHCP options: `--domain-name`, `--domain-name-server`, and `--ntp-server`.

##### {{ managed-k8s-name }} {#k8s}

* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`

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

* Added the `yc serverless trigger create container-registry` command to create triggers for {{ container-registry-name }}.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes node-group create`

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

* Commands `yc managed-clickhouse user create` and `yc managed-clickhouse user update`

    The `settings` flag parameters are now described in Help.

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Command `yc <managed DB service name> host list`

    The output now includes the column with `assign_public_ip` values.

**{{ mrd-name }}**

* Command `yc managed-redis host list`

    The output now includes columns with `type` and `shard_name` values.

##### {{ coi }} {#coi}

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`

  When you pass a file with environment variables using the `--container-env-file` flag, the `=` characters in variable values are now processed correctly.

### Version 0.55.0 (13.04.20) {#version0.55.0}

#### Changes to the CLI {#cli}

**Improved**

* Authentication now supported for `http_proxy`.
* Autocomplete added for the `zsh` command shell.
* When an operation is terminated by **Ctrl**+**C**, `yc` shows the details for the operation running.

**Fixed**

* Fixed the 30-second wait if no `folder-id` or `folder-name` property is specified in the profile you use.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`

  Added the `--node-ipv4-mask-size` flag to configure the size of `CIDRs` allocated to each cluster node.

* Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`

  Added the `--max-unavailable` and `--max-expansion` flags to control the number of nodes deleted and created at instance group update.

#### Managed database services {#managed-db}

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster restore`, and `yc <managed DB service name> host add`

  Added the `subnet-name` property to the `--host` flag to specify a subnet by its name.

**{{ mmg-name }}, {{ mch-name }}, {{ mrd-name }}**

* Command `yc <managed DB service name> cluster list-logs`

    Added formatting for log lines.

#### {{ coi }} {#coi}

* Command `yc compute instance create-with-container`

    Added mounting of `docker volumes` into a Docker container created in {{ coi }} by using the `container-volume-tmpfs` and `container-volume-host-path` flags.

* Command `yc compute instance update-container`

    Added ability to update `docker volumes` in a Docker container created in {{ coi }}.

### Version 0.54.0 (24.03.20) {#version0.54.0}

#### Changes to the CLI {#cli}

**Improved**

* Error messages thrown by commands and flags are now more intuitive.

#### Changes to {{ yandex-cloud }} services {#services}

##### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`

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

* Command `yc managed-kubernetes cluster get-credentials`

  Added checking and warning if the user runs `kubectl` versions earlier than 1.11 because they don't support the authentication method set by this command.

##### Managed database services {#managed-db}

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} user`

  Added user quota management.

* Command `{{ yc-mdb-ch }} cluster`

  Added the `metrica-access`, `datalens-access`, and `websql-access` flags to the cluster create, restore, and update commands.

* Added `{{ yc-mdb-ch }} ml-model` commands.

  It allows you to manage ML models in Clickhouse clusters.

**{{ mmg-name }}, {{ mpg-name }}, {{ mmy-name }}, {{ mrd-name }}**

* Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster update`, and `yc <managed DB service name> cluster restore`

  Added the `datalens-access` flag to manage Yandex.DataLens access to the cluster.

### Version 0.52.1 (21.02.20) {#version0.52.1}

#### Changes to the CLI {#cli}

**Fixed**

* During installation, WARN not shown for non-existent problems.

### Version 0.52.0 (21.02.20) {#version0.52.0}

#### Changes to the CLI {#cli}

**Improved**

* When you start `yc` using the `--help` or `-h` flag, interactive help opens:
in `less` (`$PAGER`) on Linux and macOS, in `more` on Windows. Now you no longer have to scroll up through the help output.

* Debug logs for execution and API interaction are now saved to the
`$HOME/.config/yandex-cloud/logs` configuration directory rather than the installation directory. This fixes the problem when `yc`, which is installed as a stand-alone binary file, suddenly tries to save its log in the same directory without the rights to it.

* Debug logs are also saved for successful requests. If you contact support about an issue with a `yc` command, we may be able to help you faster if you attach your log file.

**Fixed**

* No update notice is shown on `yc components ...` commands.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Command `yc compute instance create`

  Added the `nat-address` parameter to the `--network-interface` flag to assign a specific NAT address for the instance created.

* Added the commands `yc compute instance add-one-to-one-nat` and `yc compute instance remove-one-to-one-nat`.

  These commands let you manage NAT on already existing instances.

* Commands `yc compute instance create` and `yc compute instance update`

  Added the `--network-settings` flag to change the network type to `Software accelerated` and back to `Standard`.

#### {{ kms-name }} {#kms}

* Command `yc kms symmetric-key`

  Added commands to manage roles for individual keys:
`list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`

  Added the `--enable-network-policy` flag to create a Kubernetes cluster with
[Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) support.

* Command `yc k8s cluster get-credentials`

  Added the `--context-name` flag to let the user specify the name of the `context` created in `kubeconfig`.

  The default name at context creation is now more intuitive: `yc-<cluster-name>`.

  Execution result is now explained in the output.

### Version 0.51.0 (12.02.20) {#version0.51.0}

#### Changes to the CLI {#cli}

**Improved**

* Command `yc <service> <resource> create`

  Added the ability to pass resource names as command arguments. Commands like `yc <service> <resource> create --name <resource name>` and `yc <service> <resource> create <resource name>` are now the same.

  For example, instead of the running the command `yc managed-kubernetes cluster create --name my-cluster ...`, you can now use the command `yc managed-kubernetes cluster create my-cluster ...`.

* Command `yc <service> <resource> set-access-binding`

  Added a warning that the command deletes assigned roles. If the user runs the command directly (rather than using another command or script), they're asked for confirmation.

**Fixed**

* Command `yc init`

  The values of the flags `--cloud-id`, `--folder-id`, and `--folder-name` are now properly recognized.

* Disabled messages about the availability of a new version of `yc` when invoking of a non-interactive command.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{iam-name}} {#iam}

* Added commands for creating and managing SAML-compatible identity federations and their certificates: `yc iam federation` and `yc iam certificate`. Learn more about SAML-compatible identity federations in the [documentation](https://cloud.yandex.com/docs/iam/concepts/users/identity-federations).

### Version 0.50.0 (27.01.20) {#version0.50.0}

#### Changes to {{ yandex-cloud }} services {#services}

* For [resources that you can assign roles for](../iam/concepts/access-control/resources-with-access-control.md).

    Added alternatives to the `--subject` flag for role management commands: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login`, and `--all-authenticated-users`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes node-group create`

    Added the flag `--auto-scale`. You can use it to create a group of nodes whose size is dynamically adjusted by [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### {{ compute-name }} {#compute}

* Command `yc compute instance create`

  If you specify the `--gpus` flag, the `gpu-standard-v1` platform is automatically selected.

### Version 0.49.0 (21.01.20) {#version0.49.0}

#### Changes to the CLI {#cli}

**Improved**

* When running the YC CLI with the `--debug` flag, the API call response log line now outputs not only the gRPC status code, but also its description.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ kms-name }} {#kms}

Support for the cryptographic key management service: {{ kms-full-name }}.

{{ kms-full-name }} (KMS) lets you create encryption keys and implement data protection models in your applications and services.
Use the keys to protect your secrets, private data, and other confidential information you store in the cloud.

The {{ kms-full-name }} service is at the Preview stage. Read more about the service in the [documentation](https://cloud.yandex.com/docs/kms/).

### Version 0.48.0 (27.12.19) {#version0.48.0}

#### Changes to the CLI {#cli}

**Improved**

* When updating YC CLI, the current version to be installed is now displayed.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Added ability to use placement groups: `yc compute placement-group --help`.

* Commands `yc compute instance create` and `yc compute instance update`

    Renamed the flag used for specifying the platform from `--platform-id` to `--platform`. The old flag name is still supported.

* Command `yc compute instance create`

    SSH keys added using the `--ssh-key` flag are saved to the metadata with the `ssh-keys` key instead of `ec2-user-data`.

#### Managed database services {#managed-db}

**{{ mmy-name }}**

* Added support for creating a cluster with {{ MY }} version 8.0.

* Added a command to manually switch the master for a specified cluster: {{ MY }} `{{ yc-mdb-my }} cluster start-failover`.

* Command `{{ yc-mdb-my }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

**{{ mpg-name }}**

* Added a command to manually switch the master for a specified cluster: {{ PG }} `{{ yc-mdb-pg }} cluster start-failover`.

* Command `{{ yc-mdb-pg }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

**{{ mrd-name }}**

* Command `{{ yc-mdb-rd }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

### Version 0.47.0 (17.12.19) {#version0.47.0}

#### Changes to the CLI {#cli}

**Improved**

* [Federated authentication](operations/authentication/federated-user.md) is now supported for non-interactive `yc` calls. This mode is used when the CLI is not started directly by the user, like when it is started via a script or `kubectl` when working with the [Kubernetes cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster) in {{ managed-k8s-name }}.

### Version 0.46.0 (13.12.19) {#version0.46.0}

#### Changes to the CLI {#cli}

**Improved**

* To accelerate authorization diagnostics, the CRC32 of the sent [IAM token](../iam/concepts/authorization/iam-token.md) is written to the request debug log.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Added the `yc serverless trigger create object-storage` command to subscribe to bucket updates in {{ objstorage-name }}.

### Version 0.45.0 (03.12.19) {#version0.45.0}

#### Changes to the CLI {#cli}

**Improved**

* Increased the time between reconnection attempts if any resource involved in the execution of a command is unavailable.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ iot-name }} {#iot}

* Added commands for managing passwords: `yc iot registry password` and `yc iot device password`.

* Commands `yc iot registry create` and `yc iot device create`

    Added flags to enable login and password authorization: `--password`, `--read-password`, and `--generate-password`.

* Commands `yc iot mqtt publish` and `yc iot mqtt subscribe`

    Added flags to enable login and password authorization: `--username` and `--password`.

### Version 0.44.0 (19.11.19) {#version0.44.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ sf-name }} {#serverless-functions}

* Added the command `yc serverless trigger create timer` for timed function calls.

#### Changes to the CLI {#cli}

**Fixed**

* Fixed an error that in rare cases caused several lines of the `debug` log to result in `stdout`.

**Improved**

* Disabled the display of the `Status.details` field for gRPC errors. Information from it is duplicated in the `Status.message` field, which is shown as the main error message.

### Version 0.43.1 (14.11.19)

#### Changes to the CLI {#cli}

**Fixed**

* For Windows Subsystem for Linux (WSL), the browser now opens correctly when logging in to the CLI using [SAML-compatible identity federations](../iam/concepts/users/identity-federations.md).

### Version 0.43.0 (11.11.19) {#version0.43.0}

#### Changes to the CLI {#cli}

* Added CLI authentication using [SAML-compatible identity federations](../iam/concepts/users/identity-federations.md).

    To do this, run the command `yc init --federation-id=<FEDERATION_ID>` to use the CLI on behalf of the federated user.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Added details to the logged data and error text on [authorization from within a virtual machine](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (using an IAM token from the metadata).

#### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* Added support for {{ PG }} version 12 database creation.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 4.2.

### Version 0.42.0 (21.10.19) {#version0.42.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Added commands `yc compute instance-group start` and `yc compute instance-group stop` for starting and stopping instance groups.

#### {{ container-registry-name }} {#container-registry}

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`

   Added alternative spellings for `--container-restart-policy` flag values "always"," never", and "on-failure": "Always", "Never", "OnFailure".

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`

    Deleted the `--default-gateway-v4-address` flag.

#### Changes to managed database services {#managed-db}

**{{ mpg-name }}**

* Commands `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore`

   Added the value `10_1s` for the `-- postgresql-version string` flag to create {{ PG }} cluster version 10-1C.

### Version 0.41.1 (26.09.19) {#version0.41.1}

* Minor fixes and updates.

### Version 0.41.0 (25.09.19) {#version0.41.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

* Command `yc compute instance create-with-container`

    The `--create-boot-disk` flag no longer supports `snapshot-*` parameters.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster create`

    Added flags to control the master type: `--regional`, `--region`, and `--master-location`.

* Commands `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update`

    Added flags to manage the maintenance policy: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.

* Command `yc managed-kubernetes node-groups update`

    Added flags to manage the maintenance policy: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.

### Version 0.40.0 (20.09.19) {#version0.40.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

* Added a command to obtain detailed registry information: `yc container registry repository get`.

* Command `yc container registry repository list`

    Added unique registry ID to the output.

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> create clusters`

    For `--*resource-preset` flags, added a default value: s2.micro.

**{{ mmg-name }}**

* Command `{{ yc-mdb-mg }} create clusters`

    For the `--mongodb-version` flag, changed the default value from 3.6 to 4.0.

### Version 0.39.0 (16.09.19) {#version0.39.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

* Command `yc container registry`

    Added the ability to set and view a list of roles for the Docker image registry: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> users list`

    The unique cluster ID is no longer displayed when viewing a list of users.

### Version 0.38.0 (09.09.19) {#version0.38.0}

#### Changes to the CLI {#cli}

**Improved**

* Improved output of fields when viewing a list of API keys.

### Version 0.37.0 (06.09.19) {#version0.37.0}

#### Changes to the CLI {#cli}

**Improved**

* Added API endpoint availability checks for {{ iam-short-name }}, {{ resmgr-short-name }}, and {{ compute-short-name }}. If an endpoint is unavailable, an error is returned.
* Added detailed error messages.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ container-registry-name }} {#container-registry}

**Improved**

* Added Windows support for Docker Credential helper.
* Added a detailed error when using `docker login` in parallel with Docker Credential helper.

#### {{ ig-name }} {#instance-groups}

* Added commands for managing instance group metadata: `yc compute instance-group add-metadata` and `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster update`

    Added `--node-service-account-id` and `--node-service-account-name` flags to add or change service accounts for nodes in an existing {{ k8s }} cluster.

* Command `yc managed-kubernetes node-group update`

    Added flags to edit existing node group parameters: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, and `--preemptible`.

* Added commands for managing labels: `yc managed-kubernetes node-group add-labels` and `yc managed-kubernetes node-group remove-labels`.

* Added commands for managing node group metadata: `yc managed-kubernetes node-group add-metadata` and `yc managed-kubernetes node-group remove-metadata`.

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Command `{{ yc-mdb-pg }} cluster update`

    Added the `--connection-pool-discard` flag for disabling the connection pooler.

* Commands `{{ yc-mdb-pg }} user create` and `yc managed-postgresql user update`

    Added ability to specify a user's login and set their access rights using the`--login` and `--grants` flags.

### Version 0.36.0 (27.08.19) {#version0.36.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ resmgr-name }} {#resmgr}

* Command `yc resource-manager cloud update`

    Added the ability to rename clouds.

### Version 0.35.1 (16.08.19) {#version0.35.1}

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> cluster create`

    Renamed default disk types: `network-nvme` is now `network-ssd` and `local-nvme` is now `local-ssd`.

### Version 0.35.0 (09.08.19) {#version0.35.0}

#### Changes to the CLI {#cli}

**Improved**

* Added a link to the documentation with release descriptions in the message about the new CLI version.

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Command `{{ yc-mdb-pg }} cluster create`

    Added the following parameters to the `--user` flag: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, and `log-statement`.

### Version 0.34.0 (26.07.19) {#version0.34.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mrd-name }}**

* Command `{{ yc-mdb-rd }} shards`

    Added shard support for Redis clusters.

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} cluster add-external-dictionary`

    Added PostgreSQL dictionary support. Flags for working with dictionaries: `--postgresql-source`, `--postgresql-source-hosts`, and `--postgresql-invalidate-query`.

**{{ mmy-name }}**

* Command `{{ mmy-name }} cluster update-config --set`

    Added the ability to globally set the SQL mode using `sql_mode`.

### Version 0.33.0 (19.07.19) {#version0.33.0}

#### Changes to the CLI {#cli}

**Improved**

* Changed command progress indicator from dots to [throbber](https://en.wikipedia.org/wiki/Throbber).

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

* Commands `{{ yc-mdb-pg }} user create` and `{{ yc-mdb-pg }} user update`

    Added ability to set user parameters with flags such as `--lock_timeout` and `--log_min_duration_statement`.

### Version 0.32.0 (05.07.19) {#version0.32.0}

#### Changes to the CLI {#cli}

**Improved**

* Commands for displaying a list of elements `yc <service> <resource> list`.

   The maximum number of elements to output has been increased from 100 to 1000.

#### Changes to {{ yandex-cloud }} services {#services}

#### Managed database services {#managed-db}

**{{ mmg-name }}**

* Commands `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster update-config`

    In [sharded](../managed-mongodb/concepts/sharding.md) clusters, you can now change `mongos` and `mongocfg` component parameters.

### Version 0.31.0 (01.07.19) {#version0.31.0}

#### Changes to the CLI {#cli}

**Improved**

* When using the CLI on a virtual machine launched under a service account, the CLI will be authorized under this service account by default.

**Fixed**

* Attempts to get resources by specifying their unique ID failed if the CLI configuration did not specify a `folder-id` parameter.

* Attempts to get folders by specifying their unique ID failed if the user didn't have the `viewer` role for the folder in {{ yandex-cloud }}.

* The `yc init` command failed if the user didn't have the `viewer` role in {{ yandex-cloud }}.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ network-load-balancer-name }} {#load-balancer}

* Commands `yc load-balancer network-load-balancer create` and `yc load-balancer network-load-balancer update`

    For the `--listener` flag, you can now set the `target-port` parameter, which lets you configure NAT so that target resources receive traffic on a port other than `listener`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `{{ yc-mdb-ch }} user create` and `{{ yc-mdb-ch }} user update`

    Added the `--settings` flag that lets you pass user settings.

### Version 0.30.0 (18.06.19) {#version0.30.0}

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute}

* Command `yc compute instance update`

    Added the `--service-account-id` and `--service-account-name` flags, which let you add and change service accounts for existing virtual machines.

* Command `yc compute instance create`

    Changed the default number of cores used when creating a virtual machine with the Intel Cascade Lake platform (`standard-v2`). It's now `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

* Command `yc managed-kubernetes cluster update`

    Added the `--default-gateway-v4-address` flag that lets you update the gateway address for an existing {{ k8s }} cluster.

### Version 0.29.0 (11.06.19) {#version0.29.0}

* Minor fixes and updates.

### Version 0.28.0 (05.06.19) {#version0.28.0}

#### Changes to the CLI {#cli}

* Added automatic reconnect if any resource involved in the execution of a command is unavailable. The CLI will try to reconnect 5 times, and the retry frequency is calculated using exponential backoff.

#### Changes to {{ yandex-cloud }} services {#services}

#### {{ compute-name }} {#compute-cloud}

* Command `yc compute instance create`

    Added the `--gpus` flag, which lets you specify the number of GPUs in a virtual machine.

#### Managed database services {#managed-db}

**All managed database services**

* Command `yc <managed DB service name> cluster get`

    Improved cluster information printout.

* Command `yc <managed DB service name> cluster create`

    Added the `--backup-window-start` flag, which lets you set the daily cluster backup time when creating a cluster.

**{{ mch-name }}**

* Command `{{ yc-mdb-ch }} cluster add-zooker`

    Added the ability to add ZooKeeper hosts.

* Command `{{ yc-mdb-ch }} shards add`

    Changed the logic of creating shards:
    - If the `--host` flag is not specified, the shard parameters are copied from the old shard.
    - If the `--host` flag is specified, all parameters must be entered.
    - If there are no shards, all parameters have to be entered to create a shard.

