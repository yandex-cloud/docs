# Changing a node group

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

## Changing node group parameters {#update-settings}

You can change the following parameters of a [node group](../../concepts/index.md#node-group):
* Name.
* Description.
* Number of nodes.
* {{ k8s }} version.
* [Container runtime environment](../../concepts/index.md#config).
* List of [security groups](../connect/security-groups.md).

  {% note alert %}

  Do not delete the security groups bound to a running node group as this might result in disruptions in its operation and data loss.

  {% endnote %}

* Computing resources and node disk size.
* Node name template.
* [Update](../../concepts/release-channels-and-updates.md#updates) policy.

{% note alert %}

Do not update the parameters of VMs that belong to a {{ managed-k8s-name }} cluster using the [{{ compute-full-name }} interfaces](../../../compute/operations/vm-control/vm-update.md). This will disrupt the operation of the node group and the entire cluster.

{% endnote %}

{% list tabs %}

- Management console

  To change a [node group](../../concepts/index.md#node-group):
  1. Open **{{ managed-k8s-name }}** in the folder where you want to change the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster).
  1. Click on the name of the desired cluster.
  1. Go to the **Node group** tab.
  1. Click **Edit** in the upper-right corner.
  1. Change the necessary parameters in the window that opens.
  1. Click **Save changes**.

- CLI

  Get detailed information about the command to edit the node group:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Use the following parameters to edit the node group:
  * `--new-name`: Change the name.
  * `--description`: Edit the description.
  * `--service-account-id`, `--service-account-name`: Edit the [service account](../../../iam/concepts/index.md#sa) resource.
  * `--node-service-account-id`, `--node-service-account-name`: Edit the node service account.
  * `--version`: Change the {{ k8s }} version.
  * `--network-interface`: [Network](../../../vpc/concepts/network.md#network) settings:

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

  * `--network-acceleration-type`: The type of [network acceleration](../../../vpc/concepts/software-accelerated-network.md):
    * `standard`: No acceleration.
    * `software-accelerated`: Software-accelerated network.

      {% note warning %}

      Before activating a software-accelerated network, make sure that you have sufficient [cloud resources available](../../concepts/limits.md) to create an additional node.

      {% endnote %}

  * `--container-runtime`: Change the [container runtime environment](../../concepts/index.md#config), `docker` or `containerd`.
  * `--node-name`: Update the node name template. The name is unique if the template contains at least one of the variables:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * `--template-labels`: Update the [{{ yandex-cloud }} resource labels](../../../overview/concepts/services.md#labels) in `<label name>=<label value>` format for VMs representing the group nodes. You can specify multiple labels separated by commas.
  * `--latest-revision`: Get all available updates for the current version of the [master](../../concepts/index.md#master).
  * `--auto-upgrade`: Manage automatic updates.
  * Managing the maintenance window:
    * `--anytime-maintenance-window`: Perform maintenance at any time.
    * `--daily-maintenance-window`: Update daily at the selected time.
    * `--weekly-maintenance-window`: Update on selected days.

  {% note warning %}

  * The `user-data` metadata key is not supported for VM post-configuration or user data transmission.
  * To manage SSH keys, [use the `ssh-keys` key](../../../compute/concepts/vm-metadata.md).
  * For post-configuring nodes, use privileged DaemonSets. For example, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

  {% endnote %}

- {{ TF }}

  To change a [node group](../../concepts/index.md#node-group):
  1. Open the current {{ TF }} configuration file describing the node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Edit properties in the node group description.
     * To change the [container runtime environment](../../concepts/index.md#config), add an `instance_template.container_runtime` section:

       ```hcl
       resource "yandex_kubernetes_node_group" "<group name>" {
         ...
         instance_template {
           ...
           container_runtime {
             type = "<docker | containerd>"
           }
         }
       }
       ```

     * To update the [{{ yandex-cloud }} resource labels](../../../overview/concepts/services.md#labels) for VMs representing the group nodes, add an `instance_template.labels` section:

       ```hcl
       resource "yandex_kubernetes_node_group" "<group name>" {
         ...
         instance_template {
           ...
           labels {
             "<label name>"="<label value>"
           }
         }
       }
       ```

     * To change the node name template, update the `instance_template.name` parameter. The name is unique if the template contains at least one of the variables:

       {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

     * To update [DNS records](../../../dns/concepts/resource-record.md):

       {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

  1. Make sure that the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API

  To edit the properties of a [node group](../../concepts/index.md#node-group), use the [update](../../api-ref/NodeGroup/update.md) method for the [NodeGroup](../../api-ref/NodeGroup) resource.

  To change the [container runtime environment](../../concepts/index.md#config), pass the `docker` or the `containerd` value in the `nodeTemplate.containerRuntimeSettings.type` parameter.

  To update the [{{ yandex-cloud }} resource labels](../../../overview/concepts/services.md#labels) for VMs representing the group nodes, pass their values in the `nodeTemplate.labels` parameter.

  To update the node name template, pass it in the `nodeTemplate.name` parameter. The name is unique if the template contains at least one of the variables:

  {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  To update [DNS records](../../../dns/concepts/resource-record.md), pass their settings in the `nodeTemplate.v4AddressSpec.dnsRecordSpecs` parameter. In a DNS record's FQDN, you can use the `nodeTemplate.name` node name template with variables.

{% endlist %}

## Enabling access to nodes from the internet {#node-internet-access}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ compute-name }}**.
  1. Click the name of the desired VM.
  1. Under **Network**, click ![options](../../../_assets/horizontal-ellipsis.svg) and select **Add public IP address**.
  1. Specify the appropriate settings and click **Add**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To enable access to [nodes](../../concepts/index.md#node-group) from the internet:
  1. Get detailed information about the command to edit the node group:

     ```bash
     {{ yc-k8s }} node-group update --help
     ```

  1. Run the command to change a node group by passing the `--network-interface` parameter:

     ```bash
     {{ yc-k8s }} node-group update <node group ID or name> \
     ...
       --network-interface subnets=<name of node group subnet>, ipv4-address=nat
     ```

     You can find out the names and IDs of node groups in the [list of node groups in the folder](node-group-list.md#list).

- API

  Use the [update](../../api-ref/NodeGroup/update.md) method for the [NodeGroup](../../api-ref/NodeGroup) resource.

{% endlist %}

## Managing node group labels {#manage-label}

You can perform the following actions with node group [labels](../../../overview/concepts/services.md#labels):
* [Add](#add-label).
* [Edit](#update-label).
* [Delete](#remove-label).

### Adding a label {#add-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a label to a [node group](../../concepts/index.md#node-group):

  ```bash
  yc managed-kubernetes node-group add-labels my-node-group --labels new_label=test_label
  ```

  Result:

  ```bash
  done (28s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

- {{ TF }}

  1. Open the current {{ TF }} configuration file describing the node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Add the `labels` property to the node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node group name>" {
       cluster_id = yandex_kubernetes_cluster.<cluster name>.id
       ...
       labels = {
         "<label>" = "<value>"
       }
       ...
     }
     ```

  1. Make sure that the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

  Change a node group label:

  {% note warning %}

  The existing set of `labels` is completely replaced by the set transmitted.

  {% endnote %}

  ```bash
  yc managed-kubernetes node-group update my-node-group --labels test_label=my_ng_label
  ```

  Result:

  ```bash
  done (3s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

- {{ TF }}

  1. Open the current {{ TF }} configuration file describing the node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Edit the `labels` property in the node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node group name>" {
       cluster_id = yandex_kubernetes_cluster.<cluster name>.id
       ...
       labels = {
         "<label>" = "<value>"
         ...
       }
       ...
     }
     ```

  1. Make sure that the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

  Delete a label from a node group:

  ```bash
  yc managed-kubernetes node-group remove-labels my-node-group --labels test_label
  ```

  Result:

  ```bash
  done (2s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

- {{ TF }}

  1. Open the current {{ TF }} configuration file describing the node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. In the node group description, delete the labels you no longer need under `labels`.
  1. Make sure that the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}