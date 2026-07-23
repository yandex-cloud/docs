---
title: Управление доступом в {{ yandex-siem-full-name }}
description: Управление доступом в сервисе для мониторинга и реагирования на инциденты {{ yandex-siem-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ yandex-siem-full-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

{% include [siem](../../_mermaid/roles/siem.md) %}

### Сервисные роли {#service-roles}

#### ycem.inspector {#ycem-inspector}

{% include [ycem-inspector](../../_roles/ycem/inspector.md) %}

#### ycem.executor {#ycem-executor}

{% include [ycem-executor](../../_roles/ycem/executor.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
