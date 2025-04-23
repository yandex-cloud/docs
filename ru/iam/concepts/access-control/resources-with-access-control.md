---
title: Список ресурсов, на которые можно назначать роли в {{ iam-full-name }}
description: Из статьи вы узнаете, на какие ресурсы {{ yandex-cloud }} можно назначить роли.
---

# Список ресурсов, на которые можно назначать роли


Есть несколько ресурсов {{ yandex-cloud }}, на которые можно [назначать](../../operations/roles/grant.md) роли, [просматривать](../../operations/roles/get-assigned-roles.md) их и [отзывать](../../operations/roles/revoke.md).

Если нужно предоставить доступ к ресурсу, которого нет в списках, назначьте роль на родительский ресурс, от которого [наследуются](index.md#inheritance) права доступа. Например, у [кластеров {{ mpg-full-name }}](../../../managed-postgresql/concepts/index.md) права доступа наследуются от каталога.

Список ресурсов различается в зависимости от интерфейса {{ yandex-cloud }}, через который вы назначаете роль:

{% list tabs group=instructions %}

- Консоль управления и интерфейсы сервисов {#console}

  **{{ billing-name }}**
  * [Платежный аккаунт](../../../billing/concepts/billing-account.md)

  **{{ cloud-desktop-full-name }}**
  * [Группа рабочих столов](../../../cloud-desktop/concepts/desktops-and-groups.md)

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ compute-full-name }}**

  {% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

  **{{ container-registry-full-name }}**
  * [Реестр](../../../container-registry/concepts/registry.md)

  **{{ datalens-full-name }}**
  * [Воркбук](../../../datalens/workbooks-collections/index.md)
  * [Коллекция](../../../datalens/workbooks-collections/index.md)

  **{{ ml-platform-full-name }}**
  * [Проект](../../../datasphere/security/index.md)
  * [Сообщество](../../../datasphere/security/index.md)

  **{{ iam-full-name }}**
  * [Сервисный аккаунт](../../operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Секрет](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [СУБД YDB](../../../ydb/concepts/index.md#ydb)

  **{{ metadata-hub-full-name }}**
  * [Подключение к управляемым базам данных](../../../metadata-hub/operations/connection-access.md) в {{ connection-manager-full-name }}

  **{{ objstorage-full-name }}**
  * [Бакет](../../../storage/operations/buckets/iam-access.md)

  **{{ resmgr-full-name }}**
  * [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ speechsense-full-name }}**
  * [Пространство](../../../speechsense/concepts/resources-hierarchy.md#space)
  * [Проект](../../../speechsense/concepts/resources-hierarchy.md#project)

  **{{ websql-full-name }}**
  * [Сохраненный запрос](../../../websql/concepts/index.md#saved-queries)
  * [Запрос из истории](../../../websql/concepts/index.md#query-log)

- CLI {#cli}

  **{{ api-gw-full-name }}**
  * [API-шлюз](../../../api-gateway/concepts/index.md)

  **{{ at-full-name }}**
  * [Трейл](../../../audit-trails/concepts/trail.md)

  **{{ certificate-manager-full-name }}**
  * [Пользовательский сертификат](../../../certificate-manager/concepts/imported-certificate.md)
  * [Сертификат Let's Encrypt](../../../certificate-manager/concepts/managed-certificate.md)

  **{{ cloud-desktop-full-name }}**
  * [Группа рабочих столов](../../../cloud-desktop/concepts/desktops-and-groups.md)

  **{{ dns-full-name }}**
  * [Зона DNS](../../../dns/operations/zone-access.md)

  **{{ sf-full-name }}**
  * [Функция](../../../functions/operations/function/role-add.md)

  **{{ cloud-logging-full-name }}**
  * [Лог-группа](../../../logging/concepts/log-group.md)
  * [Приемник логов](../../../logging/operations/create-sink.md)

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ compute-full-name }}**

  {% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

  **{{ container-registry-full-name }}**
  * [Реестр](../../../container-registry/concepts/registry.md)
  * [Репозиторий](../../../container-registry/concepts/repository.md)

  **{{ iam-full-name }}**
  * [Сервисный аккаунт](../../../iam/operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Секрет](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [СУБД YDB](../../../ydb/concepts/index.md#ydb)
  * Резервная копия СУБД YDB

  **{{ resmgr-full-name }}**
  * [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ serverless-containers-full-name }}**
  * [Контейнер](../../../serverless-containers/operations/role-add.md)

- {{ TF }} {#tf}

  **{{ dns-full-name }}**
  * [Зона DNS](../../../dns/operations/zone-access.md)

  **{{ sf-full-name }}**
  * [Функция](../../../functions/operations/function/role-add.md)

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ certificate-manager-full-name }}**
  * [Пользовательский сертификат](../../../certificate-manager/concepts/imported-certificate.md)
  * [Сертификат Let's Encrypt](../../../certificate-manager/concepts/managed-certificate.md)

  **{{ compute-full-name }}**

  {% include notitle [compute-resources-tf](../../../_includes/iam/resources-with-access-control/compute-tf.md) %}

  **{{ container-registry-full-name }}**
  * [Реестр](../../../container-registry/concepts/registry.md)
  * [Репозиторий](../../../container-registry/concepts/repository.md)

  **{{ ml-platform-full-name }}**
  * [Проект](../../../datasphere/security/index.md)
  * [Сообщество](../../../datasphere/security/index.md)

  **{{ iam-full-name }}**
  * [Сервисный аккаунт](../../operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Секрет](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [СУБД YDB](../../../ydb/concepts/index.md#ydb)

  **{{ resmgr-full-name }}**
  * [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ serverless-containers-full-name }}**
  * [Контейнер](../../../serverless-containers/operations/role-add.md)

- API {#api}

  **{{ api-gw-full-name }}**
  * [API-шлюз](../../../api-gateway/concepts/index.md)

  **{{ at-full-name }}**
  * [Трейл](../../../audit-trails/concepts/trail.md)

  **{{ certificate-manager-full-name }}**
  * [Пользовательский сертификат](../../../certificate-manager/concepts/imported-certificate.md)
  * [Сертификат Let's Encrypt](../../../certificate-manager/concepts/managed-certificate.md)

  **{{ billing-name }}**
  * [Платежный аккаунт](../../../billing/concepts/billing-account.md)

  **{{ cloud-desktop-full-name }}**
  * [Группа рабочих столов](../../../cloud-desktop/concepts/desktops-and-groups.md)

  **{{ dns-full-name }}**
  * [Зона DNS](../../../dns/operations/zone-access.md)

  **{{ sf-full-name }}**
  * [Функция](../../../functions/operations/function/role-add.md)

  **{{ cloud-logging-full-name }}**

  {% include notitle [logging-resources](../../../_includes/iam/resources-with-access-control/logging.md) %}

  **{{ org-full-name }}**

  {% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

  **{{ compute-full-name }}**

  {% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

  **{{ container-registry-full-name }}**
  * [Реестр](../../../container-registry/concepts/registry.md)
  * [Репозиторий](../../../container-registry/concepts/repository.md)

  **{{ ml-platform-full-name }}**
  * [Проект](../../../datasphere/security/index.md)
  * [Сообщество](../../../datasphere/security/index.md)

  **{{ iam-full-name }}**
  * [Сервисный аккаунт](../../../iam/operations/sa/assign-role-for-sa.md)

  **{{ kms-full-name }}**

  {% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

  **{{ lockbox-full-name }}**
  * [Секрет](../../../lockbox/operations/secret-access.md)

  **{{ ydb-full-name }}**
  * [СУБД YDB](../../../ydb/concepts/index.md#ydb)
  * Резервная копия СУБД YDB

  **{{ resmgr-full-name }}**
  * [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

  **{{ serverless-containers-full-name }}**
  * [Контейнер](../../../serverless-containers/operations/role-add.md)

{% endlist %}