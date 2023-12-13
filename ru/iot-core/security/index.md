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

{% include [iot-editor](../../_includes/roles-iot-editor.md) %}

{% include [iot-viewer](../../_includes/roles-iot-viewer.md) %}

{% include [iot-auditor](../../_includes/roles-iot-auditor.md) %}

{% include [iot-devices-writer](../../_includes/roles-iot-devices-writer.md) %}

{% include [iot-registries-writer](../../_includes/roles-iot-registries-writer.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
