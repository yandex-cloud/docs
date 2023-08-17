---
title: "Управление доступом в {{ message-queue-full-name }}"
description: "Управление доступом в сервисе для обмена сообщениями между приложениями {{ message-queue-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ message-queue-full-name }}, назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ message-queue-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ message-queue-full-name }}, назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Для управления очередями пользователь должен иметь соответствующие полномочия в облаке и каталогах, в которых будут выполняться операции.

Чтобы дать пользователю полномочия:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ service-name }}.

### Сервисные роли {#service-roles}

{% include [roles-ymq-reader](../../_includes/roles-ymq-reader.md) %}

{% include [roles-ymq-writer](../../_includes/roles-ymq-writer.md) %}

{% include [roles-ymq-admin](../../_includes/roles-ymq-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## См. также {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)
