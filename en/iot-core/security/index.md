---
title: Access management in Yandex IoT Core
description: "Access management of the cloud MQTT broker — Yandex IoT Core. The section describes which resources can be assigned a role, which roles are active in the service."
---

# Access management

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ iot-short-name }} service.

### Service roles

| Role | Permissions |
| ----- | ----- |
| `resource-manager.clouds.member` | The role required to access resources in the cloud for all users except [cloud owners](../../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../../iam/concepts/users/service-accounts.md). |
| `resource-manager.clouds.owner` | Grants you full access to a cloud and the resources in it. You can only assign this role for a cloud. |
| `iot.devices.writer` | The role required to send gRPC messages to {{ iot-short-name }} on behalf of a device. |
| `iot.registries.writer` | The role required to send gRPC messages to {{ iot-short-name }} on behalf of a registry. |

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} documentation.

### Primitive roles

{% include [roles-primitive](../../_includes/roles-primitive.md) %}