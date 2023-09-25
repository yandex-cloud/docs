---
title: "Управление доступом в {{ sws-name }}"
description: "В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ sws-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Вы можете назначить роль на [организацию](../../organization/), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на профили безопасности, которые в них находятся.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/smartwebsecurity/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

{% include [sws-auditor](../../_includes/iam/roles/sws-auditor.md) %}

{% include [sws-viewer](../../_includes/iam/roles/sws-viewer.md) %}

{% include [sws-user](../../_includes/iam/roles/sws-user.md) %}

{% include [sws-editor](../../_includes/iam/roles/sws-editor.md) %}

{% include [sws-admin](../../_includes/iam/roles/sws-admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
