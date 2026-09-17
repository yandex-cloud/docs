[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Использование Yandex Managed Service for Valkey™ с модулем Search и моделей Yandex AI Studio для векторного поиска в RAG-системе

# Использование Yandex Managed Service for Valkey™ с модулем Search и моделей Yandex AI Studio для векторного поиска в RAG-системе

# Использование Yandex Managed Service for Valkey™ с модулем Search и моделей Yandex AI Studio для векторного поиска в RAG-системе

RAG (Retrieval-Augmented Generation) — это подход, при котором языковая модель для ответа на запрос пользователя использует результаты поиска в базе данных.

В руководстве приведен пример RAG-системы, которая использует [Yandex Managed Service for Valkey™](../../managed-valkey/index.md) для хранения данных о людях и выполнения векторного поиска по ним с помощью модуля [Search](../../managed-valkey/concepts/modules.md#valkey-search). Для векторизации поискового запроса и формирования ответа используются модели [Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/index.html). Yandex Managed Service for Valkey™ и AI Studio взаимодействуют с помощью [MCP](../../glossary/mcp.md).

При обработке поискового запроса компоненты системы взаимодействуют следующим образом:

1. Языковая модель Yandex AI Studio получает запрос пользователя и вызывает MCP-инструмент для поиска данных.
1. MCP-инструмент преобразует запрос в [эмбеддинг](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/embeddings.html) с помощью модели векторного представления Yandex AI Studio, а затем передает эмбеддинг в Yandex Managed Service for Valkey™.
1. Yandex Managed Service for Valkey™ с помощью модуля `Search` выполняет векторный поиск и возвращает результат MCP-инструменту, который передает его языковой модели.
1. Языковая модель анализирует найденные данные и отвечает пользователю.

Для работы с примером необходима Unix-подобная среда, а также кластер Yandex Managed Service for Valkey™ версии `9.0` или выше.

Исходный код примера RAG-системы хранится в [репозитории](https://sourcecraft.dev/valkey/webinar-260624-rag-example) SourceCraft.

Чтобы настроить RAG-систему, выполните следующие шаги:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте среду для тестирования](#prepare-test-environment).
1. [Подготовьте тестовые данные и загрузите их в Yandex Managed Service for Valkey™](#prepare-test-data).
1. [Проверьте тестовые данные в Yandex Managed Service for Valkey™](#check-test-data).
1. [Выполните поиск в RAG-системе](#test-rag-search).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex Managed Service for Valkey™: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Yandex Managed Service for Valkey™](../../managed-valkey/pricing.md)).
* AI-ассистент: количество токенов в запросе и ответе ([тарифы Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/pricing.html)). Тарификация за использование ассистента начинается с момента его включения.
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `demo-network`.

      При создании сети автоматически создаются три подсети в разных зонах доступности.

  1. В сети `demo-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) `valkey-sg` для кластера Yandex Managed Service for Valkey™ и [добавьте](../../vpc/operations/security-group-add-rule.md) в группу правило для входящего трафика, которое разрешает подключение к кластеру через интернет:

      * **Диапазон портов** — `6380`.
      * **Протокол** — `TCP`.
      * **Назначение** — `Диапазон адресов`.
      * **IPv4 CIDR** — `0.0.0.0/0`.

  1. [Создайте кластер Yandex Managed Service for Valkey™](../../managed-valkey/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

      * **Версия** — `9.0` или выше.
      * **Сеть** — `demo-network`.
      * **Группа безопасности** — `valkey-sg`.
      * **Поддержка TLS** — включена.

      При создании кластера включите публичный доступ к хостам и добавьте модуль `Search`.
    
      {% note info %}
      
      Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
      
      {% endnote %}

- С помощью Terraform {#tf}
  
  1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
  1. Скачайте в ту же рабочую директорию файл конфигурации [valkey-rag-search.tf](https://github.com/yandex-cloud-examples/yc-valkey-mcp-rag-search/blob/main/valkey-rag-search.tf). В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [подсети](../../vpc/concepts/network.md#subnet);
      * [группа безопасности](../../vpc/concepts/security-groups.md);
      * кластер Yandex Managed Service for Valkey™ с публичным доступом к хостам и модулем `Search`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %} 

  1. Укажите в конфигурационном файле следующие параметры:
        
      * `network_name` — имя сети;
      * `sg_name` — имя группы безопасности;
      * `valkey_cluster_name` — имя кластера;
      * `valkey_password` — пароль для подключения к кластеру.

  1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте необходимую инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
      
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}


## Подготовьте среду для тестирования {#prepare-test-environment}

1. [Установите Python](https://www.python.org/) версии `3.11` или выше.
1. [Установите Git](https://git-scm.com/downloads).
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `sa-ai` и назначьте ему роль [ai.languageModels.user](https://aistudio.yandex.ru/docs/ru/ai-studio/security/index.html#languageModels-user) для использования моделей Yandex AI Studio.
1. [Создайте API-ключ](../../iam/operations/authentication/manage-api-keys.md) для сервисного аккаунта `sa-ai`.
1. [Создайте локальную копию репозитория](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/repo-clone) SourceCraft с исходным кодом примера:

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

1. Настройте параметры доступа к Yandex Managed Service for Valkey™ и Yandex AI Studio:

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
        * **YDS_FOLDER_ID** — идентификатор [каталога Yandex Cloud](../../resource-manager/concepts/resources-hierarchy.md#folder), который можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * **VALKEY_USERNAME** — `default`.
        * **VALKEY_PASSWORD** — пароль для подключения к кластеру Yandex Managed Service for Valkey™.

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

1. Настройте параметры подключения к кластеру Yandex Managed Service for Valkey™:

    1. Откройте файл `config.yaml` в текстовом редакторе, например в `vim`:

        ```bash
        vim config.yaml
        ```

    1. В блоке `valkey` укажите следующие параметры:

        * **host** — `c-<идентификатор_кластера>.rw.mdb.yandexcloud.net`.
            
          Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-valkey/operations/cluster-list.md#list-clusters).
        
        * **port** — `6380`.
        * **db** — `0`.
        * **ssl** — `true`.

        Пример блока `valkey`:

        ```yaml
        # Valkey connection settings
        valkey:
          host: "c-c9qlvmr5h2g9********.rw.mdb.yandexcloud.net"
          port: 6380
          db: 0
          # username + password read from .env: VALKEY_USERNAME, VALKEY_PASSWORD
          # SSL toggle for managed Valkey
          ssl: true
        ```

    Кроме параметров подключения к кластеру Yandex Managed Service for Valkey™, файл `config.yaml` также содержит настройки:
    
    * моделей Yandex AI Studio;
    * индекса и векторного поиска в Yandex Managed Service for Valkey™;
    * MCP-сервера;
    * оркестратора;
    * системного промпта языковой модели;
    * логирования.

    Для работы примера достаточно настроить только параметры подключения к кластеру Yandex Managed Service for Valkey™. Остальные настройки можно оставить без изменений.


## Подготовьте тестовые данные и загрузите их в Yandex Managed Service for Valkey™ {#prepare-test-data}

В каталоге репозитория `webinar-260624-rag-example` выполните следующие команды:

1. Подготовьте файл `data/people.json` с тестовыми данными:

    ```bash
    rag-demo generate -n 10
    ```

    Результат:

    ```text
    Wrote 10 people to data/people.json
    ```

1. Загрузите тестовые данные в Yandex Managed Service for Valkey™:

    ```bash
    rag-demo index
    ```

    В кластере Yandex Managed Service for Valkey™ будет создан индекс `idx_people`, в который загрузятся тестовые данные.

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


## Проверьте тестовые данные в Yandex Managed Service for Valkey™ {#check-test-data}
    
1. Подключитесь к базе данных кластера Yandex Managed Service for Valkey™:

    {% list tabs group=instructions %}

    - С помощью утилиты valkey-cli {#with-valkey-cli}
      
      1. Перейдите в директорию, куда хотите скачать дистрибутив Valkey™.

      1. Скачайте нужную [версию](https://github.com/valkey-io/valkey/releases) Valkey™ и выполните сборку и установку с поддержкой TLS:

          ```bash
          wget https://github.com/valkey-io/valkey/archive/refs/tags/<версия>.tar.gz && \
          tar -xzvf <версия>.tar.gz && \
          cd valkey-<версия> && \
          make BUILD_TLS=yes && \
          sudo make install && \
          sudo cp ./src/valkey-cli /usr/bin/
          ```
      
      1. Получите SSL-сертификат:
        
          ```bash
          mkdir -p ~/.redis && \
          wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
               --output-document ~/.redis/YandexInternalRootCA.crt && \
          chmod 0655 ~/.redis/YandexInternalRootCA.crt
          ```
          
          Сертификат будет сохранен в файле `~/.redis/YandexInternalRootCA.crt`.
          
      1. Подключитесь к кластеру:
          
          * Для подключения к нешардированному кластеру выполните команду:

            ```bash
            valkey-cli \
                -h c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
                -a <пароль> \
                -p 6380 \
                --tls \
                --cacert ~/.redis/YandexInternalRootCA.crt
            ```

            Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-valkey/operations/cluster-list.md#list-clusters).

          * Для подключения к шардированному кластеру выполните команду:
          
            ```bash
            valkey-cli \
                -h <FQDN_хоста-мастера_в_нужном_шарде> \
                -c \
                -a <пароль> \
                -p 6380 \
                --tls \
                --cacert ~/.redis/YandexInternalRootCA.crt
            ```

            О том, как получить FQDN хоста, читайте в разделе [FQDN хостов Valkey™](../../managed-valkey/operations/connect/fqdn.md).

    - С помощью утилиты redis-cli {#with-redis-cli}

      1. Установите утилиту `redis-cli`:

          ```bash
          sudo apt update && sudo apt install --yes redis-tools
          ```
            
      1. Получите SSL-сертификат:
        
          ```bash
          mkdir -p ~/.redis && \
          wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
               --output-document ~/.redis/YandexInternalRootCA.crt && \
          chmod 0655 ~/.redis/YandexInternalRootCA.crt
          ```
          
          Сертификат будет сохранен в файле `~/.redis/YandexInternalRootCA.crt`.

      1. Подключитесь к кластеру:

          * Для подключения к нешардированному кластеру выполните команду:

            ```bash
            redis-cli \
                -h c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
                -a <пароль> \
                -p 6380 \
                --tls \
                --cacert ~/.redis/YandexInternalRootCA.crt
            ```

            Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-valkey/operations/cluster-list.md#list-clusters).

          * Для подключения к шардированному кластеру выполните команду:

            ```bash
            redis-cli \
                -h <FQDN_хоста-мастера_в_нужном_шарде> \
                -c \
                -a <пароль> \
                -p 6380 \
                --tls \
                --cacert ~/.redis/YandexInternalRootCA.crt
            ```

            О том, как получить FQDN хоста, читайте в разделе [FQDN хостов Valkey™](../../managed-valkey/operations/connect/fqdn.md).

    - С помощью Yandex WebSQL {#with-websql}

      Перед подключением [включите](../../managed-valkey/operations/update.md#change-additional-settings) доступ к сервису [Yandex WebSQL](../../websql/index.md) в настройках кластера.

      Чтобы подключиться к базе данных с помощью Yandex WebSQL:

      1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится нужный кластер.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Managed Service for&nbsp;Valkey™**.
      1. Нажмите на имя нужного кластера и выберите вкладку **WebSQL**.
      1. В правом верхнем углу страницы нажмите кнопку **Перейти в WebSQL**.
    
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

  [Удалите кластер Yandex Managed Service for Valkey™](../../managed-valkey/operations/cluster-delete.md).

- С помощью Terraform {#tf}

  1. В терминале перейдите в директорию с планом инфраструктуры.
  
      {% note warning %}
  
      Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
  
      {% endnote %}
  
  1. Удалите ресурсы:
  
      1. Выполните команду:
  
          ```bash
          terraform destroy
          ```
  
      1. Подтвердите удаление ресурсов и дождитесь завершения операции.
  
      Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}