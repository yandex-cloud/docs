# Creating a VM with {{ coi }}

Create a VM from a [{{ coi }}](concepts/index.md) and run a Docker container on it.

## Getting started {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-name }}, create a [service account](../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../container-registry/security/index.md#choosing-roles) role for the registry in use. A {{ coi }} VM will pull the Docker image from the registry on behalf of this account.

## Create a VM with a Docker container from a {{ coi }} image {#create-vm}

{% list tabs %}


- Management console

  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Click **Create VM**.
  1. Under **Image/boot disk selection**, go to the **Container Solution** tab.
  1. Click **Configure**.
  1. In the **Docker container settings** window that opens, set the parameters using hints:
     * Specify the **Docker image** to use when running the Docker container on the VM.
     * Select the **Restart policy** field value for the Docker container:
       * **Always**: Always restart the Docker container when it's stopped.
       * **Never**: Do not restart the Docker container automatically.
       * **On-Failure**: Restart the Docker container only if it shut down with a non-zero return code.
     * Fill out the remaining fields, if required.

     Click **Apply**.
  1. Set the remaining VM parameters by following [this guide](../compute/operations/vm-create/create-linux-vm.md).


- CLI

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create a VM from a {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Create a VM from a {{ coi }}:

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
     * `--service-account-name`: Name of the service account.
     * `--create-boot-disk size`: Boot disk size. It must be at least 30 GB.
     * `--public-ip`: Public IP address allocated to the VM.
     * `--container-name`: Name of the Docker container.
     * `--container-image`: Name of the Docker image used to launch the Docker container.
     * `--container-command`: Command to run upon Docker container launch.
     * `--container-arg`: Parameters for the command specified in `--container-command`.
     * `--container-env`: Environment variables available in the Docker container.
     * `--container-privileged`: Launching the Docker container in privileged mode.

     Result:

     ```text
     done (17s)
      id: epdbf646ge5qgutfvh43
      folder_id: b1g88tflru0ek1omtsu0
      created_at: "2023-03-13T09:44:03Z"
      name: my-vm
     ...
     ```

     Once created, the VM will appear in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step guides](../compute/operations/index.md).

{% endlist %}

#### What's next {#what-is-next}

* Read a detailed description of a [{{ coi }}](concepts/index.md).
* To learn what else you can do with a {{ coi }}, see our [step-by-step guides](tutorials/index.md).