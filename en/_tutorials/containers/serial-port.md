# Configuring data output from a Docker container to a serial port

To create a [VM](../../compute/concepts/vm.md) from an [image](../../compute/concepts/image.md), such as a [{{ coi }}](../../cos/concepts/index.md), and set up a redirect of the application output stream to the VM [serial port](../../compute/concepts/serial-console.md):

1. [Get your cloud ready](#before-you-begin).
1. [Create a VM specification file](#prepare-specification-vm).
1. [Create a Docker container specification file](#prepare-specification-docker).
1. [Get the ID of the image for creating the VM](#get-id).
1. [Create the VM](#create-vm).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

If the [Docker image](../../container-registry/concepts/docker-image.md) you need is stored in [{{ container-registry-name }}](../../container-registry/), create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the [registry](../../container-registry/concepts/registry.md) in question. Your {{ coi }} VM will use this account to pull the Docker image from the registry.

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

If you do not have a [network](../../vpc/operations/network-create.md) or [subnet](../../vpc/operations/subnet-create.md), create them.

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a dynamic or static [external IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a VM specification file {#prepare-specification-vm}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a VM specification file named `cloud-config-ports.yaml` and paste the following into it:

  ```yaml
  #cloud-config
  runcmd:
  - [ sudo, chmod, 666, /dev/ttyS1]
  users:
  - name: <username>
    groups: sudo
    shell: /bin/bash
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    ssh_authorized_keys:
    - <public_SSH_key_for_connecting_to_VM>
  ```

  In the file configuration, set the username and specify the public part of the [SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) required to connect to the VM. You will need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair by yourself.

{% endlist %}

## Create a Docker container specification file {#prepare-specification-docker}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a Docker container specification file named `container-spec-ports.yaml` and paste the following into it:

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
     1. Get the ID of the image for creating the VM:

        {% list tabs group=programming_language %}

        - Bash {#bash}

          ```bash
          IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | jq -r .id)
          ```

        - PowerShell {#powershell}

          ```shell script
          > $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | ConvertFrom-Json).id
          ```

        {% endlist %}

     1. Create the VM:

        ```bash
        yc compute instance create \
          --name coi-vm-with-sp \
          --zone {{ region-id }}-a \
          --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
          --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
          --create-boot-disk image-id=$IMAGE_ID \
          --service-account-name <service_account_name>
        ```

        Where:
        * `--name`: VM name.
        * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `--network-interface`: VM network settings.
        * `--metadata-from-file`: YAML [metadata](../../compute/concepts/vm-metadata.md) files for creating the VM.

            {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}
        * `--create-boot-disk`: ID of the image to create a boot disk from.
        * `--service-account-name`: Name of the service account you created [earlier](#before-you-begin).

        Once created, the VM will appear in the VM list under **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in the [management console]({{ link-console-main }}).
     1. Check the result.
        1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
        1. Click the VM name: `coi-vm-with-sp`.
        1. Under **{{ ui-key.yacloud.compute.instance.switch_service-console }}**, select the `COM2` port. In a few minutes, the screen will display `Hello world!`.

{% endlist %}

## Get the ID of the image for creating the VM {#get-id}

To get the ID of the latest image for creating the VM, run:

{% list tabs group=operating_system %}

- Linux (Bash) {#linux}

  ```bash
  IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image \
    --folder-id standard-images \
    --format=json | jq -r .id)
  ```

- Windows (PowerShell) {#windows}

  ```shell script
  $IMAGE_ID=(yc compute image get-latest-from-family container-optimized-image `
    --folder-id standard-images `
    --format=json | ConvertFrom-Json).id
  ```

{% endlist %}

## Create a VM {#create-vm}

{% list tabs group=instructions %}

- CLI {#cli}

  Enter a name for the [subnet](../../vpc/operations/subnet-create.md) where you will create your VM and run:

  ```bash
  yc compute instance create \
    --name coi-vm-with-sp \
    --zone {{ region-id }}-d \
    --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
    --metadata-from-file user-data=cloud-config-ports.yaml,docker-container-declaration=container-spec-ports.yaml \
    --create-boot-disk image-id=$IMAGE_ID
  ```

  Where:
  * `--name`: VM name.
  * `--zone`: Availability zone.
  * `--network-interface`: VM network settings.
  * `--metadata-from-file`: YAML metadata files for creating the VM.
  * `--create-boot-disk`: ID of the image to create a boot disk from.

{% endlist %}

Once created, the VM will appear in the VM list under **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** in the [management console]({{ link-console-main }}).

## Check the result {#check-result}

To check whether you correctly configured data output from the Docker container to the serial port:
1. In the [management console]({{ link-console-main }}), navigate to the folder page.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Click the VM name: `coi-vm-with-sp`.
1. Under **{{ ui-key.yacloud.compute.instance.switch_service-console }}**, select the `COM2` port. In a few minutes, the screen will display `Hello world!`.

For more information about working with VMs, see [our step-by-step guides](../../compute/operations/index.md).

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete](../../vpc/operations/address-delete.md) the VM’s public static IP address if you reserved one.