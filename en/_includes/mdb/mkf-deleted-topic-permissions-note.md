{% note info %}

Permissions granted to a [user](../../managed-kafka/operations/cluster-accounts.md) for a topic persist even after the topic is [deleted](../../managed-kafka/operations/cluster-topics.md#delete-topic). If you do not [revoke the permissions](../../managed-kafka/operations/cluster-accounts.md#revoke-permission) after topic deletion, the user will be able to access a [newly created topic](../../managed-kafka/operations/cluster-topics.md#create-topic) with the same name without reassigning permissions.

{% endnote %}
