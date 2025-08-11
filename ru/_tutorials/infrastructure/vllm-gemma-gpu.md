# Запуск библиотеки vLLM с языковой моделью Gemma 3 на виртуальной машине с GPU в {{ compute-full-name }}


С помощью этой инструкции вы создадите виртуальную машину с одним GPU и запустите на ней легковесную мультимодальную языковую модель [Gemma 3](https://huggingface.co/google/gemma-3-27b-it).

Чтобы запустить языковую модель:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Получите доступ к модели Gemma 3](#get-gemma3-access).
1. [Создайте виртуальную машину с GPU](#create-gpu-vm).
1. [Запустите языковую модель](#launch-llm).
1. [Проверьте работу языковой модели](#test-llm).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Убедитесь, что в облаке достаточно [квот](../../compute/concepts/limits#compute-quotas) на суммарное количество GPU на платформе `AMD EPYC™ 9474F with Gen2`, объем RAM, количество vCPU и объем SSD-дисков для создания ВМ. Для этого используйте сервис [{{ quota-manager-full-name }}](../../quota-manager/).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за постоянно работающие ВМ и диски (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Получите доступ к модели Gemma 3 {#get-gemma3-access}

1. Зарегистрируйтесь на [Hugging Face](https://huggingface.co/).

1. Создайте токен доступа:
   1. После входа в аккаунт нажмите на свой аватар → **Settings** → **Access Tokens**.
   1. Нажмите **+ Create new token**.
   1. Выберите тип токена **Read**.
   1. Введите имя токена.
   1. Нажмите **Create token**.
   1. Скопируйте значение токена.

1. Запросите доступ к модели `Gemma-3-27b-it`:
   1. Перейдите на [страницу модели](https://huggingface.co/google/gemma-3-27b-it).
   1. Нажмите **Request access**.
   1. Примите условия лицензии.
   1. Дождитесь подтверждения доступа.

## Создайте виртуальную машину с GPU {#create-gpu-vm}

{% list tabs group=instructions %}
- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана виртуальная машина.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2).
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-d`.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите [тип диска](../../compute/concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}` и задайте размер не менее `500 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md) и количество GPU:

         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `AMD Epyc 9474F with Gen2`.
         * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}** — `1`.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

         * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `ubuntu`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
         * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

   1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

## Запустите языковую модель {#launch-llm}

1. [Подключитесь по протоколу SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине.

1. Добавьте текущего пользователя в группу `docker`:

   ```bash
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp docker
   ```

1. Заполните переменные:

   ```bash
   TOKEN=<HF_токен>
   MODEL=google/gemma-3-27b-it
   MODEL_OPTS="--max-num-seqs 256 --max-model-len 16384 --gpu-memory-utilization 0.98 --max_num_batched_tokens 2048"
   ```

   Где `HF_токен` — токен доступа Hugging Face.

1. Выполните команду:

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

1. Подождите, пока сервер запустится:

   ```text
   INFO:     Started server process [1]
   INFO:     Waiting for application startup.
   INFO:     Application startup complete.
   ```

## Проверьте работу языковой модели {#test-llm}

1. Подключитесь к виртуальной машине по протоколу SSH в новой сессии.
1. Установите пакет `openai`:

   ```bash
   sudo apt update
   sudo apt install python3-pip
   pip install openai
   ```

1. Создайте скрипт `test_model.py` со следующим содержимым:

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

1. Запустите скрипт:

   ```bash
   python3 test_model.py
   ```

   Пример ответа модели:

   ```text
   Here's a one-sentence description of the image:

   The Statue of Liberty stands prominently on Liberty Island with the Manhattan skyline, including the Empire State Building, visible in the background across the water on a clear, sunny day.
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, в сервисе {{ compute-name }} [удалите](../../compute/operations/vm-control/vm-delete.md) созданную виртуальную машину.