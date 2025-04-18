# Launching the DeepSeek-R1 language model in a {{ compute-full-name }} GPU cluster



{% note info %}

Currently, GPU clusters are only available in the `{{ region-id }}-a` and `{{ region-id }}-d` [availability zones](../../overview/concepts/geo-scope.md). You can only add a VM to a GPU cluster from the same availability zone.

{% endnote %}


In this tutorial, you will create a [GPU cluster](../../compute/concepts/gpus.md#gpu-clusters) with two VMs to run the [DeepSeek-R1](https://huggingface.co/deepseek-ai/DeepSeek-R1) language model.

To run a language model in a GPU cluster:

1. [Get your cloud ready](#prepare-cloud).
1. [Create a GPU cluster with two VMs](#create-gpu-cluster).
1. [Test cluster state](#test-cluster-state).
1. [Run the language model](#launch-llm).
1. [Test the language model performance](#test-llm).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for continuously running VMs and disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Create a GPU cluster with two VMs {#create-gpu-cluster}.

### Create a GPU cluster

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a cluster.
   1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.compute.gpu_clusters }}**.
   1. Click **{{ ui-key.yacloud.gpu-cluster.action_create-cluster }}**.
   1. In the **{{ ui-key.yacloud.gpu-cluster.field_name }}** field, enter cluster name: `test-gpu-cluster`.
   1. In the **{{ ui-key.yacloud.gpu-cluster.label_zone }}** field, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
   1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

{% endlist %}

### Add two VMs to the cluster

1. Create the first VM:

   {% list tabs group=instructions %}
   - Management console {#console}

      1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
      1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) public image.
      1. In the **{{ ui-key.yacloud.compute.instance.overview.label_zone }}** field, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select the `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}` [disk type](../../compute/concepts/disk.md#disks_types) and specify its size: `800 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of GPUs, and cluster:

            * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `AMD Epyc 9474F with Gen2`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}**: `8`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpu-cluster }}**: Select the previously created `test-gpu-cluster` cluster.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

            * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `ubuntu`. Do not use `root` or other names reserved for the OS purposes. To perform operations requiring root privileges, use the `sudo` command.
            * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

1. Similarly, create the second VM.

## Test cluster state {#test-cluster-state}

Optionally, you can:
   * [Test cluster physical state](../../compute/operations/gpu-cluster/gpu-cluster-test-physical-state.md).
   * [Run parallel jobs in the cluster](../../compute/operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).
   * [Test InfiniBand throughput](../../compute/operations/gpu-cluster/test-infiniband-bandwidth.md).

## Run the language model {#launch-llm}

1. [Connect to both VMs over SSH](../../compute/operations/vm-connect/ssh.md#vm-connect).

1. Add the current user to the `docker` group:

   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

1. Pull the `SGLang` image to both VMs:

   ```bash
   docker pull lmsysorg/sglang:latest
   ```

1. Run this command on the first VM:

   ```bash
   docker run --gpus all --device=/dev/infiniband --ulimit memlock=-1 --ulimit stack=67108864 --shm-size 32g --network=host -v ~/.cache/huggingface:/root/.cache/huggingface --name sglang_multinode1 -e GLOO_SOCKET_IFNAME=eth0 -it --rm --ipc=host lmsysorg/sglang:latest python3 -m sglang.launch_server --model-path deepseek-ai/DeepSeek-R1 --tp 16 --nccl-init-addr <IP_address_1>:30000 --nnodes 2 --node-rank 0 --trust-remote-code --host 0.0.0.0 --port 30001 --disable-radix --max-prefill-tokens 126000
   ```

   Where `IP_address_1` is the first VM internal IP address.

1. Run this command on the second VM:

   ```bash
   docker run --gpus all --device=/dev/infiniband --ulimit memlock=-1 --ulimit stack=67108864 --shm-size 32g --network=host -v ~/.cache/huggingface:/root/.cache/huggingface --name sglang_multinode2 -e GLOO_SOCKET_IFNAME=eth0 -it --rm --ipc=host lmsysorg/sglang:latest python3 -m sglang.launch_server --model-path deepseek-ai/DeepSeek-R1 --tp 16 --nccl-init-addr <IP_address_1>:30000 --nnodes 2 --node-rank 1 --trust-remote-code --host 0.0.0.0 --port 30001 --disable-radix --max-prefill-tokens 126000
   ```

   Where `IP_address_1` is the first VM internal IP address.

1. Wait for the server to start:

   ```text
   The server is fired up and ready to roll!
   ```

## Test the language model performance {#test-llm}

1. In a new session, connect to the first VM over SSH.

1. Install the `openai` package:

   ```bash
   sudo apt update
   sudo apt install python3-pip
   pip install openai
   ```

1. Create a `test_model.py` script with the following contents:

   ```python
   import openai
   client = openai.Client(
      base_url="http://127.0.0.1:30001/v1", api_key="EMPTY")

   response = client.chat.completions.create(
      model="default",
      messages=[
         {"role": "system", "content": "You are a helpful AI assistant"},
         {"role": "user", "content": "List 3 countries and their capitals."},
      ],
      temperature=0.3,
      max_tokens=1024,
   )
   print(response.choices[0].message.content)
   ```

1. Run the script:

   ```bash
   python3 test_model.py
   ```

   Model response example:

   ```text
   Here are three countries and their capitals:

   1. **France** - Paris
   2. **Japan** - Tokyo
   3. **Brazil** - Brasília

   Let me know if you'd like more examples! 😊
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM instances in {{ compute-name }}.
1. [Delete](../../compute/operations/gpu-cluster/gpu-cluster-delete.md) the GPU cluster in {{ compute-name }}.