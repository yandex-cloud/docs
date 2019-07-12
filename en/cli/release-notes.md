# YC CLI Releases

## Version 0.32.0 (05.07.19) {#latest-release}

### Changes to the CLI {#cli}

**Improved**

- Commands for displaying a list of `yc <service> <resource> list`

    The maximum number of elements to output has been increased from 100 to 1000.

### Changes to Yandex.Cloud services {#services}

#### Managed database services {#managed-db}

**Managed Service for MongoDB**

- `yc managed-mongodb cluster update` and `yc managed-mongodb cluster update-config`

    In sharded clusters, you can now change `mongos` and `mongocfg` component parameters.

## Previous releases {#previous-releases}

### Version 0.31.0 (01.07.19) {#version0.31.0}

#### Changes to the CLI {#cli}

**Improved**

- When using the CLI on a virtual machine launched under a service account, the CLI will be authorized under this service account by default.

**Fixed**

- Attempts to get resources by specifying their unique ID failed if the CLI configuration did not specify a `folder-id` parameter.

- Attempts to get folders by specifying their unique ID failed if the user did not have the `viewer` role for the folder in Yandex.Cloud.

- The `yc init` command failed if the user didn't have the `viewer` role in Yandex.Cloud.

#### Changes to Yandex.Cloud services {#services}

#### Load Balancer {#load-balancer}

- `yc load-balancer network-load-balancer create` and `yc load-balancer network-load-balancer update`

    For the `--listener` flag, you can now set the `target-port` parameter, which lets you configure NAT so that target resources receive traffic on a port other than `listener`.

#### Managed database services {#managed-db}

**Managed Service for ClickHouse**

- `yc managed-clickhouse user create` and `yc managed-clickhouse user update`

    Added the `--settings` flag that lets you pass user settings.

### Version 0.30.0 (18.06.19) {#version0.30.0}

#### Changes to Yandex.Cloud services {#services}

#### Compute Cloud {#compute}

- `yc compute instance update`

    Added the `--service-account-id` and `--service-account-name` flags that let you add and change service accounts for existing virtual machines.

- `yc compute instance create`

    Changed the default number of cores used when creating a virtual machine with the Intel Cascade Lake platform (`standard-v2`). It's now `cores: 2`.

#### Managed Service for Kubernetes {#k8s}

- `yc managed-kubernetes cluster update`

    Added the `--default-gateway-v4-address` flag that lets you update the gateway address for an existing Kubernetes cluster.

### Version 0.29.0 (11.06.19) {#version0.29.0}

- Minor fixes and updates.

### Version 0.28.0 (05.06.19) {#version0.28.0}

#### Changes to the CLI {#cli}

- Added automatic reconnect if any resource involved in the execution of a command is unavailable. The CLI will try to reconnect 5 times, and the retry frequency is calculated using exponential backoff.

#### Changes to Yandex.Cloud services {#services}

#### Compute Cloud {#compute-cloud}

- `yc compute instance create`

    Added the `--gpus` flag that lets you specify the number of GPUs in a virtual machine.

#### Managed database services {#managed-db}

**All managed database services**

- `yc <database name> cluster get`

    Improved cluster information printout.

- `yc <database name> cluster create`

    Added the `--backup-window-start` flag that lets you set the daily cluster backup time when creating a cluster.

**Managed Service for ClickHouse**

- `yc managed-clickhouse cluster add-zookeeper`

    Added the ability to add ZooKeeper hosts.

- `yc managed-clickhouse shards add`

    Changed the logic of creating shards:
    - If the `--host` flag is not specified, the shard parameters are copied from the old shard.
    - If the `--host` flag is specified, all parameters must be entered.
    - If there are no shards, all parameters have to be entered to create a shard.

