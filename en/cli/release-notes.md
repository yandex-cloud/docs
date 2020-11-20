# YC CLI Releases

## Version 0.56.0 (23.04.20) {#latest-release}

### Changes to Yandex.Cloud services {#services}

#### All services {#all}

* You can now use the `get` and `delete` commands to pass multiple resource IDs or names.

#### Managed database services {#managed-db}

**{{ mch-name }}**

* Commands `yc managed-clickhouse user create` and `yc managed-clickhouse user update`

    The `settings` flag parameters are now described in Help.

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Command `yc <managed DB service name> host list`

    The output now includes the column with `assign_public_ip` values.

**{{ mrd-name }}**

* Command `yc managed-redis host list`

    The output now includes columns with `type` and `shard_name` values.

#### {{ coi }} {#coi}

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`

  When you pass a file with environment variables using the `--container-env-file` flag, the `=` characters in variable values are now processed correctly.

## Previous releases {#previous-releases}

### Version 0.55.0 (13.04.20) {#version0.55.0}

#### Changes to the CLI {#cli}

**Improved**

- Authentication now supported for `http_proxy`.
- Autocomplete added for the `zsh` command shell.
- When an operation is terminated by **Ctrl**+**C,** `yc` shows the details for the operation running.

**Fixed**

- Fixed the 30-second wait if no `folder-id` or `folder-name` property is specified in the profile you use.

#### Changes to Yandex.Cloud services {#services}

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster create`

  Added the `--node-ipv4-mask-size` flag to configure the size of `CIDRs` allocated to each cluster node.

- Commands `yc managed-kubernetes node-group create` and `yc managed-kubernetes node-group update`

  Added the `--max-unavailable` and `--max-expansion` flags to control the number of nodes deleted and created at instance group update.

#### Managed database services {#managed-db}

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

- Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster restore`, and `yc <managed DB service name> host add`

  Added the `subnet-name` property to the `--host` flag to specify a subnet by its name.

**{{ mmg-name }}, {{ mch-name }}, {{ mrd-name }}**

- Command `yc <managed DB service name> cluster list-logs`

    Added formatting for log lines.

#### {{ coi }} {#coi}

- Command `yc compute instance create-with-container`

    Added mounting of `docker volumes` into a Docker container created in {{ coi }} by using the `container-volume-tmpfs` and `container-volume-host-path` flags.

- Command `yc compute instance update-container`

    Added ability to update `docker volumes` in a Docker container created in {{ coi }}.

### Version 0.54.0 (24.03.20) {#version0.54.0}

#### Changes to the CLI {#cli}

**Improved**

- Error messages thrown by commands and flags are now more intuitive.

#### Changes to Yandex.Cloud services {#services}

##### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster create`

  Added the `--kms-key-id` and `--kms-key-name` flags for creating {{ k8s }} clusters with secrets encryption in KMS.

### Version 0.53.0 (04.03.20) {#version0.53.0}

#### Changes to the CLI {#cli}

**Improved**

- When `yc` starts on a VM inside Yandex.Cloud with no `folder-id` specified in the `yc` config, a folder hosting the VM is used.

- Added the `--version` flag for the `yc version` command.

**Fixed**

- Fixed updating using `yc components update` on WSL 1.

- Fixed abnormal termination on invoking `yc help`.

#### Changes to Yandex.Cloud services {#services}

##### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster get-credentials`

  Added checking and warning if the user runs `kubectl` versions earlier than 1.11: such versions don't support the authentication method set by this command.

##### Managed database services {#managed-db}

**{{ mch-name }}**

- Commands `{{ yc-mdb-ch }} user`

  Added user quota management.

- Commands `{{ yc-mdb-ch }} cluster`

  Added the `metrica-access`, `datalens-access`, and `websql-access` flags to the cluster create, restore, and update commands.

- Added `{{ yc-mdb-ch }} ml-model` commands.

  It allows you to manage ML models in Clickhouse clusters.

**{{ mmg-name }}, {{ mpg-name }}, {{ mmy-name }}, {{ mrd-name }}**

- Commands `yc <managed DB service name> cluster create`, `yc <managed DB service name> cluster update`, and `yc <managed DB service name> cluster restore`.

  Added the `datalens-access` flag to manage Yandex.DataLens access to the cluster.

### Version 0.52.1 (21.02.20) {#version0.52.1}

#### Changes to the CLI {#cli}

**Fixed**

- During installation, WARN not shown for non-existent problems.

### Version 0.52.0 (21.02.20) {#version0.52.0}

#### Changes to the CLI {#cli}

**Improved**

- When you start `yc` using the `--help` or `-h` flag, interactive help opens:
 in `less` (`$PAGER`) on Linux and macOS, in `more` on Windows. Now you no longer have to scroll up through the help output.

- Debug logs for execution and API interaction are now saved to the
`$HOME/.config/yandex-cloud/logs` configuration directory rather than installation directory. This fixes the problem when `yc`, which is installed as a stand-alone binary file, suddenly tries to save its log in the same directory without the rights to it.

- Debug logs are also saved for successful requests. If you contact support about an issue 
with a `yc` command, we can likely help you faster if you attach your log file.

**Fixed**

- No update notice is shown on `yc components ...` commands.

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute}

- Command `yc compute instance create`

  Added the `nat-address` parameter to the `--network-interface` flag to assign a specific NAT address for the instance created.

- Added the commands `yc compute instance add-one-to-one-nat` and `yc compute instance remove-one-to-one-nat`.

  These commands let you manage NAT on already existing instances.

- Commands `yc compute instance create` and `yc compute instance update`

  Added the `--network-settings` flag to change the network type to `Software accelerated` and back to `Standard`.

#### {{ kms-name }} {#kms}

- Command `yc kms symmetric-key`

  Added commands to manage roles for individual keys:
`list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster create`

  Added the `--enable-network-policy` flag to create a Kubernetes cluster with
[Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) support.

- Command `yc k8s cluster get-credentials`

  Added the `--context-name` flag to let the user specify the name of the `context` created in `kubeconfig`.

  The default name at context creation is now more intuitive: `yc-<cluster-name>`.

  Execution result is now explained in the output.

### Version 0.51.0 (12.02.20) {#version0.51.0}

#### Changes to the CLI {#cli}

**Improved**

- Command `yc <service> <resource> create`

  Added the ability to pass resource names as command arguments. Сommands like `yc <service> <resource> create --name <resource name>` and `yc <service> <resource> create <resource name>` are now the same.

  For example, instead of the running the command `yc managed-kubernetes cluster create --name my-cluster ...`, you can now use the command `yc managed-kubernetes cluster create my-cluster ...`.

- Command `yc <service> <resource> set-access-binding`

  Added a warning that the command deletes assigned roles. If the user runs the command directly (rather than using another command or script), they're asked for confirmation.

**Fixed**

- Command `yc init`

  The values of the flags `--cloud-id`, `--folder-id`, and `--folder-name` are now properly recognized.

- Disabled messages about the availability of a new version of `yc` when invoking of a non-interactive command.

#### Changes to Yandex.Cloud services {#services}

#### {{iam-name}} {#iam}

- Added commands for creating and managing SAML-compatible identity federations and their certificates: `yc iam federation` and `yc iam certificate`. Learn more about SAML-compatible identity federations in the [documentation](https://cloud.yandex.ru/docs/iam/concepts/users/identity-federations).

### Version 0.50.0 (27.01.20) {#version0.50.0}

#### Changes to Yandex.Cloud services {#services}

- For [resources that you can assign roles for](../iam/concepts/access-control/resources-with-access-control.md).

    Added alternatives to the `--subject` flag for role management commands: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login`, and `--all-authenticated-users`.

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes node-group create`

    Added the flag `--auto-scale`. You can use it to create a group of nodes whose size is dynamically adjusted by [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### {{ compute-name }} {#compute}

- Command `yc compute instance create`

  If you specify the `--gpus` flag, the `gpu-standard-v1` platform is automatically selected.

### Version 0.49.0 (21.01.20) {#version0.49.0}

#### Changes to the CLI {#cli}

**Improved**

- When running the YC CLI with the `--debug` flag, the API call response log line now outputs not only the gRPC status code, but also its description.

#### Changes to Yandex.Cloud services {#services}

#### {{ kms-name }} {#kms}

Support for the cryptographic key management service: {{ kms-full-name }}.

{{ kms-full-name }} (KMS) allows you to create encryption keys and implement data protection models in your applications and services.
Use the keys to protect your secrets, private data, and other confidential information you store in the cloud.

The {{ kms-full-name }} service is at the Preview stage. Read more about the service in the [documentation](https://cloud.yandex.com/docs/kms/).

### Version 0.48.0 (27.12.19) {#version0.48.0}

#### Changes to the CLI {#cli}

**Improved**

- When updating YC CLI, the current version to be installed is now displayed.

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute}

- Added ability to use placement groups: `yc compute placement-group --help`.

- Commands `yc compute instance create` and `yc compute instance update`

    Renamed the flag used for specifying the platform from `--platform-id` to `--platform`. The old flag name is still supported.

- Command `yc compute instance create`

    SSH keys added using the `--ssh-key` flag are saved to the metadata with the `ssh-keys` key instead of `ec2-user-data`.

#### Managed database services {#managed-db}

**{{ mmy-name }}**

- Added support for creating a cluster with {{ MY }} version 8.0.

- Added a command to manually switch the master for a specified cluster: {{ MY }} `{{ yc-mdb-my }} cluster start-failover`.

- Command `{{ yc-mdb-my }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

**{{ mpg-name }}**

- Added a command to manually switch the master for a specified cluster: {{ PG }} `{{ yc-mdb-pg }} cluster start-failover`.

- Command `{{ yc-mdb-pg }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

**{{ mch-name }}**

- Command `{{ yc-mdb-ch }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

**{{ mrd-name }}**

- Command `{{ yc-mdb-rd }} cluster update`

    Added the ability to rename clusters using the `--new-name` flag.

### Version 0.47.0 (17.12.19) {#version0.47.0}

#### Changes to the CLI {#cli}

**Improved**

- [Federated authentication](operations/authentication/federated-user.md) is now supported for non-interactive `yc` calls. This mode is used when the CLI is not started directly by the user, like when it is started via a script or `kubectl` when working with the [Kubernetes cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster) in {{ managed-k8s-name }}.

### Version 0.46.0 (13.12.19) {#version0.46.0}

#### Changes to the CLI {#cli}

**Improved**

- To accelerate authorization diagnostics, the CRC32 of the sent [IAM token](../iam/concepts/authorization/iam-token.md) is written to the request debug log.

#### Changes to Yandex.Cloud services {#services}

#### {{ sf-name }} {#serverless-functions}

- Added the `yc serverless trigger create object-storage` command to subscribe to bucket updates in {{ objstorage-name }}.

### Version 0.45.0 (03.12.19) {#version0.45.0}

#### Changes to the CLI {#cli}

**Improved**

- Increased the time between reconnection attempts if any resource involved in the execution of a command is unavailable.

#### Changes to Yandex.Cloud services {#services}

#### {{ iot-name }} {#iot}

- Added commands for managing passwords: `yc iot registry password` and `yc iot device password`.

- Commands `yc iot registry create` and `yc iot device create`

    Added flags to enable login and password authorization: `--password`, `--read-password`, and `--generate-password`.

- Commands `yc iot mqtt publish` and `yc iot mqtt subscribe`

    Added flags to enable login and password authorization: `--username` and `--password`.

### Version 0.44.0 (19.11.19) {#version0.44.0}

#### Changes to Yandex.Cloud services {#services}

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

- For Windows Subsystem for Linux (WSL), the browser now opens correctly when logging in to the CLI using [SAML-compatible identity federations](../iam/concepts/users/identity-federations.md).

### Version 0.43.0 (11.11.19) {#version0.43.0}

#### Changes to the CLI {#cli}

* Added CLI authentication using [SAML-compatible identity federations](../iam/concepts/users/identity-federations.md).

    To do this, run the command `yc init --federation-id=<FEDERATION_ID>` to use the CLI on behalf of the federated user.

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute}

* Added details to the logged data and error text on [authorization from within a virtual machine](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (using an IAM token from the metadata).

#### Changes in managed database services {#managed-db}

**{{ mpg-name }}**

* Added support for {{ PG }} version 12 database creation.

**{{ mmg-name }}**

* Added support for creating a cluster with {{ MG }} version 4.2.

### Version 0.42.0 (21.10.19) {#version0.42.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute}

* Added commands `yc compute instance-group start` and `yc compute instance-group stop` for starting and stopping instance groups.

#### {{ container-registry-name }} {#container-registry}

* Commands `yc compute instance create-with-container` and `yc compute instance update-container`

   Added alternative spellings for `--container-restart-policy` flag values "always"," never", and "on-failure": "Always", "Never", "OnFailure".

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster create`

    Deleted the `--default-gateway-v4-address` flag.

#### Changes in managed database services {#managed-db}

**{{ mpg-name }}**

* Commands `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update`, and `yc managed-postgresql cluster restore`

   Added the value `10_1s` for the `-- postgresql-version string` flag to create {{ PG }} cluster version 10-1C.

### Version 0.41.1 (26.09.19) {#version0.41.1}

- Minor fixes and updates.

### Version 0.41.0 (25.09.19) {#version0.41.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ container-registry-name }} {#container-registry}

- Command `yc compute instance create-with-container`

    The `--create-boot-disk` flag no longer supports `snapshot-*` parameters.

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster create`

    Added flags to control the master type: `--regional`, `--region`, and `--master-location`.

- Commands `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update`

    Added flags to manage the maintenance policy: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.

- Command `yc managed-kubernetes node-groups update`

    Added flags to manage the maintenance policy: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.

### Version 0.40.0 (20.09.19) {#version0.40.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ container-registry-name }} {#container-registry}

- Added a command to obtain detailed registry information: `yc container registry repository get`.

- Command `yc container registry repository list`

    Added unique registry ID to the output.

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed DB service name> create clusters`

    For `--*resource-preset` flags, added a default value: s2.micro.

**{{ mmg-name }}**

- Command `{{ yc-mdb-mg }} create clusters`

    For the `--mongodb-version` flag, changed the default value from 3.6 to 4.0.

### Version 0.39.0 (16.09.19) {#version0.39.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ container-registry-name }} {#container-registry}

- Command `yc container registry`

    Added the ability to set and view a list of roles for the Docker image registry: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed DB service name> users list`

    The unique cluster ID is no longer displayed when viewing a list of users.

### Version 0.38.0 (09.09.19) {#version0.38.0}

#### Changes to the CLI {#cli}

**Improved**

- Improved output of fields when viewing a list of API keys.

### Version 0.37.0 (06.09.19) {#version0.37.0}

#### Changes to the CLI {#cli}

**Improved**

- Added API endpoint availability checks for {{ iam-short-name }}, {{ resmgr-short-name }}, and {{ compute-short-name }}. If an endpoint is unavailable, an error is returned.
- Added detailed error messages.

#### Changes to Yandex.Cloud services {#services}

#### {{ container-registry-name }} {#container-registry}

**Improved**

- Added Windows support for Docker Credential helper.
- Added a detailed error when using `docker login` in parallel with Docker Credential helper.

#### {{ ig-name }} {#instance-groups}

- Added commands for managing instance group metadata: `yc compute instance-group add-metadata` and `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster update`

    Added `--node-service-account-id` and `--node-service-account-name` flags to add or change service accounts for nodes in an existing {{ k8s }} cluster.

- Command `yc managed-kubernetes node-group update`

    Added flags to edit existing node group parameters: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, and `--preemptible`.

- Added commands for managing labels: `yc managed-kubernetes node-group add-labels` and `yc managed-kubernetes node-group remove-labels`.

- Added commands for managing node group metadata: `yc managed-kubernetes node-group add-metadata` and `yc managed-kubernetes node-group remove-metadata`.

#### Managed database services {#managed-db}

**{{ mpg-name }}**

- Command `{{ yc-mdb-pg }} cluster update`

    Added the `--connection-pool-discard` flag for disabling the connection pooler.

- Commands `{{ yc-mdb-pg }} user create` and `yc managed-postgresql user update`

    Added ability to specify a user's login and set their access rights using the`--login` and `--grants` flags.

### Version 0.36.0 (27.08.19) {#version0.36.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ resmgr-name }} {#resmgr}

- Command `yc resource-manager cloud update`

    Added the ability to rename clouds.

### Version 0.35.1 (16.08.19) {#version0.35.1}

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed DB service name> cluster create`

    Renamed default disk types: `network-nvme` is now `network-ssd` and `local-nvme` is now `local-ssd`.

### Version 0.35.0 (09.08.19) {#version0.35.0}

#### Changes to the CLI {#cli}

**Improved**

- Added a link to the documentation with release descriptions in the message about the new CLI version.

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

- Command `{{ yc-mdb-pg }} cluster create`

    Added the following parameters to the `--user` flag: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, and `log-statement`.

### Version 0.34.0 (26.07.19) {#version0.34.0}

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mrd-name }}**

- Command `{{ yc-mdb-rd }} shards`

    Added shard support for Redis clusters.

**{{ mch-name }}**

- Command `{{ yc-mdb-ch }} cluster add-external-dictionary`

    Added PostgreSQL dictionary support. Flags for working with dictionaries: `--postgresql-source`, `--postgresql-source-hosts`, and `--postgresql-invalidate-query`.

**{{ mmy-name }}**

- Command `{{ mmy-name }} cluster update-config --set`

    Added the ability to globally set the SQL mode using `sql_mode`.

### Version 0.33.0 (19.07.19) {#version0.33.0}

#### Changes to the CLI {#cli}

**Improved**

- Changed command progress indicator from dots to [throbber](https://en.wikipedia.org/wiki/Throbber).

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

- Commands `{{ yc-mdb-pg }} user create` and `{{ yc-mdb-pg }} user update`

    Added ability to set user parameters with flags such as `--lock_timeout` and `--log_min_duration_statement`.

### Version 0.32.0 (05.07.19) {#version0.32.0}

#### Changes to the CLI {#cli}

**Improved**

- Commands for displaying a list of elements `yc <service> <resource> list`.

   The maximum number of elements to output has been increased from 100 to 1000.

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mmg-name }}**

- Commands `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster update-config`

    In [sharded](../managed-mongodb/concepts/sharding.md) clusters, you can now change `mongos` and `mongocfg` component parameters.

### Version 0.31.0 (01.07.19) {#version0.31.0}

#### Changes to the CLI {#cli}

**Improved**

- When using the CLI on a virtual machine launched under a service account, the CLI will be authorized under this service account by default.

**Fixed**

- Attempts to get resources by specifying their unique ID failed if the CLI configuration did not specify a `folder-id` parameter.

- Attempts to get folders by specifying their unique ID failed if the user did not have the `viewer` role for the folder in Yandex.Cloud.

- The `yc init` command failed if the user didn't have the `viewer` role in Yandex.Cloud.

#### Changes to Yandex.Cloud services {#services}

#### {{ load-balancer-name }} {#load-balancer}

- Commands `yc load-balancer network-load-balancer create` and `yc load-balancer network-load-balancer update`

    For the `--listener` flag, you can now set the `target-port` parameter, which lets you configure NAT so that target resources receive traffic on a port other than `listener`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

- Commands `{{ yc-mdb-ch }} user create` and `{{ yc-mdb-ch }} user update`

    Added the `--settings` flag that lets you pass user settings.

### Version 0.30.0 (18.06.19) {#version0.30.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute}

- Command `yc compute instance update`

    Added the `--service-account-id` and `--service-account-name` flags, which let you add and change service accounts for existing virtual machines.

- Command `yc compute instance create`

    Changed the default number of cores used when creating a virtual machine with the Intel Cascade Lake platform (`standard-v2`). It's now `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster update`

    Added the `--default-gateway-v4-address` flag that lets you update the gateway address for an existing {{ k8s }} cluster.

### Version 0.29.0 (11.06.19) {#version0.29.0}

- Minor fixes and updates.

### Version 0.28.0 (05.06.19) {#version0.28.0}

#### Changes to the CLI {#cli}

- Added automatic reconnect if any resource involved in the execution of a command is unavailable. The CLI will try to reconnect 5 times, and the retry frequency is calculated using exponential backoff.

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute-cloud}

- Command `yc compute instance create`

    Added the `--gpus` flag, which lets you specify the number of GPUs in a virtual machine.

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed DB service name> cluster get`

    Improved cluster information printout.

- Command `yc <managed DB service name> cluster create`

    Added the `--backup-window-start` flag, which lets you set the daily cluster backup time when creating a cluster.

**{{ mch-name }}**

- Command `{{ yc-mdb-ch }} cluster add-zooker`

    Added the ability to add ZooKeeper hosts.

- Command `{{ yc-mdb-ch }} shards add`

    Changed the logic of creating shards:
    - If the `--host` flag is not specified, the shard parameters are copied from the old shard.
    - If the `--host` flag is specified, all parameters must be entered.
    - If there are no shards, all parameters have to be entered to create a shard.

