# Creating a VM from a {{ coi }}

Create a VM from a [{{ coi }}](../concepts/index.md) and run a Docker container on it.

## Getting started {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-full-name }}, create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the registry in use. A {{ coi }} VM will pull the Docker image from the registry on behalf of this account.

## Create a VM with a Docker container from a {{ coi }} {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.  
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab.
  1. Click **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
  1. In the **{{ ui-key.yacloud.compute.instances.create.section_coi }}** window that opens, set the parameters using suggestions:

      * (Optional) Enter the **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}** of the Docker container to run on the VM. The naming requirements are as follows:

          {% include [name-format](../../_includes/name-format.md) %}

      * Specify the [**{{ ui-key.yacloud.compute.instances.create.field_coi-image }}**](../concepts/docker-image.md) to be used to run the Docker container on the VM. You can do this in one of the following ways:

          * By selecting one of the available images. To do this, start typing the image name in the search bar. The image search reads all the available cloud folders.
          * By specifying the image name manually. To do this, click **{{ ui-key.yacloud.component.image-field.button_custom-image }}** and enter the image name. You can specify an image from {{ container-registry-name }} or any publicly available Docker image library (such as [Docker Hub](https://hub.docker.com)).

      * (Optional) In the **{{ ui-key.yacloud.compute.instances.create.field_coi-command }}** field, specify the executable file to run when the Docker container starts.
      * (Optional) Set **{{ ui-key.yacloud.compute.instances.create.field_coi-arguments }}**.
      * (Optional) Specify **{{ ui-key.yacloud.compute.instances.create.field_coi-env }}** you want to make available in the Docker container in `key:value` format.
      * Select the [**{{ ui-key.yacloud.compute.instances.create.field_coi-restart-policy }}**](../concepts/restart-policy.md) field value for the Docker container:

          * `{{ ui-key.yacloud.compute.instances.create.value_coi-restart-always }}`: Always restart the Docker container when it stops.
          * `{{ ui-key.yacloud.compute.instances.create.value_coi-restart-on-failure }}`: Restart the Docker container only if it shuts down with a non-zero return code.
          * `{{ ui-key.yacloud.compute.instances.create.value_coi-restart-never }}`: Do not restart the Docker container automatically.

      * (Optional) Enable **{{ ui-key.yacloud.compute.instances.create.field_coi-tty }}** to use the command shell in the Docker container.
      * (Optional) Enable **{{ ui-key.yacloud.compute.instances.create.field_coi-stdin }}** to link the input stream to the running Docker container.
      * (Optional) Enable **{{ ui-key.yacloud.compute.instances.create.field_coi-privileged }}** to allow the Docker container processes to access all VM resources.

  1. Click **{{ ui-key.yacloud.common.apply }}**.
  1. Use [this guide](../../compute/operations/vm-create/create-linux-vm.md) to configure the remaining VM parameters.

- CLI using flags {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a VM and set Docker container parameters via the YC CLI:
  1. View a description of the command:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Run this command:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone {{ region-id }}-b \
       --ssh-key ssh-key.pub \
       --service-account-name my-robot \
       --create-boot-disk size=30 \
       --public-ip \
       --platform standard-v3 \
       --container-name=my-app \
       --container-image={{ registry }}/mirror/ubuntu:20.04 \
       --container-command=sleep \
       --container-arg="1000" \
       --container-env=KEY1=VAL1,KEY2=VAL2 \
       --container-privileged
      ```

     Where:
     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
     * `--service-account-name`: Service account name.
     * `--create-boot-disk`: Boot disk size. It must be at least 30 GB.
     * `--public-ip`: Public IP address allocated to the VM.
     * `--container-name`: Docker container name.
     * `--container-image`: Name of the Docker image used to run the Docker container.
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

    Once created, the VM will appear in the VM list under **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step guides](../../compute/operations/index.md).

- CLI using a specification file {#spec-cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a VM and set Docker container parameters using a [specification file](../concepts/coi-specifications.md#coi-spec):
  1. View a description of the command:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Create a Docker container specification file. Save the following data to the `docker-spec.yaml` file:

     ```yaml
     spec:
       containers:
       - command:
         - sleep
         args:
         - 100000
         image: {{ registry }}/mirror/ubuntu:20.04
         name: my-container
         securityContext:
          privileged: true
     ```

  1. Run this command:

     ```bash
     yc compute instance create-with-container \
       --coi-spec-file docker-spec.yaml \
       --name my-vm \
       --zone {{ region-id }}-b \
       --ssh-key ssh-key.pub \
       --create-boot-disk size=30 \
       --service-account-name my-service-account \
       --public-ip
     ```

     Where:
     * `--coi-spec-file`: Path to the Docker container [specification file](../concepts/coi-specifications.md#coi-spec).
     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
     * `--create-boot-disk size`: Boot disk size. It must be at least 30 GB.
     * `--service-account-name`: Service account name.
     * `--public-ip`: Public IP address allocated to the VM.

     Result:

     ```text
     done (1m40s)
      id: epde18u4mahl********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-03-13T13:50:17Z"
      name: my-vm
      ...
     ```

  Once created, the VM will appear in the VM list under **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step guides](../../compute/operations/index.md).

{% endlist %}