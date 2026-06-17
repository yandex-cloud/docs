---
title: Управление доступом в {{ cns-full-name }}
description: Управление доступом в сервисе для отправки почтовых сообщений {{ cns-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ cns-name }}, назначьте пользователю нужные роли из приведенного списка.
---

# Управление доступом в {{ cns-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ cns-full-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

## Какие роли действуют в сервисе {#roles-list}

Для управления правами доступа в {{ cns-name }} можно использовать как сервисные, так и примитивные роли.

{% include [cns](../../_mermaid/roles/cns.md) %}

### Сервисные роли {#service-roles}

#### notifications.auditor {#notifications-auditor}

{% include [notifications.auditor](../../_roles/notifications/auditor.md) %}

#### notifications.viewer {#notifications-viewer}

{% include [notifications.viewer](../../_roles/notifications/viewer.md) %}

#### notifications.publisher {#notifications-publisher}

{% include [notifications.publisher](../../_roles/notifications/publisher.md) %}

#### notifications.editor {#notifications-editor}

{% include [notifications.editor](../../_roles/notifications/editor.md) %}

#### notifications.admin {#notifications-admin}

{% include [notifications.admin](../../_roles/notifications/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Полезные ссылки {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)