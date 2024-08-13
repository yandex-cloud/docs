---
title: "Управление доступом в {{ iot-full-name }}"
description: "Управление доступом облачного MQTT-сервера {{ iot-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---
    
# Управление доступом в {{ iot-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Эти роли будут действовать и на вложенные ресурсы.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ iot-short-name }}.

### Сервисные роли {#service-roles}

#### iot.devices.writer {#iot-devices-writer}

{% include [iot-devices-writer](../../_roles/iot/devices/writer.md) %}

#### iot.registries.writer {#iot-registries-writer}

{% include [iot-registries-writer](../../_roles/iot/registries/writer.md) %}

#### iot.auditor {#iot-auditor}

{% include [iot-auditor](../../_roles/iot/auditor.md) %}

#### iot.viewer {#iot-viewer}

{% include [iot-viewer](../../_roles/iot/viewer.md) %}

#### iot.editor {#iot-editor}

{% include [iot-editor](../../_roles/iot/editor.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}