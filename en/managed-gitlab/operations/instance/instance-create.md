---
title: "How to create a {{ mgl-full-name }} instance"
description: "In this tutorial, you will learn how to create a {{ mgl-name }} instance."
---

# Creating and activating a {{ mgl-name }} instance

## Creating a {{ GL }} instance {#create}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [instance-create-console](../../../_includes/managed-gitlab/instance-create-console.md) %}

{% endlist %}

To prevent your instance disk space from running out:

* [Set the expiration time for job artifacts](https://docs.gitlab.com/ee/administration/settings/continuous_integration.html#default-artifacts-expiration) at the instance level. Its default value is 30 days.
* [Create and enable a tag cleanup policy](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#create-a-cleanup-policy) for separate projects utilizing {{ container-registry-name }}.
* If you are using a [{{ container-registry-full-name }} integration](../../tutorials/image-storage.md), create and enable a [Docker image cleanup policy](../../../container-registry/concepts/lifecycle-policy.md) for {{ container-registry-name }}.

## Activating the {{ GL }} instance {#activate}

After the instance status changes to **Running**, activate the instance:

1. Follow the link you received in your administrator mailbox after creating the instance.

   If you cannot open the {{ GL }} web interface, create a separate security group and [configure it](../configure-security-group.md) so that the rules allow incoming traffic from the required ports and IP addresses.

1. Change the administrator password.
1. Log in using the administrator username and password.

Further on, to open the {{ GL }} web interface, [get detailed information about your instance](instance-list.md#get) and follow the link in **{{ ui-key.yacloud.gitlab.field_domain }}**.
