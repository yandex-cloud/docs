# Creating a VM with Container Optimized Image

Create a VM from a Container Optimized Image and run a Docker container on it.

_A Container Optimized Image_ is a VM [image](../../compute/concepts/image.md) that is optimized for running Docker containers. The image includes Ubuntu LTS, Docker, and a daemon for launching Docker containers.

It's integrated with the Yandex.Cloud platform, which allows you to:

- Run the Docker container specified in the VM settings immediately after creation from the management console or YC CLI.
- Access Docker container open network ports without any additional settings.
- Update running Docker containers with minimum downtime.

## Before you start {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-name }}, create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role for the registry in use. A VM with a Container Optimized Image pulls the Docker image from the registry on behalf of this account.

## Create a VM with a Docker container from a Container Optimized Image {#create-vm}

{% list tabs %}

- Management console
    1. In the [management console](https://console.cloud.yandex.com), select a folder to create a VM in.
    1. In the list of services, select **{{ compute-name }}**.
    1. Click **Create VM**.
    1. Under **Public images**, select **Container Optimized Image**.
    1. The **Docker container settings** section appears at the bottom of the VM creation page. Fill out this section based on the prompts next to each field:
       1. Enter the name of the Docker container to be run on the VM.
       1. Specify the Docker image used to launch the Docker container on the VM.
       1. If necessary, fill in the remaining fields.
    1. Configure the other VM settings based on these [instructions](../../compute/operations/vm-create/create-linux-vm.md).

- CLI

    1. View a description of the CLI command to create a VM from a Container Optimized Image:

        ```
        $ yc compute instance create-with-container --help
        ```

    1. Create a VM:

        View a [description of parameters and flags](#desc-flags) used to create a VM.

        ```
        $ yc compute instance create-with-container
        --name my-vm \
        --zone=ru-central1-b \
        --ssh-key ssh-key.pub \
        --service-account-name my-robot \
        --public-ip \
        --container-name=my-app \
        --container-image=vm_ubuntu \
        --container-command=sleep \
        --container-arg="1000" \
        --container-env=KEY1=VAL1,KEY2=VAL2 \
        --container-privileged
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

Once created, the VM appears in the list of running VMs in the [management console]({{ link-console-main }}) under **{{ compute-name }}**.

For more information about working with VMs, see our [step-by-step instructions](../../compute/operations/index.md).

## Update the virtual machine {#update}

{% list tabs %}

- Management console
    1. In the [management console](https://console.cloud.yandex.com), select a folder to create a VM in.
    1. In the list of services, select **{{ compute-name }}**.
    1. Click the line with the VM you want to change.
    1. Click **Edit VM** in the top panel.
    1. Make your changes in the **Docker container settings**.
    1. Click **Save changes**.
    1. To start the VM, click **Start** in the top panel.

- CLI

    1. View a description of the CLI command for updating VMs:

        ```
        yc compute instance update-container --help
        ```

    1. Get the unique ID of the virtual machine. To do this, click on the line with its name under **{{ compute-name }}** in the [консоли управления]({{ link-console-main }}) or use the CLI command:

        ```
        $ yc compute instance list
        +----------------------+-------+---------------+---------+----------------+-------------+
        |          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
        +----------------------+-------+---------------+---------+----------------+-------------+
        | epdbf646ge5qgutfvh43 | my-vm | ru-central1-b | RUNNING | 84.201.155.117 | 172.18.0.21 |
        +----------------------+-------+---------------+---------+----------------+-------------+
        ```

    1. Update the virtual machine:

        View a [description of parameters and flags](#desc-flags) used to update a VM.

        ```
        $ yc compute instance update-container epdbf646ge5qgutfvh43 \
        --container-name=my_vm_new_version \
        --container-image=my_vm_ubuntu \
        --container-env=KEY1=VAL1,KEY2=VAL2 \
        --remove-container-env=KEY3 \
        --container-stdin=false \
        --container-restart-policy=never
        done (2s)
        id: epdbf646ge5qgutfvh43
        folder_id: b1g88tflru0ek1omtsu0
        created_at: "2019-08-07T09:44:03Z"
        name: my-vm
        zone_id: ru-central1-b
        platform_id: standard-v2
        ...
        ```

{% endlist %}

## Description of parameters and flags {#desc-flags}

- `--container-arg` — Pass parameters to the command specified in `--container-command`.
- `--clear-container-args` — Exclude all parameters passed to the command by `--container-arg` from the Docker container launch.
    - This parameter is only available for the update command.
- `--container-command` — Specify the command to be run on Docker container launch.
- `--clear-container-command` — Exclude the command run on Docker container launch.
    - This parameter is only available for the update command.
- `--container-env` — Pass environment variables to the Docker container.
    - If the key is repeated multiple times, only the last value is used.
    - It has a higher priority than the `--container-env-file` parameter.
- `--container-env-file` — Pass environment variables to the Docker container from a file.
    - If the key is repeated multiple times, only the last value is used.
    - It has a lower priority than the `--container-env` parameter.
- `--remove-container-env` — Exclude the environment variables whose keys are specified in the parameter.
    - It has a higher priority than the `--container-env` and `--container-env-file`  parameters.
    - This parameter is only available for the update command.
- `--container-image` — Specify the Docker image used to launch the Docker container.
    - Required parameter.
- `--container-name` — Specify the name of the Docker container.
- `--container-privileged` — Launch the Docker container in privileged mode.
    - Default value: `false`.
- `--container-stdin` — Allocate the buffer for the input stream while running the Docker container.
    - Default value: `false`.
- `--container-tty` — Allocate TTY for the Docker container.
    - Default value: `false`.
- `--container-restart-policy` — Set the Docker container restart policy.
    - Valid values: `always` (default), `never`, `on-failure`.

