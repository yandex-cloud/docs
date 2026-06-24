# Switching a component to a different storage class

When deployed, {{ stackland-name }} assigns a default storage class, the one specified in `StacklandClusterConfig.spec.storage.defaultStorageClass`. This class is annotated with `storageclass.kubernetes.io/is-default-class: "true"` and used for all PVCs where the storage class is not explicitly specified.

For databases, the preferred choice is usually SSD or NVMe, and for object storage, HDD. If a component requires a storage class different from the one specified during installation, specify it explicitly in the component configuration.

{% note warning %}

Data is not transferred automatically when changing the storage class.

Changing the storage class results in PVC re-creation and data loss. Perform the operation before writing user data, ideally during initial deployment.

{% endnote %}

## Getting started {#before-you-begin}

1. Make sure the required storage class exists in the cluster:

   ```bash
   kubectl get storageclasses
   ```

1. Make sure the nodes have disks of the appropriate type:

   ```bash
   kubectl get volumegroups -A -o wide
   ```

For more information about the available storage classes, see the [Disk subsystem](../../concepts/components/disk-storage.md#storage-classes) section.

## Changing the default storage class {#change-default}

You can specify a default storage class for all or individual components.

### Changing the storage class for all components {#change-all}

The default storage class is defined by the `storageclass.kubernetes.io/is-default-class: "true"` annotation of the `StorageClass` resource. You can move this annotation to another storage class. After this, all new PVCs that do not explicitly specify a storage class will use the new default class.

To change the default storage class:

1. Remove the annotation from the current default class:

   ```bash
   kubectl annotate storageclass <current_class> storageclass.kubernetes.io/is-default-class-
   ```

1. Set an annotation on the new class:

   ```bash
   kubectl annotate storageclass <new_class> storageclass.kubernetes.io/is-default-class=true
   ```

{% note warning %}

Changing the default class only affects new PVCs. Existing PVCs retain their previous storage class.

{% endnote %}

### Changing the storage class for an individual component {#change-component}

To change the storage class for a specific platform component, specify the appropriate field in the component configuration.

#### Managed databases {#postgresql-platform}

{{ PG }}, {{ CH }}, and {{ KF }} do not require configuring the storage class at the component level. Clusters use the default storage class. To specify a storage class other than the default, specify it in the manifest when creating the cluster.

#### {{ objstorage-name }} {#object-storage-platform}

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: StorageConfig
metadata:
  name: main
spec:
  enabled: false
  settings:
    storage:
      diskType: HDD
      servers: 3
      size: 154Gi
      storageClass: "stackland-hdd"
```

## Changing the storage class for custom DB clusters {#user-clusters}

Database clusters use the default storage class if the `storageClass` attribute is not specified in the cluster specification. To set a storage class for a specific cluster, specify it in the manifest when creating it.

You cannot change the storage class for already created {{ PG }}, {{ CH }}, and {{ KF }} clusters.

### {{ PG }} {#postgresql}

Specify the `spec.storage.storageClass` field in the `PostgresqlCluster` resource:

```yaml
apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
kind: PostgresqlCluster
metadata:
  name: <cluster_name>
spec:
  storage:
    size: 10Gi
    storageClass: "stackland-ssd"
  # ...
```

To learn more, see [Creating a {{ PG }} cluster](../postgresql/create-cluster.md).

### {{ CH }} {#clickhouse}

Specify the `spec.clickhouse.storage.storageClass` and `spec.keeper.storage.storageClass` fields in the `ClickhouseCluster` resource:

```yaml
apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
kind: ClickhouseCluster
metadata:
  name: <cluster_name>
spec:
  clickhouse:
    storage:
      size: 10Gi
      storageClass: "stackland-ssd"
    # ...
  keeper:
    storage:
      size: 5Gi
      storageClass: "stackland-ssd"
```

To learn more, see [Creating a {{ mch-name }} cluster](../clickhouse/create-cluster.md).

### {{ KF }} {#kafka}

Specify the `spec.controller.storage.storageClass` and `spec.broker.storage.storageClass` fields in the `KafkaCluster` resource:

```yaml
apiVersion: kafka.stackland.yandex.cloud/v1alpha1
kind: KafkaCluster
metadata:
  name: <cluster_name>
spec:
  controller:
    storage:
      size: 5Gi
      storageClass: "stackland-ssd"
  broker:
    storage:
      size: 20Gi
      storageClass: "stackland-ssd"
  # ...
```

For more information on creating a cluster, see [this section](../kafka/create-cluster.md).

## Switching the storage class for system components {#system-components}

For system components, specify the storage class in the component's configuration file. If the component is already running, follow the procedure in the [Changing the storage class for an existing data component](#existing-component) section.

### Logging (Loki) {#logging}

Specify the `spec.settings.logStorage.storage.storageClass` field in the `LoggingConfig` resource:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: LoggingConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    logStorage:
      storage:
        enabled: true
        storageClass: "stackland-hdd"
        size: 50Gi
```

### Secrets Store (OpenBao) {#secrets-store}

Specify the `spec.settings.server.dataStorage.storageClass` field in the `SecretsStoreConfig` resource:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SecretsStoreConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    server:
      dataStorage:
        size: 2Gi
        storageClass: "stackland-ssd"
```

### {{ datalens-name }} {#datalens}

Specify the `spec.settings.database.storageClass` field in the `DataLensConfig` resource:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: DataLensConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    database:
      storageSize: "2Gi"
      storageClass: "stackland-ssd"
```

#### {{ objstorage-name }} {#object-storage-platform}

Specify the `spec.settings.storage.storageClass` field in the `StorageConfig` resource:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: StorageConfig
metadata:
  name: main
spec:
  enabled: false
  settings:
    storage:
      diskType: HDD
      servers: 3
      size: 154Gi
      storageClass: "stackland-hdd"
```

## Changing the storage class for an existing data component {#existing-component}

Changing the storage class requires disabling and re-enabling the component.

{% note alert %}

This operation results in complete loss of data on the affected PVCs. Make sure you have a backup you can restore your data from.

{% endnote %}

To change the storage class for an already running component:

1. Create a backup of your data.

1. Disable the component. For system components, install `spec.enabled: false` and apply the manifest:

   ```bash
   kubectl apply -f <configuration_file>.yaml
   ```

   For custom DB clusters, delete the cluster resource:

   ```bash
   kubectl delete <resource_type> <cluster_name> -n <project_name>
   ```

1. Delete the component PVCs:

   ```bash
   kubectl delete pvc <pvc_name> -n <namespace>
   ```

   To get a list of component PVCs:

   ```bash
   kubectl get pvc -n <namespace>
   ```

1. In the manifest, specify the new storage class and re-enable the component (`spec.enabled: true`).

1. Apply the manifest:

   ```bash
   kubectl apply -f <configuration_file>.yaml
   ```

1. Restore data from the backup.
