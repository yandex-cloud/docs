# Запуск языковой модели DeepSeek-R1 в кластере GPU {{ compute-full-name }}



{% note info %}

Кластеры GPU сейчас доступны только в [зонах доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a` и `{{ region-id }}-d`. Добавить ВМ в кластер GPU можно только из той же зоны доступности.

{% endnote %}


С помощью этой инструкции вы создадите [кластер GPU](../../compute/concepts/gpus.md#gpu-clusters) из двух виртуальных машин и запустите в кластере языковую модель [DeepSeek-R1](https://huggingface.co/deepseek-ai/DeepSeek-R1).

Чтобы запустить языковую модель в кластере GPU:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте кластер GPU из двух ВМ](#create-gpu-cluster).
1. [Проверьте состояние кластера](#test-cluster-state).
1. [Запустите языковую модель](#launch-llm).
1. [Проверьте работу языковой модели](#test-llm).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Убедитесь, что в облаке достаточно [квот](../../compute/concepts/limits.md#compute-quotas) на суммарное количество кластеров GPU, суммарное количество GPU на платформе `AMD EPYC™ 9474F with Gen2`, объем RAM, количество vCPU и объем SSD-дисков для создания ВМ. Для этого используйте сервис [{{ quota-manager-full-name }}](../../quota-manager/).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно работающие ВМ и диски (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Создайте кластер GPU из двух ВМ {#create-gpu-cluster}

### Создайте кластер GPU

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан кластер.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.compute.gpu_clusters }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.gpu-cluster.action_create-cluster }}**.
   1. В поле **{{ ui-key.yacloud.gpu-cluster.field_name }}** задайте имя кластера: `test-gpu-cluster`.
   1. В поле **{{ ui-key.yacloud.gpu-cluster.label_zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-d`.
   1. Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

{% endlist %}

### Добавьте две ВМ в кластер

1. Создайте первую ВМ:

   {% list tabs group=instructions %}
   - Консоль управления {#console}

      1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2).
      1. В поле **{{ ui-key.yacloud.compute.instance.overview.label_zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-d`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите [тип диска](../../compute/concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}` и задайте размер `800 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество GPU и кластер:

            * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `AMD Epyc 9474F with Gen2`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}** — `8`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpu-cluster }}** — выберите ранее созданный кластер `test-gpu-cluster`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

            * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `ubuntu`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
            * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

1. Аналогично создайте вторую ВМ.

## Проверьте состояние кластера {#test-cluster-state}

Опционально вы можете:
   * [Проверить физическое состояние кластера](../../compute/operations/gpu-cluster/gpu-cluster-test-physical-state.md);
   * [Запустить параллельные задачи в кластере](../../compute/operations/gpu-cluster/gpu-cluster-mpirun-parallel.md);
   * [Проверить пропускную способность InfiniBand](../../compute/operations/gpu-cluster/test-infiniband-bandwidth.md).

## Запустите языковую модель {#launch-llm}

1. [Подключитесь по протоколу SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) к обеим ВМ.

1. Добавьте текущего пользователя в группу `docker`:

   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

1. На обе виртуальные машины скачайте образ `SGLang`:

   ```bash
   docker pull lmsysorg/sglang:latest
   ```

1. Выполните на первой ВМ команду:

   ```bash
   docker run --gpus all --device=/dev/infiniband --ulimit memlock=-1 --ulimit stack=67108864 --shm-size 32g --network=host -v ~/.cache/huggingface:/root/.cache/huggingface --name sglang_multinode1 -e GLOO_SOCKET_IFNAME=eth0 -it --rm --ipc=host lmsysorg/sglang:latest python3 -m sglang.launch_server --model-path deepseek-ai/DeepSeek-R1 --tp 16 --nccl-init-addr <IP_адрес_1>:30000 --nnodes 2 --node-rank 0 --trust-remote-code --host 0.0.0.0 --port 30001 --disable-radix --max-prefill-tokens 126000
   ```

   Где `IP_адрес_1` — внутренний IP-адрес первой ВМ.

1. Выполните на второй ВМ команду:

   ```bash
   docker run --gpus all --device=/dev/infiniband --ulimit memlock=-1 --ulimit stack=67108864 --shm-size 32g --network=host -v ~/.cache/huggingface:/root/.cache/huggingface --name sglang_multinode2 -e GLOO_SOCKET_IFNAME=eth0 -it --rm --ipc=host lmsysorg/sglang:latest python3 -m sglang.launch_server --model-path deepseek-ai/DeepSeek-R1 --tp 16 --nccl-init-addr <IP_адрес_1>:30000 --nnodes 2 --node-rank 1 --trust-remote-code --host 0.0.0.0 --port 30001 --disable-radix --max-prefill-tokens 126000
   ```

   Где `IP_адрес_1` — внутренний IP-адрес первой ВМ.

1. Подождите, пока сервер запустится:

   ```text
   The server is fired up and ready to roll!
   ```

## Проверьте работу языковой модели {#test-llm}

1. Подключитесь по протоколу SSH в новой сессии к первой ВМ.

1. Установите пакет `openai`:

   ```bash
   sudo apt update
   sudo apt install python3-pip
   pip install openai
   ```

1. Создайте скрипт `test_model.py` со следующим содержимым:

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

1. Запустите скрипт:

   ```bash
   python3 test_model.py
   ```

   Пример ответа модели:

   ```text
   Here are three countries and their capitals:

   1. **France** - Paris
   2. **Japan** - Tokyo
   3. **Brazil** - Brasília

   Let me know if you'd like more examples! 😊
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. В сервисе {{ compute-name }} [удалите](../../compute/operations/vm-control/vm-delete.md) созданные виртуальные машины.
1. В сервисе {{ compute-name }} [удалите](../../compute/operations/gpu-cluster/gpu-cluster-delete.md) созданный кластер GPU.