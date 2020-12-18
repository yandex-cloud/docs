{% note info %}

Permissions granted [to the account](../../managed-kafka/operations/cluster-accounts.md) for a topic are retained even after the [topic is deleted](../../managed-kafka/operations/cluster-topics.md#delete-topic). You can either [revoke such permissions](../../managed-kafka/operations/cluster-accounts.md#revoke-permission) or leave them as is. In the latter case, you can [create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) with the same name and use it without reassigning account rights.

{% endnote %}

