# Creating a VM from a {{ coi }} and an additional volume for a Docker container

In this tutorial, you'll create a VM from a [{{ coi }}](../concepts/index.md) that contains a Docker container with a running MongoDB instance and an additional 10 GB [volume](https://docs.docker.com/storage/volumes/) attached.

## Before you start {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-name }}, create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the registry in use. A VM with a {{ coi }} pulls the Docker image from the registry on behalf of this account.

## Create a VM from a {{ coi }} with an additional volume for a Docker container {#create-vm}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View a description of the CLI create VM command:

        ```
        $ yc compute instance create --help
        ```

    1. Create a VM specification file. Specify the username and save the following data to a file named `user-data.yaml`:

        ```
        #cloud-config
        fs_setup:
          - device: /dev/disk/by-id/virtio-coi-data
            filesystem: ext4
            overwrite: false
            partition: auto
        mounts:
        - - /dev/disk/by-id/virtio-coi-data
          - /home/<username>/coi-data
          - auto
          - defaults
          - "0"
          - "0"
        users:
          name: <username>
            groups: sudo
            shell: /bin/bash
            sudo: ['ALL=(ALL) NOPASSWD:ALL']
            ssh-authorized-keys:
              - <public SSH key to connect to the VM>
        ```

    1. Create a Docker container specification file. Save the following data to a file named `container.yaml`:

        ```
        spec:
          containers:
          - image: mongo:latest
            name: container-name
            securityContext:
              privileged: false
            stdin: false
            tty: false
            volumeMounts:
              - mountPath: <path where the file or folder is mounted in the Docker container>
                name: data-volume
          restartPolicy: Always
          volumes:
            - name: data-volume
              hostPath:
                path: /home/<username>/coi-data
        ```

    1. Create a VM with multiple disks.

        1. Get the ID of the image to create the VM:

            {% list tabs %}

            - Bash

                ```
                $ IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | jq -r .id)
                ```

            - PowerShell

                ```
                > $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | ConvertFrom-Json).id
                ```

            {% endlist %}

        1. Create a VM:

            ```
            yc compute instance create
                --name coi-vm \
                --zone=ru-central1-a
                --network-interface subnet-name=<subnet name>,nat-ip-version=ipv4 \
                --metadata-from-file user-data=user-data.yaml,docker-container-declaration=container-spec.yaml \
                --create-boot-disk image-id=$IMAGE_ID \
                --create-disk name=data-disk,size=10,device-name=coi-data
            ```

            Where:
            - `--name`: VM name.
            - `--zone`: Availability zone.
            - `--network-interface`: VM network settings.
            - `--metadata-from-file`: YAML metadata files to create the VM.
            - `--create-boot-disk`: ID of the image to create a boot disk from.
            - `--create-disk`: Parameters of the volume to mount to the Docker container.

            Once the VM is created, it appears in the list of VMs under **{{ compute-name }}** in the [management console]({{ link-console-main }}).

    1. Check the results.

        1. [Connect to the VM via SSH](../../compute/operations/vm-connect/ssh.md).

        1. Get the ID of the running Docker container:

            ```
            $ sudo docker ps -a
            CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
            7efe42b56319        mongo:latest        "docker-entrypoint.s…"   17 hours ago        Up 17 hours                             coi-container-name-1375924429
            ```

        1. Connect to the running Docker container:

            ```
            $ sudo docker exec -it 7efe42b56319  bash
            ```

        1. View the list of attached disks. Note the mounted disk `/dev/vdb 11G 24M 9.9G 1% /home/<username>/second-volume`:

            ```
            $ df -H
            Filesystem      Size  Used Avail Use% Mounted on
            overlay         3.2G  3.0G   19M 100% /
            tmpfs            68M     0   68M   0% /dev
            tmpfs           1.1G     0  1.1G   0% /sys/fs/cgroup
            /dev/vda1       3.2G  3.0G   19M 100% /data/db
            shm              68M     0   68M   0% /dev/shm
            /dev/vdb         11G   24M  9.9G   1% /home/<username>/second-volume
            tmpfs           1.1G     0  1.1G   0% /proc/acpi
            tmpfs           1.1G     0  1.1G   0% /proc/scsi
            tmpfs           1.1G     0  1.1G   0% /sys/firmware
            ```

{% endlist %}

For more information about working with VMs, see our [step-by-step instructions](../../compute/operations/index.md).

