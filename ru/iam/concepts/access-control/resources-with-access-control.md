---
title: "Список ресурсов, на которые можно назначать роли в {{ iam-full-name }}"
description: "Из статьи вы узнаете, на какие ресурсы {{ yandex-cloud }} можно назначить роли." 
---

# Список ресурсов, на которые можно назначать роли

Ресурсы, на которые вы можете [назначать](../../operations/roles/grant.md) роли, [просматривать](../../operations/roles/get-assigned-roles.md) их и [отзывать](../../operations/roles/revoke.md):

**{{ resmgr-name }}**
* [Облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud)
* [Каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder)

**{{ iam-name }}**
* [Сервисный аккаунт](../users/service-accounts.md)

**{{ certificate-manager-name }}**
* [Сертификат](../../../certificate-manager/concepts/index.md)

**{{ container-registry-name }}**
* [Реестр](../../../container-registry/concepts/registry.md)
* [Репозиторий](../../../container-registry/concepts/repository.md)

**{{ compute-name }}**
* [Виртуальная машина](../../../compute/concepts/vm.md)


**{{ sf-name }}**
* [Функция](../../../functions/concepts/function.md)


Если нужно предоставить доступ к ресурсу, которого нет в списке, например к [кластеру {{ mpg-full-name }}](../../../managed-postgresql/concepts/index.md), назначьте роль на родительский ресурс, от которого [наследуются](index.md#inheritance) права доступа. У кластеров {{ mpg-name }} права доступа наследуются от каталога.
