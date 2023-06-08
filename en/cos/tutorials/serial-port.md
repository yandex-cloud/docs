# Configuring data output from a Docker container to a serial port

To create a [VM](../../compute/concepts/vm.md) from an [image](../../compute/concepts/image.md) such as a [{{ coi }}](../concepts/index.md) and set up a redirect of the application output stream to the VM's [serial port](../../compute/operations/serial-console/index.md#configuration):
1. [Prepare your cloud](#before-you-begin).
1. [Create a VM specification file](#prepare-specification-vm).
1. [Create a Docker container specification file](#prepare-specification-docker).
1. [Get the ID of the image to create the VM](#get-id).
1. [Create a VM](#create-vm).
1. [Check the results](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

If the required [Docker image](../../container-registry/concepts/docker-image.md) is pushed to [{{ container-registry-name }}](../../container-registry/), create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the [registry](../../container-registry/concepts/registry.md) in use. A {{ coi }} VM will pull the Docker image from the registry on behalf of this account.

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

If you don't have a [network](../../vpc/operations/network-create.md) or [subnet](../../vpc/operations/subnet-create.md), create them.

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static [external IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a VM specification file {#prepare-specification-vm}

{% list tabs %}

- CLI

  Create a VM specification file named `cloud-config-ports.yaml` and populate it with the following data:

  ```yaml
  #cloud-config
  runcmd:
    - [ sudo, chmod, 666, /dev/ttyS1]
  users:
    - name: <username>
      groups: sudo
      shell: /bin/bash
      sudo: ['ALL=(ALL) NOPASSWD:ALL']
      ssh-authorized-keys:
        - <public SSH key to connect to VM>
  ```

  In the file configuration, set the username and specify the public part of the [SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) required to connect to the VM. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connection yourself.

{% endlist %}

## Create a Docker container specification file {#prepare-specification-docker}

{% list tabs %}

- CLI

  Create a specification for a Docker container as a file named `container-spec-ports.yaml` and populate it with the following data:

  ```yaml
  spec:
    containers:
    - image: ubuntu
      name: app
      command: ["/bin/bash", "-c", "sleep 30 && echo 'Hello World!' > /dev/ttyS1"]
      securityContext:
        privileged: true
      stdin: false
      tty: false
      volumeMounts:
        - mountPath: /dev/ttyS1
          name: log-port
    restartPolicy: Always
    volumes:
      - name: log-port
        hostPath:
          path: /dev/ttyS1
  ```

  1. Create a VM with multiple [disks](../../compute/concepts/disk.md).
     1. Get the ID of the image to create the VM:

        {% list tabs %}

        - Bash

          ```bash
          IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | jq -r .id)
          ```

        - PowerShell

          ```shell script
          > $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | ConvertFrom-Json).id
          ```

        {% endlist %}

     1. Create a VM:

        ```bash
        yc compute instance create \
          --name coi-vm-with-sp \
          --zone {{ region-id }}-a \
          --network-interface subnet-name=<subnet name>,nat-ip-version=ipv4 \
          --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
          --create-boot-disk image-id=$IMAGE_ID
        ```

        Where:
        * `--name`: VM name.
        * `--zone`: [availability zone](../../overview/concepts/geo-scope.md).
        * `--network-interface`: VM network settings.
        * `--metadata-from-file`: YAML [metadata](../../compute/concepts/vm-metadata.md) files to create the VM.
        * `--create-boot-disk`: ID of the image to create a boot disk from.

        Once created, the VM appears in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}).
     1. Check the results.
        1. In the [management console]({{ link-console-main }}), go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ compute-name }}**.
        1. Click on the name of the `coi-vm-with-sp` VM.
        1. Under **Serial port**, select `COM2`. In a few minutes, the screen displays `Hello world!`.

{% endlist %}

## Get the ID of the image to create the VM {#get-id}

To get the ID of the latest image used for VM creation, run:

{% list tabs %}

- Linux (Bash)

  ```bash
  IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image \
    --folder-id standard-images \
    --format=json | jq -r .id)
  ```

- Windows (PowerShell)

  ```shell script
  $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image `
    --folder-id standard-images `
    --format=json | ConvertFrom-Json).id
  ```

{% endlist %}

## Create a VM {#create-vm}

{% list tabs %}

- CLI

  Enter a name for the [subnet](../../vpc/operations/subnet-create.md) to create your VM in and run:

  ```bash
  yc compute instance create \
    --name coi-vm-with-sp \
    --zone {{ region-id }}-c \
    --network-interface subnet-name=<subnet name>,nat-ip-version=ipv4 \
    --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
    --create-boot-disk image-id=$IMAGE_ID
  ```

  Where:
  * `--name`: VM name.
  * `--zone`: Availability zone.
  * `--network-interface`: VM network settings.
  * `--metadata-from-file`: YAML metadata files to create the VM.
  * `--create-boot-disk`: ID of the image to create a boot disk from.

{% endlist %}

Once created, the VM appears in the VM list under **{{ compute-name }}** in the [management console]({{ link-console-main }}).

## Check the results {#check-result}

To check the result of configuring data output from the Docker container to the serial port:
1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ compute-name }}**.
1. Click the name of the `coi-vm-with-sp` VM.
1. Under **Serial port**, select `COM2`. In a few minutes, the screen displays `Hello world!`.

For more information about working with VMs, see our [step-by-step guides](../../compute/operations/index.md).

## How to delete created resources {#clear-out}

To stop paying for the resources you created:
1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. If you reserved a public static IP address for the VM, [delete it](../../vpc/operations/address-delete.md).