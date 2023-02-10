# Creating a VM with {{ coi }}

Create a VM from a [{{ coi }}](concepts/index.md) and run a {% if lang == "ru" %}[Docker container](/blog/posts/2022/03/docker-containers){% else %}Docker container{% endif %} on it.

## Before you begin {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-name }}, create a [service account](../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../container-registry/security/index.md#choosing-roles) role for the registry in use. A {{ coi }} VM will pull the Docker image from the registry on behalf of this account.

## Create a VM with a Docker container from a {{ coi }} image {#create-vm}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Click **Create VM**.
  1. Under **Image/boot disk selection**, go to the **Container Solution** tab.
  1. Click **Configure**.
  1. In the **Docker container settings** window that opens, set parameters using hints:
     * Specify the **Docker image** to be used to run the Docker container on the VM.
     * Select the **Restart policy** field value for the Docker container:
       * **Always**: Always restart the Docker container when it's stopped.
       * **Never**: Don't restart the Docker container automatically.
       * **On-Failure**: Restart the Docker container only if it shut down with a non-zero return code.
     * If necessary, fill in the remaining fields.

     Click **Apply**.
  1. Set the remaining VM parameters by following the [instructions](../compute/operations/vm-create/create-linux-vm.md).

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
     * `--ssh-key`: The contents of a [public key](../compute/quickstart/quick-create-linux.md#create-ssh) file.
     * `--service-account-name`: Name of the service account.
     * `--public-ip`: Public IP address allocated to the VM.
     * `--container-name`: The name of the Docker container.
     * `--container-image`: The name of the Docker image used to launch the Docker container.
     * `--container-command`: The command to run upon Docker container launch.
     * `--container-arg`: Parameters for the command specified in `--container-command`.
     * `--container-env`: The environment variables available in the Docker container.
     * `--container-privileged`: Launch the Docker container in privileged mode.

     Result:

     ```text
     done (17s)
      id: epdbf646ge5qgutfvh43
      folder_id: b1g88tflru0ek1omtsu0
      created_at: "2019-08-07T09:44:03Z"
      name: my-vm
      zone_id: {{ region-id }}-b
      platform_id: standard-v3
     ...
     ```

     Once created, the VM appears in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step instructions](../compute/operations/index.md).

{% endlist %}

#### What's next {#what-is-next}

* Read a detailed description of a [{{ coi }}](concepts/index.md).
* For information about what else you can do with a {{ coi }}, see our [step-by-step instructions](tutorials/index.md).