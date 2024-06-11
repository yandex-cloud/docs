---
title: "Access management in {{ iot-full-name }}"
description: "Access management in the {{ iot-full-name }} cloud-based MQTT server This section describes the resources for which you can assign a role and the roles existing in the service."
---

# Access management in {{ iot-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). These roles also apply to nested resources.

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ iot-short-name }} service.

### Service roles {#service-roles}

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

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
