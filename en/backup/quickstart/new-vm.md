---
title: Getting started with {{ backup-full-name }} on a new VM
description: Follow this guide to connect to {{ backup-name }} and get started with it on new VMs.
---

# Getting started with {{ backup-full-name }} on a new VM


{% include [quickstart-billing-paragraph](../../_includes/backup/quickstart-billing-paragraph.md) %}

In this scenario, you will create a [Linux](https://en.wikipedia.org/wiki/Linux) VM and connect it to {{ backup-name }}. If you do not need to create a new VM and want to use an existing VM for connecting to {{ backup-name }}, refer to [{#T}](./existing-vm.md).

{% include [quickstart-paid-resources](../../_includes/backup/quickstart-paid-resources.md) %}

To get started with {{ backup-name }}:

1. [Set up the infrastructure](#deploy-infrastructure).
1. [Activate {{ backup-name }}](#activate-provider).
1. [Create your VM](#vm-create).
1. [Link your VM to a backup policy](#add-policy).

If you no longer need the resources you created, [delete them](#clear-out).

## Set up your infrastructure {#deploy-infrastructure}

1. If you do not have a cloud network yet, [create](../../vpc/operations/network-create.md) one.
1. If your [cloud network](../../vpc/concepts/network.md#network) has no subnets, [create](../../vpc/operations/subnet-create.md) one:
1. In a cloud network, [create](../../vpc/operations/security-group-create.md) a security group with the following [rules](../../vpc/concepts/security-groups.md#security-groups-rules) for outgoing traffic:

    {% include [outgoing-rules](../../_includes/backup/outgoing-rules.md) %}

1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `backup.editor` [role](../security/index.md#backup-editor).

## Activate {{ backup-name }} {#activate-provider}

{% include [quickstart-activate-provider](../../_includes/backup/quickstart-activate-provider.md) %}

## Create a VM {#vm-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a VM connected to {{ backup-name }}.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image](../../compute/concepts/image.md) with a [supported OS](../concepts/vm-connection.md#os), e.g., [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}** and **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, set the preferred VM parameters.

      {% include [vm-requirements](../../_includes/backup/vm-requirements.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the subnet you [prepared earlier](#deploy-infrastructure).
      1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

          Instead of assigning a public IP address to your VM, you can associate the [subnet](../../vpc/concepts/network.md#subnet) hosting this VM with a [route table](../../vpc/concepts/routing.md#rt-vm) allowing internet access via a [NAT gateway](../../vpc/concepts/gateways.md) or a custom router.

      1. In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the security group you [configured earlier](#deploy-infrastructure).

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:
  
      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, select the SSH key saved in your [organization user](../../organization/concepts/membership.md) profile.

      If your profile has no SSH keys, click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}** to add a new key.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for your VM:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

      1. Select the service account you [created earlier](#deploy-infrastructure).
      1. Enable **{{ backup-name }}**.

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

For more information on how to create a VM, see [{#T}](../../compute/operations/index.md#vm-create).

## Link your VM to a backup policy {#add-policy}

{% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan.md) %}

{% include [quickstart-attach-to-policy-after-agent-setup](../../_includes/backup/quickstart-attach-to-policy-after-agent-setup.md) %}

1. {% include [quickstart-check-vm-agent-status](../../_includes/backup/quickstart-check-vm-agent-status.md) %}
1. {% include [quickstart-attach-vm-to-policy](../../_includes/backup/quickstart-attach-vm-to-policy.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../operations/backup-vm/delete.md) VM backups, if any.
1. [Delete](../operations/delete-vm.md) the VM from {{ backup-name }}.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM from {{ compute-name }}.

## What's next {#what-is-next}

* [Learn about the service's features](../concepts/index.md)
* [See other guides on how to use the service](../operations/index.md)

#### See also {#see-also}

{% include [see-also-snapshot](../../_includes/backup/see-also-snapshot.md) %}

* [{#T}](./existing-vm.md)