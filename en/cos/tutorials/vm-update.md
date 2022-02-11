# Updating a VM with a {{ coi }}

Change the Docker container settings on the VM created from a [{{ coi }}](../concepts/index.md).

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder where the VM was created.
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
        $ yc compute instance list
        +----------------------+-------+---------------+---------+----------------+-------------+
        |          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
        +----------------------+-------+---------------+---------+----------------+-------------+
        | epdbf646ge5qgutfvh43 | my-vm | ru-central1-b | RUNNING | 84.201.155.117 | 172.18.0.21 |
        +----------------------+-------+---------------+---------+----------------+-------------+
        ```

    1. Update the VM.

        Depending on how the VM was created, there are several ways to update it:

        | Creation method | Update the VM using <br>`--container-image` | Update the VM using <br>`--docker-compose-file` |
        | ---- | ---- | ---- |
        | Using the parameters `--container-*` | The old Docker container is deleted and a new one is created. | The old Docker container is deleted and new Docker containers are created (described in the docker-compose.yaml file). |
        | Using the docker-compose.yaml file specification | The old Docker containers (described in the docker-compose.yaml file) are deleted and a new Docker container is created, which is described using the parameters `--container-*` | Only new Docker containers (those added to the docker-compose.yaml file) or modified Docker containers are created. The Docker containers missing from the new docker-compose.yaml file are deleted. |

        * Update the VM by setting new parameters:

            ```
            $ yc compute instance update-container epdbf646ge5qgutfvh43 \
            --container-name=my_vm_new_version \
            --container-image=cr.yandex/mirror/ubuntu:18.04 \
            --container-env=KEY1=VAL1,KEY2=VAL2 \
            --remove-container-env=KEY3 \
            --container-stdin=false \
            --container-restart-policy=Never
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
            - `--container-name`: The name of the Docker container.
            - `--container-image`: The name of the Docker image used to launch the Docker container.
            - `--container-env`: The environment variables available in the Docker container.
            - `--remove-container-env`: Exclude the environment variables whose keys are specified in the parameter.
            - `--container-command`: The command to run upon Docker container launch.
            - `--container-stdin`: Allocate the buffer for the input stream while running the Docker container.
            - `--container-restart-policy`: Parameters for the command specified in `--container-command`.
            - `--container-privileged`: Launch the Docker container in privileged mode.

        * Update the VM by setting the specification of multiple Docker containers:

            ```
            $ yc compute instance update-container epdbf646ge5qgutfvh43 --docker-compose-file=<file path>
            done (2s)
            id: fhma9omhj2e7d4c04kd2
            folder_id: b1g88tflru0ek1omtsu0
            created_at: "2020-02-05T17:08:48Z"
            name: coi-vm
            zone_id: ru-central1-a
            platform_id: standard-v2
            ...
            ```

            Where:
            - `--docker-compose-file`: Path to the file with the Docker container specification.

{% endlist %}

