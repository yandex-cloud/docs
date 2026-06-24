* `clickhouse-disk-size-limit`: Maximum {{ CH }} storage size, in GB.

* `clickhouse-planned-usage-threshold`: {{ CH }} storage utilization threshold to trigger an increase during the next maintenance window, in percent. The default value is `0` (auto increase disabled).

  The valid values range from `0` to `100`.

* `clickhouse-emergency-usage-threshold`: Utilization threshold for the {{ CH }} storage capacity, in percent, to trigger an immediate increase. The default value is `0` (auto increase disabled).

  The valid values range from `0` to `100`.

* `zookeeper-disk-size-limit`: Maximum {{ ZK }} storage size, in GB.

* `zookeeper-planned-usage-threshold`: {{ ZK }} storage utilization threshold to trigger an increase during the next maintenance window, in percent. The default value is `0` (auto increase disabled).

  The valid values range from `0` to `100`.

* `zookeeper-emergency-usage-threshold`: Utilization threshold for the {{ ZK }} storage capacity, in percent, to trigger an immediate increase. The default value is `0` (auto increase disabled).

  The valid values range from `0` to `100`.

{% note warning %}

* If you specify both thresholds for {{ CH }}, `clickhouse-emergency-usage-threshold` must not be less than `clickhouse-planned-usage-threshold`.

* If you specify both thresholds for {{ ZK }}, `zookeeper-emergency-usage-threshold` must not be less than `zookeeper-planned-usage-threshold`.

* When using `clickhouse-planned-usage-threshold` and `zookeeper-planned-usage-threshold`, make sure to set up a [maintenance window](../../../managed-clickhouse/concepts/maintenance.md).

{% endnote %}
