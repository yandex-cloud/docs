{% note info %}

Выданные [пользователю](../../managed-kafka/operations/cluster-accounts.md) права на доступ к топику сохраняются после [его удаления](../../managed-kafka/operations/cluster-topics.md#delete-topic). Если после удаления вы не [отзывали права](../../managed-kafka/operations/cluster-accounts.md#revoke-permission), то при [создании топика](../../managed-kafka/operations/cluster-topics.md#create-topic) с тем же именем пользователь сможет работать с ним без переназначения прав.

{% endnote %}
