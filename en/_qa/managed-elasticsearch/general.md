#### How are {{ ES }} clusters maintained? {#service-window}

Maintenance in {{ mes-short-name }} implies:

* Automatic installation of {{ ES }} updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mes-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-elasticsearch/concepts/maintenance.md).

#### Is cluster backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ mes-name }} clusters, a full backup takes place once per hour and saves all indexes. This helps restore a cluster's state from any available backup.

Backups are kept for seven days.

#### Which {{ ES }} version does {{ mes-short-name }} use? {#dbms-version}

The {{ ES }} versions maintained by the vendor are available in {{ mes-short-name }}. For more information, see [{#T}](../../managed-elasticsearch/concepts/update-policy.md).


#### What happens when a new {{ ES }} version is released? {#new-version}

When new versions include only bug fixes (such versions are called _maintenance releases_), the cluster software is automatically updated after a short testing period.

Owners of the affected DB clusters are notified of expected work times and DB availability in advance.


#### What happens when an {{ ES }} version becomes deprecated? {#dbms-deprecated}

{{ mes-short-name }} automatically notifies cluster owners by email that their {{ ES }} version is approaching end of life.

Clusters running a deprecated version of {{ ES }} are updated according to the [version control policy](../../managed-elasticsearch/concepts/update-policy.md).

Owners of the affected clusters are notified of expected work times and DB availability in advance.

{% include [logs](../logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I set up an alert that triggers as soon as a certain percentage of disk space has been used up? {#disk-space-percentage}

[Create an alert](../../managed-elasticsearch/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mes-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`: 90% of the disk space
* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`: 80% of the disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`: `85,899,345,920` bytes (80%)

#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../../managed-elasticsearch/operations/cluster-update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../managed-elasticsearch/operations/cluster-backups.md#restore) from a backup.
