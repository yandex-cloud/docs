# Getting information about instances

You can get detailed information about each [{{ GL }} instance](../../concepts/index.md#instance) you created in {{ yandex-cloud }}.

## Getting a list of instances in a folder {#list}

{% list tabs %}

- Management console

  Go to the folder page and select **{{ mgl-name }}**.

{% endlist %}

## Getting detailed information about an instance {#get}

Instance details:
* Domain.
* Status.
* Resources: RAM, vCPU, storage size.
* The administrator's login and email address.

{% list tabs %}

- Management console

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ GL }} instance is located.
  1. Select **{{ mgl-name }}**.
  1. Click on the name of the instance.

{% endlist %}

## Viewing a list of operations in an instance {#list-operations}

The list shows operations with instances and resources linked to them.

{% list tabs %}

- Management console

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ GL }} instance is located.
  1. Select **{{ mgl-name }}**.
  1. Click the name of the desired instance and select the ![image](../../../_assets/mdb/operations.svg) **Operations** tab.

{% endlist %}