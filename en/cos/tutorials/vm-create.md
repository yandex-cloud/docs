# Creating a VM with {{ coi }}

Create a VM from a [{{ coi }}](../concepts/index.md) and run a Docker container on it.

## Getting started {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-full-name }}, create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the registry in use. A {{ coi }} VM will pull the Docker image from the registry on behalf of this account.

## Create a VM with a Docker container from a {{ coi }} image {#create-vm}

{% list tabs %}


- Management console

  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Click **Create VM**.
  1. Under **Image/boot disk selection**, go to the **Container Solution** tab.
  1. Click **Configure**.
  1. In the **Docker container settings** window that opens, set the parameters using hints:
     * (Optional) Enter the **Name** of the Docker container to run on the VM. The naming requirements are as follows:
       * Name must be from 3 to 63 characters long.
       * It may contain Latin letters, numbers, and hyphens.
       * It must start with a letter. The last character cannot be a hyphen.
     * Specify the [**Docker image**](../concepts/docker-image.md) to be used to run the Docker container on the VM. You can do this in one of the following ways:
       * By selecting one of the available images. To do this, start typing the image name in the search bar. The image search reads all the available cloud folders.
       * By specifying the image name manually. To do this, click **Enter link** and enter the image name. You can specify an image from {{ container-registry-name }} or any publicly available Docker image library (such as [Docker Hub](https://hub.docker.com)).
     * (Optional) In the **Command** field, specify the executable file to run when the Docker container starts.
     * (Optional) Specify **Command arguments**.
     * (Optional) Specify **Environment variables** in `key:value` format, which are available in the Docker container.
     * Select the [**Restart policy**](../concepts/restart-policy.md) field value for the Docker container:
       * **Always**: Always restart the Docker container when it stops.
       * **Never**: Do not restart the Docker container automatically.
       * **On-Failure**: Restart the Docker container only if it shuts down with a non-zero return code.
     * (Optional) Enable **Attach a TTY to the Docker container** to use the command shell in the Docker container.
     * (Optional) Enable **Allocate an stdin buffer for a running Docker container** to link the input stream to the running Docker container.
     * (Optional) Enable **Run Docker container in privileged mode** to allow the Docker container processes to access all VM resources.
     Click **Apply**.
  1. Set the remaining VM parameters by following [this guide](../../compute/operations/vm-create/create-linux-vm.md).


- CLI using flags

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
       --container-image={{ registry }}/mirror/ubuntu:16.04 \
       --container-command=sleep \
       --container-arg="1000" \
       --container-env=KEY1=VAL1,KEY2=VAL2 \
       --container-privileged
     ```

     Where:
     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key](../../compute/quickstart/quick-create-linux.md#create-ssh) file.
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

  Once created, the VM will appear in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step guides](../../compute/operations/index.md).

- CLI using a specification file

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a VM and set Docker container parameters using a [specification file](../concepts/coi-specifications.md#coi-spec):
  1. View a description of the command:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Create a Docker container specification file. Save the following data to a file named `docker-spec.yaml`:

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
     * `--ssh-key`: Contents of the [public key](../../compute/quickstart/quick-create-linux.md#create-ssh) file.
     * `--create-boot-disk size`: Boot disk size. It must be at least 30 GB.
     * `--service-account-name`: Name of the service account.
     * `--public-ip`: Public IP address allocated to the VM.

     Result:

     ```text
     done (1m40s)
      id: epde18u4mahl4a8n39ta
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2023-03-13T13:50:17Z"
      name: my-vm
     ...
     ```

  Once created, the VM will appear in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step guides](../../compute/operations/index.md).

{% endlist %}