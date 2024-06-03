---
title: "Управление доступом в {{ maf-full-name }}"
description: "Управление доступом в сервисе создания и управления кластерами {{ AF }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ maf-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `managed-airflow.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ maf-name }}, назначьте пользователю нужные роли на каталог или облако, в котором содержатся эти ресурсы.

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе.

#### managed-airflow.auditor {#managed-airflow-auditor}

{% include [managed-airflow.auditor](../../_roles/managed-airflow/auditor.md) %}

#### managed-airflow.viewer {#managed-airflow-viewer}

{% include [managed-airflow.viewer](../../_roles/managed-airflow/viewer.md) %}

#### managed-airflow.user {#managed-airflow-user}

{% include [managed-airflow.user](../../_roles/managed-airflow/user.md) %}

#### managed-airflow.editor {#managed-airflow-editor}

{% include [managed-airflow.editor](../../_roles/managed-airflow/editor.md) %}

#### managed-airflow.admin {#managed-airflow-admin}

{% include [managed-airflow.admin](../../_roles/managed-airflow/admin.md) %}

#### managed-airflow.integrationProvider {#managed-airflow-integrationProvider}

{% include [managed-airflow.integrationProvider](../../_roles/managed-airflow/integrationProvider.md) %}

### Примитивные роли {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

Роль `{{ roles-viewer }}` позволяет просматривать информацию о кластерах {{ maf-name }} и логах их работы.

#### {{ roles-editor }} {#editor}

Пользователь с ролью `{{ roles-editor }}` может управлять любыми ресурсами, например создать кластер, создать или удалить подкластер в кластере.

Включает в себя роль `{{ roles-viewer }}`.

#### {{ roles-admin }} {#admin}

Пользователь с ролью `{{ roles-admin }}` может управлять правами доступа к ресурсам, например разрешить другим пользователям создавать кластеры {{ maf-name }} или просматривать информацию о правах пользователей.

Включает в себя роль `{{ roles-editor }}`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

