# Запуск языковой модели DeepSeek-R1 в кластере GPU {{ compute-full-name }}



{% note info %}

Кластеры GPU сейчас доступны только в [зонах доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a` и `{{ region-id }}-d`. Добавить виртуальную машину (ВМ) в кластер GPU можно только из той же зоны доступности.

{% endnote %}


С помощью этой инструкции вы создадите [кластер GPU](../concepts/gpus.md#gpu-clusters) из двух виртуальных машин и запустите на нем языковую модель [DeepSeek-R1](https://huggingface.co/deepseek-ai/DeepSeek-R1).

Чтобы запустить языковую модель в кластере:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте кластер GPU из двух ВМ](#create-gpu-cluster).
1. [Проверьте состояние кластера](#test-cluster-state).
1. [Запустите языковую модель](#launch-llm).
1. [Проверьте работу модели](#test-llm).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Убедитесь, что в облаке достаточно [квот](../concepts/limits.md#compute-quotas) на суммарное количество кластеров GPU, GPU на платформе `Gen2`, объем RAM, vCPU и объем SSD-дисков для создания ВМ. Для проверки используйте [{{ quota-manager-full-name }}](../../quota-manager/index.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за вычислительные ресурсы ВМ и диски, а также кластер GPU (см. [тарифы {{ compute-full-name }}](../pricing.md)).

## Создайте кластер GPU из двух ВМ {#create-gpu-cluster}

### Создайте кластер GPU {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder)для создания кластера.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.gpu-cluster.action_create-cluster }}**.
   1. В поле **{{ ui-key.yacloud.gpu-cluster.field_name }}** укажите `test-gpu-cluster`.
   1. В поле **{{ ui-key.yacloud.gpu-cluster.label_zone }}** выберите `{{ region-id }}-d`.
   1. Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

{% endlist %}

### Добавьте ВМ в кластер {#add-vm}

1. Создайте первую виртуальную машину:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2).
      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите `{{ region-id }}-d`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите [тип диска](../concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}` и задайте размер `800 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите:

            * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Gen2`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}** — `8`.
            * **{{ ui-key.yacloud.component.compute.resources.field_gpu-cluster }}** — выберите ранее созданный кластер `test-gpu-cluster`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа:

            * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: `ubuntu`.
            * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
              
              Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
              
              1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
              1. Задайте имя SSH-ключа.
              1. Выберите вариант:
              
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                  * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
                  
                    При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
              
              1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
              
              SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

      1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

1. Аналогичным образом создайте вторую ВМ с точно такими же параметрами.

## Проверьте состояние кластера (опционально) {#test-cluster-state}

Вы можете дополнительно:


* [Проверить физическое состояние кластера](../operations/gpu-cluster/gpu-cluster-test-physical-state.md).
* [Запустить параллельные задачи](../operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).
* [Проверить пропускную способность сети InfiniBand](../operations/gpu-cluster/test-infiniband-bandwidth.md).



## Запустите языковую модель {#launch-llm}

1. [Подключитесь по SSH](../operations/vm-connect/ssh.md#vm-connect) к обеим виртуальным машинам.

1. Добавьте пользователя `ubuntu` в группу `docker`, выполнив на обеих ВМ:

   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

1. Скачайте образ SGLang на обе машины:

   ```bash
   docker pull lmsysorg/sglang:latest
   ```

1. На **первой ВМ** выполните команду запуска сервера (замените `<IP-адрес_1>` на внутренний IP первой машины):

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
     --nccl-init-addr <IP-адрес_1>:30000 \
     --nnodes 2 \
     --node-rank 0 \
     --trust-remote-code \
     --host 0.0.0.0 \
     --port 30001 \
     --disable-radix \
     --max-prefill-tokens 126000
   ```

1. На **второй ВМ** выполните аналогичную команду, изменив только параметр `--node-rank` на `1`:

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
     --nccl-init-addr <IP-адрес_1>:30000 \
     --nnodes 2 \
     --node-rank 1 \
     --trust-remote-code \
     --host 0.0.0.0 \
     --port 30001 \
     --disable-radix \
     --max-prefill-tokens 126000
   ```

1. Дождитесь появления сообщения об успешном старте: `The server is fired up and ready to roll!`.

## Проверьте работу языковой модели {#test-llm}

1. Откройте новую SSH-сессию к первой ВМ.

1. Установите библиотеку OpenAI:

   ```bash
   sudo apt update
   sudo apt install python3-pip -y
   pip install openai
   ```

1. Создайте скрипт `test_model.py` со следующим кодом:

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

1. Запустите скрипт:

   ```bash
   python3 test_model.py
   ```

   **Пример ожидаемого ответа:**

   ```text
   Here are three countries and their capitals:

   1. **France** - Paris
   2. **Japan** - Tokyo
   3. **Brazil** - Brasília

   Let me know if you'd like more examples! 😊
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, в сервисе {{ compute-name }}:
1. [Удалите](../operations/vm-control/vm-delete.md) созданные виртуальные машины.
1. [Удалите](../operations/gpu-cluster/gpu-cluster-delete.md) созданный кластер GPU.

#### См. также {#see-also}

[Вопросы про GPU](../qa/gpu.md).