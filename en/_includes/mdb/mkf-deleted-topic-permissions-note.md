{% note info %}

Permissions granted [to the account](../../managed-kafka/operations/cluster-accounts.md) for a topic remain even after the [topic is deleted](../../managed-kafka/operations/cluster-topics.md#delete-topic). If, after deleting a topic, you do not [revoke the permissions](../../managed-kafka/operations/cluster-accounts.md#revoke-permission), then, when you [create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) with the same name, the account will have access even if you do not explicitly assign it new permissions.

{% endnote %}

