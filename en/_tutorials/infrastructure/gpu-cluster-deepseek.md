# Running the DeepSeek-R1 language model in a {{ compute-full-name }} GPU cluster



{% note info %}

Currently, GPU clusters are only available in the `{{ region-id }}-a` and `{{ region-id }}-d` [availability zones](../../overview/concepts/geo-scope.md). You can only add a virtual machine (VM) to a GPU cluster from the same availability zone.

{% endnote %}


In this tutorial, you will create a [GPU cluster](../../compute/concepts/gpus.md#gpu-clusters) with two VMs to run the [DeepSeek-R1](https://huggingface.co/deepseek-ai/DeepSeek-R1) language model.

To run a language model in a cluster:

1. [Get your cloud ready](#prepare-cloud).
1. [Create a GPU cluster with two VMs](#create-gpu-cluster).
1. [Test cluster state](#test-cluster-state).
1. [Run the language model](#launch-llm).
1. [Test the model](#test-llm).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Make sure the cloud has enough [quotas](../../compute/concepts/limits.md#compute-quotas) for the total number of GPU clusters, total number of `Gen2` GPUs, amount of RAM, number of vCPUs, and the SSD size to create the VMs. To check your quotas, use [{{ quota-manager-full-name }}](../../quota-manager/).

### Required paid resources {#paid-resources}

The infrastructure support cost includes a fee for VM computing resources and disks, as well as for the GPU cluster (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Create a GPU cluster with two VMs {#create-gpu-cluster}.

### Create a GPU cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your cluster in.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
   1. Click **{{ ui-key.yacloud.gpu-cluster.action_create-cluster }}**.
   1. In the **{{ ui-key.yacloud.gpu-cluster.field_name }}** field, specify `test-gpu-cluster`.
   1. In the **{{ ui-key.yacloud.gpu-cluster.label_zone }}** field, select `{{ region-id }}-d`.
   1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

{% endlist %}

### Add your VM to a cluster {#add-vm}

1. Create your first VM:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) public image.
      1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select `{{ region-id }}-d`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select the `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}` [disk type](../../compute/concepts/disk.md#disks_types) and specify its size: `800 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify:

            * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Gen2`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}**: `8`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpu-cluster }}**: Select the `test-gpu-cluster` cluster you created earlier.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the access credentials:

            * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ubuntu`.
            * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

1. Similarly, create a second VM with the same settings.

## Optionally, check the cluster state {#test-cluster-state}

Also, you can:


* [Test the cluster physical state](../../compute/operations/gpu-cluster/gpu-cluster-test-physical-state.md).
* [Run parallel jobs](../../compute/operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).
* [Test InfiniBand throughput](../../compute/operations/gpu-cluster/test-infiniband-bandwidth.md).



## Run the language model {#launch-llm}

1. [Connect to both VMs over SSH](../../compute/operations/vm-connect/ssh.md#vm-connect).

1. Add the `ubuntu` user to the `docker` group by running these commands on both VMs:

   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

1. Pull the `SGLang` image to both VMs:

   ```bash
   docker pull lmsysorg/sglang:latest
   ```

1. On **the first VM**, run the server start command (replace `<IP_address_1>` with the first VM's internal IP):

   ```bash
   docker run --gpus all \
     --device=/dev/infiniband \
     --ulimit memlock=-1 \
     --ulimit stack=67108864 \
     --shm-size 32g \
     --network=host \
     -v ~/.cache/huggingface:/root/.cache/huggingface \
     --name sglang_multinode1 \
     -e GLOO_SOCKET_IFNAME=eth0 \
     -it --rm --ipc=host lmsysorg/sglang:latest \
     python3 -m sglang.launch_server \
     --model-path deepseek-ai/DeepSeek-R1 \
     --tp 16 \
     --nccl-init-addr <IP_address_1>:30000 \
     --nnodes 2 \
     --node-rank 0 \
     --trust-remote-code \
     --host 0.0.0.0 \
     --port 30001 \
     --disable-radix \
     --max-prefill-tokens 126000
   ```

1. On **the second VM**, run the same command with `--node-rank` set to `1`:

   ```bash
   docker run --gpus all \
     --device=/dev/infiniband \
     --ulimit memlock=-1 \
     --ulimit stack=67108864 \
     --shm-size 32g \
     --network=host \
     -v ~/.cache/huggingface:/root/.cache/huggingface \
     --name sglang_multinode2 \
     -e GLOO_SOCKET_IFNAME=eth0 \
     -it --rm --ipc=host lmsysorg/sglang:latest \
     python3 -m sglang.launch_server \
     --model-path deepseek-ai/DeepSeek-R1 \
     --tp 16 \
     --nccl-init-addr <IP_address_1>:30000 \
     --nnodes 2 \
     --node-rank 1 \
     --trust-remote-code \
     --host 0.0.0.0 \
     --port 30001 \
     --disable-radix \
     --max-prefill-tokens 126000
   ```

1. Wait for the message saying your start was successful: `The server is fired up and ready to roll!`.

## Test the language model performance {#test-llm}

1. Open a new SSH session to the first VM.

1. Install the OpenAI library:

   ```bash
   sudo apt update
   sudo apt install python3-pip -y
   pip install openai
   ```

1. Create a script named `test_model.py` with this code:

   ```python
   import openai

   client = openai.Client(
      base_url="http://127.0.0.1:30001/v1",
      api_key="EMPTY"
   )

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

   **Sample response:**

   ```text
   Here are three countries and their capitals:

   1. **France** - Paris
   2. **Japan** - Tokyo
   3. **Brazil** - Brasília

   Let me know if you'd like more examples! 😊
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, in {{ compute-name }}:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VMs you created.
1. [Delete](../../compute/operations/gpu-cluster/gpu-cluster-delete.md) the GPU cluster you created.

#### See also {#see-also}

[Questions about GPUs](../../compute/qa/gpu.md)
