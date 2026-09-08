### The memory usage limit has been reached on the host {#valkey_maxmemory_policy}

**Description**

The memory usage limit has been reached on the host. The `noeviction` policy does not allow new inserts without data deletion. To resolve the issue, do one of the following: delete unused data, modify the memory usage policy in cluster settings, or increase the available memory.

**Action**

You can modify the memory policy or increase the amount of memory:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Select the cluster.
1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.

    * To modify the memory policy in the [DBMS settings](../../managed-valkey/concepts/settings-list.md), provide a value for **Maxmemory policy**.
    * To increase the amount of memory, set a new value in the cluster resource settings.