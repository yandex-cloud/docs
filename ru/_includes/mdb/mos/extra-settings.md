* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../../managed-opensearch/concepts/maintenance.md):

    {% include [Maintenance window](../console/maintenance-window-description.md) %}


* **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — аккаунт для [доступа к {{ objstorage-full-name }}](../../../managed-opensearch/operations/s3-access.md) в качестве репозитория [снапшотов](../../../glossary/snapshot.md) {{ OS }}. Подробнее о сервисных аккаунтах см. в [документации {{ iam-full-name }}](../../../iam/concepts/users/service-accounts.md).



* {% include [Deletion protection](../console/deletion-protection.md) %}

    Включенная защита кластера от удаления не помешает удалить пользователя или подключиться к кластеру вручную и удалить данные.
