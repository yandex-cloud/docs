# Работа с модулями Valkey™

В Yandex Managed Service for Valkey™ доступно подключение [модулей](../concepts/modules.md) — расширений ядра Valkey™. Модули предоставляют функциональность для решения современных задач с помощью высоконагруженных сервисов и AI-платформ — векторный поиск, эффективное хранение JSON-структур данных и масштабируемые вероятностные фильтры.

Вы можете подключить модули к [новому](cluster-create.md) или [существующему](#enable-modules) кластеру, а также [изменить настройки модуля](#change-modules).

## Подключение модулей {#enable-modules}

{% note warning %}

После подключения модули невозможно отключить.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
    1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
    1. Выберите нужный кластер.
    1. В верхней части страницы нажмите кнопку **Редактировать**.
    1. В блоке **Модули** подключите необходимые модули Valkey™.

        Для модуля **Search** настройте параметры **Количество потоков чтения** и **Количество потоков записи**.

    1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы подключить модули:

  1. Посмотрите описание команды CLI для обновления кластера:

     ```bash
     yc managed-redis cluster update --help
     ```

  1. Выполните команду подключения модулей:

     ```bash
     yc managed-redis cluster update \
       --cluster-name=<имя_кластера> \
       --valkey-modules enable-valkey-search=<включить_модуль_Valkey-Search>,`
                        `valkey-search-reader-threads=<количество_потоков_обработки_запросов>,`
                        `valkey-search-writer-threads=<количество_потоков_индексации>,`
                        `enable-valkey-json=<включить_модуль_Valkey-JSON>,`
                        `enable-valkey-bloom=<включить_модуль_Valkey-Bloom>
     ```

     Где:
     * `--cluster-name` — имя кластера Yandex Managed Service for Valkey™. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--valkey-modules` — параметры [модулей Valkey™](../concepts/modules.md):
        * `enable-valkey-search` — подключить модуль `Valkey-Search`: `true` или `false`.
        * `valkey-search-reader-threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
        * `valkey-search-writer-threads` — количество потоков индексации в модуле `Valkey-Search`.
        * `enable-valkey-json` — подключить модуль `Valkey-JSON`: `true` или `false`.
        * `enable-valkey-bloom` — подключить модуль `Valkey-Bloom`: `true` или `false`.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте в описание кластера Yandex Managed Service for Valkey™ блок `modules`:

        ```hcl
        resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
          ...
          modules = {
            valkey_bloom = {
              enabled = <включить_модуль_Valkey-Bloom>
            }
            valkey_json = {
              enabled = <включить_модуль_Valkey-JSON>
            }
            valkey_search = {
              enabled        = <включить_модуль_Valkey-Search>
              reader_threads = <количество_потоков_обработки_запросов>
              writer_threads = <количество_потоков_индексации>
            }
          }
        }
        ```

        Где:

        * `valkey_bloom.enabled` — подключить модуль `Valkey-Bloom`: `true` или `false`.
        * `valkey_json.enabled` — подключить модуль `Valkey-JSON`: `true` или `false`.
        * `valkey_search.enabled` — подключить модуль `Valkey-Search`: `true` или `false`.
        * `valkey_search.reader_threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
        * `valkey_search.writer_threads` — количество потоков индексации в модуле `Valkey-Search`.

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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_redis_cluster_v2.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex Managed Service for Valkey™:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 15 минут;
    * изменение — 60 минут;
    * удаление — 15 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.modules.valkeySearch.enabled,configSpec.modules.valkeySearch.readerThreads,configSpec.modules.valkeySearch.writerThreads,configSpec.valkeyJson.enabled,configSpec.valkeyBloom.enabled",
                      "configSpec": {
                        "modules": {
                          "valkeySearch": {
                            "enabled": "<включить_модуль_Valkey-Search>",
                            "readerThreads": "<количество_потоков_обработки_запросов>",
                            "writerThreads": "<количество_потоков_индексации>"
                          },
                          "valkeyJson": {
                            "enabled": "<включить_модуль_Valkey-JSON>"
                          },
                          "valkeyBloom": {
                            "enabled": "<включить_модуль_Valkey-Bloom>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `configSpec.modules` — параметры модулей Valkey™:

            * `valkeySearch.enabled` — подключить модуль `Valkey-Search`: `true` или `false`. Для модуля доступна настройка параметров:
                * `valkeySearch.readerThreads` — количество потоков обработки запросов.
                * `valkeySearch.writerThreads` — количество потоков индексации.
            * `valkeyJson.enabled` — подключить модуль `Valkey-JSON`: `true` или `false`.
            * `valkeyBloom.enabled` — подключить модуль `Valkey-Bloom`: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.modules.valkey_search.enabled",
                      "config_spec.modules.valkey_search.reader_threads",
                      "config_spec.modules.valkey_search.writer_threads",
                      "config_spec.valkey_json.enabled",
                      "config_spec.valkey_bloom.enabled"
                    ]
                  },
                  "config_spec": {
                    "modules": {
                      "valkey_search": {
                        "enabled": "<включить_модуль_Valkey-Search>",
                        "reader_threads": "<количество_потоков_обработки_запросов>",
                        "writer_threads": "<количество_потоков_индексации>"
                      },
                      "valkey_json": {
                        "enabled": "<включить_модуль_Valkey-JSON>"
                      },
                      "valkey_bloom": {
                        "enabled": "<включить_модуль_Valkey-Bloom>"
                      }
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.modules` — параметры модулей Valkey™:

            * `valkey_search.enabled` — подключить модуль `Valkey-Search`: `true` или `false`. Для модуля доступна настройка параметров:
                * `valkey_search.reader_threads` — количество потоков обработки запросов.
                * `valkey_search.writer_threads` — количество потоков индексации.
            * `valkey_json.enabled` — подключить модуль `Valkey-JSON`: `true` или `false`.
            * `valkey_bloom.enabled` — подключить модуль `Valkey-Bloom`: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменение настроек модулей {#change-modules}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
    1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
    1. Выберите нужный кластер.
    1. В верхней части страницы нажмите кнопку **Редактировать**.
    1. В блоке **Модули** измените необходимые настройки модулей Valkey™.

        Для модуля **Search** доступна настройка параметров:

        * **Количество потоков чтения**.
        * **Количество потоков записи**.

    1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить настройки модулей:

  1. Посмотрите описание команды CLI для обновления кластера:

     ```bash
     yc managed-redis cluster update --help
     ```

  1. Выполните команду изменения настроек модулей:

     ```bash
     yc managed-redis cluster update \
       --cluster-name=<имя_кластера> \
       --valkey-modules valkey-search-reader-threads=<количество_потоков_обработки_запросов>,`
                        `valkey-search-writer-threads=<количество_потоков_индексации>
     ```

     Где:
     * `--cluster-name` — имя кластера Yandex Managed Service for Valkey™. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--valkey-modules` — параметры [модулей Valkey™](../concepts/modules.md):
        * `valkey-search-reader-threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
        * `valkey-search-writer-threads` — количество потоков индексации в модуле `Valkey-Search`.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера Yandex Managed Service for Valkey™ значение нужной настройки в блоке `modules.valkey_search`:

        ```hcl
        resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
          ...
          modules = {
            ...
            valkey_search = {
              ...
              reader_threads = <количество_потоков_обработки_запросов>
              writer_threads = <количество_потоков_индексации>
            }
          }
        }
        ```

        Где:

        * `reader_threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
        * `writer_threads` — количество потоков индексации в модуле `Valkey-Search`.

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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_redis_cluster_v2.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex Managed Service for Valkey™:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 15 минут;
    * изменение — 60 минут;
    * удаление — 15 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.modules.valkeySearch.readerThreads,configSpec.modules.valkeySearch.writerThreads",
                      "configSpec": {
                        "modules": {
                          "valkeySearch": {
                            "readerThreads": "<количество_потоков_обработки_запросов>",
                            "writerThreads": "<количество_потоков_индексации>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `configSpec.modules` — параметры модулей Valkey™:

            * `valkeySearch.readerThreads` — количество потоков обработки запросов в модуле `Valkey-Search`.
            * `valkeySearch.writerThreads` — количество потоков индексации в модуле `Valkey-Search`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.modules.valkey_search.reader_threads",
                      "config_spec.modules.valkey_search.writer_threads"
                    ]
                  },
                  "modules": {
                    "valkey_search": {
                      "reader_threads": "<количество_потоков_обработки_запросов>",
                      "writer_threads": "<количество_потоков_индексации>"
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.modules` — параметры модулей Valkey™:

            * `valkey_search.reader_threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
            * `valkey_search.writer_threads` — количество потоков индексации в модуле `Valkey-Search`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}