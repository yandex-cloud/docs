### Risk of unavailability due to hosting the coordination service on hosts {#clickhouse_ha_embedded_keeper}

**Description**

A configuration where {{ CH }} and {{ CK }} share the hosts is not highly available. Place {{ CK }} on separate hosts.


{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Action**

To update the {{ CK }} settings:

1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
1. For the **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-separated-clickhouse-keeper }}** coordination service, select the platform, VM type, and [host class](../../managed-clickhouse/concepts/instance-types.md) under **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}**.