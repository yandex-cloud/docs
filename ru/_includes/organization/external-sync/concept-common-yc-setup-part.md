Для корректной работы агента синхронизации на стороне {{ yandex-cloud }} выполните следующие действия:

* [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого синхронизация будет выполняться на стороне {{ org-full-name }}.
* [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) сервисному аккаунту следующие [роли](../../../iam/concepts/access-control/roles.md) на [организацию](../../../organization/concepts/organization.md), в которой находится нужный пул пользователей:

    {% include [ad-sync-sa-roles](./ad-sync-sa-roles.md) %}

* (Опционально) [Создайте](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта.

    {% include [ad-sync-iam-via-metadata-warning](./ad-sync-iam-via-metadata-warning.md) %}