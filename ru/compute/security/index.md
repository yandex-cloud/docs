---
title: Управление доступом в {{ compute-full-name }}
description: Управление доступом в сервисе предоставляющим масштабируемые вычислительные мощности для создания виртуальных машин и управления ими — {{ compute-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ compute-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `compute.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначать роли {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Вы также можете назначать роли на отдельные ресурсы сервиса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Через [консоль управления]({{ link-console-main }}) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

- CLI {#cli}

  Через [{{ yandex-cloud }} CLI](../../cli/cli-ref/compute/cli-ref/index.md) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

- {{ TF }} {#tf}

  Через [{{ TF }}]({{ tf-provider-link }}) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources-tf](../../_includes/iam/resources-with-access-control/compute-tf.md) %}

- API {#api}

  Через [API {{ yandex-cloud }}](../api-ref/authentication.md) вы можете назначить роли на следующие ресурсы:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

{% endlist %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/compute/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### compute.auditor {#compute-auditor}

{% include [compute.auditor](../../_roles/compute/auditor.md) %}

#### compute.viewer {#compute-viewer}

{% include [compute.viewer](../../_roles/compute/viewer.md) %}

#### compute.editor {#compute-editor}

{% include [compute.editor](../../_roles/compute/editor.md) %}

#### compute.admin {#compute-admin}

{% include [compute.admin](../../_roles/compute/admin.md) %}

#### compute.osLogin {#compute-oslogin}

{% include [compute.oslogin](../../_roles/compute/osLogin.md) %}

#### compute.osAdminLogin {#compute-osadminlogin}

{% include [compute.osadminlogin](../../_roles/compute/osAdminLogin.md) %}

#### compute.disks.user {#compute-disks-user}

{% include [compute.disks.user](../../_roles/compute/disks/user.md) %}

#### compute.images.user {#compute-images-user}

{% include [compute.images.user](../../_roles/compute/images/user.md) %}

#### compute.operator {#compute-operator}

{% include [compute.operator](../../_roles/compute/operator.md) %}

#### compute.snapshotSchedules.viewer {#compute-snapshotSchedules-viewer}

{% include [compute.snapshotSchedules.viewer](../../_roles/compute/snapshotSchedules/viewer.md) %}

#### compute.snapshotSchedules.editor {#compute-snapshotSchedules-editor}

{% include [compute.snapshotSchedules.editor](../../_roles/compute/snapshotSchedules/editor.md) %}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../../_roles/iam/serviceAccounts/user.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
