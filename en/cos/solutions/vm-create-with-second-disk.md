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
        yc compute instance create-with-container --help
        ```

    1. Prepare the [Docker Compose specification](../concepts/index.md#compose-spec). Save the following data to a file named `docker-compose.yaml`:

        ```
        version: '3.4'
        services:
          app2:
            container_name: container-name
            image: "mongo:latest"
            restart: always
            volumes: 
              - /home/yc-user/coi-data:/data
        
        x-yc-disks:
          - device_name: coi-data
            fs_type: ext4
            host_path: /home/yc-user/coi-data
        ```

        When creating your VM via the CLI, the default user is created: `yc-user`.

    1. Create a VM with multiple disks.

        ```
        yc compute instance create-with-container \
            --name coi-vm \
            --zone=ru-central1-a \
            --public-ip \
            --create-boot-disk size=10 \
            --create-disk name=data-disk,size=10,device-name=coi-data \
            --ssh-key <public SSH key to connect to the VM> \
            --docker-compose-file docker-compose.yaml 
        ```

        Where:
        - `--name`: VM name.
        - `--zone`: Availability zone.
        - `--public-ip`: Public IP address allocated to the VM.
        - `--create-boot-disk`: Parameters of the VM disk.
        - `--ssh-key`: Contents of the [public key file](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
        - `--docker-compose-file`: YAML file with the container specification.

        Once the VM is created, it appears in the list of VMs under **{{ compute-name }}** in the [management console]({{ link-console-main }}).

    1. Check the results.

        1. [Connect to the VM via SSH](../../compute/operations/vm-connect/ssh.md).

        1. Get the ID of the running Docker container:

            ```
            sudo docker ps -a
            CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
            1f71192ded4c        mongo:latest        "docker-entrypoint.s…"   5 minutes ago       Up 5 minutes        27017/tcp           container-name
            ```

        1. Connect to the running Docker container:

            ```
            sudo docker exec -it 1f71192ded4c bash
            ```

        1. View the list of attached disks. Note the mounted disk `/dev/vdb 11G 24M 9.9G 1% /data`:

            ```
            df -H
            Filesystem      Size  Used Avail Use% Mounted on
            overlay          11G  3.1G  7.0G  31% /
            tmpfs            68M     0   68M   0% /dev
            tmpfs           1.1G     0  1.1G   0% /sys/fs/cgroup
            /dev/vdb         11G   24M  9.9G   1% /data
            /dev/vda2        11G  3.1G  7.0G  31% /data/db
            shm              68M     0   68M   0% /dev/shm
            tmpfs           1.1G     0  1.1G   0% /proc/acpi
            tmpfs           1.1G     0  1.1G   0% /proc/scsi
            tmpfs           1.1G     0  1.1G   0% /sys/firmware
            ```

{% endlist %}

For more information about working with VMs, see our [step-by-step instructions](../../compute/operations/index.md).
