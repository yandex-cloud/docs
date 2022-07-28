{% note info %}

Permissions granted to the [user](../../managed-kafka/operations/cluster-accounts.md) for a topic remain even after the topic is [deleted](../../managed-kafka/operations/cluster-topics.md#delete-topic). If, after deleting a topic, you don't [revoke the permissions](../../managed-kafka/operations/cluster-accounts.md#revoke-permission), then, when you [create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) with the same name, the user will have access to it even if you don't explicitly assign them new permissions.

{% endnote %}
