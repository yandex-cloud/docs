## Об управлении доступом {#about-access-control}

Все операции в {{ yandex-cloud }} проверяются в сервисе [{{ iam-full-name }}](../../iam/). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.

{% if audience != "internal" %}

Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить аккаунту {% if product == "yandex-cloud" %}на Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %}, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md). Подробнее читайте в разделе [{#T}](../../iam/concepts/access-control/index.md).

{% endif %}

Назначать роли на ресурс могут те, у кого есть роль `admin` или `resource-manager.clouds.owner` на этот ресурс.