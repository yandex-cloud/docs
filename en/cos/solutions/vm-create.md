# Creating a VM with {{ coi }}

Create a VM from a [{{ coi }}](../concepts/index.md) and run a Docker container on it.

## Before you start {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-full-name }}, create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the registry in use. A VM with a {{ coi }} pulls the Docker image from the registry on behalf of this account.

## Create a VM with a Docker container from a {{ coi }} image {#create-vm}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your VM.
  1. In the list of services, select **{{ compute-name }}**.
  1. Click **Create VM**.
  1. Under **Image/boot disk selection**, go to the **Container Solution** tab.
  1. Click **Configure**.
  1. In the **Docker container settings** window that opens, set parameters using hints:
     * (optional) Enter the **Name** of the Docker container to run on the VM. Naming requirements:
       * The length can be from 3 to 63 characters.
       * It may contain Latin letters, numbers, and hyphens.
       * The first character must be a letter. The last character can't be a hyphen.
     * Specify the [**Docker image**](../concepts/docker-image.md) to use to run the Docker container on the VM. You can do this one of the following ways:
       * By selecting one of the available images. To do this, start typing the image name in the search bar. Image search reads all the available cloud folders.
       * By specifying the image name manually. To do this, click **Enter link** and enter the image name. You can specify an image from the {{ container-registry-name }} service or any publicly available Docker image library (such as, [Docker Hub](https://hub.docker.com)).
     * (optional) In the **Command** field, specify the executable file to run when the Docker container starts.
     * (optional) Specify **Command arguments**.
     * (optional) Specify **Environment variables** in `key:value` format, which are available in the Docker container.
     * Select the [**Restart policy**](../concepts/restart-policy.md) field value for the Docker container:
       * **Always**: Always restart the Docker container when it's stopped.
       * **Never**: Don't restart the Docker container automatically.
       * **On-Failure**: Restart the Docker container only if it shut down with a non-zero return code.
     * (optional) Enable **Attach a TTY to the Docker container** to use the command shell in the Docker container.
     * (optional) Enable **Allocate an stdin buffer for a running Docker container** to link the input stream to the running Docker container.
     * (optional) Enable **Run Docker container in privileged mode** to allow the Docker container processes to access all VM resources.
     Click **Apply**.
  1. Set the remaining VM parameters per the [instructions](../../compute/operations/vm-create/create-linux-vm.md).

- CLI using flags

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a VM and set Docker container parameters via the YC CLI:
  1. View a description of the command:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Run the command:

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
     * `--ssh-key`: Contents of the [public key file](../../compute/quickstart/quick-create-linux.md#create-ssh).
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

    After being created, the VM will appear in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step instructions](../../compute/operations/index.md).

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
         image: cr.yandex/mirror/ubuntu:20.04
         name: my-container
         securityContext:
          privileged: true
     ```

  1. Run the command:

     ```bash
     yc compute instance create-with-container \
       --coi-spec-file docker-spec.yaml \
       --name my-vm \
       --zone ru-central1-b \
       --ssh-key ssh-key.pub \
       --service-account-name my-service-account \
       --public-ip
     ```

     Where:

     * `--coi-spec-file`: Path to the Docker container [specification file](../concepts/coi-specifications.md#coi-spec).
     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key file](../../compute/quickstart/quick-create-linux.md#create-ssh).
     * `--service-account-name`: Service account name.
     * `--public-ip`: Public IP address allocated to the VM.

     Result:

     ```
     done (1m40s)
      id: epde18u4mahl4a8n39ta
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2020-08-10T13:50:17Z"
      name: my-vm
      zone_id: ru-central1-b
      platform_id: standard-v2
      ...
     ```

  After being created, the VM will appear in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}). For more information about working with VMs, see our [step-by-step instructions](../../compute/operations/index.md).

{% endlist %}