---
title: Управление доступом в {{ sws-name }}
description: В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ sws-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `smart-web-security.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

Вы можете назначить роль на [организацию](../../organization/), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на профили безопасности, которые в них находятся.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/smartwebsecurity/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### smart-web-security.auditor {#smart-web-security-auditor}

{% include [sws-auditor](../../_roles/smart-web-security/auditor.md) %}

#### smart-web-security.viewer {#smart-web-security-viewer}

{% include [sws-viewer](../../_roles/smart-web-security/viewer.md) %}

#### smart-web-security.user {#smart-web-security-user}

{% include [sws-user](../../_roles/smart-web-security/user.md) %}

#### smart-web-security.editor {#smart-web-security-editor}

{% include [sws-editor](../../_roles/smart-web-security/editor.md) %}

#### smart-web-security.admin {#smart-web-security-admin}

{% include [sws-admin](../../_roles/smart-web-security/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}