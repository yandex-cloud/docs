---
title: Управление доступом в {{ cloud-apps-full-name }}
description: Управление доступом в сервисе {{ cloud-apps-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ cloud-apps-full-name }}, назначьте пользователю нужные роли из приведенного списка.
---

# Управление доступом в {{ cloud-apps-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ cloud-apps-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

## Какие роли действуют в сервисе {#roles-list}

Для управления правами доступа в {{ cloud-apps-name }} можно использовать как сервисные, так и примитивные роли.

{% include [cloud-apps](../../_mermaid/roles/cloud-apps.md) %}

### Сервисные роли {#service-roles}

#### cloudapps.auditor {#cloudapps-auditor}

{% include [cloudapps.auditor](../../_roles/cloudapps/auditor.md) %}

#### cloudapps.viewer {#cloudapps-viewer}

{% include [cloudapps.viewer](../../_roles/cloudapps/viewer.md) %}

#### cloudapps.editor {#cloudapps-editor}

{% include [cloudapps.editor](../../_roles/cloudapps/editor.md) %}

#### cloudapps.admin {#cloudapps-admin}

{% include [cloudapps.admin](../../_roles/cloudapps/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Полезные ссылки {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)
