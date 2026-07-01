# Запуск библиотеки vLLM с языковой моделью Gemma 3 на виртуальной машине с GPU в Yandex Compute Cloud


С помощью этой инструкции вы создадите виртуальную машину с одним GPU и запустите на ней легковесную мультимодальную языковую модель [Gemma 3](https://huggingface.co/google/gemma-3-27b-it).

Чтобы запустить языковую модель:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Получите доступ к модели Gemma 3](#get-gemma3-access).
1. [Создайте виртуальную машину с GPU](#create-gpu-vm).
1. [Запустите языковую модель](#launch-llm).
1. [Проверьте работу языковой модели](#test-llm).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

Убедитесь, что в облаке достаточно [квот](../../compute/concepts/limits.md#compute-quotas) на суммарное количество GPU на платформе `Gen2`, объем RAM, количество vCPU и объем SSD-дисков для создания ВМ. Для этого используйте сервис [Yandex Cloud Quota Manager](../../quota-manager/index.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за постоянно работающие ВМ и диски ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).

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

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана виртуальная машина.
   1. Перейдите в сервис **Compute Cloud**.
   1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
   1. Нажмите кнопку **Создать виртуальную машину**.
   1. В блоке **Образ загрузочного диска** выберите публичный образ [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2).
   1. В поле **Зона доступности** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
   1. В блоке **Диски и файловые хранилища** выберите [тип диска](../../compute/concepts/disk.md#disks_types) `SSD` и задайте размер не менее `500 ГБ`.
   1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md) и количество GPU:

         * **Платформа** — `Gen2`.
         * **GPU** — `1`.
   1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

         * В поле **Логин** введите имя пользователя, например: `ubuntu`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
         * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
           
           Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
           
           1. Нажмите кнопку **Добавить ключ**.
           1. Задайте имя SSH-ключа.
           1. Выберите вариант:
           
               * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
               * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
               * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
               
                 При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
           
           1. Нажмите кнопку **Добавить**.
           
           SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

   1. Нажмите **Создать ВМ**.

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

Чтобы перестать платить за созданные ресурсы, в сервисе Compute Cloud [удалите](../../compute/operations/vm-control/vm-delete.md) созданную виртуальную машину.

#### Полезные ссылки {#see-also}

* [Вопросы про GPU](../../compute/qa/gpu.md).