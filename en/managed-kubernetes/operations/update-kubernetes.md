# Updating {{ k8s }}

For {{ managed-k8s-name }}, both automatic and manual updates are available for [clusters](../concepts/index.md#kubernetes-cluster) and [node groups](../concepts/index.md#node-group). You can request a manual update of your {{ managed-k8s-name }} cluster or its nodes to the latest supported [version](../concepts/release-channels-and-updates.md) at any time. Manual updates bypass any pre-configured maintenance windows and maintenance exceptions.

When updating the {{ k8s }} major version, first update the {{ managed-k8s-name }} cluster and then its node group.

You can edit the update policy of [{{ managed-k8s-name }}](#cluster-auto-upgrade) clusters and [node groups](#node-group-auto-upgrade) at any time.

For more information, see [{#T}](../concepts/release-channels-and-updates.md).

{% include [preflight-check](../../_includes/managed-kubernetes/preflight-check.md) %}

## List of available {{ k8s }} versions {#versions-list}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of available versions for a {{ managed-k8s-name }} cluster:
  1. Navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. View the list of available versions in the **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** field under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**.

  To get a list of available versions for a {{ managed-k8s-name }} node group:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of your {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Select the {{ managed-k8s-name }} node group from the list and click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Get a list of available versions in the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of available versions, run this command:

  ```bash
  yc managed-kubernetes list-versions
  ```

- API {#api}

  To get a list of available versions, use the [list](../../managed-kubernetes/managed-kubernetes/api-ref/Version/list.md) method.

{% endlist %}

## Updating a cluster {#cluster-upgrade}

### Configuring auto updates when creating or editing a cluster {#cluster-auto-upgrade}

Select auto update mode for your {{ managed-k8s-name }} cluster and set the update schedule:

{% list tabs group=instructions %}

- Management console {#console}

  You can specify update settings when [creating a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating its settings](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md).

  In the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** field, select the {{ managed-k8s-name }} cluster update policy:
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}`: Select this option to disable auto updates.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}`: Select this option for {{ managed-k8s-name }} to manage the update installation schedule.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`: Set the start time and duration of the update.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}`: Set the day, start time, and duration of the update. You can select multiple options using the **{{ ui-key.yacloud.k8s.clusters.create.button_add-day-of-week }}** button.

- CLI {#cli}

  Set auto update parameters when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) the {{ managed-k8s-name }} cluster:

  ```bash
  {{ yc-k8s }} cluster <create_or_update> <cluster_name_or_ID> \
  ...
    --auto-upgrade <auto_update_mode> \
    --anytime-maintenance-window \
    --daily-maintenance-window <value> \
    --weekly-maintenance-window <value>
  ```

  Where:
  * `--auto-upgrade`: Auto update mode for the {{ managed-k8s-name }} cluster. The default value is `true` (auto updates are enabled).
  * `--anytime-maintenance-window`: Any update window for the {{ managed-k8s-name }} cluster.
  * `--daily-maintenance-window`: `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}` update mode.

    Example of updating a {{ managed-k8s-name }} cluster daily at 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window`: Auto update on specified days.

    Example of updating a {{ managed-k8s-name }} cluster on Mondays and Tuesdays starting at 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    To set multiple maintenance windows, provide the settings of each one in a separate `--weekly-maintenance-window` argument.

    {% note info %}

    The `--daily-maintenance-window` and `--weekly-maintenance-window` arguments require the `--auto-upgrade` argument set to `true`. The update schedule will not be created if you set `--auto-upgrade=false`.

    {% endnote %}

  You can get the {{ managed-k8s-name }} cluster ID and name with the [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current configuration file with the {{ managed-k8s-name }} cluster description.

     For information about creating this file, see [{#T}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Change auto update settings in the {{ managed-k8s-name }} cluster description.

     {% note info %}

     You can select either of the update modes: daily or on selected days. Concurrent use of update modes is not allowed.

     {% endnote %}

     * To enable the daily update mode:

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster_name>" {
         name = <cluster_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<update_start_time>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

       Where:

       * `start_time`: Update start time in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
       * `duration`: Update duration, e.g., `4h30m`.

     * To enable updates on selected days (multiple periods are possible):

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster_name>" {
         name = <cluster_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<update_start_day>"
             start_time = "<update_start_time>"
             duration   = "<update_duration>"
           }
           maintenance_window {
             day        = "<update_start_day>"
             start_time = "<update_start_time>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

       Where:

       * `day`: Day of week, e.g., `monday`.
       * `start_time`: Update start time in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
       * `duration`: Update duration, e.g., `4h30m`.

     * To enable the random update time mode, do not add the `maintenance_policy` parameter section to the {{ managed-k8s-name }} cluster description. If you do not specify auto update settings in the {{ managed-k8s-name }} cluster description, updates will take place at a random time.
     * To disable auto updates:

       ```hcl
       resource "yandex_kubernetes_cluster" "<cluster_name>" {
         name = "<cluster_name>"
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/managed-kubernetes/terraform-timeout-cluster.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-cluster }}).

- API {#api}

  Set up auto updates in the `masterSpec.maintenancePolicy` section when [creating a {{ managed-k8s-name }} cluster](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/create.md) or [updating its settings](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/update.md).

  Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/update.md) API method and provide the following in the request:
  * {{ managed-k8s-name }} cluster ID in the `clusterId` parameter. To find out the {{ managed-k8s-name }} cluster ID, [get a list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).
  * Auto update settings in the `masterSpec.maintenancePolicy` parameter.
  * List of settings to update in the `updateMask` parameter.

  {% include [updateMask warning](../../_includes/note-api-updatemask.md) %}

  To disable auto updates, provide the `false` value in the `masterSpec.maintenancePolicy.autoUpgrade` parameter.

  To enable and configure the update window, provide one of the allowed values of the `maintenanceWindow` parameter:
  * For a {{ managed-k8s-name }} cluster to update at a random time, provide the `"anytime": {}` value.
  * To set up daily updates, add the `dailyMaintenanceWindow` section:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<update_start_hour>",
        "minutes": "<update_start_minute>",
        "seconds": "<update_start_second>",
        "nanos": "<update_start_fraction_of_second>"
      },
      "duration": "<duration_of_update_period>"
    }
    ```

    Where:

    * `hours`: Update start hour in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
    * `nanos`: Fraction of a second of the update start, in nanoseconds.
    * `duration`: Duration of update period, in hours.

  * For updates to take place on selected days, add the `weeklyMaintenanceWindow` section:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<list_of_days>"
          ],
          "startTime": {
            "hours": "<update_start_hour>",
            "minutes": "<update_start_minute>",
            "seconds": "<update_start_second>",
            "nanos": "<update_start_fraction_of_second>"
          },
          "duration": "<duration_of_update_period>"
        }
      ]
    }
    ```

    Where:

    * `days`: List of days, e.g., `monday`, `tuesday`.
    * `hours`: Update start hour in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
    * `nanos`: Fraction of a second of the update start, in nanoseconds.
    * `duration`: Duration of update period, in hours.

{% endlist %}

### Manually updating the cluster version {#cluster-manual-upgrade}

You can update the {{ managed-k8s-name }} cluster version manually. You can only update your {{ managed-k8s-name }} cluster in a single step to the next minor version from the current one. Upgrading to newer versions is done in multiple steps, e.g., 1.19 → 1.20 → 1.21.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. In the **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** field, select the `Upgrade to version <version_number>` option.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Specify the new {{ k8s }} version in the `--version` argument:

  ```bash
  {{ yc-k8s }} cluster update <cluster_name_or_ID> \
    --version <new_version>
  ```

  You can get the {{ managed-k8s-name }} cluster ID and name with the [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }} {#tf}

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

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/managed-kubernetes/terraform-timeout-cluster.md) %}

  For more information, see this [{{ TF }} provider guide]({{ tf-provider-k8s-cluster}}).

- API {#api}

  Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/update.md) API method and provide the following in the request:
  * {{ managed-k8s-name }} cluster ID in the `clusterId` parameter. To find out the {{ managed-k8s-name }} cluster ID, [get the list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md).
  * Required {{ k8s }} version in the `masterSpec.version.version` parameter.
  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating a node group {#node-group-upgrade}

{% include [os-new-version](../../_includes/managed-kubernetes/note-os-new-version.md) %}

### Configuring auto updates for a node group {#node-group-auto-upgrade}

Select auto update mode for the {{ managed-k8s-name }} node group and set the required update schedule:

{% list tabs group=instructions %}

- Management console {#console}

  You can specify update settings when [creating a {{ managed-k8s-name }} node group](../../managed-kubernetes/operations/node-group/node-group-create.md) or [updating its settings](../../managed-kubernetes/operations/node-group/node-group-update.md).

  In the **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}** field, specify scaling settings for your {{ managed-k8s-name }} node group:
  * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-expansion }}**: Specify the maximum number of nodes by which you can exceed the size of the group when updating it.

    {% include [note-expansion-group-vm](../../_includes/managed-kubernetes/note-expansion-group-vm.md) %}

  * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-unavailable }}**: Specify the maximum number of unavailable nodes the group may have during updates.

  In the **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** field, select the {{ managed-k8s-name }} node group update policy:
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}`: Select this option to disable auto updates.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}`: Select this option for {{ managed-k8s-name }} to manage the update installation schedule.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`: Set the start time and duration of the update.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}`: Set the day, start time, and duration of the update. You can select multiple options using the **{{ ui-key.yacloud.k8s.clusters.create.button_add-day-of-week }}** button.

- CLI {#cli}

  Set auto update parameters when [creating](../../managed-kubernetes/operations/node-group/node-group-create.md) or [updating](../../managed-kubernetes/operations/node-group/node-group-update.md) a {{ managed-k8s-name }} node group:

  ```bash
  {{ yc-k8s }} node-group <create_or_update> <node_group_name_or_ID> \
  ...
    --max-expansion <increasing_group_size_when_updating> \
    --max-unavailable <number_of_unavailable_nodes_when_updating> \
    --auto-upgrade <auto_update_mode> \
    --auto-repair <recreation_mode> \
    --anytime-maintenance-window \
    --daily-maintenance-window <value> \
    --weekly-maintenance-window <value>
  ```

  Where:

  * `--max-expansion`: Maximum number of nodes by which you can increase the size of the group when updating it.

    {% include [note-expansion-group-vm](../../_includes/managed-kubernetes/note-expansion-group-vm.md) %}

  * `--max-unavailable`: Maximum number of unavailable nodes in the group when updating it.

    {% note info %}

    The `--max-expansion` and `--max-unavailable` parameters should be used together.

    {% endnote %}

  * `--auto-upgrade`: Auto update mode for the {{ managed-k8s-name }} node group. The default value is `true` (auto updates are enabled). The possible values are `true` or `false`.
  * `--auto-repair`: Failed node recreation mode. The possible values are `true` or `false`.

    `--auto-repair` is at the [Preview](../../overview/concepts/launch-stages.md) stage.
  * `--anytime-maintenance-window`: Any update time for the {{ managed-k8s-name }} node group.
  * `--daily-maintenance-window`: `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}` update mode.

    Example of updating a {{ managed-k8s-name }} node group daily at 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window`: Auto update on specified days.

    Example of updating a {{ managed-k8s-name }} node group on Mondays and Tuesdays from 22:00 UTC, with a duration of up to 10 hours:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    To set multiple maintenance windows, provide the settings of each one in a separate `--weekly-maintenance-window` argument.

    {% note info %}

    The `--daily-maintenance-window` and `--weekly-maintenance-window` arguments require the `--auto-upgrade` argument set to `true`.

    The update schedule will not be created if you set `--auto-upgrade=false`.

    {% endnote %}

  You can get the {{ managed-k8s-name }} node group ID and name with the [list of groups in the cluster](node-group/node-group-list.md).

- {{ TF }} {#tf}

  1. Open the current configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-create.md).
  1. Change auto update settings in the {{ managed-k8s-name }} node group description.

     {% note info %}

     You can select either of the update modes: daily or on selected days. Concurrent use of update modes is not allowed.

     {% endnote %}

     * To enable the daily update mode:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = <node_group_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<update_start_time>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

       Where:

       * `start_time`: Update start time in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
       * `duration`: Update duration, e.g., `4h30m`.

     * To enable updates on selected days (multiple periods are possible):

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = <node_group_name>
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<update_start_day>"
             start_time = "<update_start_time>"
             duration   = "<update_duration>"
           }
           maintenance_window {
             day        = "<update_start_day>"
             start_time = "<update_start_time>"
             duration   = "<update_duration>"
           }
         }
       }
       ```

       Where:

       * `day`: Day of week, e.g., `monday`.
       * `start_time`: Update start time in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
       * `duration`: Update duration, e.g., `4h30m`.

     * To enable the random update time mode, do not add the `maintenance_policy` parameter section to the {{ managed-k8s-name }} node group description. If you do not specify auto update settings in the {{ managed-k8s-name }} node group description, updates will take place at a random time.
     * To configure the settings for {{ managed-k8s-name }} node group deployment during updates:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = <node_group_name>
         ...
         deploy_policy {
           max_expansion   = <expanding_group_size_when_updating>
           max_unavailable = <number_of_unavailable_nodes_when_updating>
         }
       }
       ```

       Where:
       * `max_expansion`: Maximum number of nodes by which you can increase the size of the group when updating it.

         {% include [note-expansion-group-vm](../../_includes/managed-kubernetes/note-expansion-group-vm.md) %}

       * `max_unavailable`: Maximum number of unavailable nodes in the group when updating it.


       {% note info %}

       The `max_expansion` and `max_unavailable` parameters should be used together.

       {% endnote %}

     * To disable auto updates:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         name = "<node_group_name>"
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

  For more information, see this [{{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  You can set up auto updates under `maintenancePolicy` when [creating a {{ managed-k8s-name }} node group](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/create.md) or [updating its settings](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/update.md).

  Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/update.md) API method and provide the following in the request:
  * {{ managed-k8s-name }} node group ID in the `nodeGroupId` parameter. To find out the {{ managed-k8s-name }} node group ID, get the [list of groups in the cluster](node-group/node-group-list.md).
  * Auto update settings in the `maintenancePolicy` parameter.
  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

  To disable auto updates, provide the `false` value in the `maintenancePolicy.autoUpgrade` parameter.

  To enable and configure the update window, provide one of the allowed values of the `maintenanceWindow` parameter:
  * For a {{ managed-k8s-name }} node group to update at a random time, provide the `"anytime": {}` value.
  * To set up daily updates, add the `dailyMaintenanceWindow` section:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<update_start_hour>",
        "minutes": "<update_start_minute>",
        "seconds": "<update_start_second>",
        "nanos": "<update_start_fraction_of_second>"
      },
      "duration": "<duration_of_update_period>"
    }
    ```

    Where:

    * `hours`: Update start hour in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
    * `nanos`: Fraction of a second of the update start, in nanoseconds.
    * `duration`: Duration of update period, in hours.

  * For updates to take place on selected days, add the `weeklyMaintenanceWindow` section:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<list_of_days>"
          ],
          "startTime": {
            "hours": "<update_start_hour>",
            "minutes": "<update_start_minute>",
            "seconds": "<update_start_second>",
            "nanos": "<update_start_fraction_of_second>"
          },
          "duration": "<duration_of_update_period>"
        }
      ]
    }
    ```

    Where:

    * `days`: List of days, e.g., `monday`, `tuesday`.
    * `hours`: Update start hour in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format.
    * `nanos`: Fraction of a second of the update start, in nanoseconds.
    * `duration`: Duration of update period, in hours.

  To configure the settings for {{ managed-k8s-name }} node group deployment during updates, add the `deployPolicy` section:

  ```json
  "deployPolicy": {
    "maxUnavailable": "<number_of_unavailable_nodes_when_updating>",
    "maxExpansion": "<expanding_group_size_when_updating>"
  }
  ```

  Where:

  * `maxUnavailable`: Maximum number of unavailable nodes in the group when updating it.
  * `maxExpansion`: Maximum number of nodes by which you can increase the size of the group when updating it.

    {% include [note-expansion-group-vm](../../_includes/managed-kubernetes/note-expansion-group-vm.md) %}

{% endlist %}

### Manually updating a node group version {#node-group-manual-upgrade}

You can update the {{ managed-k8s-name }} node group version manually. You can only update to the next minor version. Updating to newer versions is done in steps, e.g., 1.19 → 1.20 → 1.21.

{% note warning %}

Update the {{ managed-k8s-name }} cluster version before updating the node group.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Navigate to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Select the {{ managed-k8s-name }} node group from the list.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select the `Upgrade to version <version_number>` option.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Set auto update parameters:

  ```bash
  {{ yc-k8s }} node-group update <node_group_ID_or_name> \
  ...
    --version <new_version>
  ```

  You can get the {{ managed-k8s-name }} node group ID and name with the [list of groups in the cluster](node-group/node-group-list.md).

- {{ TF }} {#tf}

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

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

  For more information, see this [{{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/update.md) API method and provide the following in the request:
  * {{ managed-k8s-name }} node group ID in the `nodeGroupId` parameter. To find out the {{ managed-k8s-name }} node group ID, get the [list of groups in the cluster](node-group/node-group-list.md).
  * Required {{ k8s }} version in the `version.version` parameter.
  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating {{ k8s }} components without changing the version {#latest-revision}

You can update a {{ managed-k8s-name }} cluster and node group within the same {{ k8s }} version. When installing the update, the major version of {{ k8s }} does not change.

This update enables you to:
* Install new packages.
* Update the {{ k8s }} image.
* Updating the {{ k8s }} patch version.

The {{ managed-k8s-name }} cluster and node groups will be updated if any of the auto update options are enabled in their settings.

### Updating a cluster with auto updates disabled {#cluster-latest-revision}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. In the **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** field, select `Get the latest improvements and fixes for version...`
  1. Click **{{ ui-key.yacloud.common.save}}**.

- CLI {#cli}

  Run your {{ managed-k8s-name }} cluster update:

  ```bash
  {{ yc-k8s }} cluster update <cluster_name_or_ID> \
    --latest-revision
  ```

  You can get the {{ managed-k8s-name }} cluster ID and name with the [list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md#list).

- API {#api}

  Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/update.md) API method and provide the following in the request:
  * {{ managed-k8s-name }} cluster ID in the `clusterId` parameter. To find out the {{ managed-k8s-name }} cluster ID, [get the list of clusters in the folder](kubernetes-cluster/kubernetes-cluster-list.md#list).
  * `true` in the `masterSpec.version.version` parameter.
  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

### Updating a node group with auto updates disabled {#node-group-latest-revision}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Navigate to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Select the {{ managed-k8s-name }} node group from the list.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select `Get the latest improvements and fixes for version...`
  1. Click **{{ ui-key.yacloud.common.save}}**.

- CLI {#cli}

  Update the {{ managed-k8s-name }} node group:

  ```bash
  {{ yc-k8s }} node-group update <node_group_ID_or_name> \
    --latest-revision
  ```

  You can get the {{ managed-k8s-name }} node group ID and name with the [list of groups in the cluster](node-group/node-group-list.md).

- API {#api}

  Use the [update](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/update.md) API method and provide the following in the request:
  * {{ managed-k8s-name }} node group ID in the `nodeGroupId` parameter. To find out the {{ managed-k8s-name }} node group ID, get the [list of groups in the cluster](node-group/node-group-list.md).
  * `true` in the `version.latestRevision` parameter.
  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}