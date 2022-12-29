---
title: "Access management in {{ iot-full-name }}"
description: "Access management in the {{ iot-full-name }} cloud-based MQTT server This section describes what resources you can assign a role for and what roles the service supports."
---

# Access management in {{ iot-name }}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

You can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ iot-short-name }} service.

### Service roles

| Role | Permissions |
----- | -----
| `resource-manager.clouds.member` | A role everyone requires to access cloud resources, except for [cloud owners](../../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../../iam/concepts/users/service-accounts.md). |
| `resource-manager.clouds.owner` | Grants you full access to a cloud and the resources in it. You can only assign this role for a cloud. |
| `iot.devices.writer` | The role required to send gRPC messages to {{ iot-short-name }} on behalf of a device. |
| `iot.registries.writer` | The role required to send gRPC messages to {{ iot-short-name }} on behalf of a registry. |

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.

### Primitive roles

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
