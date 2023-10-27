# Updating {{ k8s }}

For {{ managed-k8s-name }}, both automatic and manual updates are available for [clusters](../concepts/index.md#kubernetes-cluster) and [node groups](../concepts/index.md#node-group). You can request a manual update of the {{ managed-k8s-name }} cluster or its nodes to the latest supported [version](../concepts/release-channels-and-updates.md) at any time. Manual updates bypass any configured maintenance windows and maintenance exceptions.

When updating the {{ k8s }} major version, first update the {{ managed-k8s-name }} cluster and then its node group.

{% note info %}

You can edit the update policy of [{{ managed-k8s-name }} clusters](#cluster-auto-upgrade) and [node groups](#node-group-auto-upgrade) at any time.

{% endnote %}

For more information, see [{#T}](../concepts/release-channels-and-updates.md).

## List of available {{ k8s }} versions {#versions-list}

{% list tabs %}

- Management console

  To get a list of available versions for a {{ managed-k8s-name }} cluster:
  1. Go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ managed-k8s-name }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **Edit** in the top-right corner.
  1. View the list of available versions in the **{{ k8s }} version** field under **Master configuration**.

  To get a list of available versions for a {{ managed-k8s-name }} node group:
  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the {{ managed-k8s-name }} cluster name and go to the **Nodes manager** tab.
  1. Select the {{ managed-k8s-name }} node group from the list and click **Edit** in the top-right corner.
  1. Get a list of available versions in the **{{ k8s }} version** field.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of available versions, run the following command:

  ```bash
  yc managed-kubernetes list-versions
  ```

- API

  To get a list of available versions, use the [list](../../managed-kubernetes/api-ref/Version/list.md) method.

{% endlist %}

## Updating a cluster {#cluster-upgrade}

### Configuring automatic updates when creating or editing a cluster {#cluster-auto-upgrade}

Select automatic update mode for your {{ managed-k8s-name }} cluster and set the update schedule:

{% list tabs %}

- Management console

  You can specify update settings when [creating a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating its settings](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md).

  In the **Maintenance frequency / Disable** field, select the {{ managed-k8s-name }} cluster update policy:
  * **Disabled**: Select this option not to use automatic updates.
  * **Anytime**: Select this option for {{ managed-k8s-name }} to manage the update installation schedule.
  * **Daily**: Set the start time and duration of the update.
  * **On selected days**: Set the day, start time, and duration of the update. If necessary, select multiple options using the **Add day and time** button.

- CLI

  Set automatic update parameters when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) the {{ managed-k8s-name }} cluster:

  ```bash
  {{ yc-k8s }} cluster <create_or_update> <cluster_ID_or_name> \
  ...
    --auto-upgrade <true_or_false> \
    --anytime-maintenance-window \
    --daily-maintenance-window <value> \
    --weekly-maintenance-window <value>
  ```

  Where:
  * `--auto-upgrade`: Automatic {{ managed-k8s-name }} cluster update mode. The default value is `true` (automatic updates are enabled).
  * `--anytime-maintenance-window`: Random {{ managed-k8s-name }} cluster update time.
  * `--daily-maintenance-window`: **Daily** update mode.

    Example of updating a {{ managed-k8s-name }} cluster daily at 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window`: Automatic update on specified days.

    Example of updating a {{ managed-k8s-name }} cluster on Mondays and Tuesdays starting at 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    To set multiple maintenance periods, provide the settings of each one in a separate `--weekly-maintenance-window` argument.

    {% note info %}

    The `--daily-maintenance-window` and `--weekly-maintenance-window` arguments require the `--auto-upgrade` argument with the `true` value. The update schedule will not be created if you set `--auto-upgrade=false`.

    {% endnote %}

  You can get the {{ managed-k8s-name }} cluster ID and name with a [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }}

  1. Open the current configuration file with the {{ managed-k8s-name }} cluster description.

     For information about how to create this file, see [{#T}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Change automatic update settings in the {{ managed-k8s-name }} cluster description.

     {% note info %}

     You can select only one of the update modes — daily or on selected days. Concurrent use of update modes is not permitted.

     {% endnote %}

     * To enable the daily update mode:

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster_name>" {
         name = <cluster_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<update_start_time,_UTC>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

     * To enable updates on selected days (multiple periods are possible):

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster_name>" {
         name = <cluster_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<update_start_day,_e.g.,_monday>"
             start_time = "<update_start_time,_UTC>"
             duration   = "<update_duration>"
           }
           maintenance_window {
             day        = "<update_start_day,_e.g.,_monday>"
             start_time = "<update_start_time,_UTC>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

     * To enable the random update time mode, do not add the `maintenance_policy` parameter section to the {{ managed-k8s-name }} cluster description. If you omit automatic update settings in the {{ managed-k8s-name }} cluster description, updates will take place at a random time.
     * To disable automatic updates:

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster_name>" {
         name = "<cluster_name>"
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

- API

  Set up automatic updates in the `masterSpec.maintenancePolicy` section when [creating a {{ managed-k8s-name }} cluster](../../managed-kubernetes/api-ref/Cluster/create.md) or [updating its settings](../../managed-kubernetes/api-ref/Cluster/update.md).

  Use the [update](../../managed-kubernetes/api-ref/Cluster/update.md) API method and include the following in the request:
  * {{ managed-k8s-name }} cluster ID in the `clusterId` parameter. To find out the {{ managed-k8s-name }} cluster ID, [get a list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).
  * Automatic update settings in the `masterSpec.maintenancePolicy` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [updateMask warning](../../_includes/note-api-updatemask.md) %}

  To disable automatic updates, provide the `false` value in the `masterSpec.maintenancePolicy.autoUpgrade` parameter.

  To enable and configure the update window, provide one of the acceptable values of the `maintenanceWindow` parameter:
  * For {{ managed-k8s-name }} clusters to update at a random time, provide the `"anytime": {}` value.
  * To set up daily updates, add the `dailyMaintenanceWindow` section:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<hour_of_update_start,_UTC>",
        "minutes": "<minute_of_update_start>",
        "seconds": "<second_of_update_start>",
        "nanos": "<thousandth_of_seconds_of_update_start>"
      },
      "duration": "<update_duration,_hours>"
    }
    ```

  * To set up the update on selected days, add the `weeklyMaintenanceWindow` section:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<list_of_days,_e.g.:_monday,_tuesday>"
          ],
          "startTime": {
            "hours": "<hour_of_update_start,_UTC>",
            "minutes": "<minute_of_update_start>",
            "seconds": "<second_of_update_start>",
            "nanos": "<thousandth_of_second_of_update_start>"
          },
          "duration": "<update_duration,_hours>"
        }
      ]
    }
    ```

{% endlist %}

### Manually updating the cluster version {#cluster-manual-upgrade}

If necessary, update the {{ managed-k8s-name }} cluster version manually. You can only update your {{ managed-k8s-name }} cluster in a single step to the minor version next to the current one. Updating to newer versions should be done in steps, e.g., 1.19 → 1.20 → 1.21.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **Edit** in the top-right corner.
  1. In the **{{ k8s }} version** field, select the **Upgrade to version <version number>** option.
  1. Click **Save changes**.

- CLI

  Specify the new version of {{ k8s }} in the value of the `--version` argument:

  ```bash
  {{ yc-k8s }} cluster update <cluster_ID_or_name> \
    --version <new_version>
  ```

  You can get the {{ managed-k8s-name }} cluster ID and name with a [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }}

  1. Open the current configuration file with the {{ managed-k8s-name }} cluster description.

     For more information about creating this file, see [{#T}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Change the version in the {{ managed-k8s-name }} cluster description:

     ```hcl
     resource "yandex_kubernetes_cluster" "<cluster_name>" {
       name = <cluster_name>
       ...
       version = "<new_version>"
     }
     ```

  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster}}).

- API

  Use the [update](../../managed-kubernetes/api-ref/Cluster/update.md) API method and include the following in the request:
  * {{ managed-k8s-name }} cluster ID in the `clusterId` parameter. To find out the {{ managed-k8s-name }} cluster ID, [get a list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).
  * Required {{ k8s }} version in the `masterSpec.version.version` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating a node group {#node-group-upgrade}

### Configuring automatic updates of a node group {#node-group-auto-upgrade}

Select automatic update mode for the {{ managed-k8s-name }} node group and set the required update schedule:

{% list tabs %}

- Management console

  You can specify update settings when [creating a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/node-group/node-group-create.md) or [updating its settings](../../managed-kubernetes/operations/node-group/node-group-update.md).

  In the **Allow when creating and updating** field, specify scaling settings of the {{ managed-k8s-name }} node group:
  * **Max expansion of group size**: Set the maximum number of instances by which you can increase the size of the {{ managed-k8s-name }} node group when updating it.
  * **Max reduction of group size**: Set the maximum number of instances by which you can decrease the size of the {{ managed-k8s-name }} node group when updating it.

  In the **Maintenance frequency / Disable** field, select the {{ managed-k8s-name }} node group update policy:
  * **Disabled**: Select this option not to use automatic updates.
  * **Anytime**: Select this option for {{ managed-k8s-name }} to manage the update installation schedule.
  * **Daily**: Set the start time and duration of the update.
  * **On selected days**: Set the day, start time, and duration of the update. If necessary, select multiple options using the **Add day and time** button.

- CLI

  Set automatic update parameters when [creating](../../managed-kubernetes/operations/node-group/node-group-create.md) or [updating](../../managed-kubernetes/operations/node-group/node-group-update.md) a {{ managed-k8s-name }} node group.

  ```bash
  {{ yc-k8s }} node-group <create_or_update> <node_group_ID_or_name> \
  ...
    --max-expansion <value> \
    --max-unavailable <value> \
    --auto-upgrade <true_or_false> \
    --auto-repair <true_or_false> \
    --anytime-maintenance-window \
    --daily-maintenance-window <value> \
    --weekly-maintenance-window <value>
  ```

  Where:
  * `--max-expansion`: Maximum number of instances by which you can increase the size of the {{ managed-k8s-name }} node group when updating it.
  * `--max-unavailable`: Maximum number of instances by which you can decrease the size of the {{ managed-k8s-name }} node group when updating it.

    {% note info %}

    The `--max-expansion` and `--max-unavailable` parameters should be used together.

    {% endnote %}

  * `--auto-upgrade`: Automatic update mode for the {{ managed-k8s-name }} node group. The default value is `true` (automatic updates are enabled).
  * `--auto-repair`: Mode for re-creating failed nodes.

    The `--auto-repair` mode is at the [Preview](../../overview/concepts/launch-stages.md).
  * `--anytime-maintenance-window`: Random update time for the {{ managed-k8s-name }} node group.
  * `--daily-maintenance-window`: **Daily** update mode.

    Example of updating a {{ managed-k8s-name }} node group daily at 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window`: Automatic update on specified days.

    Example of updating a {{ managed-k8s-name }} node group on Mondays and Tuesdays from 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    To set multiple maintenance periods, provide the settings of each one in a separate `--weekly-maintenance-window` argument.

    {% note info %}

    The `--daily-maintenance-window` and `--weekly-maintenance-window` arguments require the `--auto-upgrade` argument with the `true` value.

    The update schedule will not be created if you set `--auto-upgrade=false`.

    {% endnote %}

   You can get the {{ managed-k8s-name }} node group ID and name with a [list of the groups in the cluster](node-group/node-group-list.md).

- {{ TF }}

  1. Open the current configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-create.md).
  1. Change automatic update settings in the {{ managed-k8s-name }} node group description.

     {% note info %}

     You can select only one of the update modes — daily or on selected days. Concurrent use of update modes is not permitted.

     {% endnote %}

     * To enable the daily update mode:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = <node_group_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<update_start_time,_UTC>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

     * To enable updates on selected days (multiple periods are possible):

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = <node_group_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<update_start_day,_e.g.,_monday>"
             start_time = "<update_start_time,_UTC>"
             duration   = "<update_duration>"
           }
           maintenance_window {
             day        = "<update_start_day,_e.g.,_monday>"
             start_time = "<update_start_time,_UTC>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

     * To enable the random update time mode, do not add the `maintenance_policy` parameter section to the {{ managed-k8s-name }} node group description. If you omit automatic update settings in the {{ managed-k8s-name }} node group description, updates will take place at a random time.
     * To configure the {{ managed-k8s-name }} node group scaling settings applied at updates:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = <node_group_name>
         ...
         deploy_policy {
           max_expansion   = <maximum_number_of_instances_to_increase_node_group_size>
           max_unavailable = <maximum_number_of_instances_to_decrease_node_group_size>
         }
       }
       ```

       {% note info %}

       The `max_expansion` and `max_unavailable` parameters should be used together.

       {% endnote %}

     * To disable automatic updates:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = <node_group_name>
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Make sure the configuration files are valid.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API

  You can set up automatic updates under `maintenancePolicy` when [creating](../../managed-kubernetes/api-ref/NodeGroup/create.md) or [updating](../../managed-kubernetes/api-ref/NodeGroup/update.md) a {{ managed-k8s-name }} node group.

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) API method and include the following in the request:
  * ID of the {{ managed-k8s-name }} node group in the `nodeGroupId` parameter. To find out the {{ managed-k8s-name }} node group ID, get a [list of groups in the cluster](node-group/node-group-list.md).
  * Automatic update settings in the `maintenancePolicy` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

  To disable automatic updates, provide the `false` value in the `maintenancePolicy.autoUpgrade` parameter.

  To enable and configure the update window, provide one of the acceptable values of the `maintenanceWindow` parameter:
  * For {{ managed-k8s-name }} node groups to update at a random time, provide the `"anytime": {}` value.
  * To set up daily updates, add the `dailyMaintenanceWindow` section:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<hour_of_update_start,_UTC>",
        "minutes": "<minute_of_update_start>",
        "seconds": "<second_of_update_start>",
        "nanos": "<thousandth_of_seconds_of_update_start>"
      },
      "duration": "<update_duration,_hours>"
    }
    ```

  * To set up the update on selected days, add the `weeklyMaintenanceWindow` section:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<list_of_days,_e.g.,_monday,_tuesday>"
          ],
          "startTime": {
            "hours": "<hour_of_update_start,_UTC>",
            "minutes": "<minute_of_update_start>",
            "seconds": "<second_of_update_start>",
            "nanos": "<thousandth_of_second_of_update_start>"
          },
          "duration": "<update_duration,_hours>"
        }
      ]
    }
    ```

  To set the scaling of a {{ managed-k8s-name }} node group, add the `deployPolicy` section:

  ```json
  "deployPolicy": {
    "maxUnavailable": "<maximum_number_of_instances_that_node_group_size_can_shrink_by>",
    "maxExpansion": "<maximum_number_of_instances_that_node_group_size_can_expand_by>"
  }
  ```

{% endlist %}

### Manually updating a node group version {#node-group-manual-upgrade}

If necessary, update the {{ managed-k8s-name }} node group version manually. Only the next minor version after the current one is available for updating. Updating to newer versions should be done in steps, e.g., 1.19 → 1.20 → 1.21.

{% note warning %}

Update the {{ managed-k8s-name }} cluster version before updating the node group.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Go to the **Nodes manager** tab.
  1. Select the {{ managed-k8s-name }} node group from the list.
  1. Click **Edit** in the top-right corner.
  1. In the **{{ k8s }} version** field, select the **Upgrade to version <version number>** option.
  1. Click **Save changes**.

- CLI

  Set automatic update parameters:

  ```bash
  {{ yc-k8s }} node-group update <node_group_ID_or_name> \
  ...
    --version <new_version>
  ```

  You can get the {{ managed-k8s-name }} node group ID and name with a [list of the groups in the cluster](node-group/node-group-list.md).

- {{ TF }}

  1. Open the current configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-create.md).
  1. Change the version in the {{ managed-k8s-name }} node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
       name = <node_group_name>
       ...
       version = "<new_version>"
     }
     ```

  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) API method and include the following in the request:
  * ID of the {{ managed-k8s-name }} node group in the `nodeGroupId` parameter. To find out the {{ managed-k8s-name }} node group ID, get a [list of groups in the cluster](node-group/node-group-list.md).
  * Required version of {{ k8s }} in the `version.version` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating {{ k8s }} components without changing the version {#latest-revision}

For a {{ managed-k8s-name }} cluster and a node group, updates within the same {{ k8s }} version are available. When installing the update, the major version of {{ k8s }} does not change.

This update enables you to:
* Install new packages
* Update the {{ k8s }} image
* Update the {{ k8s }} minor version

The {{ managed-k8s-name }} cluster and node groups will be updated if any of the automatic update options are enabled in their settings.

### Updating for a cluster with automatic updating disabled {#cluster-latest-revision}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **Edit** in the top-right corner.
  1. In the **{{ k8s }} version** field, select **Get the latest improvements and fixes for version...**.
  1. Click **Save changes**.

- CLI

  Run {{ managed-k8s-name }} cluster update:

  ```bash
  {{ yc-k8s }} cluster update <cluster_ID_or_name> \
    --latest-revision
  ```

  You can get the {{ managed-k8s-name }} cluster ID and name with a [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md#list).

- API

  Use the [update](../../managed-kubernetes/api-ref/Cluster/update.md) API method and include the following in the request:
  * {{ managed-k8s-name }} cluster ID in the `clusterId` parameter. To find out the {{ managed-k8s-name }} cluster ID, [get a list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md#list).
  * `True` value in the `masterSpec.version.version` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

### Updating for a node group with automatic updating disabled {#node-group-latest-revision}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Go to the **Nodes manager** tab.
  1. Select the {{ managed-k8s-name }} node group from the list.
  1. Click **Edit** in the top-right corner.
  1. In the **{{ k8s }} version** field, select **Get the latest improvements and fixes for version...**.
  1. Click **Save changes**.

- CLI

  Update the {{ managed-k8s-name }} node group:

  ```bash
  {{ yc-k8s }} node-group update <node_group_ID_or_name> \
    --latest-revision
  ```

  You can get the {{ managed-k8s-name }} node group ID and name with a [list of the groups in the cluster](node-group/node-group-list.md).

- API

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) API method and include the following in the request:
  * ID of the {{ managed-k8s-name }} node group in the `nodeGroupId` parameter. To find out the {{ managed-k8s-name }} node group ID, get a [list of groups in the cluster](node-group/node-group-list.md).
  * `True` value in the `version.latestRevision` parameter.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
