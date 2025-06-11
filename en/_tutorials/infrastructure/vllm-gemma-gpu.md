# Running a vLLM library with the Gemma 3 language model on a {{ compute-full-name }} VM instance with a GPU


Using this tutorial, you will create a VM instance with a single GPU to run the [Gemma 3](https://huggingface.co/google/gemma-3-27b-it) lightweight multimodal language model.

To run a language model:

1. [Get your cloud ready](#prepare-cloud).
1. [Get access to the Gemma 3 model](#get-gemma3-access).
1. [Create a VM with a GPU](#create-gpu-vm).
1. [Run the language model](#launch-llm).
1. [Test the language model performance](#test-llm).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Make sure the cloud has enough [quotas](../../compute/concepts/limits#compute-quotas) for the total number of `AMD EPYC™ 9474F with Gen2` GPUs, amount of RAM, number of vCPUs, and SSD size to create the VM. To do this, use [{{ quota-manager-full-name }}](../../quota-manager/).

### Required paid resources {#paid-resources}

The infrastructure support cost includes a fee for continuously running VMs and disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Get access to the Gemma 3 model {#get-gemma3-access}

1. Sign up for [Hugging Face](https://huggingface.co/).

1. Create an access token:
   1. After logging into your account, click your avatar → **Settings** → **Access Tokens**.
   1. Click **+ Create new token**.
   1. Select the **Read** token type.
   1. Enter a token name.
   1. Click **Create token**.
   1. Copy the token value.

1. Request access to the `Gemma-3-27b-it` model:
   1. Go to the [model page](https://huggingface.co/google/gemma-3-27b-it).
   1. Click **Request access**.
   1. Accept the license terms.
   1. Wait for access confirmation.

## Create a VM with a GPU {#create-gpu-vm}

{% list tabs group=instructions %}
- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) public image.
   1. In the **{{ ui-key.yacloud.compute.instance.overview.label_zone }}** field, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select the `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}` [disk type](../../compute/concepts/disk.md#disks_types) and set the size to at least `500 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md) and number of GPUs:

         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `AMD Epyc 9474F with Gen2`.
         * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}**: `1`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

         * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `ubuntu`. Do not use `root` or other names reserved for the OS purposes. To perform operations requiring root privileges, use the `sudo` command.
         * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

## Run the language model {#launch-llm}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.

1. Add the current user to the `docker` group:

   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

1. Fill in the variables:

   ```bash
   TOKEN=<HF_token>
   MODEL=google/gemma-3-27b-it
   MODEL_OPTS="--max-num-seqs 256 --max-model-len 16384 --gpu-memory-utilization 0.98 --max_num_batched_tokens 2048"
   ```

   Where `HF_token` is the Hugging Face access token.

1. Run this command:

   ```bash
   docker run  --runtime nvidia --gpus '"device=0"' \
   --name vllm-gema3-0 \
   -v ~/.cache/huggingface:/root/.cache/huggingface \
   --env "HUGGING_FACE_HUB_TOKEN=$TOKEN" \
   --env "HF_HUB_ENABLE_HF_TRANSFER=0" \
   --env "PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True" \
   -p 8000:8000 \
   --ipc=host \
   --shm-size=32g \
   vllm/vllm-openai:latest \
   --model $MODEL $MODEL_OPTS
   ```

1. Wait for the server to start:

   ```text
   INFO:     Started server process [1]
   INFO:     Waiting for application startup.
   INFO:     Application startup complete.
   ```

## Test the language model performance {#test-llm}

1. Connect to the VM over SSH in a new session.
1. Install the `openai` package:

   ```bash
   sudo apt update
   sudo apt install python3-pip
   pip install openai
   ```

1. Create a `test_model.py` script with the following contents:

   ```python
   import openai
   client = openai.Client(base_url="http://127.0.0.1:8000/v1", api_key="EMPTY")
   response = client.chat.completions.create(
      model="google/gemma-3-27b-it",
      messages=[
         {
               "role": "user",
               "content": [
                  {
                     "type": "image_url",
                     "image_url": {
                           "url": "https://cdn.britannica.com/61/93061-050-99147DCE/Statue-of-Liberty-Island-New-York-Bay.jpg"
                     },
                  },
                  {"type": "text", "text": "Describe this image in one sentence."},
               ],
         }
      ],
      temperature=0.3,
      max_tokens=128,
   )
   print(response.choices[0].message.content)
   ```

1. Run the script:

   ```bash
   python3 test_model.py
   ```

   Model response example:

   ```text
   Here's a one-sentence description of the image:

   The Statue of Liberty stands prominently on Liberty Island with the Manhattan skyline, including the Empire State Building, visible in the background across the water on a clear, sunny day.
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) the VM instance you created in {{ compute-name }}.