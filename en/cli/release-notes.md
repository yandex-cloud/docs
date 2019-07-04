# YC CLI releases

## Version 0.31.0 (01.07.19) {#latest-release}

#### Changes to the CLI {#cli}

**Improved**

- When using the CLI on a virtual machine launched under a service account, the CLI will be authorized under this service account by default.

**Fixed**

- Attempts to get resources by specifying their unique ID failed if the CLI configuration did not specify a `folder-id` parameter.

- Attempts to get folders by specifying their unique ID failed if the user did not have the `viewer` role for the folder in Yandex.Cloud.

- The `yc init` command failed if the user didn't have the `viewer` role in Yandex.Cloud.

### Changes to Yandex.Cloud services {#services}

#### {{ load-balancer-name }} {#load-balancer}

- `$ yc load-balancer network-load-balancer create` and `$ yc load-balancer network-load-balancer update`

    For the `--listener` flag, you can now set the `target-port` parameter, which lets you configure NAT so that target resources receive traffic on a port other than `listener`.

#### Managed database services {#managed-db}

**{{ mch-name }}**

- `$ yc managed-clickhouse user create` and `$ yc managed-clickhouse user update`

    Added the `--settings` flag, which lets you pass user settings.

## Previous releases {#previous-releases}

### Version 0.30.0 (18.06.19) {#version0.30.0}

#### Changes to Yandex.Cloud services {#services}

#### {{ compute-name }} {#compute}

- Command `$ yc compute instance update`.

    Added `--service-account-id` and `--service-account-name` flags, which let you add and change the service account for existing virtual machines. 

- Command `$ yc compute instance create`.

    Changed the default number of available cores when creating virtual machines with the Intel Cascade Lake platform (`standard-v2`). Now `cores: 2`.
    
#### {{ managed-k8s-name }} {#k8s}

- Command `$ yc managed-kubernetes cluster update`.
    
    Added `--default-gateway-v4-address` flag, which lets you update the gateway address for existing {{ k8s }} clusters.    

### Version 0.29.0 (11.06.19) {#version0.29.0}

- Minor fixes and updates.

### Version 0.28.0 (05.06.19) {#version0.28.0}

#### Changes to the CLI {#cli}

- Added automatic reconnect if the resource in a command is unavailable. The CLI tries to connect 5 times. Reconnect frequency is calculated with exponential backoff.

#### Changes to Yandex.Cloud services {#services}

####  {{ compute-name }} {#compute-cloud}

- Command `$ yc compute instance create`.

    Added `--gpus` flag, which lets you indicate the number of GPUs for a virtual machine.

#### Managed database services {#managed-db}

**All managed database services** 

- Command `$ yc <database name> cluster get <cluster name>`.
    
    Improved cluster data output. 

- Command `$ yc <database name> cluster create`.

    Added `--backup-window-start` flag, which lets you configure daily backup time for the cluster that is going to be created.

**{{ mch-name }}** 

- Command `$ yc managed-clickhouse cluster add-zookeeper <cluster name>`.

    Added ability to add ZooKeeper hosts.
 
- Command: `$ yc managed-clickhouse shards add`. 

    Changed shard creation logic.
    - If the `--host` flag is not given, shard parameters are copied from the oldest shard. 
    - If the `--host` flag is given, all parameters have to be entered. 
    - If shards are not present, all parameters have to be entered to create a shard.
