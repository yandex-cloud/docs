---
title: How to update a {{ managed-k8s-name }} node group
description: Follow this guide to update a {{ managed-k8s-name }} node group.
---

# Updating a {{ managed-k8s-name }} node group


{% include [node-vm-explained](../../../_includes/managed-kubernetes/node-vm-explained.md) %}

{% include [node-vm-manipulation-warning](../../../_includes/managed-kubernetes/node-vm-manipulation-warning.md) %}

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

Before you start, make sure you have enough [free resources](../../../resource-manager/concepts/resources-hierarchy.md#cloud) in your [cloud](../../concepts/limits.md).

## Changing node group parameters {#update-settings}

You can change the following parameters of a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group):
* Name.
* Description.
* Scaling for fixed type: Number of {{ managed-k8s-name }} nodes. Scaling for [automatic type](../../concepts/node-group/cluster-autoscaler.md): Minimum, maximum, and initial number of {{ managed-k8s-name }} nodes. You cannot change the scaling type.
* [{{ k8s }} version](../../concepts/release-channels-and-updates.md).
* [IP address](../../../vpc/concepts/address.md) assignment method: internal only or both internal and external.
* List of [security groups](../connect/security-groups.md).

  {% note alert %}

  Do not delete [security groups](../../../vpc/concepts/security-groups.md) attached to a running {{ managed-k8s-name }} node group as this may disrupt its operation and result in a loss of data.

  {% endnote %}

* [Computing resources](../../../compute/concepts/vm-platforms.md) and {{ managed-k8s-name }} node [disk](../../../compute/concepts/disk.md) size.
* {{ managed-k8s-name }} node name template.
* [Updates](../../concepts/release-channels-and-updates.md#updates) policy.

To learn how to change the [availability zone](../../../overview/concepts/geo-scope.md) of a node group, see [{#T}](../../tutorials/migration-to-an-availability-zone.md).

{% list tabs group=instructions %}

- Management console {#console}

  To update a {{ managed-k8s-name }} node group:
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
  1. Click the name of the {{ managed-k8s-name }} cluster.
  1. Go to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
  1. Select the required node group.
  1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
  1. Change the required parameters in the window that opens.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Get detailed information about the command to edit the {{ managed-k8s-name }} node group:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Use the following flags to update the {{ managed-k8s-name }} node group:

  * `--new-name`: Change name.
  * `--description`: Change description.
  * `--service-account-id`, `--service-account-name`: Change [service account](../../../iam/concepts/index.md#sa) for resources.
  * `--node-service-account-id`, `--node-service-account-name`: Change service account for {{ managed-k8s-name }} nodes.
  * `--version`: Change {{ k8s }} version.
  * `--network-interface`: [Network](../../../vpc/concepts/network.md#network) settings:

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

  * `--network-acceleration-type`: Change [network acceleration](../../../compute/concepts/software-accelerated-network.md) type:
    * `standard`: No acceleration.
    * `software-accelerated`: Software-accelerated network.

      {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

  * `--node-name`: Change name template for {{ managed-k8s-name }} nodes. The name is unique if the template contains at least one of the following variables:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * `--template-labels`: Change [node group cloud labels](../../../resource-manager/concepts/labels.md) in `<label_name>=<label_value>` format. You can specify multiple labels separated by commas.
  * `--latest-revision`: Get all available updates for the current [{{ managed-k8s-name }}](../../concepts/index.md#master) master version.
  * Scaling settings:

    * `--fixed-size`: Change fixed number of nodes in a {{ managed-k8s-name }} node group.
    * `--auto-scale`: Change [automatic scaling settings of the {{ managed-k8s-name }}](../../concepts/node-group/cluster-autoscaler.md) cluster:

      * `min`: Minimum number of nodes in the group.
      * `max`: Maximum number of nodes in the group.
      * `initial`: Initial number of nodes in the group.

    You cannot change the scaling type.

  * `--auto-upgrade`: Manage automatic updates.
  * Managing the maintenance window:
    * `--anytime-maintenance-window`: Update at any time.
    * `--daily-maintenance-window`: Update daily at the selected time.
    * `--weekly-maintenance-window`: Update on selected days.

  {% note warning %}

  * The `user-data` metadata key is not supported for VM post-configuration or user data transmission.
  * To manage SSH keys, [use the `ssh-keys`](../../../compute/concepts/vm-metadata.md) key.
  * For post-configuring nodes, use privileged DaemonSets. For example, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

  {% endnote %}

- {{ TF }} {#tf}

  To update a {{ managed-k8s-name }} node group:
  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Edit the {{ managed-k8s-name }} node group description properties.

     * To change the scaling settings, make the following changes in the `scale_policy` section:

       * For fixed scaling, change the `fixed_scale.size` parameter.
       * For [automatic scaling](../../concepts/node-group/cluster-autoscaler.md), change the `auto_scale` section parameters:

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

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  To update a [{{ managed-k8s-name }} node group's](../../concepts/index.md#node-group) properties, use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup) resource.

  To update the [node group cloud labels](../../../resource-manager/concepts/labels.md), provide their values in the `nodeTemplate.labels` parameter.

  To update the {{ managed-k8s-name }} node name template, provide it in the `nodeTemplate.name` parameter. The name is unique if the template contains at least one of the following variables:

  {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  To update [DNS records](../../../dns/concepts/resource-record.md), provide their settings in the `nodeTemplate.v4AddressSpec.dnsRecordSpecs` parameter. In a DNS record's FQDN, you can use the `nodeTemplate.name` node name template with variables.

{% endlist %}

## Enabling access to nodes from the internet {#node-internet-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the VM name.
  1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
  1. Specify the appropriate settings and click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- CLI {#cli}

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
       --network-interface security-group-ids=[<security_group_IDs>],ipv4-address=nat
     ```

     You can find out the names and IDs of {{ managed-k8s-name }} node groups from the [list of node groups in the folder](node-group-list.md#list).

- API {#api}

  Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup) resource.

{% endlist %}

Alternatively, you can grant internet access permission to {{ managed-k8s-name }} cluster nodes by creating and setting up a [NAT gateway](../../../vpc/operations/create-nat-gateway.md) or [NAT instance](../../../vpc/tutorials/nat-instance/index.md). As a result, through [static routing](../../../vpc/concepts/routing.md), traffic will be routed via the gateway or a separate VM instance with NAT features.

{% note info %}

If you assigned public IP addresses to the cluster nodes and then configured the NAT gateway or NAT instance, internet access via the public IP addresses will be disabled. For more information, see the [{{ vpc-full-name }} documentation](../../../vpc/concepts/routing.md#internet-routes).

{% endnote %}

## Placing a taint on a node group {#assign-taint}

Adding [taints](../../concepts/index.md#taints-tolerations) results in recreation of a {{ managed-k8s-name }} node group. First, all nodes in the group are deleted, then nodes with the taint are added to the group.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  To place a taint on a node group:

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](node-group-create.md).

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

     * `NoSchedule`: Prohibit running new pods on the group's nodes (it does not affect the running ones).
     * `PreferNoSchedule`: Avoid running pods on the group's nodes if there are resources available for this purpose in other groups.
     * `NoExecute`: Stop pods on the group's nodes, evict them to other groups, and prohibit running new pods.

     You can place multiple taints by specifying them separated by commas.

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  To place a taint on a node group, use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) and provide the following in the request:

  * Taints in the `nodeTaints` parameter.
  * The updatable `nodeTaints` parameter in the `updateMask` parameter.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Removing a taint from a node group {#remove-taint}

Removing [taints](../../concepts/index.md#taints-tolerations) results in recreation of a {{ managed-k8s-name }} node group. First, all nodes in the group are deleted, then nodes with the new configuration are added to the group.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  To remove a taint from a node group:

  1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

     For more information about creating this file, see [{#T}](node-group-create.md).

  1. In the node group description, remove the taints you no longer need under `node_taints`.

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  To remove a taint from a node group, use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) and provide the following in the request:

  * A new set of taints in the `nodeTaints` parameter. If you want to remove all taints, put `"nodeTaints": []` in the request.
  * `nodeTaints` parameter to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Managing node group cloud labels {#manage-label}

You can perform the following actions with [cloud labels](../../../resource-manager/concepts/labels.md) of {{ managed-k8s-name }} node groups:
* [Add](#add-label)
* [Edit](#update-label)
* [Delete](#remove-label)

### Adding a cloud label {#add-label}

{% list tabs group=instructions %}

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

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. Add the `labels` parameter to the {{ managed-k8s-name }} node group description:

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

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Updating a cloud label {#update-label}

{% list tabs group=instructions %}

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

  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

### Deleting a cloud label {#remove-label}

{% list tabs group=instructions %}

- CLI {#cli}

  Delete a cloud label of a {{ managed-k8s-name }} node group:

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

     For more information about creating this file, see [{#T}](node-group-create.md).
  1. In the {{ managed-k8s-name }} node group description, delete the cloud labels you no longer need under `labels`.
  1. Make sure the configuration files are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

{% endlist %}

## Changing the method of connecting to nodes in a node group {#switch-node-connect-mode}

{% include [node-connect-mode-reconciling-warning](../../../_includes/managed-kubernetes/node-connect-mode-reconciling-warning.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
    1. Click the name of the {{ managed-k8s-name }} cluster.
    1. Go to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
    1. Select the required node group.
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

## Changing metadata {#update-metadata}

{% note warning %}

{% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

After you change the metadata, the node group status will temporarily change to `Reconciling`: all the group's nodes will be recreated for the changes to take effect.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update the {{ managed-k8s-name }} cluster.
    1. Click the name of the {{ managed-k8s-name }} cluster.
    1. Go to the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** tab.
    1. Select the required node group.
    1. Click **{{ ui-key.yacloud.common.edit }}** in the top-right corner.
    1. Open the **{{ ui-key.yacloud.common.metadata }}** block and edit, add, or remove metadata for the nodes.

        To add metadata, click **{{ ui-key.yacloud.common.metadata-add-field }}**. Specify the key and value for each metadata element in a separate set of fields.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. To add or modify metadata with a specific key:

        1. View the description of the CLI command for adding and updating the {{ managed-k8s-name }} node group metadata:

            ```bash
            {{ yc-k8s }} node-group add-metadata --help
            ```

        1. To add new or modify existing metadata, run the following command:

            ```bash
            {{ yc-k8s }} node-group add-metadata \
              --name <node_group_name> \
              --metadata <key>=<value>
            ```

            You can request the name of a node group with the [list of node groups in the folder](./node-group-list.md#list).

            You can request a list of existing metadata with [detailed information about the node group](./node-group-list.md#get).

            {% note tip %}

            Use the `--metadata-from-file` parameter instead of `--metadata` to get a value from a file:

            ```bash
            --metadata-from-file <key>=<path_to_file_with_value>
            ```

            {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

            {% endnote %}

    1. To delete metadata with a specific key:

        1. See the description of the CLI command to delete the {{ managed-k8s-name }} node group metadata:

            ```bash
            {{ yc-k8s }} node-group remove-metadata --help
            ```

        1. Delete existing metadata:

            ```bash
            {{ yc-k8s }} node-group remove-metadata \
              --name <node_group_name> \
              --keys <key>
            ```

            You can request the name of a node group with the [list of node groups in the folder](./node-group-list.md#list).

            You can request a list of existing metadata with [detailed information about the node group](./node-group-list.md#get).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing the {{ managed-k8s-name }} node group.

        For more information about creating this file, see [{#T}](./node-group-create.md).

    1. To add, modify, or delete metadata with a specific key, edit the list of keys and values in the `instance_template.metadata` parameter. If there is no such parameter, add it.

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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

    1. {% include [get-metadata-via-api](../../../_includes/managed-kubernetes/get-metadata-via-api.md) %}

    1. Use the [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) REST API method for the [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) resource and include the following in the request:

        * Node group ID in the `nodeGroupId` parameter.

        * The `updateMask` parameter set to `nodeTemplate.metadata`.

            {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

        * The `nodeTemplate.metadata` parameter listing the node group's metadata.

            Make the required changes to the metadata list you got in the previous step: add, modify, or delete `key=value` pairs. Then provide the updated list in the `nodeTemplate.metadata` parameter.

            {% note alert %}

            Metadata not listed in the `nodeTemplate.metadata` parameter will be deleted.

            {% endnote %}

{% endlist %}
