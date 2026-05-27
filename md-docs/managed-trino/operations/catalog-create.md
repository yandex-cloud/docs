# Создание каталога Trino

## Роли для создания каталога Trino {#roles}

Для создания [каталога Trino](../concepts/index.md#catalog) с типом подключения [Connection Manager](../../metadata-hub/concepts/connection-manager.md) вашему аккаунту в Yandex Cloud нужна дополнительная роль [connection-manager.user](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user), чтобы использовать подключения из Connection Manager.

[Сервисному аккаунту](../../iam/concepts/users/service-accounts.md) кластера должны быть назначены роли [connection-manager.user](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) и [lockbox.payloadViewer](../../lockbox/security/index.md#lockbox-payloadViewer). Это даст кластеру нужные права для работы с подключениями из Connection Manager. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).

О назначении ролей читайте в [документации Yandex Identity and Access Management](../../iam/operations/roles/grant.md).

## Создать каталог Trino {#create-catalog}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Trino**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **Каталоги**.
  1. Нажмите кнопку **Создать каталог**.
  1. В поле **Имя каталога** задайте имя каталога Trino.
  1. В поле **Тип коннектора** выберите тип [коннектора](../concepts/index.md#connector).
  1. Задайте [настройки каталога Trino](#catalog-settings).
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды CLI для создания каталога Trino:

        ```bash
        yc managed-trino catalog create --help
        ```

    1. Посмотрите описание команды CLI для создания каталога Trino c конкретным коннектором:

        ```bash
        yc managed-trino catalog create <тип_коннектора> --help
        ```

    1. Чтобы создать каталог Trino, выполните команду:

        ```bash
        yc managed-trino catalog create <тип_коннектора> <имя_каталога_Trino>
        ```

        В команде также нужно передать настройки каталога Trino, которые зависят от типа коннектора. [Подробнее о настройках для разных типов коннекторов](#catalog-settings).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте ресурс `yandex_trino_catalog`:

        ```hcl
        resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
          name        = "<имя_каталога_Trino>"
          cluster_id  = yandex_trino_cluster.<имя_кластера>.id
          <тип_коннектора> = {
            <настройки_каталога_Trino>
          }
        }
        ```

        [Подробнее о настройках каталога Trino](#catalog-settings) для разных типов коннекторов.

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Catalog.Create](../api-ref/Catalog/create.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
            --data '{
                      "catalog": {
                        "name": "<имя_каталога_Trino>",
                        "connector": {
                          "<тип_коннектора>": {
                            <настройки_каталога_Trino>
                          }
                        }
                      }
                    }'
        ```

        [Подробнее о настройках каталога Trino](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Catalog/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [CatalogService.Create](../api-ref/grpc/Catalog/create.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "<тип_коннектора>": {
                            <настройки_каталога_Trino>
                      }
                    }
                  }
                }' \
            trino.api.cloud.yandex.net:443 \
            yandex.cloud.trino.v1.CatalogService.Create
        ```

        [Подробнее о настройках каталога Trino](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Catalog/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настройки каталога Trino {#catalog-settings}

Настройки каталога Trino отличаются в зависимости от выбранного коннектора.

{% note info %}

Коннекторы с пометкой <code><b><small>Preview</small></b></code> находятся на стадии предварительного тестирования. Стабильность работы не гарантируется.

{% endnote %}

### Коннектор ClickHouse® {#ch}

Выберите тип подключения — [Connection Manager](../../metadata-hub/concepts/connection-manager.md) или **Ручная настройка** (пользовательская инсталляция), и задайте для него нужные настройки.

Connection Manager позволяет создавать подключения к кластеру с управляемой базой данных и к пользовательской инсталляции базы данных.

При подключении с типом Connection Manager любые изменения в параметрах подключения автоматически учитываются в Trino. При подключении с типом **Ручная настройка** изменения в параметрах подключения не отслеживаются в Trino. Их необходимо отслеживать и вносить вручную.

#### Подключение Connection Manager {#ch-connection-manager}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Идентификатор подключения** — идентификатор подключения в Connection Manager для подключения к кластеру ClickHouse®.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

    * **База данных** — имя БД в кластере ClickHouse®.
    * **Параметры клиента** — параметры клиента ClickHouse® в формате `ключ: значение`.

        {% cut "Доступные параметры" %}
        
        * `async` — использовать ли асинхронный режим. Значение: `true` или `false`.
        
        * `buffer_queue_variation` — сколько раз может заполниться буфер, прежде чем его размер будет увеличен.
        
        * `buffer_size` — размер буфера. При переполнении увеличивается до `max_buffer_size`.
        
        * `client_name` — имя клиента.
        
        * `compress` — сжимать ли данные в ответе сервера. Значение: `true` или `false`.
        
        * `compress_algorithm` — какой алгоритм использовать для сжатия данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
        
        * `compress_level` — уровень сжатия данных.
        
        * `connect_timeout` — максимальное время ожидания подключения к серверу (в миллисекундах).
        
        * `decompress` — распаковывать ли данные в запросе клиента. Значение: `true` или `false`.
        
        * `decompress_algorithm` — какой алгоритм использовать для распаковки данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
        
        * `decompress_level` — уровень сжатия данных при распаковке.
        
        * `failover` — максимальное число попыток подключения к репликам, если сервер недоступен.
        
        * `load_balancing_policy` — алгоритм выбора реплик для подключения.
        
            * `firstAlive` — запрос отправляется на первую доступную реплику.
            * `random` — запрос отправляется на любую реплику случайным образом.
            * `roundRobin` — запрос отправляется в соответствии с политикой [Round-robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)).
        
        * `max_buffer_size` — максимальный размер буфера.
        
        * `max_threads_per_client` — максимальное число потоков на один клиент.
        
        * `product_name` — имя продукта в `User-Agent`.
        
        * `read_buffer_size` — размер буфера для чтения данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
        
        * `request_buffering` — режим буферизации запросов.
        
            * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
            * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
            * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
        
        * `request_chunk_size` — размер куска данных в запросе (в байтах).
        
        * `response_buffering` — режим буферизации ответов.
        
            * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
            * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
            * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
        
        * `server_time_zone` — часовой пояс.
        
        * `use_server_time_zone` — использовать ли часовой пояс сервера. Значение: `true` или `false`.
        
        * `use_server_time_zone_for_dates` — использовать ли часовой пояс сервера при обработке значений `Date`. Значение: `true` или `false`.
        
        * `use_time_zone` — какой часовой пояс использовать. Пример значения: `Europe/Amsterdam`. Работает, если значение `use_server_time_zone` равно `false`.
        
        * `write_buffer_size` — размер буфера для записи данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
        
        {% endcut %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create clickhouse <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --connection-manager-connection-id <идентификатор_подключения> \
      --connection-manager-database <имя_БД> \
      --connection-manager-connection-properties <список_параметров_клиента_ClickHouse®> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--connection-manager-connection-id` — идентификатор подключения в Connection Manager для подключения к кластеру ClickHouse®.

      Чтобы узнать идентификатор подключения:
        1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.   

    * `--connection-manager-database` — имя БД в кластере ClickHouse®.
    * `--connection-manager-connection-properties` — параметры клиента ClickHouse® в формате `ключ=значение`.

        {% cut "Доступные параметры" %}
        
        * `async` — использовать ли асинхронный режим. Значение: `true` или `false`.
        
        * `buffer_queue_variation` — сколько раз может заполниться буфер, прежде чем его размер будет увеличен.
        
        * `buffer_size` — размер буфера. При переполнении увеличивается до `max_buffer_size`.
        
        * `client_name` — имя клиента.
        
        * `compress` — сжимать ли данные в ответе сервера. Значение: `true` или `false`.
        
        * `compress_algorithm` — какой алгоритм использовать для сжатия данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
        
        * `compress_level` — уровень сжатия данных.
        
        * `connect_timeout` — максимальное время ожидания подключения к серверу (в миллисекундах).
        
        * `decompress` — распаковывать ли данные в запросе клиента. Значение: `true` или `false`.
        
        * `decompress_algorithm` — какой алгоритм использовать для распаковки данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
        
        * `decompress_level` — уровень сжатия данных при распаковке.
        
        * `failover` — максимальное число попыток подключения к репликам, если сервер недоступен.
        
        * `load_balancing_policy` — алгоритм выбора реплик для подключения.
        
            * `firstAlive` — запрос отправляется на первую доступную реплику.
            * `random` — запрос отправляется на любую реплику случайным образом.
            * `roundRobin` — запрос отправляется в соответствии с политикой [Round-robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)).
        
        * `max_buffer_size` — максимальный размер буфера.
        
        * `max_threads_per_client` — максимальное число потоков на один клиент.
        
        * `product_name` — имя продукта в `User-Agent`.
        
        * `read_buffer_size` — размер буфера для чтения данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
        
        * `request_buffering` — режим буферизации запросов.
        
            * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
            * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
            * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
        
        * `request_chunk_size` — размер куска данных в запросе (в байтах).
        
        * `response_buffering` — режим буферизации ответов.
        
            * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
            * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
            * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
        
        * `server_time_zone` — часовой пояс.
        
        * `use_server_time_zone` — использовать ли часовой пояс сервера. Значение: `true` или `false`.
        
        * `use_server_time_zone_for_dates` — использовать ли часовой пояс сервера при обработке значений `Date`. Значение: `true` или `false`.
        
        * `use_time_zone` — какой часовой пояс использовать. Пример значения: `Europe/Amsterdam`. Работает, если значение `use_server_time_zone` равно `false`.
        
        * `write_buffer_size` — размер буфера для записи данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
        
        {% endcut %}

    * `additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      clickhouse = {
        connection_manager = {
          connection_id = "<идентификатор_подключения>"
          database      = "<имя_БД>"
          connection_properties = {
            <список_настроек_клиента_ClickHouse®>
          }
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `connection_manager` — настройки Connection Manager:

        * `connection_id` — идентификатор подключения в Connection Manager для подключения к кластеру ClickHouse®.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `database` — имя БД в кластере ClickHouse®.
        * `connection_properties` — список настроек клиента ClickHouse® в формате `"ключ" = "значение"`.

            {% cut "Доступные параметры" %}
            
            * `async` — использовать ли асинхронный режим. Значение: `true` или `false`.
            
            * `buffer_queue_variation` — сколько раз может заполниться буфер, прежде чем его размер будет увеличен.
            
            * `buffer_size` — размер буфера. При переполнении увеличивается до `max_buffer_size`.
            
            * `client_name` — имя клиента.
            
            * `compress` — сжимать ли данные в ответе сервера. Значение: `true` или `false`.
            
            * `compress_algorithm` — какой алгоритм использовать для сжатия данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
            
            * `compress_level` — уровень сжатия данных.
            
            * `connect_timeout` — максимальное время ожидания подключения к серверу (в миллисекундах).
            
            * `decompress` — распаковывать ли данные в запросе клиента. Значение: `true` или `false`.
            
            * `decompress_algorithm` — какой алгоритм использовать для распаковки данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
            
            * `decompress_level` — уровень сжатия данных при распаковке.
            
            * `failover` — максимальное число попыток подключения к репликам, если сервер недоступен.
            
            * `load_balancing_policy` — алгоритм выбора реплик для подключения.
            
                * `firstAlive` — запрос отправляется на первую доступную реплику.
                * `random` — запрос отправляется на любую реплику случайным образом.
                * `roundRobin` — запрос отправляется в соответствии с политикой [Round-robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)).
            
            * `max_buffer_size` — максимальный размер буфера.
            
            * `max_threads_per_client` — максимальное число потоков на один клиент.
            
            * `product_name` — имя продукта в `User-Agent`.
            
            * `read_buffer_size` — размер буфера для чтения данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
            
            * `request_buffering` — режим буферизации запросов.
            
                * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
                * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
                * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
            
            * `request_chunk_size` — размер куска данных в запросе (в байтах).
            
            * `response_buffering` — режим буферизации ответов.
            
                * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
                * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
                * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
            
            * `server_time_zone` — часовой пояс.
            
            * `use_server_time_zone` — использовать ли часовой пояс сервера. Значение: `true` или `false`.
            
            * `use_server_time_zone_for_dates` — использовать ли часовой пояс сервера при обработке значений `Date`. Значение: `true` или `false`.
            
            * `use_time_zone` — какой часовой пояс использовать. Пример значения: `Europe/Amsterdam`. Работает, если значение `use_server_time_zone` равно `false`.
            
            * `write_buffer_size` — размер буфера для записи данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
            
            {% endcut %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "clickhouse": {
                        "connection": {
                          "connectionManager": {
                            "connectionId": "<идентификатор_подключения>",
                            "database": "<имя_БД>",
                            "connectionProperties": {
                              <список_настроек_клиента_ClickHouse®>
                            }
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `connectionManager` — настройки Connection Manager:

        * `connectionId` — идентификатор подключения в Connection Manager для подключения к кластеру ClickHouse®.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `database` — имя БД в кластере ClickHouse®.
        * `connectionProperties` — список настроек клиента ClickHouse® в формате `"ключ": "значение"`.

            {% cut "Доступные параметры" %}
            
            * `async` — использовать ли асинхронный режим. Значение: `true` или `false`.
            
            * `buffer_queue_variation` — сколько раз может заполниться буфер, прежде чем его размер будет увеличен.
            
            * `buffer_size` — размер буфера. При переполнении увеличивается до `max_buffer_size`.
            
            * `client_name` — имя клиента.
            
            * `compress` — сжимать ли данные в ответе сервера. Значение: `true` или `false`.
            
            * `compress_algorithm` — какой алгоритм использовать для сжатия данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
            
            * `compress_level` — уровень сжатия данных.
            
            * `connect_timeout` — максимальное время ожидания подключения к серверу (в миллисекундах).
            
            * `decompress` — распаковывать ли данные в запросе клиента. Значение: `true` или `false`.
            
            * `decompress_algorithm` — какой алгоритм использовать для распаковки данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
            
            * `decompress_level` — уровень сжатия данных при распаковке.
            
            * `failover` — максимальное число попыток подключения к репликам, если сервер недоступен.
            
            * `load_balancing_policy` — алгоритм выбора реплик для подключения.
            
                * `firstAlive` — запрос отправляется на первую доступную реплику.
                * `random` — запрос отправляется на любую реплику случайным образом.
                * `roundRobin` — запрос отправляется в соответствии с политикой [Round-robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)).
            
            * `max_buffer_size` — максимальный размер буфера.
            
            * `max_threads_per_client` — максимальное число потоков на один клиент.
            
            * `product_name` — имя продукта в `User-Agent`.
            
            * `read_buffer_size` — размер буфера для чтения данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
            
            * `request_buffering` — режим буферизации запросов.
            
                * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
                * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
                * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
            
            * `request_chunk_size` — размер куска данных в запросе (в байтах).
            
            * `response_buffering` — режим буферизации ответов.
            
                * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
                * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
                * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
            
            * `server_time_zone` — часовой пояс.
            
            * `use_server_time_zone` — использовать ли часовой пояс сервера. Значение: `true` или `false`.
            
            * `use_server_time_zone_for_dates` — использовать ли часовой пояс сервера при обработке значений `Date`. Значение: `true` или `false`.
            
            * `use_time_zone` — какой часовой пояс использовать. Пример значения: `Europe/Amsterdam`. Работает, если значение `use_server_time_zone` равно `false`.
            
            * `write_buffer_size` — размер буфера для записи данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
            
            {% endcut %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "clickhouse": {
                    "connection": {
                      "connection_manager": {
                        "connection_id": "<идентификатор_подключения>",
                        "database": "<имя_БД>",
                        "connection_properties": {
                          <список_настроек_клиента_ClickHouse®>
                        }
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `connection_manager` — настройки Connection Manager:

        * `connection_id` — идентификатор подключения в Connection Manager для подключения к кластеру ClickHouse®.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `database` — имя БД в кластере ClickHouse®.
        * `connection_properties` — список настроек клиента ClickHouse® в формате `"ключ": "значение"`.

            {% cut "Доступные параметры" %}
            
            * `async` — использовать ли асинхронный режим. Значение: `true` или `false`.
            
            * `buffer_queue_variation` — сколько раз может заполниться буфер, прежде чем его размер будет увеличен.
            
            * `buffer_size` — размер буфера. При переполнении увеличивается до `max_buffer_size`.
            
            * `client_name` — имя клиента.
            
            * `compress` — сжимать ли данные в ответе сервера. Значение: `true` или `false`.
            
            * `compress_algorithm` — какой алгоритм использовать для сжатия данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
            
            * `compress_level` — уровень сжатия данных.
            
            * `connect_timeout` — максимальное время ожидания подключения к серверу (в миллисекундах).
            
            * `decompress` — распаковывать ли данные в запросе клиента. Значение: `true` или `false`.
            
            * `decompress_algorithm` — какой алгоритм использовать для распаковки данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.
            
            * `decompress_level` — уровень сжатия данных при распаковке.
            
            * `failover` — максимальное число попыток подключения к репликам, если сервер недоступен.
            
            * `load_balancing_policy` — алгоритм выбора реплик для подключения.
            
                * `firstAlive` — запрос отправляется на первую доступную реплику.
                * `random` — запрос отправляется на любую реплику случайным образом.
                * `roundRobin` — запрос отправляется в соответствии с политикой [Round-robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)).
            
            * `max_buffer_size` — максимальный размер буфера.
            
            * `max_threads_per_client` — максимальное число потоков на один клиент.
            
            * `product_name` — имя продукта в `User-Agent`.
            
            * `read_buffer_size` — размер буфера для чтения данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
            
            * `request_buffering` — режим буферизации запросов.
            
                * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
                * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
                * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
            
            * `request_chunk_size` — размер куска данных в запросе (в байтах).
            
            * `response_buffering` — режим буферизации ответов.
            
                * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
                * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
                * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.
            
            * `server_time_zone` — часовой пояс.
            
            * `use_server_time_zone` — использовать ли часовой пояс сервера. Значение: `true` или `false`.
            
            * `use_server_time_zone_for_dates` — использовать ли часовой пояс сервера при обработке значений `Date`. Значение: `true` или `false`.
            
            * `use_time_zone` — какой часовой пояс использовать. Пример значения: `Europe/Amsterdam`. Работает, если значение `use_server_time_zone` равно `false`.
            
            * `write_buffer_size` — размер буфера для записи данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.
            
            {% endcut %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

#### Ручная настройка {#ch-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URL** — URL для подключения к БД ClickHouse® в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД ClickHouse®.
    * **Пароль** — пароль пользователя для подключения к БД ClickHouse®.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create clickhouse <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД ClickHouse® в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`
    * `--on-premise-user-name` — имя пользователя для подключения к БД ClickHouse®.
    * `--on-premise-password` — пароль пользователя для подключения к БД ClickHouse®.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      clickhouse = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД ClickHouse® в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД ClickHouse®.
        * `password` — пароль пользователя для подключения к БД ClickHouse®.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "clickhouse": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД ClickHouse® в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
        * `userName` — имя пользователя для подключения к БД ClickHouse®.
        * `password` — пароль пользователя для подключения к БД ClickHouse®.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "clickhouse": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД ClickHouse® в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД ClickHouse®.
        * `password` — пароль пользователя для подключения к БД ClickHouse®.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Delta Lake {#delta-lake}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URI** — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore:
          1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
          1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
          1. На панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}
    
      * **Файловое хранилище** — тип файлового хранилища. Доступные варианты: [Yandex Object Storage](../../storage/quickstart/overview.md) и внешнее хранилище.
    
        Для внешнего хранилища необходимо указать:
    
          * **Идентификатор ключа доступа** — идентификатор AWS-совместимого статического ключа доступа.
          * **Секретный ключ** — секретный ключ AWS-совместимого статического ключа доступа.
          * **Эндпоинт** — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
          * **Регион** — регион файлового хранилища, например `ru-central1`.

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/delta-lake.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create delta-lake <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --metastore-hive-uri <URI_для_подключения> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <идентификатор_ключа_доступа> \
      --filesystem-external-s3-aws-secret-key <секретный_ключ> \
      --filesystem-external-s3-aws-endpoint <эндпоинт> \
      --filesystem-external-s3-aws-region <регион> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--metastore-hive-uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
      Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
      {% note warning %}
      
      Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
      
      {% endnote %}
    
    * `--filesystem-native-s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
    * `--filesystem-external-s3-aws-access-key` — идентификатор AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-secret-key` — секретный ключ AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
    * `--filesystem-external-s3-aws-region` — регион файлового хранилища, например `ru-central1`.
    
      {% note info %}
    
      Укажите либо флаг `--filesystem-native-s3`, чтобы использовать хранилище Object Storage, либо флаги группы `--filesystem-external-s3-aws`, чтобы использовать внешнее хранилище.
    
      {% endnote %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/delta-lake.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      delta_lake = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_для_подключения>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `file_system` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/delta-lake.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "deltaLake": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_для_подключения>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `externalS3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `awsAccessKey` — идентификатор AWS-совместимого статического ключа доступа.
            * `awsSecretKey` — секретный ключ AWS-совместимого статического ключа доступа.
            * `awsEndpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `awsRegion` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/delta-lake.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "delta_lake": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_для_подключения>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/delta-lake.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Hive {#hive}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URI** — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore:
          1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
          1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
          1. На панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}
    
      * **Файловое хранилище** — тип файлового хранилища. Доступные варианты: [Yandex Object Storage](../../storage/quickstart/overview.md) и внешнее хранилище.
    
        Для внешнего хранилища необходимо указать:
    
          * **Идентификатор ключа доступа** — идентификатор AWS-совместимого статического ключа доступа.
          * **Секретный ключ** — секретный ключ AWS-совместимого статического ключа доступа.
          * **Эндпоинт** — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
          * **Регион** — регион файлового хранилища, например `ru-central1`.

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hive.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create hive <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --metastore-hive-uri <URI_для_подключения> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <идентификатор_ключа_доступа> \
      --filesystem-external-s3-aws-secret-key <секретный_ключ> \
      --filesystem-external-s3-aws-endpoint <эндпоинт> \
      --filesystem-external-s3-aws-region <регион> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--metastore-hive-uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
      Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
      {% note warning %}
      
      Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
      
      {% endnote %}
    
    * `--filesystem-native-s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
    * `--filesystem-external-s3-aws-access-key` — идентификатор AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-secret-key` — секретный ключ AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
    * `--filesystem-external-s3-aws-region` — регион файлового хранилища, например `ru-central1`.
    
      {% note info %}
    
      Укажите либо флаг `--filesystem-native-s3`, чтобы использовать хранилище Object Storage, либо флаги группы `--filesystem-external-s3-aws`, чтобы использовать внешнее хранилище.
    
      {% endnote %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hive.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      hive = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_для_подключения>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `file_system` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hive.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "hive": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_для_подключения>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `externalS3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `awsAccessKey` — идентификатор AWS-совместимого статического ключа доступа.
            * `awsSecretKey` — секретный ключ AWS-совместимого статического ключа доступа.
            * `awsEndpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `awsRegion` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hive.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "hive": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_для_подключения>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hive.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Hudi <code><b><small>Preview</small></b></code> {#hudi}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URI** — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore:
          1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
          1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
          1. На панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}
    
      * **Файловое хранилище** — тип файлового хранилища. Доступные варианты: [Yandex Object Storage](../../storage/quickstart/overview.md) и внешнее хранилище.
    
        Для внешнего хранилища необходимо указать:
    
          * **Идентификатор ключа доступа** — идентификатор AWS-совместимого статического ключа доступа.
          * **Секретный ключ** — секретный ключ AWS-совместимого статического ключа доступа.
          * **Эндпоинт** — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
          * **Регион** — регион файлового хранилища, например `ru-central1`.

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hudi.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create hudi <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --metastore-hive-uri <URI_для_подключения> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <идентификатор_ключа_доступа> \
      --filesystem-external-s3-aws-secret-key <секретный_ключ> \
      --filesystem-external-s3-aws-endpoint <эндпоинт> \
      --filesystem-external-s3-aws-region <регион> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--metastore-hive-uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
      Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
      {% note warning %}
      
      Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
      
      {% endnote %}
    
    * `--filesystem-native-s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
    * `--filesystem-external-s3-aws-access-key` — идентификатор AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-secret-key` — секретный ключ AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
    * `--filesystem-external-s3-aws-region` — регион файлового хранилища, например `ru-central1`.
    
      {% note info %}
    
      Укажите либо флаг `--filesystem-native-s3`, чтобы использовать хранилище Object Storage, либо флаги группы `--filesystem-external-s3-aws`, чтобы использовать внешнее хранилище.
    
      {% endnote %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hudi.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      hudi = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_для_подключения>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `file_system` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hive.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "hudi": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_для_подключения>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `externalS3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `awsAccessKey` — идентификатор AWS-совместимого статического ключа доступа.
            * `awsSecretKey` — секретный ключ AWS-совместимого статического ключа доступа.
            * `awsEndpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `awsRegion` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hudi.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "hudi": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_для_подключения>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hudi.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Iceberg {#iceberg}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URI** — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore:
          1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
          1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
          1. На панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}
    
      * **Файловое хранилище** — тип файлового хранилища. Доступные варианты: [Yandex Object Storage](../../storage/quickstart/overview.md) и внешнее хранилище.
    
        Для внешнего хранилища необходимо указать:
    
          * **Идентификатор ключа доступа** — идентификатор AWS-совместимого статического ключа доступа.
          * **Секретный ключ** — секретный ключ AWS-совместимого статического ключа доступа.
          * **Эндпоинт** — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
          * **Регион** — регион файлового хранилища, например `ru-central1`.

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/iceberg.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create iceberg <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --metastore-hive-uri <URI_для_подключения> \
      --filesystem-native-s3 \
      --filesystem-external-s3-aws-access-key <идентификатор_ключа_доступа> \
      --filesystem-external-s3-aws-secret-key <секретный_ключ> \
      --filesystem-external-s3-aws-endpoint <эндпоинт> \
      --filesystem-external-s3-aws-region <регион> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--metastore-hive-uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
      Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
      {% note warning %}
      
      Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
      
      {% endnote %}
    
    * `--filesystem-native-s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
    * `--filesystem-external-s3-aws-access-key` — идентификатор AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-secret-key` — секретный ключ AWS-совместимого статического ключа доступа.
    * `--filesystem-external-s3-aws-endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
    * `--filesystem-external-s3-aws-region` — регион файлового хранилища, например `ru-central1`.
    
      {% note info %}
    
      Укажите либо флаг `--filesystem-native-s3`, чтобы использовать хранилище Object Storage, либо флаги группы `--filesystem-external-s3-aws`, чтобы использовать внешнее хранилище.
    
      {% endnote %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/iceberg.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      iceberg = {
        file_system = {
          s3 = {}
        }
        metastore = {
          uri = "<URI_для_подключения>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `file_system` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/iceberg.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "iceberg": {
                        "filesystem": {
                          "s3": {}
                        },
                        "metastore": {
                          "hive": {
                            "uri": "<URI_для_подключения>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `externalS3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `awsAccessKey` — идентификатор AWS-совместимого статического ключа доступа.
            * `awsSecretKey` — секретный ключ AWS-совместимого статического ключа доступа.
            * `awsEndpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `awsRegion` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/iceberg.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "iceberg": {
                    "filesystem": {
                      "s3": {}
                    },
                    "metastore": {
                      "hive": {
                        "uri": "<URI_для_подключения>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `filesystem` — тип файлового хранилища. Доступные варианты:
    
        * `s3` — хранилище [Yandex Object Storage](../../storage/quickstart/overview.md).
        * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:
    
            * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
            * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
            * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
            * `aws_region` — регион файлового хранилища, например `ru-central1`.
    
    * `metastore.hive.uri` — URI для подключения к кластеру Apache Hive™ Metastore в формате `thrift://<IP-адрес_кластера>:9083`.
    
        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    
        {% note warning %}
        
        Для интеграции с сервисом Managed Service for Trino требуется кластер Apache Hive™ Metastore с версией 3.1.
        
        {% endnote %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/iceberg.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор Oracle <code><b><small>Preview</small></b></code> {#oracle}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Тип подключения** — Ручная настройка.
    * **URL** — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
    * **Имя пользователя** — имя пользователя для подключения к БД Oracle.
    * **Пароль** — пароль пользователя для подключения к БД Oracle.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/oracle.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create oracle <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
    * `--on-premise-user-name` — имя пользователя для подключения к БД Oracle.
    * `--on-premise-password` — пароль пользователя для подключения к БД Oracle.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/oracle.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      oracle = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
        * `user_name` — имя пользователя для подключения к БД Oracle.
        * `password` — пароль пользователя для подключения к БД Oracle.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/oracle.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "oracle": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
        * `userName` — имя пользователя для подключения к БД Oracle.
        * `password` — пароль пользователя для подключения к БД Oracle.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/oracle.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "oracle": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
        * `user_name` — имя пользователя для подключения к БД Oracle.
        * `password` — пароль пользователя для подключения к БД Oracle.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/oracle.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор PostgreSQL {#pg}

Выберите тип подключения — [Connection Manager](../../metadata-hub/concepts/connection-manager.md) или **Ручная настройка** (пользовательская инсталляция), и задайте для него нужные настройки.

Connection Manager позволяет создавать подключения к кластеру с управляемой базой данных и к пользовательской инсталляции базы данных.

При подключении с типом Connection Manager любые изменения в параметрах подключения автоматически учитываются в Trino. При подключении с типом **Ручная настройка** изменения в параметрах подключения не отслеживаются в Trino. Их необходимо отслеживать и вносить вручную.

#### Подключение Connection Manager {#pg-connection-manager}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Идентификатор подключения** — идентификатор подключения в Connection Manager для подключения к кластеру PostgreSQL.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

    * **База данных** — имя БД в кластере PostgreSQL.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create postgresql <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --connection-manager-connection-id <идентификатор_подключения> \
      --connection-manager-database <имя_БД> \
      --connection-manager-connection-properties <список_параметров_клиента_PostgreSQL> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--connection-manager-connection-id` — идентификатор подключения в Connection Manager для подключения к кластеру PostgreSQL.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

    * `--connection-manager-database` — имя БД в кластере PostgreSQL.
    * `--connection-manager-connection-properties` — список настроек клиента PostgreSQL в формате `ключ=значение`.

        {% cut "Доступные параметры" %}
        
        * `ApplicationName` — имя приложения, использующего соединение.
        * `defaultRowFetchSize` — количество строк, извлекаемых в `ResultSet` за один запрос к базе данных. Значение по умолчанию — `0` (извлекаются все строки сразу). Ограничение на количество строк позволит избежать ненужного потребления памяти.
        * `hostRecheckSeconds` — время в секундах, по истечении которого статус хоста проверяется повторно. Значение по умолчанию — `10`.
        * `loadBalanceHosts` — определяет вариант подключения хостов. Возможные значения:
        
            * `false` (по умолчанию) — хосты подключаются в указанном порядке.
            * `true` — хосты выбираются случайным образом из набора подходящих кандидатов.
        
        * `maxResultBuffer` — размер буфера результатов, который нельзя превышать при чтении набора результатов. Значение можно указать двумя способами:
        
            * В байтах (например: `100`, `200M`, `2G`).
            * В процентах от максимального объема памяти кучи (например: `10p`, `20pct`, `50percent`). Значение не может превышать 90 % от максимального объема памяти кучи. Все значения, превышающие это ограничение, будут уменьшены до ограничения.
        
            По умолчанию `maxResultBuffer` не установлен (имеет значение `null`). Это означает, что чтение результатов будет выполняться без ограничений.
        
        * `maxSendBufferSize` — максимальное количество байтов, буферизуемых перед отправкой на серверную часть. Драйвер pgjdbc использует функцию `least(maxSendBufferSize, greatest(8192, SO_SNDBUF))` для определения размера буфера.
        * `readOnly` — позволяет перевести соединение в режим только для чтения. Значение по умолчанию — `false`.
        * `readOnlyMode` — управляет поведением, когда соединение настроено только на чтение (`readOnly = true`). Возможные значения:
        
            * `ignore` — параметр `readOnly` не действует.
            * `transaction` (по умолчанию) — если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
            * `always` — если автокоммит равен `true`, то сеанс будет настроен только на чтение. Если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
        
        * `receiveBufferSize` — размер буфера чтения сокета (`SO_RCVBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
        * `sendBufferSize` — размер буфера записи сокета (`SO_SNDBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
        * `targetServerType` — определяет, к какому типу сервера подключаться. Возможные значения: `any` (по умолчанию), `master`, `primary`, `slave`, `secondary`, `preferSlave`, `preferSecondary`, `preferPrimary`. Значения `master`, `slave` и `preferSlave` не рекомендуется использовать, т. к. они устарели и заменены на `primary`, `secondary` и `preferSecondary` соответственно.
        
        {% endcut %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      postgresql = {
        connection_manager = {
          connection_id = "<идентификатор_подключения>"
          database      = "<имя_БД>"
          connection_properties = {
            <список_настроек_клиента_PostgreSQL>
          }
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `connection_manager` — настройки Connection Manager:

        * `connection_id` — идентификатор подключения в Connection Manager для подключения к кластеру PostgreSQL.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `database` — имя БД в кластере PostgreSQL.
        * `connection_properties` — список настроек клиента PostgreSQL в формате `"ключ" = "значение"`.

            {% cut "Доступные параметры" %}
            
            * `ApplicationName` — имя приложения, использующего соединение.
            * `defaultRowFetchSize` — количество строк, извлекаемых в `ResultSet` за один запрос к базе данных. Значение по умолчанию — `0` (извлекаются все строки сразу). Ограничение на количество строк позволит избежать ненужного потребления памяти.
            * `hostRecheckSeconds` — время в секундах, по истечении которого статус хоста проверяется повторно. Значение по умолчанию — `10`.
            * `loadBalanceHosts` — определяет вариант подключения хостов. Возможные значения:
            
                * `false` (по умолчанию) — хосты подключаются в указанном порядке.
                * `true` — хосты выбираются случайным образом из набора подходящих кандидатов.
            
            * `maxResultBuffer` — размер буфера результатов, который нельзя превышать при чтении набора результатов. Значение можно указать двумя способами:
            
                * В байтах (например: `100`, `200M`, `2G`).
                * В процентах от максимального объема памяти кучи (например: `10p`, `20pct`, `50percent`). Значение не может превышать 90 % от максимального объема памяти кучи. Все значения, превышающие это ограничение, будут уменьшены до ограничения.
            
                По умолчанию `maxResultBuffer` не установлен (имеет значение `null`). Это означает, что чтение результатов будет выполняться без ограничений.
            
            * `maxSendBufferSize` — максимальное количество байтов, буферизуемых перед отправкой на серверную часть. Драйвер pgjdbc использует функцию `least(maxSendBufferSize, greatest(8192, SO_SNDBUF))` для определения размера буфера.
            * `readOnly` — позволяет перевести соединение в режим только для чтения. Значение по умолчанию — `false`.
            * `readOnlyMode` — управляет поведением, когда соединение настроено только на чтение (`readOnly = true`). Возможные значения:
            
                * `ignore` — параметр `readOnly` не действует.
                * `transaction` (по умолчанию) — если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
                * `always` — если автокоммит равен `true`, то сеанс будет настроен только на чтение. Если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
            
            * `receiveBufferSize` — размер буфера чтения сокета (`SO_RCVBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
            * `sendBufferSize` — размер буфера записи сокета (`SO_SNDBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
            * `targetServerType` — определяет, к какому типу сервера подключаться. Возможные значения: `any` (по умолчанию), `master`, `primary`, `slave`, `secondary`, `preferSlave`, `preferSecondary`, `preferPrimary`. Значения `master`, `slave` и `preferSlave` не рекомендуется использовать, т. к. они устарели и заменены на `primary`, `secondary` и `preferSecondary` соответственно.
            
            {% endcut %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "postgresql": {
                        "connection": {
                          "connectionManager": {
                            "connectionId": "<идентификатор_подключения>",
                            "database": "<имя_БД>",
                            "connectionProperties": {
                              <список_настроек_клиента_PostgreSQL>
                            }
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `connectionManager` — настройки Connection Manager:

        * `connectionId` — идентификатор подключения в Connection Manager для подключения к кластеру PostgreSQL.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `database` — имя БД в кластере PostgreSQL.
        * `connectionProperties` — список настроек клиента PostgreSQL в формате `"ключ": "значение"`.

            {% cut "Доступные параметры" %}
            
            * `ApplicationName` — имя приложения, использующего соединение.
            * `defaultRowFetchSize` — количество строк, извлекаемых в `ResultSet` за один запрос к базе данных. Значение по умолчанию — `0` (извлекаются все строки сразу). Ограничение на количество строк позволит избежать ненужного потребления памяти.
            * `hostRecheckSeconds` — время в секундах, по истечении которого статус хоста проверяется повторно. Значение по умолчанию — `10`.
            * `loadBalanceHosts` — определяет вариант подключения хостов. Возможные значения:
            
                * `false` (по умолчанию) — хосты подключаются в указанном порядке.
                * `true` — хосты выбираются случайным образом из набора подходящих кандидатов.
            
            * `maxResultBuffer` — размер буфера результатов, который нельзя превышать при чтении набора результатов. Значение можно указать двумя способами:
            
                * В байтах (например: `100`, `200M`, `2G`).
                * В процентах от максимального объема памяти кучи (например: `10p`, `20pct`, `50percent`). Значение не может превышать 90 % от максимального объема памяти кучи. Все значения, превышающие это ограничение, будут уменьшены до ограничения.
            
                По умолчанию `maxResultBuffer` не установлен (имеет значение `null`). Это означает, что чтение результатов будет выполняться без ограничений.
            
            * `maxSendBufferSize` — максимальное количество байтов, буферизуемых перед отправкой на серверную часть. Драйвер pgjdbc использует функцию `least(maxSendBufferSize, greatest(8192, SO_SNDBUF))` для определения размера буфера.
            * `readOnly` — позволяет перевести соединение в режим только для чтения. Значение по умолчанию — `false`.
            * `readOnlyMode` — управляет поведением, когда соединение настроено только на чтение (`readOnly = true`). Возможные значения:
            
                * `ignore` — параметр `readOnly` не действует.
                * `transaction` (по умолчанию) — если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
                * `always` — если автокоммит равен `true`, то сеанс будет настроен только на чтение. Если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
            
            * `receiveBufferSize` — размер буфера чтения сокета (`SO_RCVBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
            * `sendBufferSize` — размер буфера записи сокета (`SO_SNDBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
            * `targetServerType` — определяет, к какому типу сервера подключаться. Возможные значения: `any` (по умолчанию), `master`, `primary`, `slave`, `secondary`, `preferSlave`, `preferSecondary`, `preferPrimary`. Значения `master`, `slave` и `preferSlave` не рекомендуется использовать, т. к. они устарели и заменены на `primary`, `secondary` и `preferSecondary` соответственно.
            
            {% endcut %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "postgesql": {
                    "connection": {
                      "connection_manager": {
                        "connection_id": "<идентификатор_подключения>",
                        "database": "<имя_БД>",
                        "connection_properties": {
                          <список_настроек_клиента_PostgreSQL>
                        }
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `connection_manager` — настройки Connection Manager:

        * `connection_id` — идентификатор подключения в Connection Manager для подключения к кластеру PostgreSQL.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `database` — имя БД в кластере PostgreSQL.
        * `connection_properties` — список настроек клиента PostgreSQL в формате `"ключ": "значение"`.

            {% cut "Доступные параметры" %}
            
            * `ApplicationName` — имя приложения, использующего соединение.
            * `defaultRowFetchSize` — количество строк, извлекаемых в `ResultSet` за один запрос к базе данных. Значение по умолчанию — `0` (извлекаются все строки сразу). Ограничение на количество строк позволит избежать ненужного потребления памяти.
            * `hostRecheckSeconds` — время в секундах, по истечении которого статус хоста проверяется повторно. Значение по умолчанию — `10`.
            * `loadBalanceHosts` — определяет вариант подключения хостов. Возможные значения:
            
                * `false` (по умолчанию) — хосты подключаются в указанном порядке.
                * `true` — хосты выбираются случайным образом из набора подходящих кандидатов.
            
            * `maxResultBuffer` — размер буфера результатов, который нельзя превышать при чтении набора результатов. Значение можно указать двумя способами:
            
                * В байтах (например: `100`, `200M`, `2G`).
                * В процентах от максимального объема памяти кучи (например: `10p`, `20pct`, `50percent`). Значение не может превышать 90 % от максимального объема памяти кучи. Все значения, превышающие это ограничение, будут уменьшены до ограничения.
            
                По умолчанию `maxResultBuffer` не установлен (имеет значение `null`). Это означает, что чтение результатов будет выполняться без ограничений.
            
            * `maxSendBufferSize` — максимальное количество байтов, буферизуемых перед отправкой на серверную часть. Драйвер pgjdbc использует функцию `least(maxSendBufferSize, greatest(8192, SO_SNDBUF))` для определения размера буфера.
            * `readOnly` — позволяет перевести соединение в режим только для чтения. Значение по умолчанию — `false`.
            * `readOnlyMode` — управляет поведением, когда соединение настроено только на чтение (`readOnly = true`). Возможные значения:
            
                * `ignore` — параметр `readOnly` не действует.
                * `transaction` (по умолчанию) — если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
                * `always` — если автокоммит равен `true`, то сеанс будет настроен только на чтение. Если автокоммит равен `false`, то драйвер настроит транзакцию только на чтение, отправив `BEGIN READ ONLY`.
            
            * `receiveBufferSize` — размер буфера чтения сокета (`SO_RCVBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
            * `sendBufferSize` — размер буфера записи сокета (`SO_SNDBUF`) в байтах. Значение по умолчанию — `-1` (нет ограничения).
            * `targetServerType` — определяет, к какому типу сервера подключаться. Возможные значения: `any` (по умолчанию), `master`, `primary`, `slave`, `secondary`, `preferSlave`, `preferSecondary`, `preferPrimary`. Значения `master`, `slave` и `preferSlave` не рекомендуется использовать, т. к. они устарели и заменены на `primary`, `secondary` и `preferSecondary` соответственно.
            
            {% endcut %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

#### Ручная настройка {#pg-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URL** — URL для подключения к БД PostgreSQL в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД PostgreSQL.
    * **Пароль** — пароль пользователя для подключения к БД PostgreSQL.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create postgresql <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД PostgreSQL в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
    * `--on-premise-user-name` — имя пользователя для подключения к БД PostgreSQL.
    * `--on-premise-password` — пароль пользователя для подключения к БД PostgreSQL.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      postgresql = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД PostgreSQL в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД PostgreSQL.
        * `password` — пароль пользователя для подключения к БД PostgreSQL.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "postgesql": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД PostgreSQL в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
        * `userName` — имя пользователя для подключения к БД PostgreSQL.
        * `password` — пароль пользователя для подключения к БД PostgreSQL.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "postgresql": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД PostgreSQL в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД PostgreSQL.
        * `password` — пароль пользователя для подключения к БД PostgreSQL.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор MySQL® <code><b><small>Preview</small></b></code> {#mysql}

Выберите тип подключения — [Connection Manager](../../metadata-hub/concepts/connection-manager.md) или **Ручная настройка** (пользовательская инсталляция), и задайте для него нужные настройки.

Connection Manager позволяет создавать подключения к кластеру с управляемой базой данных и к пользовательской инсталляции базы данных.

При подключении с типом Connection Manager любые изменения в параметрах подключения автоматически учитываются в Trino. При подключении с типом **Ручная настройка** изменения в параметрах подключения не отслеживаются в Trino. Их необходимо отслеживать и вносить вручную.

#### Подключение Connection Manager {#mysql-connection-manager}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Идентификатор подключения** — идентификатор подключения в Connection Manager для подключения к кластеру MySQL®.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;MySQL**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

    * **Свойства подключения** — параметры подключения MySQL® в формате `ключ: значение`.

        {% cut "Доступные параметры" %}
        
        * `connectTimeout` — максимальное время ожидания установки соединения с MySQL®, в миллисекундах;
        * `socketTimeout` — максимальное время ожидания выполнения операций через сокет, в миллисекундах;
        * `connectionTimeZone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
        * `serverTimezone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
        
           {% note info %}
           
           Параметр устарел, используйте `connectionTimeZone`.
           
           {% endnote %}
        
        * `autoReconnect` — использовать ли автоматическое переподключение. Значение: `true` или `false`;
        * `maxReconnects` — максимальное количество попыток переподключения;
        * `useCompression` — использовать ли сжатие при передаче данных. Значение: `true` или `false`;
        * `cachePrepStmts` — использовать ли кеширование подготовленных запросов. Значение: `true` или `false`;
        * `prepStmtCacheSize` — максимальное количество подготовленных запросов, хранящихся в кеше;
        * `prepStmtCacheSqlLimit` — максимальное количество символов в подготовленном запросе, который может быть закеширован.
        
        {% endcut %}

    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create mysql <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --connection-manager-connection-id <идентификатор_подключения> \
      --connection-manager-connection-properties <список_настроек_подключения_MySQL®> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--connection-manager-connection-id` — идентификатор подключения в Connection Manager для подключения к кластеру MySQL®.

        Чтобы узнать идентификатор подключения:
        1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
        1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
        1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

    * `--connection-manager-connection-properties` — список настроек подключения MySQL® в формате `ключ=значение`.

       {% cut "Доступные параметры" %}
       
       * `connectTimeout` — максимальное время ожидания установки соединения с MySQL®, в миллисекундах;
       * `socketTimeout` — максимальное время ожидания выполнения операций через сокет, в миллисекундах;
       * `connectionTimeZone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
       * `serverTimezone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
       
          {% note info %}
          
          Параметр устарел, используйте `connectionTimeZone`.
          
          {% endnote %}
       
       * `autoReconnect` — использовать ли автоматическое переподключение. Значение: `true` или `false`;
       * `maxReconnects` — максимальное количество попыток переподключения;
       * `useCompression` — использовать ли сжатие при передаче данных. Значение: `true` или `false`;
       * `cachePrepStmts` — использовать ли кеширование подготовленных запросов. Значение: `true` или `false`;
       * `prepStmtCacheSize` — максимальное количество подготовленных запросов, хранящихся в кеше;
       * `prepStmtCacheSqlLimit` — максимальное количество символов в подготовленном запросе, который может быть закеширован.
       
       {% endcut %}

    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      mysql = {
        connection_manager = {
          connection_id = "<идентификатор_подключения>"
          connection_properties = {
            <список_настроек_подключения_MySQL®>
          }
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `connection_manager` — настройки Connection Manager:

        * `connection_id` — идентификатор подключения в Connection Manager для подключения к кластеру MySQL®.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;MySQL**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `connection_properties` — список настроек подключения MySQL® в формате `"ключ" = "значение"`.

           {% cut "Доступные параметры" %}
           
           * `connectTimeout` — максимальное время ожидания установки соединения с MySQL®, в миллисекундах;
           * `socketTimeout` — максимальное время ожидания выполнения операций через сокет, в миллисекундах;
           * `connectionTimeZone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
           * `serverTimezone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
           
              {% note info %}
              
              Параметр устарел, используйте `connectionTimeZone`.
              
              {% endnote %}
           
           * `autoReconnect` — использовать ли автоматическое переподключение. Значение: `true` или `false`;
           * `maxReconnects` — максимальное количество попыток переподключения;
           * `useCompression` — использовать ли сжатие при передаче данных. Значение: `true` или `false`;
           * `cachePrepStmts` — использовать ли кеширование подготовленных запросов. Значение: `true` или `false`;
           * `prepStmtCacheSize` — максимальное количество подготовленных запросов, хранящихся в кеше;
           * `prepStmtCacheSqlLimit` — максимальное количество символов в подготовленном запросе, который может быть закеширован.
           
           {% endcut %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "mysql": {
                        "connection": {
                          "connectionManager": {
                            "connectionId": "<идентификатор_подключения>",
                            "connectionProperties": {
                              <список_настроек_подключения_MySQL®>
                            }
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `connectionManager` — настройки Connection Manager:

        * `connectionId` — идентификатор подключения в Connection Manager для подключения к кластеру MySQL®.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;MySQL**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `connectionProperties` — список настроек подключения MySQL® в формате `"ключ": "значение"`.

           {% cut "Доступные параметры" %}
           
           * `connectTimeout` — максимальное время ожидания установки соединения с MySQL®, в миллисекундах;
           * `socketTimeout` — максимальное время ожидания выполнения операций через сокет, в миллисекундах;
           * `connectionTimeZone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
           * `serverTimezone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
           
              {% note info %}
              
              Параметр устарел, используйте `connectionTimeZone`.
              
              {% endnote %}
           
           * `autoReconnect` — использовать ли автоматическое переподключение. Значение: `true` или `false`;
           * `maxReconnects` — максимальное количество попыток переподключения;
           * `useCompression` — использовать ли сжатие при передаче данных. Значение: `true` или `false`;
           * `cachePrepStmts` — использовать ли кеширование подготовленных запросов. Значение: `true` или `false`;
           * `prepStmtCacheSize` — максимальное количество подготовленных запросов, хранящихся в кеше;
           * `prepStmtCacheSqlLimit` — максимальное количество символов в подготовленном запросе, который может быть закеширован.
           
           {% endcut %}

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "mysql": {
                    "connection": {
                      "connection_manager": {
                        "connection_id": "<идентификатор_подключения>",
                        "connection_properties": {
                          <список_настроек_подключения_MySQL®>
                        }
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `connection_manager` — настройки Connection Manager:

        * `connection_id` — идентификатор подключения в Connection Manager для подключения к кластеру MySQL®.

            Чтобы узнать идентификатор подключения:
            1. В консоли управления перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
            1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;MySQL**.
            1. Нажмите на имя нужного кластера и перейдите на вкладку **Подключения**.

        * `connection_properties` — список настроек подключения MySQL® в формате `"ключ": "значение"`.

           {% cut "Доступные параметры" %}
           
           * `connectTimeout` — максимальное время ожидания установки соединения с MySQL®, в миллисекундах;
           * `socketTimeout` — максимальное время ожидания выполнения операций через сокет, в миллисекундах;
           * `connectionTimeZone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
           * `serverTimezone` — временная зона, которую использует MySQL®, например, `UTC` или `Europe/Moscow`;
           
              {% note info %}
              
              Параметр устарел, используйте `connectionTimeZone`.
              
              {% endnote %}
           
           * `autoReconnect` — использовать ли автоматическое переподключение. Значение: `true` или `false`;
           * `maxReconnects` — максимальное количество попыток переподключения;
           * `useCompression` — использовать ли сжатие при передаче данных. Значение: `true` или `false`;
           * `cachePrepStmts` — использовать ли кеширование подготовленных запросов. Значение: `true` или `false`;
           * `prepStmtCacheSize` — максимальное количество подготовленных запросов, хранящихся в кеше;
           * `prepStmtCacheSqlLimit` — максимальное количество символов в подготовленном запросе, который может быть закеширован.
           
           {% endcut %}

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

#### Ручная настройка {#mysql-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **URL** — URL для подключения к серверу MySQL® в формате `jdbc:mysql://<адрес_хоста>:<порт>/`. Имя базы данных указывать не нужно — Trino автоматически обнаружит все доступные базы данных.
    * **Имя пользователя** — имя пользователя для подключения к серверу MySQL®.
    * **Пароль** — пароль пользователя для подключения к серверу MySQL®.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create mysql <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к серверу MySQL® в формате `jdbc:mysql://<адрес_хоста>:<порт>/`. Имя базы данных указывать не нужно — Trino автоматически обнаружит все доступные базы данных.
    * `--on-premise-user-name` — имя пользователя для подключения к серверу MySQL®.
    * `--on-premise-password` — пароль пользователя для подключения к серверу MySQL®.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      mysql = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к серверу MySQL® в формате `jdbc:mysql://<адрес_хоста>:<порт>/`. Имя базы данных указывать не нужно — Trino автоматически обнаружит все доступные базы данных.
        * `user_name` — имя пользователя для подключения к серверу MySQL®.
        * `password` — пароль пользователя для подключения к серверу MySQL®.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "mysql": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к серверу MySQL® в формате `jdbc:mysql://<адрес_хоста>:<порт>/`. Имя базы данных указывать не нужно — Trino автоматически обнаружит все доступные базы данных.
        * `userName` — имя пользователя для подключения к серверу MySQL®.
        * `password` — пароль пользователя для подключения к серверу MySQL®.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "mysql": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к серверу MySQL® в формате `jdbc:mysql://<адрес_хоста>:<порт>/`. Имя базы данных указывать не нужно — Trino автоматически обнаружит все доступные базы данных.
        * `user_name` — имя пользователя для подключения к серверу MySQL®.
        * `password` — пароль пользователя для подключения к серверу MySQL®.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/mysql.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор MS SQL Server <code><b><small>Preview</small></b></code> {#ms-sql}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Тип подключения** — Ручная настройка.
    * **URL** — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
    * **Имя пользователя** — имя пользователя для подключения к БД Microsoft SQL Server.
    * **Пароль** — пароль пользователя для подключения к БД Microsoft SQL Server.
    * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/sqlserver.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create sqlserver <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --on-premise-connection-url <URL_для_подключения> \
      --on-premise-user-name <имя_пользователя> \
      --on-premise-password <пароль_пользователя> \
      --additional-properties <список_дополнительных_настроек>
    ```

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--on-premise-connection-url` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
    * `--on-premise-user-name` — имя пользователя для подключения к БД Microsoft SQL Server.
    * `--on-premise-password` — пароль пользователя для подключения к БД Microsoft SQL Server.
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/sqlserver.html).

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      sqlserver = {
        on_premise = {
          connection_url = "<URL_для_подключения>"
          user_name      = "<имя_пользователя>"
          password       = "<пароль_пользователя>"
        }
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД Microsoft SQL Server.
        * `password` — пароль пользователя для подключения к БД Microsoft SQL Server.

    * `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/sqlserver.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "sqlserver": {
                        "connection": {
                          "onPremise": {
                            "connectionUrl": "<URL_для_подключения>",
                            "userName": "<имя_пользователя>",
                            "password": "<пароль_пользователя>"
                          }
                        },
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где:

    * `onPremise` — настройки для подключения к пользовательской инсталляции:

        * `connectionUrl` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
        * `userName` — имя пользователя для подключения к БД Microsoft SQL Server.
        * `password` — пароль пользователя для подключения к БД Microsoft SQL Server.

    * `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/sqlserver.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "sqlserver": {
                    "connection": {
                      "on_premise": {
                        "connection_url": "<URL_для_подключения>",
                        "user_name": "<имя_пользователя>",
                        "password": "<пароль_пользователя>"
                      }
                    },
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где:

    * `on_premise` — настройки для подключения к пользовательской инсталляции:

        * `connection_url` — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
        * `user_name` — имя пользователя для подключения к БД Microsoft SQL Server.
        * `password` — пароль пользователя для подключения к БД Microsoft SQL Server.

    * `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/sqlserver.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор TPC-DS {#tpc-ds}

Коннектор TPC-DS не требует обязательных настроек. Опционально можно задать дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpcds.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create tpcds <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --additional-properties <список_дополнительных_настроек>
    ```  

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpcds.html).  

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      tpcds = {
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpcds.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "tpcds": {
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpcds.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "tpcds": {
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpcds.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

### Коннектор TPC-H {#tpc-h}

Коннектор TPC-H не требует обязательных настроек. Опционально можно задать дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpch.html).

- CLI {#cli}

    Пример команды:

    ```bash
    yc managed-trino catalog create tpch <имя_каталога_Trino> \
      --cluster-id <идентификатор_кластера> \
      --additional-properties <список_дополнительных_настроек>
    ```  

    Где:

    * `--cluster-id` — идентификатор кластера, в котором создается каталог Trino. Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).
    * `--additional-properties` — дополнительные настройки в формате `ключ=значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpch.html).      

- Terraform {#tf}

    Пример конфигурации:

    ```hcl
    resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
      ...
      tpch = {
        additional_properties = {
          <список_дополнительных_настроек>
        }
      }
    }
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ" = "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpch.html).

- REST API {#api}

    Пример команды:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs' \
        --data '{
                  "catalog": {
                    "name": "<имя_каталога_Trino>",
                    "connector": {
                      "tpch": {
                        "additionalProperties": {
                          <список_дополнительных_настроек>
                        }
                      }
                    }
                  }
                }'
    ```

    Где `additionalProperties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpch.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- gRPC API {#grpc-api}

    Пример команды:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "catalog": {
                "name": "<имя_каталога_Trino>",
                "connector": {
                  "tpch": {
                    "additional_properties": {
                      <список_дополнительных_настроек>
                    }
                  }
                }
              }
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.CatalogService.Create
    ```

    Где `additional_properties` — список дополнительных настроек в формате `"ключ": "значение"`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpch.html).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._