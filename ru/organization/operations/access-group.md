---
title: "Как настроить доступ группы пользователей в {{ org-full-name }} к работе в {{ yandex-cloud }}"
description: "Из этой статьи вы узнаете, как настроить доступ группы пользователей в {{ org-name }} к работе в {{ yandex-cloud }}." 
---

## Настроить доступ группы к работе в {{ yandex-cloud }} {#access}

Чтобы участники группы могли работать с сервисами {{ yandex-cloud }}, назначьте группе соответствующие [роли](../../iam/concepts/access-control/roles.md).

### Назначить роль на отдельный ресурс {#access-services}

В консоли управления можно назначить роль на облако, каталог и другие ресурсы из [списка](../../iam/concepts/access-control/resources-with-access-control.md).

Чтобы выдать доступ группе на ресурс:

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

### Назначить роль на всю организацию {#access-organization}

Роль, которая выдана на всю организацию, позволяет участникам группы управлять всеми ресурсами {{ yandex-cloud }}, которые подключены к организации, в соответствии с правами роли.

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}