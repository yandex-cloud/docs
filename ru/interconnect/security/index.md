---
title: Управление доступом в {{ interconnect-full-name }}
description: Управление доступом в сервисе {{ interconnect-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ interconnect-name }}, назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако).
---

# Управление доступом в {{ interconnect-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ interconnect-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть [назначена](../../iam/operations/roles/grant.md) на родительский ресурс (каталог или облако) и на организацию.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль на облако:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

Подробнее о назначении ролей см. в документации сервиса [{{ iam-full-name }}](../../iam/operations/roles/grant.md).

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}


## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ interconnect-name }}.

### Сервисные роли {#service-roles}

#### cic.auditor {#cic-auditor}

{% include [cic.auditor](../../_roles/cic/auditor.md) %}

#### cic.viewer {#cic-viewer}

{% include [cic.viewer](../../_roles/cic/viewer.md) %}

#### cic.editor {#cic-editor}

{% include [cic.editor](../../_roles/cic/editor.md) %}

#### cic.secretViewer {#cic-secretviewer}

{% include [cic.secretViewer](../../_roles/cic/secretViewer.md) %}

#### cic.secretEditor {#cic-secreteditor}

{% include [cic.secretEditor](../../_roles/cic/secretEditor.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}
