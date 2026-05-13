# Запуск языковой модели DeepSeek-R1 в кластере GPU Yandex Compute Cloud



{% note info %}

Кластеры GPU сейчас доступны только в [зонах доступности](../../overview/concepts/geo-scope.md) `ru-central1-a` и `ru-central1-d`. Добавить ВМ в кластер GPU можно только из той же зоны доступности.

{% endnote %}


С помощью этой инструкции вы создадите [кластер GPU](../concepts/gpus.md#gpu-clusters) из двух виртуальных машин и запустите в кластере языковую модель [DeepSeek-R1](https://huggingface.co/deepseek-ai/DeepSeek-R1).

Чтобы запустить языковую модель в кластере GPU:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте кластер GPU из двух ВМ](#create-gpu-cluster).
1. [Проверьте состояние кластера](#test-cluster-state).
1. [Запустите языковую модель](#launch-llm).
1. [Проверьте работу языковой модели](#test-llm).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Убедитесь, что в облаке достаточно [квот](../concepts/limits.md#compute-quotas) на суммарное количество кластеров GPU, суммарное количество GPU на платформе `Gen2`, объем RAM, количество vCPU и объем SSD-дисков для создания ВМ. Для этого используйте сервис [Yandex Cloud Quota Manager](../../quota-manager/index.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно работающие ВМ и диски (см. [тарифы Yandex Compute Cloud](../pricing.md)).

## Создайте кластер GPU из двух ВМ {#create-gpu-cluster}

### Создайте кластер GPU

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан кластер.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
   1. На панели слева выберите ![image](../../_assets/console-icons/cpus.svg) **Кластеры GPU**.
   1. Нажмите кнопку **Создать кластер GPU**.
   1. В поле **Имя** задайте имя кластера: `test-gpu-cluster`.
   1. В поле **Зона доступности** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
   1. Нажмите **Сохранить**.

{% endlist %}

### Добавьте две ВМ в кластер

1. Создайте первую ВМ:

   {% list tabs group=instructions %}
   - Консоль управления {#console}

      1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
      1. Нажмите кнопку **Создать виртуальную машину**.
      1. В блоке **Образ загрузочного диска** выберите публичный образ [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2).
      1. В поле **Зона доступности** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
      1. В блоке **Диски и файловые хранилища** выберите [тип диска](../concepts/disk.md#disks_types) `SSD` и задайте размер `800 ГБ`.
      1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../concepts/vm-platforms.md), количество GPU и кластер:

            * **Платформа** — `Gen2`.
            * **GPU** — `8`.
            * **Кластер GPU** — выберите ранее созданный кластер `test-gpu-cluster`.
      1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

            * В поле **Логин** введите имя пользователя, например: `ubuntu`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
            * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
              
              Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
              
              1. Нажмите кнопку **Добавить ключ**.
              1. Задайте имя SSH-ключа.
              1. Выберите вариант:
              
                  * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
                  * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
                  * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
                  
                    При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
              
              1. Нажмите кнопку **Добавить**.
              
              SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

      1. Нажмите **Создать ВМ**.

   {% endlist %}

1. Аналогично создайте вторую ВМ.

## Проверьте состояние кластера {#test-cluster-state}

Опционально вы можете:


* [Проверить физическое состояние кластера](../operations/gpu-cluster/gpu-cluster-test-physical-state.md).
* [Запустить параллельные задачи в кластере](../operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).
* [Проверить пропускную способность InfiniBand](../operations/gpu-cluster/test-infiniband-bandwidth.md).


## Запустите языковую модель {#launch-llm}

1. [Подключитесь по протоколу SSH](../operations/vm-connect/ssh.md#vm-connect) к обеим ВМ.

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
1. В сервисе Compute Cloud [удалите](../operations/vm-control/vm-delete.md) созданные виртуальные машины.
1. В сервисе Compute Cloud [удалите](../operations/gpu-cluster/gpu-cluster-delete.md) созданный кластер GPU.

#### См. также {#see-also}

* [Вопросы про GPU](../qa/gpu.md).