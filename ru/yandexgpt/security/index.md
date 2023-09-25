---
title: "Управление доступом в {{ yagpt-full-name }}"
description: "Все операции в {{ yandex-cloud }} проверяются в сервисе {{ iam-full-name }}. Если у субъекта нет необходимых разрешений, сервис вернет ошибку."
---

# Управление доступом в {{ yagpt-full-name }}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

{% include [roles-primitive](../../_includes/roles-yandexgpt-user.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### См. также {#see-also}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).