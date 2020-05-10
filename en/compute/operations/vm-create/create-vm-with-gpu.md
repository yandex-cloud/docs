# Creating a VM with a GPU

This section provides guidelines for creating VMs with a GPU. For more information about VM configurations, see [{#T}](../../concepts/gpus.md).

By default, the cloud now has a zero quota for creating virtual machines with GPUs. To change the quota, contact [technical support](https://cloud.yandex.com/support).

{% list tabs %}

- Management console

  {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

      ```
      $ yc compute instance create --help
      ```

  1. Prepare a [pair of keys](../vm-connect/ssh.md#creating-ssh-keys) (public and private) for accessing the VM over SSH.

  1. Select a public [image](../images-with-pre-installed-software/get-list.md).

      {% include [gpu-images](../../../_includes/gpu-images.md) %}

      {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

  1. Create a VM in the default folder. Specify the following parameters:

      - Name of the instance.

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      - [Availability zone](../../../overview/concepts/geo-scope.md).

      - ID of the [platform](../../concepts/vm-platforms.md), `gpu-standard-v1` for Intel Broadwell with NVIDIA Tesla V100.

      - [Number of vCPUs](../../concepts/gpus.md).

      - [RAM](../../concepts/gpus.md).

      - [Number of GPUs](../../concepts/gpus.md).

      - If necessary, make your VM [preemptible](../../concepts/preemptible-vm.md) with the `--preemptible` option.

      - [Image](../images-with-pre-installed-software/get-list.md) of the OS. `ubuntu-1604-lts-gpu`: Ubuntu 16.04.6 LTS with CUDA drivers.

      - Public IP. To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.

      For example:

      ```
      $ yc compute instance create \
            --name gpu-instance \
            --zone ru-central1-a \
            --platform-id=gpu-standard-v1 \
            --cores=8 \
            --memory=96 \
            --gpus=1 \
            --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
            --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu \
            --ssh-key ~/.ssh/id_rsa.pub
      ```

      This creates a VM named `gpu-instance` with a single GPU, 8 vCPUs, and 96 GB RAM:

      ```
      $ yc compute instance get --full gpu-instance
          ...
          name: gpu-instance
          zone_id: ru-central1-a
          platform_id: gpu-standard-v1
          resources:
            memory: "103079215104"
            cores: "8"
            core_fraction: "100"
            gpus: "1"
          status: RUNNING
          ...
      ```

- API

  To create a VM, use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

- Learn how to [change the VM configuration](../vm-control/vm-update-resources.md).

