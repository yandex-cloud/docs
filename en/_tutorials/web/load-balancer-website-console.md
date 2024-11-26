1. [Prepare your cloud](#before-you-begin).
1. [Create an instance group](#create-vms).
1. [Upload the website files](#upload-files).
1. [Create a network load balancer](#create-load-balancer).
1. [Run a fault tolerance test](#test).

If you no longer need the resources you created, [delete them](#clear-out).



## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [load-balancer-website-paid-resources](../_tutorials_includes/load-balancer-website/paid-resources.md) %}


### Prepare the environment {#configure-env}

* [Create](../../vpc/operations/network-create.md) a cloud network named `nlb-network` and [subnets](../../vpc/operations/subnet-create.md).
* [Create](../../iam/operations/sa/create.md) a service account named `nlb-sa` and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-editor }}` role to it.
* [Create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair.


## Create an instance group {#create-vms}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}** and click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:

      * Enter a name for the instance group, e.g., `nlb-vm-group`.
      * Select the `nlb-sa` [service account](../../iam/concepts/users/service-accounts.md).

  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones to ensure fault tolerance of your hosting.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to configure a basic instance:

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, open the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Choose a product:

          * [LEMP](/marketplace/products/yc/lemp) for Linux, Nginx, {{ MY }}, and PHP
          * [LAMP](/marketplace/products/yc/lamp) for Linux, Apache, {{ MY }}, and PHP

          Click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify:

          * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-hdd }}`
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `3 {{ ui-key.yacloud.common.units.label_gigabyte }}`

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, open the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify the following: 

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `{{ ui-key.yacloud.mdb.forms.resource_presets_field_gen_v3 }}`
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          * Select the `nlb-network` cloud network and its subnets.
          * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for access to the VM:

          * In the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field, select the service account to link to the VM.
          * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
          * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

      1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, specify the instance group size: `2`.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**, select **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** and enter `nlb-tg` as the group name.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  It may take a few minutes to create an instance group. As soon as all VMs change their [status](../../compute/concepts/vm-statuses.md) to `RUNNING`, you can [upload the website files to them](#upload-files).

{% endlist %}


## Upload the website files {#upload-files}

{% include [load-balancer-website-upload-files](../_tutorials_includes/load-balancer-website/upload-files.md) %}


## Create a network load balancer {#create-load-balancer}

When creating a network load balancer, you need to add a [listener](../../network-load-balancer/concepts/listener.md) that the load balancer will use to receive traffic, attach the [target group](../../network-load-balancer/concepts/target-resources.md) created together with the instance group, and configure resource health checks in it.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create a load balancer in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}** and click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. Enter a name for the load balancer, e.g., `nlb-1`.
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**:
  
      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}** and specify the following parameters:

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**: `nlb-listener`
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**: `80`
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**: `80`

      1. Click **{{ ui-key.yacloud.common.add }}**.

  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**:

      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}** and select the `nlb-tg` target group [created earlier](#create-vms). If there is only one target group, it is selected automatically.
      1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}** and specify the following:

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**: `health-check-1`
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}**: Number of successful checks to consider the VM ready to receive traffic: `5`
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}**: Number of failed checks to stop routing traffic to the VM: `5`

      1. Click **{{ ui-key.yacloud.common.apply }}**.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

After you create a network load balancer, [run a fault tolerance test](#test).

## Run a fault tolerance test {#test}

{% include [load-balancer-website-test](../_tutorials_includes/load-balancer-website/test.md) %}


## How to delete the resources you created {#clear-out}

To shut down the hosting and stop paying for the created resources:
1. [Delete](../../network-load-balancer/operations/load-balancer-delete.md) the network load balancer.
1. [Delete](../../compute/operations/instance-groups/delete.md) the instance group.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.