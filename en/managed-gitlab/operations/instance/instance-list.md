# Getting information about instances

You can get detailed information about each [{{ GL }} instance](../../concepts/index.md#instance) you created in {{ yandex-cloud }}.

## Getting a list of instances in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

  Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.

{% endlist %}

## Getting detailed information about an instance {#get}

Instance details include:
* Domain.
* Status.
* Resources: RAM, vCPU, storage size.
* Admin's username and email address.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ GL }} instance is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name.

{% endlist %}

## Viewing a list of operations in an instance {#list-operations}

The list shows operations with instances and resources linked to them.

All actions with {{ mgl-name }} instances are logged as a list of operations. Each operation is assigned a unique ID.

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of operations for a specific instance:

  1. In the [management console]({{ link-console-main }}), open the folder with the cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.gitlab.switch_instances }}**.
  1. Select the instance you need.
  1. Go to the ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected cluster.

     You will see the list of operations with the selected instance.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../../api-design-guide/concepts/about-async.md)