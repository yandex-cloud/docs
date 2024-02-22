# Management event reference

The value of the `event_type` field in a management (control plane) event audit log is determined by the event source service.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

On this page, you will find events for the following services:

* [{{ api-gw-name }}](#api-gateway)
* [{{ alb-name }}](#alb)
* [{{ at-name }}](#audit-trails)
* [{{ certificate-manager-name }}](#certificate-manager)
* [{{ cloud-apps-name }}](#cloud-apps)
* [{{ dns-name }}](#dns)
* [{{ sf-name }}](#functions)
* [{{ backup-name }}](#backup)
* [{{ cdn-name }}](#cdn)
* [{{ cloud-logging-name }}](#cloud-logging)
* [{{ compute-name }}](#compute)
* [{{ container-registry-name }}](#container-registry)
* [{{ dataproc-name }}](#dataproc)
* [{{ data-transfer-name }}](#datatransfer)
* [{{ ml-platform-name }}](#datasphere)
* [{{ iam-name }}](#iam)
* [{{ iot-name }}](#iot)
* [{{ kms-name }}](#kms)
* [{{ load-testing-name }}](#loadtesting)
* [{{ lockbox-name }}](#lockbox)
* [{{ mkf-short-name }}](#managed-service-for-kafka)
* [{{ mch-short-name }}](#managed-service-for-clickhouse)
* [{{ mgl-full-name }}](#managed-service-for-gitlab)
* [{{ mgp-short-name }}](#managed-service-for-greenplum)
* [{{ mmg-short-name }}](#managed-service-for-mongodb)
* [{{ managed-k8s-name }}](#managed-service-for-kubernetes)
* [{{ mmy-short-name }}](#managed-service-for-mysql)
* [{{ mpg-short-name }}](#managed-service-for-postgresql)
* [{{ mrd-short-name }}](#managed-service-for-redis)
* [{{ mes-short-name }}](#managed-service-for-elasticsearch)
* [{{ mos-short-name }}](#managed-service-for-opensearch)
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ search-api-name }}](#searchapi)
* [{{ serverless-containers-name }}](#serverless-containers)
* [{{ org-name }}](#organization)
* [{{ resmgr-name }}](#resmgr)
* [{{ sws-name }}](#smartwebsecurity)
* [{{ captcha-name }}](#smartcaptcha)
* [{{ vpc-name }}](#vpc)
* [{{ ydb-short-name }}](#ydb)
* [{{ yq-short-name }}](#yq)

## {{ api-gw-name }} {#api-gateway}

Service name: `serverless.apigateway`.

| Event name | Description |
--- | ---
| `CreateApiGateway` | Creating a gateway |
| `DeleteApiGateway` | Deleting a gateway |
| `UpdateApiGateway` | Updating a gateway |


## {{ alb-name }} {#alb}

Service name: `apploadbalancer`.

{% include [alb-events](../../_includes/audit-trails/events/alb-events.md) %}

## {{ at-name }} {#audit-trails}

Service name: `audittrails`.

| Event name | Description |
--- | ---
| `CreateTrail` | Creating a trail |
| `DeleteTrail` | Deleting a trail |
| `SetTrailAccessBindings` | Setting access bindings for a trail |
| `UpdateTrail` | Editing a trail |
| `UpdateTrailAccessBindings` | Updating access bindings for a trail |

## {{ sf-name }} {#functions}

Service name: `serverless`.

| Event name | Description |
--- | ---
| `functions.CreateFunction` | Creating a function |
| `functions.CreateFunctionVersion` | Creating a function version |
| `functions.DeleteFunction` | Deleting a function |
| `functions.DeleteFunctionVersion` | Destroying a function version |
| `functions.RemoveFunctionTag` | Removing a function tag |
| `functions.RemoveScalingPolicy` | Deleting a function scaling policy |
| `functions.SetFunctionTag` | Assigning a function tag |
| `functions.SetFunctionAccessBindings` | Setting access bindings for a function |
| `functions.SetScalingPolicy` | Assigning a function scaling policy |
| `functions.UpdateFunction` | Updating a function |
| `functions.UpdateFunctionAccessBindings` | Updating access bindings for a function |
| `mdbproxy.CreateProxy` | Creating a proxy |
| `mdbproxy.DeleteProxy` | Deleting a proxy |
| `mdbproxy.UpdateProxy` | Updating a proxy |
| `triggers.CreateTrigger` | Creating a trigger |
| `triggers.DeleteTrigger` | Deleting a trigger |
| `triggers.UpdateTrigger` | Updating a trigger |


## {{ backup-name }} {#backup}

Service name: `backup`.

{% include [backup-events](../../_includes/audit-trails/events/backup-events.md) %}


## {{ cdn-name }} {#cdn}

Service name: `cdn`.

{% include [cdn-events](../../_includes/audit-trails/events/cdn-events.md) %}

## {{ certificate-manager-name }} {#certificate-manager}

Service name: `certificatemanager`.

{% include [cm-events](../../_includes/audit-trails/events/cm-events.md) %}

## {{ cloud-apps-name }} {#cloud-apps}

Service name: `cloudapps`.

| Event name | Description |
--- | ---
| `CreateCloudApplication` | Creating an application |
| `DeleteCloudApplication` | Deleting an application |
| `UpdateCloudApplication` | Updating an application |

## {{ dns-name }} {#dns}

Service name: `dns`.

{% include [dns-events](../../_includes/audit-trails/events/dns-events.md) %}

## {{ cloud-logging-name }} {#cloud-logging-name}

Service name: `logging`.

| Event name | Description |
--- | ---
| `ChangeLogGroupAccessBindings` | Updating access bindings for a log group |
| `CreateExport` | Creating a log export |
| `CreateLogGroup` | Creating a log group |
| `CreateRoutingRule` | Creating a routing rule |
| `CreateSink` | Creating a log sink |
| `UpdateLogGroup` | Updating a log group |
| `DeleteExport` | Deleting a log export |
| `DeleteLogGroup` | Deleting a log group |
| `DeleteRoutingRule` | Deleting a routing rule |
| `DeleteSink` | Deleting a log sink |
| `SetExportAccessBindings` | Setting access bindings for a log export |
| `SetLogGroupAccessBindings` | Setting access bindings for a log group |
| `SetRoutingRuleAccessBindings` | Setting access bindings for a routing rule |
| `SetSinkAccessBindings` | Setting access bindings for a log sink |
| `UpdateExport` | Updating a log export |
| `UpdateExportAccessBindings` | Updating access bindings for a log export |
| `UpdateLogGroupAccessBindings` | Updating access bindings for a log group |
| `UpdateRoutingRule` | Updating a routing rule |
| `UpdateRoutingRuleAccessBindings` | Updating access bindings for a routing rule |
| `UpdateSink` | Updating a log sink |
| `UpdateSinkAccessBindings` | Updating access bindings for a log sink |

## {{ compute-name }} {#compute}

Service name: `compute`.

{% include [compute-events](../../_includes/audit-trails/events/compute-events.md) %}

## {{ container-registry-name }} {#container-registry}

Service name: `containerregistry`.

| Event name | Description |
--- | ---
| `CreateImage` | Creating an image |
| `CreateImageTag` | Creating an image tag |
| `CreateLifecyclePolicy` | Creating a lifecycle policy |
| `CreateRegistry` | Creating a registry |
| `CreateRepository` | Creating a repository |
| `CreateScanPolicy` | Creating a scan policy |
| `DeleteImage` | Deleting an image |
| `DeleteImageTag` | Deleting an image tag |
| `DeleteLifecyclePolicy` | Deleting a lifecycle policy |
| `DeleteRegistry` | Deleting a registry |
| `DeleteRepository` | Deleting a repository |
| `DeleteScanPolicy` | Deleting a scan policy |
| `ScanImage` | Scanning an image |
| `SetIpPermission` | Assigning an IP access policy |
| `UpdateIpPermission` | Updating policies for accessing a registry from IP addresses |
| `UpdateLifecyclePolicy` | Updating a lifecycle policy |
| `UpdateRegistry` | Updating a registry |
| `UpdateScanPolicy` | Updating a scan policy |
| `UpdateRegistryAccessBindings` | Updating access bindings for a registry |
| `UpdateRepositoryAccessBindings` | Updating access bindings for a repository |
| `SetRegistryAccessBindings` | Setting access bindings for a registry |
| `SetRepositoryAccessBindings` | Setting access bindings for a repository |

## {{ dataproc-name }} {#dataproc}

Service name: `dataproc`.

| Event name | Description |
--- | ---
| `CreateCluster` | Creating a cluster |
| `CreateSubcluster` | Creating a subcluster |
| `DeleteCluster` | Deleting a cluster |
| `DeleteSubcluster` | Deleting a subcluster |
| `StartCluster` | Starting a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `UpdateSubcluster` | Updating subclusters |

## {{ data-transfer-name }} {#datatransfer}

Service name: `datatransfer`.

| Event name | Description |
--- | ---
| `ActivateTransfer` | Activating a transfer |
| `CreateEndpoint` | Creating an endpoint |
| `CreateTransfer` | Creating a transfer |
| `DeactivateTransfer` | Deactivating a transfer |
| `DeleteEndpoint` | Deleting an endpoint |
| `DeleteTransfer` | Deleting a transfer |
| `FreezeTransferVersion` | Committing a certain data plane version for a transfer |
| `RestartTransfer` | Restarting a transfer |
| `UnfreezeTransferVersion` | Enabling transfer upgrades to the latest data plane version |
| `UpdateEndpoint` | Updating an endpoint |
| `UpdateTransfer` | Updating a transfer |
| `UpdateTransferVersion` | Updating the version of a data plane transfer |

## {{ ml-platform-name }} {#datasphere}

Service name: `datasphere`.

{% include [ds-events](../../_includes/audit-trails/events/ds-events.md) %}

## {{ iam-name }} {#iam}

Service name: `iam`.

{% include [iam-events](../../_includes/audit-trails/events/iam-events.md) %}

## {{ iot-name }} {#iot}

Service name: `iot`.

| Event name | Description |
--- | ---
| `devices.CreateDevice` | Creating a device |
| `devices.CreateRegistry` | Creating a registry |
| `devices.DeleteDevice` | Deleting a device |
| `devices.DeleteRegistry` | Deleting a registry |
| `devices.UpdateDevice` | Updating a device |
| `devices.UpdateRegistry` | Updating a registry |

## {{ kms-name }} {#kms}

Service name: `kms`.

{% include [kms-events](../../_includes/audit-trails/events/kms-events.md) %}

## {{ load-testing-name }} {#loadtesting}

Service name: `loadtesting`.

| Event name | Description |
--- | ---
| `CreateAgent` | Creating an agent |
| `CreateConfig` | Creating a configuration |
| `CreateMigration` | Creating a migration |
| `CreateTest` | Creating a test |
| `DeleteAgent` | Deleting an agent |
| `DeleteConfig` | Deleting a configuration |
| `DeleteTest` | Deleting a test |
| `RestartAgent` | Restarting an agent |
| `StartAgent` | Running an agent |
| `StopAgent` | Stopping an agent |
| `StopTest` | Stopping a test |
| `UpdateAgent` | Updating an agent |
| `UpdateTest` | Updating a test |
| `UpgradeImageAgent` | Updating an agent image |

## {{ lockbox-name }} {#lockbox}

Service name: `lockbox`.

{% include [lockbox-events](../../_includes/audit-trails/events/lockbox-events.md) %}

## {{ mkf-short-name }} {#managed-service-for-kafka}

Service name: `mdb.kafka`.

| Event name | Description |
--- | ---
| `CreateCluster` | Creating a cluster |
| `DeleteCluster` | Deleting a cluster |
| `StartCluster` | Starting a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `CreateConnector` | Creating a connector |
| `CreateTopic` | Creating a topic |
| `CreateUser` | Creating a cluster user |
| `DeleteConnector` | Deleting a connector |
| `DeleteTopic` | Deleting a topic |
| `DeleteUser` | Deleting a cluster user |
| `GrantUserPermission` | Granting permissions to a cluster user |
| `MoveCluster` | Moving a cluster |
| `PauseConnector` | Pausing a connector |
| `ResumeConnector` | Resuming a connector |
| `RevokeUserPermission` | Revoking a cluster user's permissions |
| `UpdateConnector` | Updating a connector |
| `UpdateTopic` | Updating a topic |
| `UpdateUser` | Updating a cluster user |

## {{ mch-short-name }} {#managed-service-for-clickhouse}

Service name: `mdb.clickhouse`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `AddClusterShard` | Adding a shard to a cluster |
| `AddClusterZookeeper` | Adding a ZooKeeper subcluster to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating a cluster |
| `CreateClusterExternalDictionary` | Creating an external dictionary |
| `CreateDatabase` | Creating a database |
| `CreateFormatSchema` | Creating a data format schema |
| `CreateMlModel` | Creating a machine learning model |
| `CreateShardGroup` | Creating a shard group |
| `CreateUser` | Creating a database user |
| `DeleteCluster` | Deleting a cluster |
| `DeleteClusterExternalDictionary` | Deleting an external dictionary |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteClusterShard` | Deleting a shard from a cluster |
| `DeleteDatabase` | Deleting a database |
| `DeleteFormatSchema` | Deleting a data format schema |
| `DeleteMlModel` | Deleting a machine learning model |
| `DeleteShardGroup` | Deleting a shard group |
| `DeleteUser` | Deleting a database user |
| `GrantUserPermission` | Assigning privileges to a database user |
| `MoveCluster` | Moving a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `RevokeUserPermission` | Revoking a database user's privileges |
| `StartCluster` | Starting a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `UpdateClusterExternalDictionary` | Editing an external dictionary |
| `UpdateClusterShard` | Editing a cluster shard |
| `UpdateFormatSchema` | Editing a data schema format |
| `UpdateMlModel` | Editing a machine learning model |
| `UpdateShardGroup` | Editing a shard group |
| `UpdateUser` | Editing a database user |


## {{ mgl-name }} {#managed-service-for-gitlab}

Service name: `gitlab`.

| Event name | Description |
--- | ---
| `BackupInstance` | Creating backups |
| `CleanupRegistryInstance` | Docker Registry cleanup |
| `CreateInstance` | Creating an instance |
| `CreateInstanceBackup` | Creating an instance backup |
| `DeleteInstance` | Deleting an instance |
| `ReconfigureGitlab` | Editing the {{ GL }} configuration |
| `RescheduleMaintenance` | Changing scheduled maintenance date and time |
| `ResizeInstance` | Resizing an instance |
| `ScheduleUpgrade` | Setting the instance upgrade time |
| `StartInstance` | Launching an instance |
| `StopInstance` | Stopping an instance |
| `UpdateInstance` | Updating an instance |
| `UpdateOmniauthInstance` | Updating OmniAuth settings |
| `UpgradeInstance` | Updating the GitLab version |


## {{ mgp-short-name }} {#managed-service-for-greenplum}

Service name: `mdb.greenplum`.

| Event name | Description |
--- | ---
| `CreateCluster` | Creating a cluster |
| `CreateHBARule` | Creating a user authentication rule |
| `CreatePXFDatasource` | Creating a connection to an external table |
| `DeleteBackup` | Deleting backups |
| `DeleteCluster` | Deleting a cluster |
| `DeleteHBARule` | Deleting a user authentication rule |
| `DeletePXFDatasource` | Deleting an external table connection |
| `ExpandCluster` | Expanding a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `UpdateHBARule` | Updating a user authentication rule |
| `UpdatePXFDatasource` | Updating an external table connection |


## {{ mmg-short-name }} {#managed-service-for-mongodb}

Service name: `mdb.mongodb`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `AddClusterShard` | Adding a shard to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating a cluster |
| `DeleteBackup` | Deleting backups |
| `DeleteCluster` | Deleting a cluster |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteClusterShard` | Deleting a shard from a cluster |
| `EnableClusterSharding` | Enabling sharding for a cluster |
| `MoveCluster` | Moving a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `ResetupHosts` | Resyncing a host |
| `RestartHosts` | Restarting a host |
| `StepdownHosts` | Changing the master host |


## {{ managed-k8s-name }} {#managed-service-for-kubernetes}

Service name: `k8s`.

{% include [managed-k8s-events](../../_includes/audit-trails/events/managed-k8s-events.md) %}

## {{ mmy-short-name }} {#managed-service-for-mysql}

Service name: `mdb.mysql`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating a cluster |
| `DatabaseUserLogin` | Connecting a user to the database |
| `DatabaseUserLogout` | Disconnecting a user from the database |
| `DeleteBackup` | Deleting backups |
| `DeleteCluster` | Deleting a cluster |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `MoveCluster` | Moving a cluster |
| `RescheduleMaintenance` | Changing scheduled maintenance date and time |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting a cluster |
| `StartClusterFailover` | Launching master switching for a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `UpdateClusterHosts` | Editing hosts in a cluster |

## {{ mpg-short-name }} {#managed-service-for-postgresql}

Service name: `mdb.postgresql`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating a cluster |
| `DatabaseUserLogin` | Connecting a user to the database |
| `DatabaseUserLogout` | Disconnecting a user from the database |
| `DeleteBackup` | Deleting backups |
| `DeleteCluster` | Deleting a cluster |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `MoveCluster` | Moving a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting a cluster |
| `StartClusterFailover` | Launching master switching for a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `UpdateClusterHosts` | Editing hosts in a cluster |

## {{ mrd-short-name }} {#managed-service-for-redis}

Service name: `mdb.redis`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `AddClusterShard` | Adding a shard to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating a cluster |
| `DeleteCluster` | Deleting a cluster |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteClusterShard` | Deleting a shard from a cluster |
| `MoveCluster` | Moving a cluster |
| `RebalanceCluster` | Rebalancing a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting a cluster |
| `StartClusterFailover` | Launching master switching for a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `UpdateClusterHosts` | Updating cluster hosts |

## {{ mes-short-name }} {#managed-service-for-elasticsearch}

Service name: `mdb.elasticsearch`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating a cluster |
| `DeleteCluster` | Deleting a cluster |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `MoveCluster` | Moving a cluster |
| `RescheduleMaintenance` | Changing scheduled maintenance date and time |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |

## {{ mos-short-name }} {#managed-service-for-opensearch}

Service name: `mdb.opensearch`.

| Event name | Description |
--- | ---
| `AddDashboardsNodeGroup` | Adding a `Dashboards` host group |
| `AddOpenSearchNodeGroup` | Adding an `OpenSearch` host group |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating a cluster |
| `DeleteCluster` | Deleting a cluster |
| `DeleteDashboardsNodeGroup` | Deleting a `Dashboards` host group |
| `DeleteOpenSearchNodeGroup` | Deleting an `OpenSearch` host group |
| `MoveCluster` | Moving a cluster |
| `RescheduleMaintenance` | Changing scheduled maintenance date and time |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting a cluster |
| `StopCluster` | Stopping a cluster |
| `UpdateCluster` | Updating a cluster |
| `UpdateDashboardsNodeGroup` | Updating a `Dashboards` host group |
| `UpdateOpenSearchNodeGroup` | Updating an `OpenSearch` host group |

## {{ network-load-balancer-name }} {#network-load-balancer}

Service name: `loadbalancer`.

{% include [network-load-balancer-events](../../_includes/audit-trails/events/network-load-balancer-events.md) %}

## {{ objstorage-name }} {#objstorage}

Service name: `storage`.

{% include [storage-events](../../_includes/audit-trails/events/storage-events.md) %}

## {{ search-api-name }} {#searchapi}

Service name: `searchapi`.

{% include [searchapi-events](../../_includes/audit-trails/events/searchapi-events.md) %}

## {{ serverless-containers-name }} {#serverless-containers}

Service name: `serverless.containers`.

| Event name | Description |
--- | ---
| `CreateContainer` | Creating a container |
| `DeleteContainer` | Deleting a container |
| `DeployContainerRevision` | Creating a container revision |
| `RollbackContainer` | Rolling back to a target container revision |
| `SetContainerAccessBindings` | Setting access bindings to a container |
| `UpdateContainer` | Updating a container |
| `UpdateContainerAccessBindings` | Updating access bindings to a container |
| `mdbproxy.CreateProxy` | Creating a proxy |
| `mdbproxy.DeleteProxy` | Deleting a proxy |
| `mdbproxy.UpdateProxy` | Updating a proxy |
| `triggers.CreateTrigger` | Creating a trigger |
| `triggers.DeleteTrigger` | Deleting a trigger |
| `triggers.UpdateTrigger` | Updating a trigger |

## {{ org-name }} {#organization}

The name of the service is `organizationmanager`.

{% include [org-events](../../_includes/audit-trails/events/org-events.md) %}

## {{ resmgr-name }} {#resmgr}

Service name: `resourcemanager`.

{% include [resmgr-events](../../_includes/audit-trails/events/resmgr-events.md) %}

## {{ sws-name }} {#smartwebsecurity}

Service name: `smartwebsecurity`.

{% include [sws-events](../../_includes/audit-trails/events/sws-events.md) %}

## {{ captcha-name }} {#smartcaptcha}

Service name: `smartcaptcha`.

{% include [captcha-events](../../_includes/audit-trails/events/captcha-events.md) %}

## {{ vpc-name }} {#vpc}

Service name: `network`.

{% include [vpc-events](../../_includes/audit-trails/events/vpc-events.md) %}

## {{ ydb-short-name }} {#ydb}

Service name: `ydb`.

| Event name | Description |
--- | ---
| `BackupDatabase` | Creating a database backup |
| `CreateDatabase` | Creating a database |
| `DeleteBackup` | Deleting a database backup |
| `DeleteDatabase` | Deleting a database |
| `MoveDatabase` | Moving a database |
| `RestoreBackup` | Restoring a database from a backup |
| `StartDatabase` | Starting a database |
| `StopDatabase` | Stopping a database |
| `UpdateDatabase` | Updating a database |

## {{ yq-short-name }} {#yq}

Service name: `yq`.

| Event name | Description |
--- | ---
| `ControlQuery` | Managing queries |
| `CreateBinding` | Creating a data binding |
| `CreateConnection` | Creating a connection |
| `CreateQuery` | Creating a query |
| `DeleteBinding` | Deleting a data binding |
| `DeleteConnection` | Deleting a connection |
| `DeleteQuery` | Deleting a query |
| `UpdateBinding` | Updating a data binding |
| `UpdateConnection` | Updating a connection |
| `UpdateQuery` | Updating a query |

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}