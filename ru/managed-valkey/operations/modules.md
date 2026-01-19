# Работа с модулями {{ VLK }}

В {{ mrd-name }} доступно подключение [модулей](../concepts/modules.md) — расширений ядра {{ VLK }}. Модули предоставляют функциональность для решения современных задач с помощью высоконагруженных сервисов и AI-платформ — векторный поиск, эффективное хранение JSON-структур данных и масштабируемые вероятностные фильтры.

Вы можете подключить модули к [новому](cluster-create.md) или [существующему](#enable-modules) кластеру, а также [изменить настройки модуля](#change-modules).

## Подключение модулей {#enable-modules}

{% include [modules-warn](../../_includes/mdb/mvk/enable-modules-note.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы подключить модули:

  1. Посмотрите описание команды CLI для обновления кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Выполните команду подключения модулей:

     ```bash
     {{ yc-mdb-rd }} cluster update \
       --cluster-name=<имя_кластера> \
       --valkey-modules enable-valkey-search=<включить_модуль_Valkey-Search>,`
                        `valkey-search-reader-threads=<количество_потоков_обработки_запросов>,`
                        `valkey-search-writer-threads=<количество_потоков_индексации>,`
                        `enable-valkey-json=<включить_модуль_Valkey-JSON>,`
                        `enable-valkey-bloom=<включить_модуль_Valkey-Bloom>
     ```

     Где:
     * `--cluster-name` — имя кластера {{ mrd-name }}. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--valkey-modules` — параметры [модулей {{ VLK }}](../concepts/modules.md):
        * `enable-valkey-search` — подключить модуль `Valkey-Search`: `true` или `false`.
        * `valkey-search-reader-threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
        * `valkey-search-writer-threads` — количество потоков индексации в модуле `Valkey-Search`.
        * `enable-valkey-json` — подключить модуль `Valkey-JSON`: `true` или `false`.
        * `enable-valkey-bloom` — подключить модуль `Valkey-Bloom`: `true` или `false`.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>' \
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

        * `configSpec.modules` — параметры модулей {{ VLK }}:

            * `valkeySearch.enabled` — подключить модуль `Valkey-Search`: `true` или `false`. Для модуля доступна настройка параметров:
                * `valkeySearch.readerThreads` — количество потоков обработки запросов.
                * `valkeySearch.writerThreads` — количество потоков индексации.
            * `valkeyJson.enabled` — подключить модуль `Valkey-JSON`: `true` или `false`.
            * `valkeyBloom.enabled` — подключить модуль `Valkey-Bloom`: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.modules` — параметры модулей {{ VLK }}:

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

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки модулей:

  1. Посмотрите описание команды CLI для обновления кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Выполните команду изменения настроек модулей:

     ```bash
     {{ yc-mdb-rd }} cluster update \
       --cluster-name=<имя_кластера> \
       --valkey-modules valkey-search-reader-threads=<количество_потоков_обработки_запросов>,`
                        `valkey-search-writer-threads=<количество_потоков_индексации>
     ```

     Где:
     * `--cluster-name` — имя кластера {{ mrd-name }}. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--valkey-modules` — параметры [модулей {{ VLK }}](../concepts/modules.md):
        * `valkey-search-reader-threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
        * `valkey-search-writer-threads` — количество потоков индексации в модуле `Valkey-Search`.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>' \
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

        * `configSpec.modules` — параметры модулей {{ VLK }}:

            * `valkeySearch.readerThreads` — количество потоков обработки запросов в модуле `Valkey-Search`.
            * `valkeySearch.writerThreads` — количество потоков индексации в модуле `Valkey-Search`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.modules` — параметры модулей {{ VLK }}:

            * `valkey_search.reader_threads` — количество потоков обработки запросов в модуле `Valkey-Search`.
            * `valkey_search.writer_threads` — количество потоков индексации в модуле `Valkey-Search`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}
