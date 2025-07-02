---
title: How to get started with {{ cos-name }}
description: Follow this guide to create a VM from a {{ coi }} and run a Docker container on it.
---

# Creating a VM from a {{ coi }}

Create a VM from a [{{ coi }}](concepts/index.md) and run a Docker container on it.

## Getting started {#before-you-begin}

If the required Docker image has been pushed to {{ container-registry-name }}, create a [service account](../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../container-registry/security/index.md#choosing-roles) role for the registry in use. A {{ coi }} VM will pull the Docker image from the registry under this account.

## Create a Docker container VM from a {{ coi }} {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab.
  1. Click **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
  1. In the **{{ ui-key.yacloud.compute.instances.create.section_coi }}** window that opens, set the parameters using the suggestions:

      1. Specify the **{{ ui-key.yacloud.compute.instances.create.field_coi-image }}** for running the Docker container on the VM.
      1. Select the **{{ ui-key.yacloud.compute.instances.create.field_coi-restart-policy }}** field value for the Docker container:

          * `{{ ui-key.yacloud.compute.instances.create.value_coi-restart-always }}`: Always restart the Docker container when it stops.
          * `{{ ui-key.yacloud.compute.instances.create.value_coi-restart-on-failure }}`: Only restart the Docker container if it shuts down with a non-zero return code.
          * `{{ ui-key.yacloud.compute.instances.create.value_coi-restart-never }}`: Do not restart the Docker container automatically.

      1. Fill in the remaining fields, if required.
      1. Click **{{ ui-key.yacloud.common.apply }}**.

  1. Follow [this guide](../compute/operations/vm-create/create-linux-vm.md) to configure the remaining VM parameters.

- CLI {#cli}

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM from a {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Create a {{ coi }} VM:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone {{ region-id }}-b \
       --ssh-key ssh-key.pub \
       --service-account-name my-robot \
       --platform standard-v3 \
       --create-boot-disk size=30 \
       --public-ip \
       --container-name=my-app \
       --container-image={{ registry }}/mirror/ubuntu:16.04 \
       --container-command=sleep \
       --container-arg="1000" \
       --container-env=KEY1=VAL1,KEY2=VAL2 \
       --container-privileged
     ```

     Where:
     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key](../compute/quickstart/quick-create-linux.md#create-ssh) file.
     * `--service-account-name`: Service account name.
     * `--create-boot-disk size`: Boot disk size.

        {% include [min-disk-size](../_includes/cos/min-disk-size.md) %}

     * `--public-ip`: Public IP address allocated to the VM.
     * `--container-name`: Docker container name.
     * `--container-image`: Name of the Docker image for running the Docker container.
     * `--container-command`: Command to run when you start the Docker container.
     * `--container-arg`: Parameters for the command specified in `--container-command`.
     * `--container-env`: Environment variables available in the Docker container.
     * `--container-privileged`: Run the Docker container in privileged mode.

     Result:

     ```text
     done (17s)
      id: epdbf646ge5q********
      folder_id: b1g88tflru0e********
      created_at: "2023-03-13T09:44:03Z"
      name: my-vm
     ...
     ```

     Once created, the VM will appear in the VM list under **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step guides](../compute/operations/index.md).

{% endlist %}

#### What's next {#what-is-next}

* Read the detailed description of a [{{ coi }}](concepts/index.md).
* To learn what else you can do with a {{ coi }}, see [our step-by-step guides](tutorials/index.md).