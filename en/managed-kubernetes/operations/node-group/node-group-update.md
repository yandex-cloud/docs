---
title: How to update a {{ managed-k8s-name }} node group
description: Follow this guide to update a {{ managed-k8s-name }} node group.
---

# Updating a {{ managed-k8s-name }} node group


{% include [node-vm-explained](../../../_includes/managed-kubernetes/node-vm-explained.md) %}

{% include [node-vm-manipulation-warning](../../../_includes/managed-kubernetes/node-vm-manipulation-warning.md) %}

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

Before you start, make sure you have enough [resources](../../concepts/limits.md) in your [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud).

## Editing node group settings {#update-settings}

You can update the following parameters of a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group):
* Name.
* Description.
* Scaling for the fixed type: Number of {{ managed-k8s-name }} nodes. Scaling for the [automatic type](../../concepts/node-group/cluster-autoscaler.md): Minimum, maximum, and initial number of {{ managed-k8s-name }} nodes. You cannot change the scaling type.
* [{{ k8s }} version](../../concepts/release-channels-and-updates.md).
* Method of assigning [IP addresses](../../../vpc/concepts/address.md) to group nodes: only internal addresses or public addresses as well.

    {% note info %}

    {% include [nodes-internet-access](../../../_includes/managed-kubernetes/nodes-internet-access.md) %}

    {% include [nodes-internet-access-additional](../../../_includes/managed-kubernetes/nodes-internet-access-additional.md) %}

    {% endnote %}

* List of [security groups](../connect/security-groups.md).

  {% note alert %}

  Do not delete [security groups](../../../vpc/concepts/security-groups.md) associated with a running {{ managed-k8s-name }} node group as this may disrupt its operation and result in data loss.

  {% endnote %}

* [Computing resources](../../../compute/concepts/vm-platforms.md) and {{ managed-k8s-name }} node [disk](../../../compute/concepts/disk.md) size.
* {{ managed-k8s-name }} node name template.
* [Updates](../../concepts/release-channels-and-updates.md#updates) policy.

Learn how to change the [availability zone](../../../overview/concepts/geo-scope.md) of a node group in [{#T}](../../tutorials/migration-to-an-availability-zone.md).

{% list tabs group=instructions %}

- Management console {#console}

  To update a {{ managed-k8s-name }} node group:
  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name.
  1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
  1. Select the node group you need.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Change the parameters in the window that opens.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Get detailed information about the command to update the {{ managed-k8s-name }} node group:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Use the following flags to update the {{ managed-k8s-name }} node group:

  * `--new-name`: Edit the name.
  * `--description`: Edit the description.
  * `--service-account-id`, `--service-account-name`: Change the [service account](../../../iam/concepts/index.md#sa) for resources.
  * `--node-service-account-id`, `--node-service-account-name`: Change the service account for {{ managed-k8s-name }} nodes.
  * `--version`: Change the {{ k8s }} version.
  * `--network-interface`: [Network](../../../vpc/concepts/network.md#network) settings:

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

  * `--network-acceleration-type`: Select the [network acceleration](../../../compute/concepts/software-accelerated-network.md) type:
    * `standard`: No acceleration.
    * `software-accelerated`: Software-accelerated network.

      {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

  * `--node-name`: Change the name template for {{ managed-k8s-name }} nodes. The name is unique if the template contains at least one of the following variables:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * `--template-labels`: Change the [node group cloud labels](../../../resource-manager/concepts/labels.md) in `<label_name>=<label_value>` format. You can specify multiple labels separated by commas.
  * `--latest-revision`: Get all available updates for the current [{{ managed-k8s-name }} master](../../concepts/index.md#master) version.
  * Scaling settings:

    * `--fixed-size`: Change the fixed number of nodes in a {{ managed-k8s-name }} node group.
    * `--auto-scale`: Change the [autoscaling settings of the {{ managed-k8s-name }} cluster](../../concepts/node-group/cluster-autoscaler.md):

      * `min`: Minimum number of nodes in the group.
      * `max`: Maximum number of nodes in the group.
      * `initial`: Initial number of nodes in the group.

    You cannot change the scaling type.

  * `--auto-upgrade`: Manage automatic updates.
  * Managing the maintenance window:
    * `--anytime-maintenance-window`: Update at any time.
    * `--daily-maintenance-window`: Update daily at the selected time.
    * `--weekly-maintenance-window`: Update on selected days.

      {% include [update time](../../../_includes/managed-kubernetes/note-update-time.md) %}

  {% note warning %}

  * The `user-data` metadata key is not supported for VM tuning or user data transmission.
  * To manage SSH keys, [use the `ssh-keys` key](../../../compute/concepts/vm-metadata.md).
  * To tune your nodes, use privileged DaemonSets, e.g., [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

  {% endnote %}

- {{ TF }} {#tf}

  To update a {{ managed-k8s-name }} node group:
  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more on how to create such a file, see [{#T}](node-group-create.md).
  1. Edit the {{ managed-k8s-name }} node group description properties.

     * To change the scaling settings, edit the `scale_policy` section as follows:

       * For fixed scaling, change the `fixed_scale.size` parameter.
       * For [autoscaling](../../concepts/node-group/cluster-autoscaler.md), change the `auto_scale` section parameters:

          * `min`: Minimum number of nodes in the group.
          * `max`: Maximum number of nodes in the group.
          * `initial`: Initial number of nodes in the group.

       You cannot change the scaling type.

     * To update the [node group cloud labels](../../../resource-manager/concepts/labels.md), add the `instance_template.labels` section:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         ...
         instance_template {
           ...
           labels {
             "<label_name>"="<label_value>"
           }
         }
       }
       ```

     * To change the {{ managed-k8s-name }} node name template, update the `instance_template.name` parameter. The name is unique if the template contains at least one of the following variables:

       {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

     * To update [DNS records](../../../dns/concepts/resource-record.md):

       {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

     For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  To update parameters for a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group), use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup) resource or the [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) gRPC API call.

  {% include [api-parameters-case](../../../_includes/managed-kubernetes/api-parameters-case.md) %}

  To update the [node group cloud labels](../../../resource-manager/concepts/labels.md), provide their values in the `nodeTemplate.labels` parameter.

  To update the {{ managed-k8s-name }} node name template, provide it in the `nodeTemplate.name` parameter. The name is unique if the template contains at least one of the following variables:

  {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  To update [DNS records](../../../dns/concepts/resource-record.md), provide their settings in the `nodeTemplate.v4AddressSpec.dnsRecordSpecs` parameter. In a DNS record's FQDN, you can use the `nodeTemplate.name` node name template with variables.

{% endlist %}

## Configuring a deployment policy {#configure-deploy-policy}

Using a [deployment policy](../../concepts/node-group/deploy-policy.md), you can control the number of available nodes when modifying or updating a group.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
  1. Select the node group you need.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}**, specify the following settings:

      {% include [deploy-policy-parameters-console](../../../_includes/managed-kubernetes/deploy-policy/parameters-console.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a {{ managed-k8s-name }} node group:

      ```bash
      {{ yc-k8s }} node-group update --help
      ```

  1. Run this command:

      ```bash
      {{ yc-k8s }} node-group update \
        --name <node_group_name> \
        --max-expansion <node_group_expansion_limit> \
        --max-unavailable <unavailable_nodes_limit>
      ```

      Where:

      {% include [deploy-policy-parameters-cli](../../../_includes/managed-kubernetes/deploy-policy/parameters-cli.md) %}

      You can get the node group name with the [list of node groups in the folder](./node-group-list.md#list).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

      For more on how to create such a file, see [{#T}](./node-group-create.md).

  1. Specify the settings under `deploy_policy`. If there is no such section, add it first.

      ```hcl
      resource "yandex_kubernetes_node_group" "<node_group_name>" {
        cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
        ...
        deploy_policy {
          max_expansion   = <node_group_expansion_limit>
          max_unavailable = <unavailable_nodes_limit>
        }
        ...
      }
      ```

      Where:

      {% include [deploy-policy-parameters-tf](../../../_includes/managed-kubernetes/deploy-policy/parameters-tf.md) %}

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) resource or the [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) gRPC API call.

  {% include [api-parameters-case](../../../_includes/managed-kubernetes/api-parameters-case.md) %}

  Provide the following in the request:
  * Node group ID in the `nodeGroupId` parameter.

    You can get the node group ID with the [list of node groups in the folder](./node-group-list.md#list).
  * `updateMask` set to `deployPolicy.maxExpansion,deployPolicy.maxUnavailable`.

    {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

  {% include [deploy-policy-parameters-api](../../../_includes/managed-kubernetes/deploy-policy/parameters-api.md) %}

{% endlist %}

## Assigning public IP addresses to nodes {#node-internet-access}

{% include [public-ip](../../../_includes/managed-kubernetes/public-ip.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name.
  1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
  1. Select the node group you need.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**, in the **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** field, select the `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}` IP address assignment method. Nodes will get random public IP addresses from the {{ yandex-cloud }} address pool.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To assign random public IP addresses from the {{ yandex-cloud }} address pool to [{{ managed-k8s-name }} nodes](../../concepts/index.md#node-group):

  1. Get detailed information about the command to update the {{ managed-k8s-name }} node group:

     ```bash
     {{ yc-k8s }} node-group update --help
     ```

  1. Run the node group update command providing the `--network-interface` parameter:

     ```bash
     {{ yc-k8s }} node-group update <node_group_ID_or_name> \
     ...
       --network-interface security-group-ids=[<security_group_IDs>],ipv4-address=nat
     ```

     You can get the names and IDs of {{ managed-k8s-name }} node groups with the [list of node groups in the folder](node-group-list.md#list).

- {{ TF }} {#tf}

  To assign random public IP addresses from the {{ yandex-cloud }} address pool to nodes:

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more on how to create such a file, see [{#T}](node-group-create.md).

  1. Add `instance_template.network_interface.nat` set to `true` to the node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
       ...
       instance_template {
         ...
         network_interface {
           nat = true
         }
       }
     }
     ```

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

     For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  {% include [api-parameters-case](../../../_includes/managed-kubernetes/api-parameters-case.md) %}

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup) resource or the [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) gRPC API call, and provide the following in the request:

  * `nodeTemplate.networkInterfaceSpecs.primaryV4AddressSpec.oneToOneNatSpec.ipVersion` in the `updateMask` parameter.

     {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

  * `IPV4` in the `nodeTemplate.networkInterfaceSpecs.primaryV4AddressSpec.oneToOneNatSpec.ipVersion` parameter.

{% endlist %}

## Recreating a node group with a new taint {#assign-taint}

{% note warning %}

Adding [taints](../../concepts/index.md#taints-tolerations) results in removing the current {{ managed-k8s-name }} node group and creating a node group with a new configuration.

{% endnote %}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  To place a taint on a node group:

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more on how to create such a file, see [{#T}](node-group-create.md).

  1. Add the `node_taints` section to the node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
       ...
       node_taints = [
         "<key>=<value>:<taint_effect>",
         ...
       ]
       ...
     }
     ```

     Specify a key and value. Select one of the available taint effects:

     * `NoSchedule`: Prohibit scheduling new pods on the group nodes. It does not affect currently running pods.
     * `PreferNoSchedule`: Avoid scheduling pods on the group nodes if there are resources available for this purpose in other groups.
     * `NoExecute`: Stop pods on the group nodes, evict them to other groups, and prohibit running new pods.

     You can place multiple taints by specifying them separated by commas.

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

     For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

## Recreating a node group without a taint {#remove-taint}

{% note warning %}

Removing [taints](../../concepts/index.md#taints-tolerations) results in removing the current {{ managed-k8s-name }} node group and creating a node group with a new configuration.

{% endnote %}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  To remove a taint from a node group:

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more on how to create such a file, see [{#T}](node-group-create.md).

  1. In the node group description, remove the taints you no longer need under `node_taints`.

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

     For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

## Managing node group cloud labels {#manage-label}

You can perform the following actions with [cloud labels](../../concepts/index.md#node-labels) of {{ managed-k8s-name }} node groups:
* [Add](#add-label)
* [Edit](#update-label)
* [Delete](#remove-label)

### Adding a cloud label {#add-label}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Click the cluster name.
    1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
    1. Select the node group you need.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
    1. Enter the key and value, and press **Enter**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a cloud label to a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group):

  ```bash
  yc managed-kubernetes node-group add-labels my-node-group --labels new_label=test_label
  ```

  Result:

  ```text
  done (28s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more on how to create such a file, see [{#T}](node-group-create.md).
  1. Add the `labels` property to the {{ managed-k8s-name }} node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
       cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
       ...
       labels = {
         "<cloud_label>" = "<value>"
       }
       ...
     }
     ```

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Updating a cloud label {#update-label}

{% list tabs group=instructions %}

- Management console {#console}

  To update a cloud label, you will have to remove and recreate it:

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Click the cluster name.
    1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
    1. Select the node group you need.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click the cross next to the label to remove it.
    1. Click **{{ui-key.yacloud.component.label-set.button_add-label }}** and enter a new key and/or value for the label.
    1. Press **Enter**, then click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Update a cloud label of a {{ managed-k8s-name }} node group:

  {% include [labels-rewrite-warning](../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc managed-kubernetes node-group update my-node-group --labels test_label=my_ng_label
  ```

  Result:

  ```text
  done (3s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more on how to create such a file, see [{#T}](node-group-create.md).
  1. Edit the `labels` property in the {{ managed-k8s-name }} node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
       cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
       ...
       labels = {
         "<cloud_label>" = "<value>"
         ...
       }
       ...
     }
     ```

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Removing a cloud label {#remove-label}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Click the cluster name.
    1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
    1. Select the node group you need.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click the cross next to the label.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Remove a cloud label of a {{ managed-k8s-name }} node group:

  ```bash
  yc managed-kubernetes node-group remove-labels my-node-group --labels test_label
  ```

  Result:

  ```text
  done (2s)
  id: catpl8c44kii********
  cluster_id: catcsqidoos7********
  ...
  ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more on how to create this file, see [{#T}](node-group-create.md).
  1. In the {{ managed-k8s-name }} node group description, remove the cloud labels you no longer need under `labels`.
  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

## Changing the method of connecting to nodes in a node group {#switch-node-connect-mode}

{% include [node-connect-mode-reconciling-warning](../../../_includes/managed-kubernetes/node-connect-mode-reconciling-warning.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Click the cluster name.
    1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
    1. Select the node group you need.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. Change the connection method settings:

        1. To enable or disable access to nodes via {{ oslogin }}, use the **{{ ui-key.yacloud.k8s.node-group.access-method.field_os-login-access-method }}** option.

            {% include [note-oslogin-ssh-warning](../../../_includes/managed-kubernetes/note-oslogin-ssh-warning.md) %}

            {% include [configure-connect-oslogin](../../../_includes/managed-kubernetes/configure-connect-oslogin.md) %}

        1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

            {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

        1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    1. {% include [configure-oslogin-access](../../../_includes/managed-kubernetes/configure-oslogin-access.md) %}

    1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

        {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

    1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

- {{ TF }} {#tf}

    1. {% include [configure-oslogin-access](../../../_includes/managed-kubernetes/configure-oslogin-access.md) %}

    1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

        {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

    1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

- API {#api}

    1. {% include [configure-oslogin-access](../../../_includes/managed-kubernetes/configure-oslogin-access.md) %}

    1. {% include [enable-ssh-access](../../../_includes/managed-kubernetes/enable-ssh-access.md) %}

        {% include [configure-connect-ssh](../../../_includes/managed-kubernetes/configure-connect-ssh.md) %}

    1. {% include [disable-ssh-access](../../../_includes/managed-kubernetes/disable-ssh-access.md) %}

{% endlist %}

## Updating metadata {#update-metadata}

{% note warning %}

{% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

After you update the metadata, the node group status will temporarily change to `Reconciling`: all the group nodes will be recreated for the changes to take effect.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Click the cluster name.
    1. Navigate to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
    1. Select the node group you need.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. Expand the **{{ ui-key.yacloud.common.metadata }}** section and edit, add, or remove metadata for the nodes.

        To add metadata, click **{{ ui-key.yacloud.common.metadata-add-field }}**. Specify the key and value for each metadata element in a separate set of fields.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. To add or edit metadata with a specific key:

        1. View the description of the CLI command for adding and updating the {{ managed-k8s-name }} node group metadata:

            ```bash
            {{ yc-k8s }} node-group add-metadata --help
            ```

        1. To add new metadata or edit existing metadata, run this command:

            ```bash
            {{ yc-k8s }} node-group add-metadata \
              --name <node_group_name> \
              --metadata <key>=<value>
            ```

            You can get the node group name with the [list of node groups in the folder](./node-group-list.md#list).

            You can get a list of existing metadata with [detailed information about the node group](./node-group-list.md#get).

            {% note tip %}

            Use the `--metadata-from-file` parameter instead of `--metadata` to get a value from a file:

            ```bash
            --metadata-from-file <key>=<path_to_file_with_value>
            ```

            {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

            {% endnote %}

    1. To delete metadata with a specific key:

        1. View the description of the CLI command to delete the {{ managed-k8s-name }} node group metadata:

            ```bash
            {{ yc-k8s }} node-group remove-metadata --help
            ```

        1. Delete existing metadata:

            ```bash
            {{ yc-k8s }} node-group remove-metadata \
              --name <node_group_name> \
              --keys <key>
            ```

            You can get the node group name with the [list of node groups in the folder](./node-group-list.md#list).

            You can get a list of existing metadata with [detailed information about the node group](./node-group-list.md#get).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

        For more on how to create this file, see [{#T}](./node-group-create.md).

    1. To add, edit, or delete metadata with a specific key, edit the list of keys and values in the `instance_template.metadata` parameter. If there is no such parameter, add it.

        ```hcl
        resource "yandex_kubernetes_node_group" "<node_group_name>" {
          cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
          ...
          instance_template {
            metadata = {
              "<key>" = "<value>"
              ...
            }
            ...
          }
          ...
        }
        ```

        {% note tip %}

        Use the `file()` function to get a value from a file:

        ```hcl
        "<key>" = file("<path_to_file_with_value>")
        ```

        {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

        {% endnote %}

    1. Make sure the configuration files are correct.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../../_includes/managed-kubernetes/terraform-timeout-nodes.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

    {% include [api-parameters-case](../../../_includes/managed-kubernetes/api-parameters-case.md) %}

    1. {% include [get-metadata-via-api](../../../_includes/managed-kubernetes/get-metadata-via-api.md) %}

    1. Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup) resource or the [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) gRPC API call, and provide the following in the request:

        * Node group ID in the `nodeGroupId` parameter.

        * `updateMask` set to `nodeTemplate.metadata`.

            {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

        * The `nodeTemplate.metadata` parameter listing the node group metadata.

            Edit the metadata list you got in the previous step: add, edit, or delete `key=value` pairs. Then provide the updated list in the `nodeTemplate.metadata` parameter.

            {% note alert %}

            Metadata not listed in `nodeTemplate.metadata` will be deleted.

            {% endnote %}

{% endlist %}
