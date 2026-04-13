* `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../../resource-manager/operations/folder/get-id.md).
* `backup_id`: Backup ID. To restore a sharded cluster, specify the [sharded backup](../../../storedoc/concepts/backup.md#size) ID. Such backups are larger in size.

    To learn the ID, [get the list of backups in the folder](../../../storedoc/operations/cluster-backups.md#list-backups).

* `name`: New cluster’s name.
* `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
* `network_id`: ID of the [network](../../../vpc/concepts/network.md#network) where the cluster will be deployed.
* `recovery_target_spec.timestamp`: Target recovery time for the {{ SD }} cluster, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this setting, the cluster will be restored to the backup’s completion time.

* `config_spec`: Cluster settings:

    * `version`: {{ SD }} version, 5.0, 6.0, or 7.0.
    * {{ SD }} host type depends on the [sharding type](../../../storedoc/concepts/sharding.md). The possible values are `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

        * `resources`: Cluster resources:

            * `resource_preset_id`: [Host class](../../../storedoc/concepts/instance-types.md).
            * `disk_size`: Disk size in bytes.
            * `disk_type_id`: [Disk type](../../../storedoc/concepts/storage.md).

        * `disk_size_autoscaling`: Storage autoscaling settings:

            * `planned_usage_threshold`: Storage usage percentage to trigger a storage expansion during the next [maintenance window](../../../storedoc/concepts/maintenance.md#maintenance-window).

                Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                If you specified a value greater than `0`, configure the maintenance schedule.

            * `emergency_usage_threshold`: Storage usage percentage to trigger an immediate storage expansion.

                Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled. The value of this setting must be greater than or equal to `planned_usage_threshold`.

            * `disk_size_limit`: Maximum storage size, in bytes, that can be set when storage usage reaches one of the specified thresholds.

                If you set it to `0`, automatic storage expansion will be disabled.

* `host_specs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

    * `zone_id`: [Availability zone](../../../overview/concepts/geo-scope.md).
    * `subnet_id`: [Subnet ID](../../../vpc/concepts/network.md#subnet).
    * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
    * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
    * `shard_name`: Shard name in a sharded cluster.
    * `hidden`: Specifies whether to hide (`true`) or display (`false`) the host.
    * `secondary_delay_secs`: Host’s replication lag behind the master.
    * `priority`: Host priority for master promotion during [failover](../../../storedoc/concepts/replication.md#master-failover).
    * `tags`: Host tags.

* {% include [maintenance-window](../api/maintenance-window-grpc.md)%}
