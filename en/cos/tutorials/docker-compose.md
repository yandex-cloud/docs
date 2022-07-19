# Creating a VM from a {{ coi }} with multiple Docker containers

In this tutorial, you'll create a VM that contains multiple Docker containers from a [{{ coi }}](../concepts/index.md). A VM is created based on the [Docker Compose specification](../concepts/coi-specifications.md#compose-spec).

## Before you start {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-full-name }}, create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the registry in use. A VM with a {{ coi }} pulls the Docker image from the registry on behalf of this account.

## Create a VM with multiple Docker containers {#docker-compose}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a VM with multiple Docker containers from a {{ coi }}:

  1. View a description of the CLI command to create a VM from a {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Create a Docker container specification. Save the following data to a file named `docker-compose.yaml`:

     ```
     version: '3.7'
     services:
       app1:
         container_name: nginx
         image: "nginx"
         ports:
           - "80:80"
         restart: always
       app2:
         container_name: redis
         image: "redis"
         restart: always
     ```

  1. Create a VM with multiple Docker containers:

     ```bash
     yc compute instance create-with-container \
       --name my-vm \
       --zone ru-central1-a \
       --ssh-key ssh-key.pub \
       --network-interface subnet-name=<subnet name>,nat-ip-version=ipv4 \
       --service-account-name default-sa \
       --docker-compose-file docker-compose.yaml
     ```

     Where:

     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key file](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * `--network-interface`: VM network settings.
     * `--service-account-name`: Service account name.
     * `--docker-compose-file`: YAML file with the container specification.

     After being created, the VM will appear in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}).

  1. Check the results.
     1. [Connect to the VM via SSH](../../compute/operations/vm-connect/ssh.md).
     1. View a list of running Docker containers:

        ```bash
        sudo docker ps -a
        ```

        Result:

        ```
        CONTAINER ID  IMAGE  COMMAND                 CREATED         STATUS         PORTS               NAMES
        c79b1cdc5a3a  nginx  "nginx -g 'daemon of…"  16 seconds ago  Up 14 seconds  0.0.0.0:80->80/tcp  nginx
        3ac5a9844a5d  redis  "docker-entrypoint.s…"  2 minutes ago   Up 2 minutes   6379/tcp            redis
        ```

{% endlist %}