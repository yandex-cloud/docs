---
title: Управление доступом в {{ cloud-registry-full-name }}
description: Управление доступом в сервисе для безопасного хранения артефактов программного обеспечения {{ cloud-registry-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ cloud-registry-name }}, назначьте пользователю нужные роли из приведенного списка.
---

# Управление доступом в {{ cloud-registry-name }}

Для управления правами доступа в {{ cloud-registry-name }} используются [роли](../../iam/concepts/access-control/roles.md).

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `cloud-registry.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

{% note info %}

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

{% endnote %}

Кроме этого, роль можно назначить на [реестры {{ cloud-registry-name }}](../concepts/registry.md), а также на папки внутри реестров.

## Какие роли действуют в сервисе {#roles-list}

Для управления правами доступа в {{ cloud-registry-name }} можно использовать как сервисные, так и примитивные роли.

{% include [cloud-registry](../../_mermaid/roles/cloud-registry.md) %}

### Сервисные роли {#service-roles}

#### cloud-registry.auditor {#cloud-registry-auditor}

{% include [cloud-registry-auditor](../../_roles/cloud-registry/auditor.md) %}

#### cloud-registry.viewer {#cloud-registry-viewer}

{% include [cloud-registry-viewer](../../_roles/cloud-registry/viewer.md) %}

#### cloud-registry.editor {#cloud-registry-editor}

{% include [cloud-registry-editor](../../_roles/cloud-registry/editor.md) %}

#### cloud-registry.admin {#cloud-registry-admin}

{% include [cloud-registry-admin](../../_roles/cloud-registry/admin.md) %}

#### cloud-registry.artifacts.puller {#cloud-registry-artifacts-puller}

{% include [cloud-registry-artifacts-puller](../../_roles/cloud-registry/artifacts/puller.md) %}

#### cloud-registry.artifacts.pusher {#cloud-registry-artifacts-pusher}

{% include [cloud-registry-artifacts-pusher](../../_roles/cloud-registry/artifacts/pusher.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## См. также {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)
