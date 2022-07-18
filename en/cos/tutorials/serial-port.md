# Configuring data output from a Docker container to a serial port

In this tutorial, you'll create a VM from a [{{ coi }}](../concepts/index.md) and set up a redirect of the application output stream to the VM [serial port](../../compute/operations/serial-console/index.md#configuration).

## Before you start {#before-you-begin}

If the required Docker image is pushed to {{ container-registry-name }}, create a [service account](../../iam/operations/sa/create.md) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the registry in use. A VM with a {{ coi }} pulls the Docker image from the registry on behalf of this account.

## Create a VM from a {{ coi }} with serial port output {#create-vm}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create a VM from a {{ coi }}:

     ```bash
     yc compute instance create-with-container --help
     ```

  1. Create a VM specification file. Specify the username, set the public part of the SSH key to connect to the VM, and save this data to a file named `cloud-config-ports.yaml`:

     ```
     #cloud-config
     runcmd:
       - [ sudo, chmod, 666, /dev/ttyS1]
     users:
       name: <username>
         groups: sudo
         shell: /bin/bash
         sudo: ['ALL=(ALL) NOPASSWD:ALL']
         ssh-authorized-keys:
           - <public SSH key to connect to the VM>
     ```

  1. Create a Docker container specification file. Save the following data to a file named `container-spec-ports.yaml`:

     ```
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

        ```bash
        yc compute instance create \
          --name coi-vm-with-sp \
          --zone ru-central1-a \
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

        Once the VM is created, it appears in the list of VMs under **{{ compute-name }}** in the [management console]({{ link-console-main }}).

     1. Check the results.
        1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ compute-name }}**.
        1. Click on the name of the VM `coi-vm-with-sp`.
        1. Under **Serial port**, select `COM2`. In a few minutes, the screen displays `Hello world!`.

{% endlist %}

For more information about working with VMs, see our [step-by-step instructions](../../compute/operations/index.md).