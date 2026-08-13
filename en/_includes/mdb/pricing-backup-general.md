* Database backup storage exceeding the cluster’s allocated space.

    {% note info %}

    The cluster's storage capacity is equal to the total storage capacity of all of its hosts.

    {% endnote %}

    * Backup storage is not billable until the total size of backups exceeds that of the cluster host storages. This calculation does not count in the data volume of the database itself.

    * If the total size of all backups exceeds the cluster storage size, you only pay for the amount in excess of the storage size.