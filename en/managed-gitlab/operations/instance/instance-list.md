# Getting information about instances

You can get detailed information about each [{{ GL }} instance](../../concepts/index.md#instance) you created in {{ yandex-cloud }}.

## Getting a list of instances in a folder {#list}

{% list tabs %}

- Management console

  Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.

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
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name.

{% endlist %}

## Viewing a list of operations in an instance {#list-operations}

The list shows operations with instances and resources linked to them.

{% list tabs %}

- Management console

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ GL }} instance is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select the ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab.

{% endlist %}