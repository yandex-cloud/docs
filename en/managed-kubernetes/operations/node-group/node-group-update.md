---
title: "How to update a {{ managed-k8s-name }} node group"
description: "Follow this guide to update a {{ managed-k8s-name }} node group."
---

# Updating a node group {{ managed-k8s-name }}

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

Before you start, make sure you have enough [free resources](../../../resource-manager/concepts/resources-hierarchy.md#cloud) in your [cloud](../../concepts/limits.md).

## Changing node group parameters {#update-settings}

You can change the following parameters of a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group):
* Name
* Description
* Number of {{ managed-k8s-name }} nodes
* [{{ k8s }} version](../../concepts/release-channels-and-updates.md)
* [IP address](../../../vpc/concepts/address.md) assignment method: internal only or both internal and external
* [Container runtime environment](../../concepts/index.md#config)
* List of [security groups](../connect/security-groups.md)

  {% note alert %}

  Do not delete [security groups](../../../vpc/concepts/security-groups.md) attached to a running {{ managed-k8s-name }} node group as this may disrupt its operation and result in a loss of data.

  {% endnote %}

* [Computing resources](../../../compute/concepts/vm-platforms.md) and {{ managed-k8s-name }} node [disk](../../../compute/concepts/disk.md) size
* {{ managed-k8s-name }} node name template
* [Updates](../../concepts/release-channels-and-updates.md#updates) policy

{% note alert %}

Do not reconfigure [VMs](../../../compute/concepts/vm.md) belonging to a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) with the help of the [{{ compute-full-name }} interfaces](../../../compute/operations/vm-control/vm-update.md). This will disrupt the operation of the node group and the whole {{ managed-k8s-name }} cluster.

{% endnote %}

To change your node group's [availability zone](../../../overview/concepts/geo-scope.md), [migrate the group](../../tutorials/migration-to-an-availability-zone.md) to a different zone.

{% list tabs %}

- Management console

  To update a {{ managed-k8s-name }} node group:
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Go to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
  1. Select the desired node group.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Change the required parameters in the window that opens.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

  Get detailed information about the command to edit the {{ managed-k8s-name }} node group:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Use the following parameters to update the {{ managed-k8s-name }} node group:
  * `--new-name`: Change the name.
  * `--description`: Edit the description.
  * `--service-account-id`, `--service-account-name`: Edit the [service account](../../../iam/concepts/index.md#sa) resource.
  * `--node-service-account-id`, `--node-service-account-name`: Update the service account for {{ managed-k8s-name }} nodes.
  * `--version`: Change the {{ k8s }} version.
  * `--network-interface`: [Network](../../../vpc/concepts/network.md#network) settings:

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

   * `--network-acceleration-type`: Type of [network acceleration](../../../compute/concepts/software-accelerated-network.md):
    * `standard`: No acceleration.
    * `software-accelerated`: Software-accelerated network.

       {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

  * `--container-runtime`: Change the [container runtime environment](../../concepts/index.md#config), `docker` or `containerd`.
  * `--node-name`: Update the node {{ managed-k8s-name }} name template. The name is unique if the template contains at least one of the following variables:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * `--template-labels`: Update [node group cloud labels](../../../resource-manager/concepts/labels.md) in `<label_name>=<label_value>` format. You can specify multiple labels separated by commas.
  * `--latest-revision`: Get all available updates for current [master {{ managed-k8s-name }}](../../concepts/index.md#master) version.
  * `--auto-upgrade`: Manage automatic updates.
  * Managing the maintenance window:
    * `--anytime-maintenance-window`: Update at any time.
    * `--daily-maintenance-window`: Update daily at the selected time.
    * `--weekly-maintenance-window`: Update on selected days.

  {% note warning %}

  * The `user-data` metadata key is not supported for VM post-configuration or user data transmission.
  * To manage SSH keys, [use the `ssh-keys` key](../../../compute/concepts/vm-metadata.md).
  * For post-configuring nodes, use privileged DaemonSets. For example, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

  {% endnote %}

- {{ TF }}

  To update a {{ managed-k8s-name }} node group:
  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Edit the {{ managed-k8s-name }} node group description properties.
     * To change the [container runtime environment](../../concepts/index.md#config), add an `instance_template.container_runtime` section:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         ...
         instance_template {
           ...
           container_runtime {
             type = "<environment_type>"
           }
         }
       }
       ```

       Where `type` is container runtime environment type: `docker` or `containerd`.

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

  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API

  To update a [{{ managed-k8s-name }} node group's](../../concepts/index.md#node-group) properties, use the [update](../../api-ref/NodeGroup/update.md) method for the [NodeGroup](../../api-ref/NodeGroup) resource.

  To change the [container runtime environment](../../concepts/index.md#config), provide the `docker` or the `containerd` value in the `nodeTemplate.containerRuntimeSettings.type` parameter.

  To update the [node group cloud labels](../../../resource-manager/concepts/labels.md), provide their values in the `nodeTemplate.labels` parameter.

  To update the {{ managed-k8s-name }} node name template, provide it in the `nodeTemplate.name` parameter. The name is unique if the template contains at least one of the following variables:

  {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  To update [DNS records](../../../dns/concepts/resource-record.md), provide their settings in the `nodeTemplate.v4AddressSpec.dnsRecordSpecs` parameter. In a DNS record's FQDN, you can use the `nodeTemplate.name` node name template with variables.

{% endlist %}

## Enabling access to nodes from the internet {#node-internet-access}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the name of the required VM.
  1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
  1. Specify the appropriate settings and click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To enable access to [{{ managed-k8s-name }} nodes](../../concepts/index.md#node-group) from the internet:
  1. Get detailed information about the command to edit the {{ managed-k8s-name }} node group:

     ```bash
     {{ yc-k8s }} node-group update --help
     ```

  1. Run the node group update command with the `--network-interface` flag set:

     ```bash
     {{ yc-k8s }} node-group update <node_group_ID_or_name> \
     ...
       --network-interface subnets=<name_of_node_group_subnet>, ipv4-address=nat
     ```

     You can find out the names and IDs of {{ managed-k8s-name }} node groups from the [list of node groups in the folder](node-group-list.md#list).

- API

  Use the [update](../../api-ref/NodeGroup/update.md) method for the [NodeGroup](../../api-ref/NodeGroup) resource.

{% endlist %}

Alternatively, you can grant internet access permission to {{ managed-k8s-name }} cluster nodes by creating and setting up a [NAT gateway](../../../vpc/operations/create-nat-gateway.md) or [NAT instance](../../../vpc/tutorials/nat-instance.md). As a result, through [static routing](../../../vpc/concepts/static-routes.md), traffic will be routed via the gateway or a separate VM instance with NAT features.

{% note info %}

If you assigned public IP addresses to the cluster nodes and then configured the NAT gateway or NAT instance, internet access via the public IPs will be disabled. For more information, see the [{{ vpc-full-name }} documentation](../../../vpc/concepts/static-routes.md#internet-routes).

{% endnote %}

## Managing node group labels {#manage-label}

You can perform the following actions with [cloud labels](../../../resource-manager/concepts/labels.md) of {{ managed-k8s-name }} node groups:
* [Add](#add-label)
* [Edit](#update-label)
* [Delete](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a label to a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group):

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

- {{ TF }}

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Add the `labels` property to the {{ managed-k8s-name }} node group description:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
       cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
       ...
       labels = {
         "<label>" = "<value>"
       }
       ...
     }
     ```

  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Editing a label {#update-label}

{% list tabs %}

- CLI

  Update a cloud label of a {{ managed-k8s-name }} node group:

  {% note warning %}

  The existing set of `labels` is completely overwritten by the transmitted set.

  {% endnote %}

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

- {{ TF }}

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
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

  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

  Delete the {{ managed-k8s-name }} node group label:

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

- {{ TF }}

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. In the {{ managed-k8s-name }} node group description, delete the unnecessary labels under `labels`.
  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}