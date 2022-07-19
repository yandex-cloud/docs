# Creating a VM with a {{ coi }}

Create a VM from a [{{ coi }}](../../concepts/coi.md) and run a Docker container on it.

## Before you start {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-name }}, create a [service account](../../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../security/index.md#choosing-roles) role for the registry in use. A VM with a {{ coi }} pulls the Docker image from the registry on behalf of this account.

## Create a VM with a Docker container built on a {{ coi }} {#create-vm}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main}}), select the folder to create your VM in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Click **Create VM**.
  1. Under **Images from {{ marketplace-name }}**, select a **{{ coi }}**.
  1. The **Docker container settings** section appears at the bottom of the VM creation page. Fill out this section based on the prompts next to each field:
     1. Enter the name of the Docker container to run on the VM.
     1. Specify the Docker image used to launch the Docker container on the VM.
     1. If necessary, fill in the remaining fields.
  1. Configure the other VM settings based on these [instructions](../../../compute/operations/vm-create/create-linux-vm.md).

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create a VM from a {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Create a VM:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone ru-central1-b \
       --ssh-key ssh-key.pub \
       --service-account-name my-robot \
       --public-ip \
       --container-name=my-app \
       --container-image=cr.yandex/mirror/ubuntu:16.04 \
       --container-command=sleep \
       --container-arg="1000" \
       --container-env=KEY1=VAL1,KEY2=VAL2 \
       --container-privileged
     ```

     Where:
     
     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key file](../../../compute/quickstart/quick-create-linux.md#create-ssh).
     * `--service-account-name`: Service account name.
     * `--public-ip`: Public IP address allocated to the VM.
     * `--container-name`: The name of the Docker container.
     * `--container-image`: The name of the Docker image used to launch the Docker container.
     * `--container-command`: The command to run upon Docker container launch.
     * `--container-arg`: Parameters for the command specified in `--container-command`.
     * `--container-env`: The environment variables available in the Docker container.
     * `--container-privileged`: Launch the Docker container in privileged mode.

     Result:

     ```bash
     done (17s)
     id: epdbf646ge5qgutfvh43
     folder_id: b1g88tflru0ek1omtsu0
     created_at: "2019-08-07T09:44:03Z"
     name: my-vm
     zone_id: ru-central1-b
     platform_id: standard-v2
     ...
     ```

{% endlist %}

Once the VM is created, it appears in the list of VMs under **{{ compute-name }}** in the [management console]({{ link-console-main }}).

For more information about working with VMs, see our [step-by-step instructions](../../../compute/operations/index.md).