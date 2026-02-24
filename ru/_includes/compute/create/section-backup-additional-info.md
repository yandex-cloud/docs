{% note info %}

Если у вашего аккаунта нет назначенной роли `backup.user` или выше, вы можете подключить ВМ к {{ backup-name }} с помощью [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), которому назначена такая роль. 

Для этого разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите подходящий сервисный аккаунт. При необходимости [создайте](../../../iam/operations/sa/create.md) новый сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../../backup/security/index.md#backup-user) `backup.user`.

{% endnote %}

{% note tip %}

{% include [cloud-backup-resources-note](../../../_includes/backup/cloud-backup-resources-note.md) %}

{% endnote %}

Подробнее читайте в разделе [{#T}](../../../backup/concepts/vm-connection.md).