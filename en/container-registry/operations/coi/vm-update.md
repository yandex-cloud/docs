# Updating a VM with a {{ coi }}

Change the Docker container settings on the VM created from a [{{ coi }}](../../concepts/coi.md).

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main}}), select the folder where the VM was created.
    1. In the list of services, select **{{ compute-name }}**.
    1. Click on the line with the VM you want to change.
    1. Click **Edit VM** in the top panel.
    1. Make your changes in the **Docker container settings** section.
    1. Click **Save changes**.

- CLI

    1. View a description of the CLI command for updating VMs:

        ```
        yc compute instance update-container --help
        ```

    1. Get the unique ID of the virtual machine. To do this, click on the line with its name under **{{ compute-name }}** in the [management console]({{ link-console-main }}) or use the CLI command:

        ```
        yc compute instance list
        +----------------------+-------+---------------+---------+----------------+-------------+
        |          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
        +----------------------+-------+---------------+---------+----------------+-------------+
        | epdbf646ge5qgutfvh43 | my-vm | ru-central1-b | RUNNING | 84.201.155.117 | 172.18.0.21 |
        +----------------------+-------+---------------+---------+----------------+-------------+
        ```

    1. Update the virtual machine:

        ```
        yc compute instance update-container epdbf646ge5qgutfvh43 \
        --container-name=my_vm_new_version \
        --container-image=cr.yandex/mirror/ubuntu:18.04 \
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

        Where:

        * `--container-name`: The name of the Docker container.
        * `--container-image`: The name of the Docker image used to launch the Docker container.
        * `--container-env`: The environment variables available in the Docker container.
        * `--remove-container-env`: Exclude the environment variables whose keys are specified in the parameter.
        * `--container-command`: The command to run upon Docker container launch.
        * `--container-stdin`: Allocate the buffer for the input stream while running the Docker container.
        * `--container-restart-policy`: Parameters for the command specified in `--container-command`.
        * `--container-privileged`: Launch the Docker container in privileged mode.

{% endlist %}

