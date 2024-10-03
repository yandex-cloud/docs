---
title: Список ресурсов, на которые можно назначать роли в {{ iam-full-name }}
description: Из статьи вы узнаете, на какие ресурсы {{ yandex-cloud }} можно назначить роли.
---

# Список ресурсов, на которые можно назначать роли


Есть несколько ресурсов {{ yandex-cloud }}, на которые можно [назначать](../../operations/roles/grant.md) роли, [просматривать](../../operations/roles/get-assigned-roles.md) их и [отзывать](../../operations/roles/revoke.md).

Если нужно предоставить доступ к ресурсу, которого нет в списках, назначьте роль на родительский ресурс, от которого [наследуются](index.md#inheritance) права доступа. Например, у [кластеров {{ mpg-full-name }}](../../../managed-postgresql/concepts/index.md) права доступа наследуются от каталога.

Список ресурсов различается в зависимости от интерфейса {{ yandex-cloud }}, через который вы назначаете роль:

{% list tabs group=instructions %}

- Консоль управления {#console}

  **{{ container-registry-name }}**
  * [Реестр](../../../container-registry/operations/roles/grant.md)

  **{{ compute-name }}**

  {% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

  **{{ iam-name }}**
  * [Сервисный аккаунт](../../operations/sa/assign-role-for-sa.md)

  **{{ kms-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ ydb-name }}**
  * [СУБД YDB](../../../ydb/operations/manage-databases.md#add-access-binding)

  **{{ metadata-hub-full-name }}**
  * [Подключение к управляемым базам данных](../../../metadata-hub/operations/connection-access.md) в {{ connection-manager-full-name }}

  **{{ objstorage-name }}**
  * [Бакет](../../../storage/operations/buckets/iam-access.md)

  **{{ resmgr-name }}**
  * [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ lockbox-name }}**
  * [Секрет](../../../lockbox/operations/secret-access.md)

- CLI {#cli}

  {% include notitle [cli-api](../../../_includes/iam/resources-with-access-control/cli-api.md) %}

- {{ TF }} {#tf}

  **{{ container-registry-name }}**
  * [Реестр](../../../container-registry/operations/roles/grant.md)
  * [Репозиторий](../../../container-registry/operations/roles/grant.md)

  **{{ ml-platform-name }}**
  * [Проект](../../../datasphere/security/index.md)
  * [Сообщество](../../../datasphere/security/index.md)

  **{{ dns-name }}**
  * [Зона DNS](../../../dns/operations/zone-access.md)

  **{{ sf-name }}**
  * [Функция](../../../functions/operations/function/role-add.md)

  **{{ compute-name }}**

  {% include notitle [compute-resources-tf](../../../_includes/iam/resources-with-access-control/compute-tf.md) %}

  **{{ iam-name }}**
  * [Сервисный аккаунт](../../operations/sa/assign-role-for-sa.md)

  **{{ kms-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-name }}**
  * [Секрет](../../../lockbox/operations/secret-access.md)

  **{{ resmgr-name }}**
  * [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ serverless-containers-name }}**
  * [Контейнер](../../../serverless-containers/operations/role-add.md)

  **{{ ydb-name }}**
  * [СУБД YDB](../../../ydb/security/index.md)

  **{{ org-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

- API {#api}

  {% include notitle [cli-api](../../../_includes/iam/resources-with-access-control/cli-api.md) %}

{% endlist %}