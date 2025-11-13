## Environment {#environment}

Select the environment where you want to create the {{ mkf-name }} cluster (you cannot change the environment once the cluster is created):
  * `PRODUCTION`: For stable versions of your apps.
  * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.

## Host class {#broker-class}

Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the [platform](../../../compute/concepts/vm-platforms.md), host type, and host class.

The host class defines the technical specifications of [VMs](../../../compute/concepts/vm.md) the {{ KF }} nodes are deployed on. All available options are listed under [Host classes](../../../managed-kafka/concepts/instance-types.md).

When you [change the host class](../../../managed-kafka/operations/cluster-update.md#change-brokers) for a {{ mkf-name }} cluster, the specifications of all existing instances also change.

## Default host configuration {#default-config}

{{ ZK }} and {{ kraft-short-name }} hosts have the following default configuration:

* [Host class](../../../managed-kafka/concepts/instance-types.md): `s3-c2-m8`
* Disk size: `10` GB
* [Disk type](../../../managed-kafka/concepts/storage.md): `network-ssd`

## Automatic increase of storage size {#auto-rescale}

To prevent the cluster disk space from running out, create a cluster that will [increase the storage space automatically](../../../managed-kafka/concepts/storage.md#auto-rescale).

```bash
{{ yc-mdb-kf }} cluster create \
...
--disk-size-autoscaling disk-size-limit=<maximum_storage_size_in_bytes>,`
                        `planned-usage-threshold=<scheduled_increase_percentage>,`
                        `emergency-usage-threshold=<immediate_increase_percentage> \
...
```

{% include [description-of-parameters](disk-auto-scaling.md) %}

{% include [warn-storage-resize](../mpg/warn-storage-resize.md) %}

## Cluster status {#status}

Wait until the {{ mkf-name }} cluster is ready: its status on the {{ mkf-name }} dashboard will change to `Running`, and its state, to `Alive`. This may take some time.

## Availability zone and cluster creation warning {#note-warning}

{% note warning %}
        
If you create a {{ mkf-name }} cluster with a single [availability zone](../../../overview/concepts/geo-scope.md), you will not be able to increase the number of zones and broker hosts later.
        
{% endnote %}

## Maintenance time setup {#maintenance}

To set up a [maintenance window](../../../managed-kafka/concepts/maintenance.md) (including for disabled {{ mkf-name }} clusters), provide the required value in the `--maintenance-window` parameter when creating your cluster:

```bash
{{ yc-mdb-kf }} cluster create \
...
--maintenance-window type=<maintenance_type>,`
                    `day=<day_of_week>,`
                    `hour=<hour> \
...
```

Where `type` is the maintenance type:

{% include [maintenance-window](../cli/maintenance-window-description.md) %}

## Combined mode and host configuration transfer warning {#note-warning-combined-mode}

{% note warning %}
                    
If you are creating a [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../../../managed-kafka/concepts/kraft.md#cluster-topology) cluster, do not provide the {{ kraft-short-name }} host configuration.
                    
{% endnote %}

## Cluster deletion protection {#protect-from-deletion}

{% note info %}

Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

{% endnote %}
