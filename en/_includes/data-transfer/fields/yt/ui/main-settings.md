* **Service account ID**: Select or [create](../../../../../iam/operations/sa/create.md) a [service account](../../../../../iam/concepts/users/service-accounts.md) with the `managed-ytsaurus.editor` role that {{ data-transfer-name }} will use to connect to the cluster.

* **Cluster ID**: Select the cluster to connect to.

* **Security groups**: Select the following:
    * Cloud network for hosting the endpoint.
    * [Security groups](../../../../../vpc/concepts/security-groups.md) for network traffic.

    Security group rules apply to a transfer. They allow opening up network access from the transfer VM to the cluster. Learn more in [{#T}](../../../../../data-transfer/concepts/network.md).
