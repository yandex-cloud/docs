# Updating {{ k8s }}

For {{ managed-k8s-name }}, both automatic and manual updates are available for [clusters](../concepts/index.md#kubernetes-cluster) and [node groups](../concepts/index.md#node-group). You can request a manual update of the cluster or its nodes to the latest supported version at any time. Manual updates bypass any configured maintenance windows and maintenance exceptions.

When updating the {{ k8s }} major version, first update the cluster and then its node group.

{% note info %}

You can edit the update policy of [clusters](#cluster-auto-upgrade) and [node groups](#node-group-auto-upgrade) at any time.

{% endnote %}

For more information, see [{#T}](../concepts/release-channels-and-updates.md).

## List of available {{ k8s }} versions {#versions-list}

{% list tabs %}

- Management console

  To get a list of available versions for a cluster:
  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of the {{ k8s }} cluster.
  1. Click **Edit** in the upper-right corner.
  1. View the list of available versions in the **{{ k8s }} version** field under **Master configuration**.

  To get a list of available versions for a node group:
  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of the {{ k8s }} cluster and go to the **Nodes manager** tab.
  1. Select the node group from the list and click **Edit** in the upper-right corner.
  1. Get a list of available versions in the **{{ k8s }} version** field.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of available versions, run the command:

  ```bash
  yc managed-kubernetes list-versions
  ```

- API

  To get a list of available versions, use the [list](../../managed-kubernetes/api-ref/Version/list.md) method.

{% endlist %}

## Updating a cluster {#cluster-upgrade}

### Configuring automatic updates when creating or editing a cluster {#cluster-auto-upgrade}

Select automatic update mode for the cluster and set the update schedule:

{% list tabs %}

- Management console

  You can specify update settings when [creating a cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [editing its settings](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md).

  In the **Maintenance frequency / Disable** field, select the cluster update policy:
  * **Disabled**: Select this option to not use automatic updates.
  * **Anytime**: Select this option for {{ managed-k8s-name }} to manage the update installation schedule.
  * **Daily**: Set the start time and duration of the update.
  * **On selected days**: Set the day, start time, and duration of the update. If necessary, select multiple options by clicking **Add day and time**.

- CLI

  Set automatic update parameters when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [editing](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) a cluster:

  ```bash
  {{ yc-k8s }} cluster <create or update> <cluster ID or name> \
  ...
    --auto-upgrade <true or false> \
    --anytime-maintenance-window \
    --daily-maintenance-window <value> \
    --weekly-maintenance-window <value>
  ```

  Where:
  * `--auto-upgrade`: Automatic update mode for the cluster. The default value is `true` (automatic updates are enabled).
  * `--anytime-maintenance-window`: Random update time for the cluster.
  * `--daily-maintenance-window`: **Daily** update mode.

    Example of updating a cluster daily at 22:00 UTC, which lasts up to 10 hours:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window`: Automatic update on specified days.

    Example of updating a cluster on Mondays and Tuesdays starting at 22:00 UTC, which lasts up to 10 hours:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    To set multiple maintenance periods, pass the settings of each of them in a separate `--weekly-maintenance-window` argument.

    {% note info %}

    The `--daily-maintenance-window` and `--weekly-maintenance-window` arguments require the `--auto-upgrade` argument with the `true` value. The update schedule will not be created if you set `--auto-upgrade=false`.

    {% endnote %}

  You can find out the cluster ID and name in the [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }}

  1. Open the current configuration file with the cluster description.

     For information about how to create this file, see [{#T}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Change automatic update settings in the {{ k8s }} cluster description.

     {% note info %}

     You can select only one update mode: daily or on selected days. Concurrent use of update modes is not permitted.

     {% endnote %}

     * To enable daily update mode:

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster name>" {
         name = <cluster name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<update start time, UTC>"
             duration   = "<update duration>"
           }
         }
       }
       ```

     * To enable updates on selected days (multiple periods are possible):

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster name>" {
         name = <cluster name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<update start day, for example monday>"
             start_time = "<update start time, UTC>"
             duration   = "<update duration>"
           }
           maintenance_window {
             day        = "<update start day, for example monday>"
             start_time = "<update start time, UTC>"
             duration   = "<update duration>"
           }
         }
       }
       ```

     * To enable a random update time, do not add the `maintenance_policy` parameter section to the cluster description. If the cluster description doesn't indicate automatic update settings, it will be run at any time.
     * To disable automatic updates:

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster name>" {
         name = "<cluster name>"
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Make sure that the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

- API

  Set automatic update settings in the `masterSpec.maintenancePolicy` section when [creating a cluster](../../managed-kubernetes/api-ref/Cluster/create.md) or [modifying its settings](../../managed-kubernetes/api-ref/Cluster/update.md).

  Use the [update](../../managed-kubernetes/api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).
  * Automatic update settings in the `masterSpec.maintenancePolicy` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [updateMask warning](../../_includes/note-api-updatemask.md) %}

  To disable automatic updates, pass the `false` value in the `masterSpec.maintenancePolicy.autoUpgrade` parameter.

  To enable and configure the update window, pass one of the acceptable values of the `maintenanceWindow` parameter:
  * For clusters to update at a random time, pass the `"anytime": {}` value.
  * To set up daily updates, add the `dailyMaintenanceWindow` section:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<update start hour, UTC>",
        "minutes": "<update start minute>",
        "seconds": "<update start second>",
        "nanos": "<update start thousandth of a second>"
      },
      "duration": "<duration of update period, hours>"
    }
    ```

  * To set up the update on selected days, add the `weeklyMaintenanceWindow` section:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<list of days, for example: monday, tuesday>"
          ],
          "startTime": {
            "hours": "<update start hour, UTC>",
            "minutes": "<update start minute>",
            "seconds": "<update start second>",
            "nanos": "<update start thousandth of a second>"
          },
          "duration": "<duration of update period, hours>"
        }
      ]
    }
    ```

{% endlist %}

### Manually updating the cluster version {#cluster-manual-upgrade}

If necessary, update the {{ k8s }} cluster version manually. Only the next minor version after the current one is available for updating. Updating to newer versions should be done in steps, for example: 1.19 → 1.20 → 1.21.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of the {{ k8s }} cluster.
  1. Click **Edit** in the upper-right corner.
  1. In the **{{ k8s }} version** field, select the **Update to version <version number>** option.
  1. Click **Save changes**.

- CLI

  Specify the new version of {{ k8s }} in the value of the `--version` argument:

  ```bash
  {{ yc-k8s }} cluster update <cluster name or ID> \
    --version <new version>
  ```

  You can find out the cluster ID and name in the [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }}

  1. Open the current configuration file with the cluster description.

     For more information about creating this file, see [{#T}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Change the version in the {{ k8s }} cluster description:

     ```hcl
     resource "yandex_kubernetes_cluster" "<cluster name>" {
       name = <cluster name>
       ...
       version = "<new version>"
     }
     ```

  1. Make sure that the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster}}).

- API

  Use the [update](../../managed-kubernetes/api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).
  * The desired {{ k8s }} version in the `masterSpec.version.version` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating a node group {#node-group-upgrade}

### Configuring automatic updates of a node group {#node-group-auto-upgrade}

Select automatic update mode for the node group and set the desired update schedule:

{% list tabs %}

- Management console

  You can specify update settings when [creating a cluster](../../managed-kubernetes/operations/node-group/node-group-create.md) or [updating its settings](../../managed-kubernetes/operations/node-group/node-group-update.md).

  In the **Allow when creating and updating** field, specify scaling settings of the node group:
  * **Max expansion of group size**: Set the maximum number of instances by which you can expand the size of the group when updating it.
  * **Max reduction of group size**: Set the maximum number of instances by which you can reduce the size of the group when updating it.

  In the **Maintenance frequency / Disable** field, select the node group update policy:
  * **Disabled**: Select this option to not use automatic updates.
  * **Anytime**: Select this option for {{ managed-k8s-name }} to manage the update installation schedule.
  * **Daily**: Set the start time and duration of the update.
  * **On selected days**: Set the day, start time, and duration of the update. If necessary, select multiple options by clicking **Add day and time**.

- CLI

  Set automatic update parameters when [creating](../../managed-kubernetes/operations/node-group/node-group-create.md) or [editing](../../managed-kubernetes/operations/node-group/node-group-update.md) a node group:

  ```bash
  {{ yc-k8s }} node-group <create or update> <node group ID or name> \
  ...
    --max-expansion <value> \
    --max-unavailable <value> \
    --auto-upgrade <true or false> \
    --auto-repair <true or false> \
    --anytime-maintenance-window \
    --daily-maintenance-window <value> \
    --weekly-maintenance-window <value>
  ```

  Where:
  * `--max-expansion`: The maximum number of instances by which you can expand the size of the group when updating it.
  * `--max-unavailable`: The maximum number of instances by which you can reduce the size of the group when updating it.

    {% note info %}

    The `--max-expansion` and `--max-unavailable` parameters should be used together.

    {% endnote %}

  * `--auto-upgrade`: Automatic update mode for the node group. The default value is `true` (automatic updates are enabled).
  * `--auto-repair`: The mode for re-creating failed nodes.

    The `--auto-repair` mode is at the [Preview](../../overview/concepts/launch-stages.md) stage.
  * `--anytime-maintenance-window`: Random update time for the node group.
  * `--daily-maintenance-window`: **Daily** update mode.

    Example of updating a node group daily at 22:00 UTC, which lasts up to 10 hours:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window`: Automatic update on specified days.

    Example of updating a node group on Mondays and Tuesdays from 22:00 UTC, which lasts 10 hours:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    To set multiple maintenance periods, pass the settings of each of them in a separate `--weekly-maintenance-window` argument.

    {% note info %}

    The `--daily-maintenance-window` and `--weekly-maintenance-window` arguments require the `--auto-upgrade` argument with the `true` value.
    The update schedule will not be created if you set `--auto-upgrade=false`.

    {% endnote %}

  You can find out the ID and name of the node group [in a list of groups in a cluster](node-group/node-group-list.md).

- {{ TF }}

  1. Open the current configuration file with the description of the node group.

     For more information about creating this file, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-create.md).
  1. Change automatic update settings in the node group description.

     {% note info %}

     You can select only one of the update mode: daily or on selected days. Concurrent use of update modes is not permitted.

     {% endnote %}

     * To enable the daily update mode:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node group name>" {
         name = <node group name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<update start time, UTC>"
             duration   = "<update duration>"
           }
         }
       }
       ```

     * To enable updates on selected days (multiple periods are possible):

       ```hcl
       resource "yandex_kubernetes_node_group" "<node group name>" {
         name = <node group name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<update start day, for example monday>"
             start_time = "<update start time, UTC>"
             duration   = "<update duration>"
           }
           maintenance_window {
             day        = "<update start day, for example monday>"
             start_time = "<update start time, UTC>"
             duration   = "<update duration>"
           }
         }
       }
       ```

     * To enable random update times, do not add the `maintenance_policy` parameter section to the node group description. If the node group description doesn't indicate automatic update settings, it will be run at any time.
     * To set the scaling settings of a node group when updating:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node group name>" {
         name = <node group name>
         ...
         deploy_policy {
           max_expansion   = <maximum number of instances by which you can expand the size of the group>
           max_unavailable = <maximum number of instances by which you can reduce the size of the group>
         }
       }
       ```

       {% note info %}

       The `max_expansion` and `max_unavailable` parameters should be used together.

       {% endnote %}

     * To disable automatic updates:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node group name>" {
         name = "<node group name>"
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Make sure that the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API

  You specify automatic update settings under `maintenancePolicy` when [creating a node group](../../managed-kubernetes/api-ref/NodeGroup/create.md) or [editing a node group configuration](../../managed-kubernetes/api-ref/NodeGroup/update.md).

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) API method and pass the following in the request:
  * ID of the node group in the `nodeGroupId` parameter. To find out the node group ID, [get the list of groups in the cluster](node-group/node-group-list.md).
  * Automatic update settings in the `maintenancePolicy` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

  To disable automatic updates, pass the `false` value in the `maintenancePolicy.autoUpgrade` parameter.

  To enable and configure the update window, pass one of the acceptable values of the `maintenanceWindow` parameter:
  * For node groups to update at any time, pass the `"anytime": {}` value.
  * To set up daily updates, add the `dailyMaintenanceWindow` section:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<update start hour, UTC>",
        "minutes": "<update start minute>",
        "seconds": "<update start second>",
        "nanos": "<update start thousandth of a second>"
      },
      "duration": "<duration of update period, hours>"
    }
    ```

  * To set up the update on selected days, add the `weeklyMaintenanceWindow` section:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<list of days, for example: monday, tuesday>"
          ],
          "startTime": {
            "hours": "<update start hour, UTC>",
            "minutes": "<update start minute>",
            "seconds": "<update start second>",
            "nanos": "<update start thousandth of a second>"
          },
          "duration": "<duration of update period, hours>"
        }
      ]
    }
    ```

  To set the scaling of a node group, add the `deployPolicy` section:

  ```json
  "deployPolicy": {
    "maxUnavailable": "<maximum number of instances you can add to the target size of the instance group>",
    "maxExpansion": "<maximum number of instances by which you can reduce the size of the group>"
  }
  ```

{% endlist %}

### Manually updating a node group version {#node-group-manual-upgrade}

If necessary, update the {{ k8s }} node group version manually. Only the next minor version after the current one is available for updating. Updating to newer versions should be done in steps, for example: 1.19 → 1.20 → 1.21.

{% note warning %}

Update the cluster version before updating the node group.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of the {{ k8s }} cluster.
  1. Go to the **Nodes manager** tab.
  1. Select the desired node group from the list.
  1. Click **Edit** in the upper-right corner.
  1. In the **{{ k8s }} version** field, select the **Update to version <version number>** option.
  1. Click **Save changes**.

- CLI

  Set automatic update parameters:

  ```bash
  {{ yc-k8s }} node-group update <node group ID or name> \
  ...
    --version <new version>
  ```

  You can find out the ID and name of the node group [in a list of groups in a cluster](node-group/node-group-list.md).

- {{ TF }}

  1. Open the current configuration file with the description of the node group.

     For more information about creating this file, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-create.md).
  1. Change the version in the node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node group name>" {
       name = <node group name>
       ...
       version = "<new version>"
     }
     ```

  1. Make sure that the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) API method and pass the following in the request:
  * ID of the node group in the `nodeGroupId` parameter. To find out the node group ID, [get the list of groups in the cluster](node-group/node-group-list.md).
  * The desired version of {{ k8s }} in the `version.version` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating {{ k8s }} components without changing the version {#latest-revision}

For a {{ managed-k8s-name }} cluster and a node group, updates within the same {{ k8s }} version are available. When installing the update, the major version of {{ k8s }} doesn't change.

This update enables you to:
* Install new packages.
* Update the {{ k8s }} image.
* Update the {{ k8s }} minor version.

The cluster and node groups will be updated if any of the automatic update options are enabled in their settings.

### Updating for a cluster with automatic updating disabled {#cluster-latest-revision}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of the {{ k8s }} cluster.
  1. Click **Edit** in the upper-right corner.
  1. In the **{{ k8s }} version** field, select **Get the latest improvements and fixes for version...**.
  1. Click **Save changes**.

- CLI

  Run a cluster update:

  ```bash
  {{ yc-k8s }} cluster update <cluster name or ID> \
    --latest-revision
  ```

  You can find out the cluster ID and name in the [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md#list).

- API

  Use the [update](../../managed-kubernetes/api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md#list).
  * The `true` value in the `masterSpec.version.version` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

### Updating for a node group with automatic updating disabled {#node-group-latest-revision}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click on the name of the {{ k8s }} cluster.
  1. Go to the **Nodes manager** tab.
  1. Select the desired node group from the list.
  1. Click **Edit** in the upper-right corner.
  1. In the **{{ k8s }} version** field, select **Get the latest improvements and fixes for version...**.
  1. Click **Save changes**.

- CLI

  Update the node group:

  ```bash
  {{ yc-k8s }} node-group update <node group ID or name> \
    --latest-revision
  ```

  You can find out the ID and name of the node group [in a list of groups in a cluster](node-group/node-group-list.md).

- API

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) API method and pass the following in the request:
  * ID of the node group in the `nodeGroupId` parameter. To find out the node group ID, [get the list of groups in the cluster](node-group/node-group-list.md).
  * The `true` value in the `version.latestRevision` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}