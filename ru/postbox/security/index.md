---
title: "Управление доступом в {{ postbox-full-name }}"
description: "Управление доступом в сервисе для отправки транзакционных почтовых сообщений {{ postbox-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ postbox-full-name }}, назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ postbox-full-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ postbox-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

{% endnote %}

## Какие роли действуют в сервисе {#roles-list}

Для управления правами доступа в {{ postbox-name }} можно использовать как сервисные, так и примитивные роли.

### Сервисные роли {#service-roles}

#### postbox.sender {#postbox-sender}

{% include [postbox.sender](../../_roles/postbox/sender.md) %}

#### postbox.auditor {#postbox-auditor}

{% include [postbox.auditor](../../_roles/postbox/auditor.md) %}

#### postbox.viewer {#postbox-viewer}

{% include [postbox.viewer](../../_roles/postbox/viewer.md) %}

#### postbox.editor {#postbox-editor}

{% include [postbox.editor](../../_roles/postbox/editor.md) %}

#### postbox.admin {#postbox-admin}

{% include [postbox.admin](../../_roles/postbox/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## См. также {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)
