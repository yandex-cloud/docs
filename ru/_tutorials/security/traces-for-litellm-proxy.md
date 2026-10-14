# Интеграция LiteLLM Proxy с {{ ai-studio-full-name }} и {{ traces-name }}

[LiteLLM Proxy](https://docs.litellm.ai/docs/providers/litellm_proxy) — прокси-сервер для работы с LLM-провайдерами через единый интерфейс, совместимый с [OpenAI API](https://openai.com/api/).

LiteLLM Proxy удобен для работы с несколькими моделями, поскольку позволяет централизованно управлять доступом приложений, ограничивать частоту запросов, учитывать расходы и формировать трейсы для анализа выполнения запросов.

Отслеживать выполнение запросов можно через систему распределенной трассировки [{{ traces-name }}](../../monium/traces/index.md). Трейс объединяет данные об отдельных операциях: их последовательности, длительности и ошибках.

Трейсы помогают:

* Определить, на каком этапе, в каком сервисе или компоненте приложения возник сбой или задержка.
* Анализировать промпты, ответы модели и расход токенов. Например, какой контекст получила модель, сколько времени заняла генерация и сколько токенов использовано в запросе и ответе.

Интеграция LiteLLM Proxy с системой трассировки позволяет собирать эти данные на стороне прокси-сервера без добавления кода отправки телеметрии в приложение.

В этом руководстве вы развернете LiteLLM Proxy и настроите передачу трейсов в {{ traces-name }} с помощью встроенной интеграции [OpenTelemetry v2](https://docs.litellm.ai/docs/observability/opentelemetry_v2). Затем вы запустите тестовое приложение, которое имитирует диалог пользователя с [моделью]({{ link-docs-ai }}ai-studio/concepts/generation/models) DeepSeek V4 Flash в [{{ ai-studio-full-name }}]({{ link-docs-ai }}) через LiteLLM Proxy, и просмотрите полученные трейсы.

{% include [traces-for-litellm-proxy](../../_mermaid/other/monium/traces-for-litellm-proxy.md) %}

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки решения входят:

* Вычислительные ресурсы виртуальной машины и диск ([тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Публичный IP-адрес и исходящий трафик ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Генерация текста ([тарифы {{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/pricing)).
* Запись трейсов в {{ traces-name }} ([тарифы {{ monium-full-name }}](../../monium/pricing.md)).

## Порядок действий {#procedure}

1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните и настройте экземпляр LiteLLM Proxy](#deploy-litellm-proxy).
1. [Отправьте запросы к модели и проверьте трейсы](#test-integration).

Если вы развернули систему только для знакомства с решением, после завершения работы можно [удалить созданные ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}


Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице [{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }}) убедитесь, что у вас подключен платежный аккаунт и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).



### Подготовьте окружение {#prepare}

[Создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину из публичного образа [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin).

{% note warning %}

При создании ВМ укажите объем оперативной памяти не менее 4 ГБ.

{% endnote %}


### Создайте API-ключи {#create-api-keys}

Чтобы LiteLLM Proxy мог обращаться к модели {{ ai-studio-full-name }} и передавать трейсы в {{ traces-name }}, создайте два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md) с [API-ключами](../../iam/concepts/authorization/api-key.md) — по одному для каждого сервиса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте сервисный аккаунт для доступа LiteLLM Proxy к {{ ai-studio-full-name }}:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
      1. [Перейдите]({{ link-console-main }}/link/iam) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. В открывшемся окне введите имя сервисного аккаунта `litellm-ai-studio-sa`.
      1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_roles }}** нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль]({{ link-docs-ai }}ai-studio/security/#languageModels-user) `ai.languageModels.user`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Создайте API-ключ для доступа LiteLLM Proxy к {{ ai-studio-full-name }}:

      1. В открывшемся списке сервисных аккаунтов выберите сервисный аккаунт `litellm-ai-studio-sa`.
      1. В верхней части страницы нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** → **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
      1. В открывшемся окне выберите [область действия](*key_scope_definition) `yc.ai.languageModels.execute` и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Сохраните секретную часть API-ключа. После закрытия диалогового окна она будет недоступна.
  1. Аналогично создайте сервисный аккаунт и API-ключ для доступа LiteLLM Proxy к {{ monium-full-name }} со следующими параметрами:

      * Имя сервисного аккаунта — `litellm-monium-sa`.
      * [Роль](../../monium/security/index.md#monium-traces-writer) — `monium.traces.writer`.
      * Область действия API-ключа — `yc.monium.traces.write`.

{% endlist %}


## Разверните и настройте экземпляр LiteLLM Proxy {#deploy-litellm-proxy}

Чтобы развернуть LiteLLM Proxy на [созданной виртуальной машине](#prepare), установите Docker, подготовьте файлы конфигурации и запустите контейнер:

1. Подключитесь к виртуальной машине [по SSH](../../compute/operations/vm-connect/ssh.md) или [через {{ oslogin }}](../../compute/operations/vm-connect/os-login.md) в зависимости от способа подключения, выбранного при ее создании.
1. Установите и настройте Docker:

    1. Установите необходимые зависимости:

        ```bash
        sudo apt update
        sudo apt install ca-certificates curl gnupg
        ```
    1. Установите [GPG](https://www.gnupg.org/)-ключ Docker:

        ```bash
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        ```
    1. Добавьте репозиторий Docker в список источников пакетов `apt`:

        ```bash
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        ```
    1. Установите Docker:

        ```bash
        sudo apt update
        sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        ```
    1. Добавьте текущего пользователя в группу `docker` и запустите новую оболочку, чтобы применить изменения:

        ```bash
        sudo usermod -aG docker $USER
        newgrp docker
        ```
    1. Убедитесь, что Docker установлен и работает:

        ```bash
        docker run hello-world
        ```

        Результат:

        ```text
        Unable to find image 'hello-world:latest' locally
        latest: Pulling from library/hello-world
        4f55086f7dd0: Pull complete 
        d5e71e642bf5: Download complete 
        Digest: sha256:5e23090353324d887c48ad5e5c56d294eab81588df9605b07d1afe89********
        Status: Downloaded newer image for hello-world:latest

        Hello from Docker!
        This message shows that your installation appears to be working correctly.
        ...
        ```
1. В домашней директории создайте директорию для проекта Docker Compose и перейдите в нее:

    ```bash
    mkdir ~/litellm-proxy && cd ~/litellm-proxy
    ```
1. Создайте файлы, необходимые для работы проекта:

    ```bash
    touch .env
    touch config.yaml
    touch docker-compose.yaml
    ```
1. В текстовом редакторе откройте файл `.env`:

    ```bash
    nano .env
    ```
1. Добавьте в файл `.env` переменные окружения, необходимые для работы проекта:

    ```text
    YANDEX_AI_STUDIO_API_KEY=<секретная_часть_ключа_ai_studio>
    MONIUM_API_KEY=<секретная_часть_ключа_monium>
    MONIUM_PROJECT=folder__<идентификатор_каталога>
    LITELLM_MASTER_KEY=sk-local-litellm
    ```

    Где:

    * `YANDEX_AI_STUDIO_API_KEY` — секретная часть API-ключа сервисного аккаунта `litellm-ai-studio-sa`.
    * `MONIUM_API_KEY` — секретная часть API-ключа сервисного аккаунта `litellm-monium-sa`.
    * `MONIUM_PROJECT` — идентификатор проекта {{ monium-name }}. Он состоит из префикса `folder__` и идентификатора каталога, в котором созданы ВМ и сервисные аккаунты. Например: `folder__b1gt6g8ht345********`.
    * `LITELLM_MASTER_KEY` — ключ для доступа приложений к LiteLLM Proxy. Вы задаете его в файле `.env`, чтобы прокси проверял ключ в поступающих запросах. Для выполнения руководства оставьте значение `sk-local-litellm`: оно уже предусмотрено в коде тестового приложения `agent_example.py`, которое вы создадите на следующем этапе.

        {% note tip %}

        Для рабочей среды сгенерируйте случайную строку командой `openssl rand -hex 32` и добавьте к ней префикс `sk-`.

        Если вы изменили `LITELLM_MASTER_KEY` в `.env` после запуска контейнера, пересоздайте контейнер командой `docker compose up -d --force-recreate`. При использовании собственного ключа перед запуском тестового приложения `agent_example.py` задайте такое же значение в переменной окружения `LITELLM_PROXY_KEY` в терминале, из которого будете запускать приложение:

        ```bash
        export LITELLM_PROXY_KEY='<ключ_из_файла_env>'
        ```

        Библиотека `openai` в тестовом приложении автоматически передаст этот ключ в заголовке `Authorization` со схемой `Bearer`. Значение в заголовке должно совпадать с ключом, заданным для прокси в `.env`.

        {% endnote %}

1. В текстовом редакторе откройте файл `config.yaml`:

    ```bash
    nano config.yaml
    ```
1. Добавьте в файл `config.yaml` конфигурацию LiteLLM Proxy:

    ```yaml
    # LiteLLM proxy: Yandex AI Studio (OpenAI-compatible) → traces to {{ monium-full-name }}.
    # Model URI: gpt://<идентификатор_каталога>/deepseek-v4-flash

    model_list:
      - model_name: deepseek-v4-flash
        litellm_params:
          model: openai/gpt://<идентификатор_каталога>/deepseek-v4-flash
          api_base: https://{{ api-host-llm }}/v1
          api_key: os.environ/YANDEX_AI_STUDIO_API_KEY

    litellm_settings:
      drop_params: true
      set_verbose: false
      # Both this callback and LITELLM_OTEL_V2=true are required.
      callbacks:
        - otel

    general_settings:
      master_key: os.environ/LITELLM_MASTER_KEY
    ```

    Где `model` — идентификатор модели в LiteLLM: префикс `openai/` и URI модели {{ ai-studio-full-name }}, содержащий [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Например: `openai/gpt://b1gt6g8ht345********/deepseek-v4-flash`.

    Префикс `os.environ/` указывает, что значение параметра нужно получить из соответствующей переменной окружения.
1. В текстовом редакторе откройте файл `docker-compose.yaml`:

    ```bash
    nano docker-compose.yaml
    ```
1. Добавьте в файл `docker-compose.yaml` конфигурацию проекта Docker Compose:

    ```yaml
    services:
      litellm:
        image: docker.litellm.ai/berriai/litellm:main-latest
        container_name: litellm-proxy
        restart: unless-stopped
        # Host network: on this class of host net.ipv4.ip_forward=0 and bridge NAT drops connections.
        network_mode: host
        volumes:
          - ./config.yaml:/app/config.yaml:ro
        environment:
          - LITELLM_OTEL_V2=true
          - OTEL_EXPORTER=otlp_http
          - OTEL_ENDPOINT=https://{{ api-host-monium }}/otlp
          - OTEL_SERVICE_NAME=litellm-proxy
          - OTEL_ENVIRONMENT_NAME=local
          - OTEL_HEADERS=Authorization=Api-Key ${MONIUM_API_KEY:?MONIUM_API_KEY},x-monium-project=${MONIUM_PROJECT:?MONIUM_PROJECT},x-monium-cluster=${MONIUM_CLUSTER:-default},x-monium-service=litellm-proxy
          - OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=span_only
          - YANDEX_AI_STUDIO_API_KEY=${YANDEX_AI_STUDIO_API_KEY:?YANDEX_AI_STUDIO_API_KEY}
          - LITELLM_MASTER_KEY=${LITELLM_MASTER_KEY:-sk-local-litellm}
        command:
          - --config
          - /app/config.yaml
          - --port
          - "4000"
          - --host
          - "0.0.0.0"
    ```

    Параметры конфигурации:

    * `environment` — переменные окружения:

        * `OTEL_EXPORTER=otlp_http` — задает отправку трейсов по протоколу OTLP через HTTP.
        * `OTEL_ENDPOINT=https://{{ api-host-monium }}/otlp` — задает базовый адрес эндпоинта. LiteLLM Proxy добавляет к нему `/v1/traces` и отправляет трейсы на `https://{{ api-host-monium }}/otlp/v1/traces`.
        * `x-monium-service=litellm-proxy` — имя, которое будет присвоено сервису в интерфейсе {{ monium-name }}.
        * `OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=span_only` — включает запись текстов запросов и ответов модели в [спаны](*span_definition).
    * `network_mode: host` — запускает контейнер в сети хоста.

        Это позволяет контейнеру обращаться к {{ ai-studio-full-name }} и {{ monium-full-name }}, даже если на хосте отключена пересылка IP-пакетов (`net.ipv4.ip_forward = 0`). LiteLLM Proxy принимает подключения на порте `4000` виртуальной машины.
1. Запустите контейнер:

    ```bash
    docker compose up -d
    ```

    Результат:

    ```text
    [+] up 27/27
    ✔ Image docker.litellm.ai/berriai/litellm:main-latest Pulled                                                      82.4s
    ✔ Container litellm-proxy                             Started                                                     43.1s
    ```
1. Чтобы проверить, что LiteLLM Proxy готов принимать запросы, выполните команду в терминале виртуальной машины:

    ```bash
    for _ in $(seq 1 30); do
      curl -sf http://127.0.0.1:4000/health/liveliness >/dev/null && echo "proxy is up" && break
      sleep 1
    done
    ```

    Результат:

    ```text
    proxy is up
    ```

## Отправьте запросы к модели и проверьте трейсы {#test-integration}

Чтобы проверить передачу трейсов, создайте и запустите тестовое приложение на той же ВМ, где работает LiteLLM Proxy. Приложение отправит запросы к модели через прокси, а прокси передаст трейсы в {{ traces-name }}. Затем найдите эти трейсы в интерфейсе {{ monium-name }} и просмотрите данные о выполнении запросов.

### Создайте и запустите тестовое приложение {#run-sample-application}

Тестовое приложение на языке Python имитирует диалог покупателя с агентом службы поддержки. Для отправки запросов к модели через LiteLLM Proxy оно использует библиотеку `openai`. Установите ее в отдельное виртуальное окружение, чтобы изолировать зависимости приложения.

Чтобы создать и запустить приложение:

1. Перейдите в директорию `~/litellm-proxy`, созданную при развертывании LiteLLM Proxy на виртуальной машине:

    ```bash
    cd ~/litellm-proxy
    ```
1. Установите Python и модуль `venv` для работы с виртуальными окружениями:

    ```bash
    sudo apt install python3 python3.12-venv
    ```
1. Создайте и активируйте виртуальное окружение `litellm-venv`:

    ```bash
    python3 -m venv ~/litellm-venv
    source ~/litellm-venv/bin/activate
    ```
1. Установите библиотеку `openai`:

    ```bash
    pip install 'openai==2.54.0'
    ```
1. Создайте и откройте в текстовом редакторе файл тестового приложения `agent_example.py`:

    ```bash
    touch agent_example.py
    nano agent_example.py
    ```
1. Добавьте в файл `agent_example.py` следующий код:

    {% cut "Код приложения" %}

    {% include [api-key-scope](../_tutorials_includes/traces-for-litellm-proxy-app-code.md) %}

    {% endcut %}

    Приложение последовательно отправляет модели через локальный LiteLLM Proxy пять сообщений покупателя: вопрос о доставке, вопрос о статусе заказа, вопрос о правилах возврата товара, просьбу вернуть деньги и сообщение с двумя вопросами — о гарантии и сбросе пароля.

    Для подготовки ответа модель может запросить вызов инструмента: поиск в локальной базе знаний, проверку статуса заказа или возврат денег. Приложение выполняет этот вызов и передает результат модели через прокси в следующем запросе. Проверка статуса заказа и возврат денег имитируются в коде приложения.

    Число запросов зависит от того, какие инструменты вызовет модель. Например, при проверке статуса заказа первый запрос позволяет модели выбрать инструмент, а второй передает ей результат проверки для подготовки ответа покупателю. Для каждого запроса LiteLLM Proxy формирует отдельный трейс и передает его в {{ traces-name }}. Само приложение телеметрию не отправляет.

1. Запустите тестовое приложение:

    ```bash
    python3 agent_example.py
    ```

    Результат:

    ```text
    Customer Support Agent (LiteLLM proxy demo)
    ============================================================
    Proxy model: deepseek-v4-flash
    Turns: 5
    ...
    [1/5] You: Hi! I need express shipping info for an order I'm about to place.
      [tool] search_knowledge_base -> Express shipping takes 2-3 business days and costs $12.99
    Agent: Great news! Here's the express shipping information:
    ...
    ...
    Demo finished.
    ```

### Найдите и просмотрите трейсы в {{ monium-name }} {#check-traces}

Чтобы найти трейсы запросов тестового приложения:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в сервис {{ monium-name }}.
  1. На панели слева выберите ![cube](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.llm-monitoring.title }}**.
  1. Выберите на шкале времени в верхней части экрана период, когда вы запускали тестовое приложение.
  1. В правом верхнем углу строки запроса нажмите значок ![code](../../_assets/console-icons/code.svg) и введите фильтр:

      ```text
      {project = "folder__<идентификатор_каталога>", service = "litellm-proxy"}
      ```

      Где `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы [ранее](#create-api-keys) создали сервисные аккаунты.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.llm-tracing.search.actions.execute }}**.

{% endlist %}

В результатах поиска появятся трейсы запросов тестового приложения. Чтобы просмотреть все операции в трейсе, нажмите на строку с ним, затем — **Показать полный трейс**.

В открывшемся трейсе будут представлены следующие спаны:

* `POST /v1/chat/completions` — HTTP-запрос к LiteLLM Proxy.
* `auth /v1/chat/completions` — проверка ключа доступа к LiteLLM Proxy.
* `chat gpt://<идентификатор_каталога>/deepseek-v4-flash` — вызов модели. Спан содержит имя модели, количество входных и выходных токенов, тексты сообщений.

Если модель запросила вызовы инструментов, спан модели содержит их имена (`search_knowledge_base`, `get_order_status` или `process_refund`) и аргументы вызовов.

Приложение сохраняет историю диалога и передает ее в последующих запросах, поэтому контекст в следующих трейсах становится длиннее.

Подробнее о просмотре трейсов в разделе [{#T}](../../monium/traces/llm/traces.md).


### Решение проблем {#troubleshooting}

#|
|| **Проблема** | **Решение** ||
|| Ошибка соединения (`Error: Connection error`) |
* На последнем шаге [развертывания LiteLLM Proxy](#deploy-litellm-proxy) дождитесь сообщения `proxy is up`.
* Убедитесь, что порт `4000` виртуальной машины не занят другим приложением.
||
|| {{ ai-studio-full-name }} возвращает код HTTP `401` или `403` |
* Убедитесь, что переменная `YANDEX_AI_STUDIO_API_KEY` содержит только ключ, без `Bearer`, `Api-Key` и других лишних символов.
* Убедитесь, что в `config.yaml`:

    * `model` (идентификатор модели в LiteLLM) — `openai/gpt://<идентификатор_каталога>/deepseek-v4-flash`;
    * `api_base` (адрес) — `https://{{ api-host-llm }}/v1`.
||
|| Тестовое приложение работает, но трейсы не поступают в {{ monium-name }} |
Убедитесь, что:

* значение переменной `MONIUM_PROJECT` — `folder__<идентификатор_каталога>` (с двумя подчеркиваниями);
* в файле `docker-compose.yaml` в заголовке `Authorization` между `Api-Key` и ключом есть пробел (не символ `%20`);
* сервисному аккаунту `litellm-monium-sa` назначена роль `monium.traces.writer` на каталог, указанный в переменной `MONIUM_PROJECT`;
* для API-ключа этого сервисного аккаунта задана область действия `yc.monium.traces.write`;
* в интерфейсе {{ monium-name }} [указан](#check-traces) фильтр `{project = "folder__<идентификатор_каталога>", service = "litellm-proxy"}` и выбран период, когда вы запускали тестовое приложение.
||
|| Нет сетевого соединения у контейнера (`Connection reset`) |
Выполните команду `sysctl net.ipv4.ip_forward`.

Если результат `net.ipv4.ip_forward = 0`, в файле `docker-compose.yaml` оставьте строку `network_mode: host`.

После внесения изменений выполните `docker compose up -d --force-recreate`.
||
|| Спаны не содержат текста сообщений | Убедитесь, что файл `docker-compose.yaml` содержит переменную `OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=span_only`.

После внесения изменений выполните `docker compose up -d --force-recreate`. ||
|#

## Как удалить созданные ресурсы {#clear-out}

Если вы развернули систему только в тестовых целях, после завершения работы можно удалить созданные ресурсы, чтобы избежать дальнейших расходов:

1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md) с LiteLLM Proxy.
1. Если диск не был удален вместе с виртуальной машиной, [удалите его](../../compute/operations/disk-control/delete.md).
1. Если вы зарезервировали для виртуальной машины статический публичный IP-адрес, [удалите его](../../vpc/operations/address-delete.md).

Если сервисные аккаунты `litellm-ai-studio-sa` и `litellm-monium-sa` больше не нужны, [удалите их](../../iam/operations/sa/delete.md).


[*key_scope_definition]: {% include [api-key-scope](../../_popups/iam/api-key-scope.md) %}

[*span_definition]: {% include [span-definition](../../_popups/monium/span-definition.md) %}
