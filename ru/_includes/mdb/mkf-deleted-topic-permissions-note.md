{% note info %}

Выданные [учетной записи](../../managed-kafka/operations/cluster-accounts.md) права на доступ к топику сохраняются даже после [удаления топика](../../managed-kafka/operations/cluster-topics.md#delete-topic). Вы можете либо [отозвать эти права доступа](../../managed-kafka/operations/cluster-accounts.md#revoke-permission), либо оставить. В последнем случае вы можете [создать топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с тем же именем и работать с ним без переназначения прав учетной записи.

{% endnote %}