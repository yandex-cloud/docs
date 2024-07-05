---
title: "Список ресурсов, на которые можно назначать роли в {{ iam-full-name }}"
description: "Из статьи вы узнаете, на какие ресурсы {{ yandex-cloud }} можно назначить роли."
---

# Список ресурсов, на которые можно назначать роли


Есть несколько ресурсов {{ yandex-cloud }}, на которые можно [назначать](../../operations/roles/grant.md) роли, [просматривать](../../operations/roles/get-assigned-roles.md) их и [отзывать](../../operations/roles/revoke.md). Список таких ресурсов различается в зависимости от интерфейса {{ yandex-cloud }}, через который вы назначаете роль.

Если нужно предоставить доступ к ресурсу, которого нет в списках, назначьте роль на родительский ресурс, от которого [наследуются](index.md#inheritance) права доступа. Например, у [кластеров {{ mpg-full-name }}](../../../managed-postgresql/concepts/index.md) права доступа наследуются от каталога.

## Ресурсы, на которые можно назначать роли в консоли управления {#console}

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

**{{ metadata-hub-name }}**
* [Подключение к управляемым базам данных](../../../metadata-hub/operations/connection-access.md) в {{ connection-manager-full-name }}

**{{ objstorage-name }}**
* [Бакет](../../../storage/operations/buckets/iam-access.md)

**{{ resmgr-name }}**
* [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

**{{ lockbox-name }}**
* [Секрет](../../../lockbox/operations/secret-access.md)

## Ресурсы, на которые можно назначать роли через YC CLI и API {{ yandex-cloud }} {#cli-api}

**{{ api-gw-name }}**
* [API-шлюз](../../../api-gateway/concepts/index.md)

**{{ at-name }}**
* [Трейл](../../../audit-trails/concepts/trail.md)

**{{ certificate-manager-name }}**
* [Пользовательский сертификат](../../../certificate-manager/concepts/imported-certificate.md)

**{{ cloud-desktop-name }}**
* [Группа рабочих столов](../../../cloud-desktop/concepts/desktops-and-groups.md)

**{{ dns-name }}**
* [Зона DNS](../../../dns/operations/zone-access.md)

**{{ sf-name }}**
* [Функция](../../../functions/operations/function/role-add.md)

**{{ cloud-logging-name }}**

{% include notitle [logging-resources](../../../_includes/iam/resources-with-access-control/logging.md) %}

**{{ org-name }}**

{% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}

**{{ container-registry-name }}**
* [Реестр](../../../container-registry/operations/roles/grant.md)
* [Репозиторий](../../../container-registry/operations/roles/grant.md)

**{{ compute-name }}**

{% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

**{{ iam-name }}**
* [Сервисный аккаунт](../../operations/sa/assign-role-for-sa.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ ydb-name }}**
* [СУБД YDB](../../../ydb/operations/manage-databases.md#add-access-binding)
* Резервная копия СУБД YDB

**{{ resmgr-name }}**
* [Облако](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [Каталог](../../../resource-manager/operations/folder/set-access-bindings.md)

**{{ serverless-containers-name }}**
* [Контейнер](../../../serverless-containers/operations/role-add.md)

**{{ lockbox-name }}**
* [Секрет](../../../lockbox/operations/secret-access.md)

## Ресурсы, на которые можно назначать роли с помощью {{ TF }} {#terraform}

**{{ container-registry-name }}**
* [Реестр](../../../container-registry/concepts/registry.md)
* [Репозиторий](../../../container-registry/concepts/repository.md)

**{{ ml-platform-name }}**
* [Проект](../../../datasphere/concepts/project.md)
* [Сообщество](../../../datasphere/concepts/community.md)

**{{ dns-name }}**
* [Зона DNS](../../../dns/concepts/dns-zone.md)

**{{ sf-name }}**
* [Функция](../../../functions/concepts/function.md)

**{{ iam-name }}**
* [Сервисный аккаунт](../users/service-accounts.md)

**{{ kms-name }}**

{% include notitle [kms-resources](../../../_includes/iam/resources-with-access-control/kms.md) %}

**{{ lockbox-name }}**
* [Секрет](../../../lockbox/concepts/secret.md)

**{{ resmgr-name }}**
* [Облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud)
* [Каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder)

**{{ serverless-containers-name }}**
* [Контейнер](../../../serverless-containers/concepts/container.md)

**{{ ydb-name }}**
* [СУБД YDB](../../../ydb/concepts/index.md#ydb)

**{{ org-name }}**

{% include notitle [organization-resources](../../../_includes/iam/resources-with-access-control/organization.md) %}
