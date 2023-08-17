---
title: "Управление доступом в {{ iot-full-name }}"
description: "Управление доступом облачного MQTT-сервера {{ iot-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---
    
# Управление доступом в {{ iot-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Эти роли будут действовать и на вложенные ресурсы.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ iot-short-name }}.

### Сервисные роли {#service-roles}

Роль | Разрешения
----- | -----
`resource-manager.clouds.member` | Роль, необходимая для доступа к ресурсам в облаке всем, кроме [владельцев облака](../../resource-manager/concepts/resources-hierarchy.md#owner) и [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md).
`resource-manager.clouds.owner` | Дает полный доступ к облаку и ресурсам в нем. Можно назначить только на облако.
`iot.devices.writer` | Роль для отправки gRPC-сообщений в {{ iot-short-name }} от имени устройства.
`iot.registries.writer` | Роль для отправки gRPC-сообщений в {{ iot-short-name }} от имени реестра.

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
