* `--backup-id`: Backup ID. To restore a sharded cluster, specify the [sharded backup](../../../storedoc/concepts/backup.md#size) ID. Such backups are larger in size.

    To find out the ID, [get a list of backups in the folder](#list-backups).

* `--recovery-target-timestamp`: Target recovery time for the {{ SD }} cluster, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this argument, the cluster will be restored to its state at the time of backup completion.

* `--mongodb-version`: {{ SD }} version.

* `--name`: New cluster’s name.

* `--environment`: Environment, `PRESTABLE` or `PRODUCTION`.

* `--network-name`: Name of the [network](../../../vpc/concepts/network.md#network) the cluster will be deployed in.

* `--mongod-resource-preset`: MONGOD [ host class](../../../storedoc/concepts/instance-types.md).

* `--mongod-disk-size`: Storage size for MONGOD hosts, GB.

* `--mongod-disk-type`: Disk type for MONGOD hosts: `network-hdd`, `network-ssd`, or `network-ssd-io-m3`.


* `--<host_type>-resource-preset`, `--<host_type>-disk-size`, `--<host_type>-disk-type`: Host parameters controlling cluster sharding. The possible `<host_type>` values are `mongoinfra`, `mongocfg`, or `mongos`.

* `--disk-size-autoscaling`: Storage autoscaling settings. The `<host_type>` can take the following values: `mongod` for sharded and non-sharded clusters; `mongoinfra`, `mongocfg`, or `mongos` only for sharded clusters.

    * `<host_type>-planned-usage-threshold`: Storage usage percentage to trigger a storage expansion during the next [maintenance window](../../../storedoc/concepts/maintenance.md#maintenance-window).

        Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

        If you specified a value greater than `0`, configure the maintenance schedule.

    * `<host_type>-emergency-usage-threshold`: Storage usage percentage to trigger an immediate storage expansion.

        Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled. The value of this setting must be greater than or equal to `<host_type>-planned-usage-threshold`.

    * `<host_type>-disk-size-limit`: Maximum storage size, in GB, that can be set if the usage percentage reaches one of the specified thresholds.

        If you set it to `0`, automatic storage expansion will be disabled.

* `--maintenance-window`: [Maintenance](../../../storedoc/concepts/maintenance.md) window settings, applying to both running and stopped clusters. In `--maintenance-window`, provide one of these two values:

    {% include [maintenance-window](../cli/maintenance-window-description.md) %}

* `--performance-diagnostics`: Enables cluster performance diagnostics, `true` or `false`.
