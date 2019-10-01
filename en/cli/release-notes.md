# YC CLI Releases

## Version 0.41.1 (26.09.19) {#latest-release}

- Minor fixes and updates.

## Previous releases {#previous-releases}

### Version 0.41.0 (25.09.19) {#version0.41.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ container-registry-name }} {#container-registry}

- Command `yc compute instance create-with-container`.

    The `--create-boot-disk` flag no longer supports `snapshot-*` parameters.

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster create`.

    Added flags to control the master type: `--regional`, `--region`, and `--master-location`.

- Commands `yc managed-kubernetes cluster create` and `yc managed-kubernetes cluster update`.

    Added flags to manage the maintenance policy: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.

- Command `yc managed-kubernetes node-groups update`.

    Added flags to manage the maintenance policy: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window`, and `--weekly-maintenance-window`.

### Version 0.40.0 (20.09.19) {#version0.40.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ container-registry-name }} {#container-registry}

- Added a command to obtain detailed registry information: `yc container registry repository get`.

- Command `yc container registry repository list`.

    Added unique registry ID to the output.

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed DB service name> create clusters`.

    For `--*resource-preset` flags, added a default value: s2.micro.

**{{ mmg-name }}**

- Command `{{ yc-mdb-mg }} create clusters`.

    For the `--mongodb-version` flag, changed the default value from 3.6 to 4.0.

### Version 0.39.0 (16.09.19) {#version0.39.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ container-registry-name }} {#container-registry}

- Command `yc container registry`.

    Added the ability to set and view a list of roles for the Docker image registry: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, and `remove-access-binding`.

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed database service name> users list`.

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

- Command `yc managed-kubernetes cluster update`.

    Added `--node-service-account-id` and `--node-service-account-name` flags to add or change service accounts for nodes in an existing {{ k8s }} cluster.

- Command `yc managed-kubernetes node-group update`.

    Added flags to edit existing node group parameters: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, and `--preemptible`.

- Added commands for managing labels: `yc managed-kubernetes node-group add-labels` and `yc managed-kubernetes node-group remove-labels`.

- Added commands for managing node group metadata: `yc managed-kubernetes node-group add-metadata` and `yc managed-kubernetes node-group remove-metadata`.

#### Managed database services {#managed-db}

**{{ mpg-name }}**

- Command `{{ yc-mdb-pg }} cluster update`.

    Added the `--connection-pool-discard` flag for disabling the connection pooler.

- Commands `{{ yc-mdb-pg }} user create` and `yc managed-postgresql user update`

    Added ability to specify a user's login and set their access rights using the`--login` and `--grants` flags.

### Version 0.36.0 (27.08.19) {#version0.36.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ resmgr-name }} {#resmgr}

- Command `yc resource-manager cloud update`.

    Added the ability to rename clouds.

### Version 0.35.1 (16.08.19) {#version0.35.1}

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed database service name> cluster create`.

    Renamed default disk types: `network-ssd` is now `network-ssd` and `local-ssd` is now `local-ssd`.
    
### Version 0.35.0 (09.08.19) {#version0.35.1}

#### Changes to the CLI {#cli}

**Improved**

- Added a link to the documentation with release descriptions in the message about the new CLI version.

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

- Command `{{ yc-mdb-pg }} cluster create`.

    Added the following parameters to the `--user` flag: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, `log-statement`.

### Version 0.34.0 (26.07.19) {#version0.34.0}

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mrd-name }}**

- Command `{{ yc-mdb-rd }} shards`.

    Added shard support for Redis clusters.

**{{ mch-name }}**

- Command `{{ yc-mdb-ch }} cluster add-external-dictionary`.

    Added PostgreSQL dictionary support. Flags for working with dictionaries: `--postgresql-source`, `--postgresql-source-hosts`, and `--postgresql-invalidate-query`.

**{{ mmy-name }}**

- Command `{{ mmy-name }} cluster update-config --set`.

    Added the ability to globally set the SQL mode using `sql_mode`.
    
### Version 0.33.0 (19.07.19) {#version0.33.0}

#### Changes to the CLI {#cli}

**Improved**

- Changed command progress indicator from dots to [throbber](https://en.wikipedia.org/wiki/Throbber).

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mpg-name }}**

- Commands `{{ yc-mdb-pg }} user create` and `{{ yc-mdb-pg }} user update`.

    Added ability to set user parameters with flags such as `--lock_timeout` and `--log_min_duration_statement`.

### Version 0.32.0 (05.07.19) {#version0.32.0}

#### Changes to the CLI {#cli}

**Improved**

- Commands for displaying lists of `yc <service> <resource> list` elements.

   The maximum number of elements to output has been increased from 100 to 1000.

#### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**{{ mmg-name }}**

- Commands `{{ yc-mdb-mg }} cluster update` and `{{ yc-mdb-mg }} cluster update-config`.

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

- Commands `yc load-balancer network-load-balancer create` and `yc load-balancer network-load-balancer update`.

    For the `--listener` flag, you can now set the `target-port` parameter, which lets you configure NAT so that target resources receive traffic on a port other than `listener`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

- Commands `{{ yc-mdb-ch }} user create` and `{{ yc-mdb-ch }} user update`.

    Added the `--settings` flag that lets you pass user settings.

### Version 0.30.0 (18.06.19) {#version0.30.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute}

- Command `yc compute instance update`.

    Added the `--service-account-id` and `--service-account-name` flags, which let you add and change service accounts for existing virtual machines.

- Command `yc compute instance create`.

    Changed the default number of cores used when creating a virtual machine with the Intel Cascade Lake platform (`standard-v2`). It's now `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

- Command `yc managed-kubernetes cluster update`.

    Added the `--default-gateway-v4-address` flag that lets you update the gateway address for an existing {{ k8s }} cluster.

### Version 0.29.0 (11.06.19) {#version0.29.0}

- Minor fixes and updates.

### Version 0.28.0 (05.06.19) {#version0.28.0}

#### Changes to the CLI {#cli}

- Added automatic reconnect if any resource involved in the execution of a command is unavailable. The CLI will try to reconnect 5 times, and the retry frequency is calculated using exponential backoff.

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute-cloud}

- Command `yc compute instance create`.

    Added the `--gpus` flag, which lets you specify the number of GPUs in a virtual machine.

#### Managed database services {#managed-db}

**All managed database services**

- Command `yc <managed database service name> cluster get`.

    Improved cluster information printout.

- Command `yc <managed database service name> cluster create`.

    Added the `--backup-window-start` flag, which lets you set the daily cluster backup time when creating a cluster.

**{{ mch-name }}**

- Command `{{ yc-mdb-ch }} cluster add-zooker`.

    Added the ability to add ZooKeeper hosts.

- Command `{{ yc-mdb-ch }} shards add`.

    Changed the logic of creating shards:
    - If the `--host` flag is not specified, the shard parameters are copied from the old shard.
    - If the `--host` flag is specified, all parameters must be entered.
    - If there are no shards, all parameters have to be entered to create a shard.

