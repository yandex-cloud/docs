# Использование {{ mrd-full-name }} с модулем Search и моделей {{ foundation-models-full-name }} для векторного поиска в RAG-системе

RAG (Retrieval-Augmented Generation) — это подход, при котором языковая модель для ответа на запрос пользователя использует результаты поиска в базе данных.

В руководстве приведен пример RAG-системы, которая использует [{{ mrd-full-name }}](../../managed-valkey/index.yaml) для хранения данных о людях и выполнения векторного поиска по ним с помощью модуля [Search](../../managed-valkey/concepts/modules.md#valkey-search). Для векторизации поискового запроса и формирования ответа используются модели [{{ foundation-models-full-name }}]({{ link-docs-ai }}ai-studio/concepts/index.html). {{ mrd-name }} и {{ foundation-models-name }} взаимодействуют с помощью [MCP](../../glossary/mcp.md).

При обработке поискового запроса компоненты системы взаимодействуют следующим образом:

1. Языковая модель {{ foundation-models-full-name }} получает запрос пользователя и вызывает MCP-инструмент для поиска данных.
1. MCP-инструмент преобразует запрос в [эмбеддинг]({{ link-docs-ai }}ai-studio/concepts/embeddings.html) с помощью модели векторного представления {{ foundation-models-full-name }}, а затем передает эмбеддинг в {{ mrd-name }}.
1. {{ mrd-name }} с помощью модуля `Search` выполняет векторный поиск и возвращает результат MCP-инструменту, который передает его языковой модели.
1. Языковая модель анализирует найденные данные и отвечает пользователю.

Для работы с примером необходима Unix-подобная среда, а также кластер {{ mrd-name }} версии `9.0` или выше.

Исходный код примера RAG-системы хранится в [репозитории]({{ link-src-main }}/valkey/webinar-260624-rag-example) {{ src-name }}.

Чтобы настроить RAG-систему, выполните следующие шаги:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте среду для тестирования](#prepare-test-environment).
1. [Подготовьте тестовые данные и загрузите их в {{ mrd-name }}](#prepare-test-data).
1. [Проверьте тестовые данные в {{ mrd-name }}](#check-test-data).
1. [Выполните поиск в RAG-системе](#test-rag-search).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mrd-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mrd-name }}](../../managed-valkey/pricing.md)).
* AI-ассистент: количество токенов в запросе и ответе ([тарифы {{ foundation-models-full-name }}]({{ link-docs-ai }}ai-studio/pricing.html)). Тарификация за использование ассистента начинается с момента его включения.
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `demo-network`.

      При создании сети автоматически создаются три подсети в разных зонах доступности.

  1. В сети `demo-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) `valkey-sg` для кластера {{ mrd-name }} и [добавьте](../../vpc/operations/security-group-add-rule.md) в группу правило для входящего трафика, которое разрешает подключение к кластеру через интернет:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mrd-tls }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  1. [Создайте кластер {{ mrd-name }}](../../managed-valkey/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

      * **Версия** — `9.0` или выше.
      * **Сеть** — `demo-network`.
      * **Группа безопасности** — `valkey-sg`.
      * **Поддержка TLS** — включена.

      При создании кластера включите публичный доступ к хостам и добавьте модуль `Search`.
    
      {% include [public-access](../../_includes/mdb/note-public-access.md) %}

- С помощью {{ TF }} {#tf}
  
  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. Скачайте в ту же рабочую директорию файл конфигурации [valkey-rag-search.tf](https://github.com/yandex-cloud-examples/yc-valkey-mcp-rag-search/blob/main/valkey-rag-search.tf). В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [подсети](../../vpc/concepts/network.md#subnet);
      * [группа безопасности](../../vpc/concepts/security-groups.md);
      * кластер {{ mrd-name }} с публичным доступом к хостам и модулем `Search`.

        {% include [public-access](../../_includes/mdb/note-public-access.md) %} 

  1. Укажите в конфигурационном файле следующие параметры:
        
      * `network_name` — имя сети;
      * `sg_name` — имя группы безопасности;
      * `valkey_cluster_name` — имя кластера;
      * `valkey_password` — пароль для подключения к кластеру.

  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}


## Подготовьте среду для тестирования {#prepare-test-environment}

1. [Установите Python](https://www.python.org/) версии `3.11` или выше.
1. [Установите Git](https://git-scm.com/downloads).
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `sa-ai` и назначьте ему роль [ai.languageModels.user]({{ link-docs-ai }}ai-studio/security/index.html#languageModels-user) для использования моделей {{ foundation-models-full-name }}.
1. [Создайте API-ключ](../../iam/operations/authentication/manage-api-keys.md) для сервисного аккаунта `sa-ai`.
1. [Создайте локальную копию репозитория]({{ link-src-docs }}/sourcecraft/operations/repo-clone) {{ src-name }} с исходным кодом примера:

    ```bash
    git clone https://git@git.sourcecraft.dev/valkey/webinar-260624-rag-example.git
    ```

1. Перейдите в каталог репозитория:
    
    ```bash
    cd webinar-260624-rag-example
    ```

1. Подготовьте окружение примера:

    1. Установите зависимости:

        ```bash
        make install
        ```

    1. Активируйте виртуальное окружение:

        ```bash
        source .venv/bin/activate
        ```

1. Настройте параметры доступа к {{ mrd-name }} и {{ foundation-models-full-name }}:

    1. Создайте файл `.env` на основе шаблона `.env.example`:

        ```bash
        cp .env.example .env
        ```

    1. Откройте файл `.env` в текстовом редакторе, например в `vim`:

        ```bash
        vim .env
        ```
    
    1. Укажите в файле следующие параметры:
        
        * **YDS_API_KEY** — значение API-ключа.
        * **YDS_FOLDER_ID** — идентификатор [каталога {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md#folder), который можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * **VALKEY_USERNAME** — `default`.
        * **VALKEY_PASSWORD** — пароль для подключения к кластеру {{ mrd-name }}.

        Пример файла:

        ```text
        # Yandex AI Studio credentials
        # Get an API key: https://yandex.cloud/en/docs/ai-studio/operations/get-api-key
        YDS_API_KEY=AQVN1TpRw9tkjhKtj6R0mRgmHLvMsj84********
        YDS_FOLDER_ID=b1g4unjqq856********
        
        # Valkey auth (leave empty for local unauthenticated Valkey)
        VALKEY_USERNAME=default
        VALKEY_PASSWORD=********
        ```

1. Настройте параметры подключения к кластеру {{ mrd-name }}:

    1. Откройте файл `config.yaml` в текстовом редакторе, например в `vim`:

        ```bash
        vim config.yaml
        ```

    1. В блоке `valkey` укажите следующие параметры:

        * **host** — `c-<идентификатор_кластера>.rw.mdb.yandexcloud.net`.
            
          Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-valkey/operations/cluster-list.md#list-clusters).
        
        * **port** — `{{ port-mrd-tls }}`.
        * **db** — `0`.
        * **ssl** — `true`.

        Пример блока `valkey`:

        ```yaml
        # Valkey connection settings
        valkey:
          host: "c-c9qlvmr5h2g9********.rw.mdb.yandexcloud.net"
          port: {{ port-mrd-tls }}
          db: 0
          # username + password read from .env: VALKEY_USERNAME, VALKEY_PASSWORD
          # SSL toggle for managed Valkey
          ssl: true
        ```

    Кроме параметров подключения к кластеру {{ mrd-name }}, файл `config.yaml` также содержит настройки:
    
    * моделей {{ foundation-models-full-name }};
    * индекса и векторного поиска в {{ mrd-name }};
    * MCP-сервера;
    * оркестратора;
    * системного промпта языковой модели;
    * логирования.

    Для работы примера достаточно настроить только параметры подключения к кластеру {{ mrd-name }}. Остальные настройки можно оставить без изменений.


## Подготовьте тестовые данные и загрузите их в {{ mrd-name }} {#prepare-test-data}

В каталоге репозитория `webinar-260624-rag-example` выполните следующие команды:

1. Подготовьте файл `data/people.json` с тестовыми данными:

    ```bash
    rag-demo generate -n 10
    ```

    Результат:

    ```text
    Wrote 10 people to data/people.json
    ```

1. Загрузите тестовые данные в {{ mrd-name }}:

    ```bash
    rag-demo index
    ```

    В кластере {{ mrd-name }} будет создан индекс `idx_people`, в который загрузятся тестовые данные.

    Результат:

    ```text
      indexed person 1: Alice Smith
      indexed person 2: John Doe
      indexed person 3: Maria Garcia
      indexed person 4: Wei Zhang
      indexed person 5: James Brown
      indexed person 6: Priya Patel
      indexed person 7: Lars Nilsson
      indexed person 8: Olivia Wilson
      indexed person 9: Hassan Ali
      indexed person 10: Sophie Martin
    Loaded 10 people into index idx_people
    ```


## Проверьте тестовые данные в {{ mrd-name }} {#check-test-data}
    
1. Подключитесь к базе данных кластера {{ mrd-name }}:

    {% list tabs group=instructions %}

    - С помощью утилиты valkey-cli {#with-valkey-cli}
      
      1. Перейдите в директорию, куда хотите скачать дистрибутив {{ VLK }}.

      1. Скачайте нужную [версию](https://github.com/valkey-io/valkey/releases) {{ VLK }} и выполните сборку и установку с поддержкой TLS:

          ```bash
          wget https://github.com/valkey-io/valkey/archive/refs/tags/<версия>.tar.gz && \
          tar -xzvf <версия>.tar.gz && \
          cd valkey-<версия> && \
          make BUILD_TLS=yes && \
          sudo make install && \
          sudo cp ./src/valkey-cli /usr/bin/
          ```
      
      1. Получите SSL-сертификат:
        
          {% include [unix-certificate](../../_includes/mdb/mvk/unix-certificate.md) %}
          
      1. Подключитесь к кластеру:
          
          * Для подключения к нешардированному кластеру выполните команду:

            ```bash
            valkey-cli \
                -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
                -a <пароль> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-valkey/operations/cluster-list.md#list-clusters).

          * Для подключения к шардированному кластеру выполните команду:
          
            ```bash
            valkey-cli \
                -h <FQDN_хоста-мастера_в_нужном_шарде> \
                -c \
                -a <пароль> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            О том, как получить FQDN хоста, читайте в разделе [{#T}](../../managed-valkey/operations/connect/fqdn.md).

    - С помощью утилиты redis-cli {#with-redis-cli}

      1. Установите утилиту `redis-cli`:

          ```bash
          sudo apt update && sudo apt install --yes redis-tools
          ```
            
      1. Получите SSL-сертификат:
        
          {% include [unix-certificate](../../_includes/mdb/mvk/unix-certificate.md) %}

      1. Подключитесь к кластеру:

          * Для подключения к нешардированному кластеру выполните команду:

            ```bash
            redis-cli \
                -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
                -a <пароль> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-valkey/operations/cluster-list.md#list-clusters).

          * Для подключения к шардированному кластеру выполните команду:

            ```bash
            redis-cli \
                -h <FQDN_хоста-мастера_в_нужном_шарде> \
                -c \
                -a <пароль> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            О том, как получить FQDN хоста, читайте в разделе [{#T}](../../managed-valkey/operations/connect/fqdn.md).

    - С помощью {{ websql-full-name }} {#with-websql}

      Перед подключением [включите](../../managed-valkey/operations/update.md#change-additional-settings) доступ к сервису [{{ websql-full-name }}](../../websql/index.yaml) в настройках кластера.

      Чтобы подключиться к базе данных с помощью {{ websql-full-name }}:

      1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится нужный кластер.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
      1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.overview.label_websql-service }}**.
      1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_go-to-websql}}**.
    
    {% endlist %}
  
1. Получите информацию об индексе `idx_people`:

    ```bash
    FT.INFO idx_people
    ```

    Проверьте значения параметров в выводе:
    
    * **num_docs** — `10`;
    * **state** — `ready`.

1. Получите список ключей в кластере:

    ```bash
    KEYS *
    ```

    Результат:

    ```text
    1) "person:1"
    2) "person:2"
    3) "person:3"
    4) "person:4"
    5) "person:5"
    6) "person:9"
    7) "person:id_counter"
    8) "person:6"
    9) "person:7"
    10) "person:8"
    11) "person:10"
    ```

    Где `person:id_counter` — служебный ключ, в котором хранится значение счетчика идентификаторов.

1. Просмотрите данные по ключу `person:1`:

    ```bash
    HGETALL person:1
    ```


## Выполните поиск в RAG-системе {#test-rag-search}

В каталоге репозитория `webinar-260624-rag-example` выполните следующие команды:

1. Выполните поиск по запросу `Who works with Kubernetes?`:

    ```bash
    rag-demo ask "Who works with Kubernetes?"
    ```

    Результат:

    ```text
    Lars Nilsson works with Kubernetes. He is a site reliability engineer in Stockholm, Sweden, responsible for keeping large Kubernetes clusters healthy.
    ```

    Помимо ответа модели, в выводе отображается подробная информация о выполнении запроса. Чтобы скрыть эту информацию, в файле `config.yaml` в блоке `logging` укажите `console_level: "WARNING"`. После этого будет выводиться сокращенная информация о выполнении запроса и итоговый ответ модели.

1. Выполните поиск по запросу `Кто увлекается бегом?`:

    ```bash
    rag-demo ask "Кто увлекается бегом?"
    ```

    Результат:

    ```text
    Из найденных людей бегом увлекается **Wei Zhang** (38 лет, Токио, Япония) — он тренируется для участия в марафонах.
    ```


## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  [Удалите кластер {{ mrd-name }}](../../managed-valkey/operations/cluster-delete.md).

- С помощью {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}