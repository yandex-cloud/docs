# Управление собственной геобазой в Managed Service for ClickHouse®

Геобаза в ClickHouse® — это текстовые файлы, которые содержат иерархию и имена регионов. Вы можете добавить в ClickHouse® несколько альтернативных геобаз для поддержки разных точек зрения о принадлежности регионов странам. Подробнее читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/dictionaries/internal-dicts/).

Чтобы подключить к кластеру ClickHouse® собственную геобазу:

1. [Создайте ее](#create).
1. [Загрузите геобазу в Yandex Object Storage](#upload).
1. [Подключите геобазу к кластеру ClickHouse®](#add).

Если собственная геобаза не используется, [отключите ее](#disconnect).

## Создать геобазу {#create}

1. Создайте файл `regions_hierarchy.txt` с иерархией регионов. Файл должен представлять собой таблицу в [формате TSV](https://ru.wikipedia.org/wiki/TSV) без заголовков и со столбцами:
   * идентификатор региона (UInt32);
   * идентификатор родительского региона (UInt32);
   * тип региона (UInt8):
        * `1` — континент;
        * `3` — страна;
        * `4` — федеральный округ;
        * `5` — область;
        * `6` — город;
   * население (UInt32) — необязательный столбец.
1. Чтобы добавить альтернативную иерархию регионов, создайте файлы `regions_hierarchy_<суффикс>.txt` с аналогичной структурой. Чтобы затем воспользоваться альтернативной геобазой, передайте этот суффикс при вызове функции. Например:

    * `regionToCountry(RegionID)` — использует словарь по умолчанию: `regions_hierarchy.txt`;
    * `regionToCountry(RegionID, 'alt')` — использует словарь с суффиксом `alt`: `regions_hierarchy_alt.txt`.

1. Создайте файл `regions_names.txt` с именами регионов. Файл должен представлять собой таблицу в [формате TSV](https://ru.wikipedia.org/wiki/TSV) без заголовков и со столбцами:

    * идентификатор региона (UInt32);
    * имя региона (String) — не может содержать символы табуляции или переводы строк, даже экранированные.

1. Чтобы добавить в базу имена регионов на других языках, создайте файлы `regions_names_<код_языка>.txt` с аналогичной структурой. Например, `regions_names_en.txt` для английского языка и `regions_names_tr.txt` для турецкого.
1. Создайте из файлов геобазы архив в формате `tar`, `tar.gz` или `zip`.

## Загрузить геобазу в Yandex Object Storage {#upload}

Managed Service for ClickHouse® работает только с геобазами, которые загружены в Yandex Object Storage и к которым предоставлен доступ на чтение:


1. Для привязки [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) к кластеру [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Загрузите](../../storage/operations/objects/upload.md) архив с геобазой в Yandex Object Storage.
1. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account). С помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вы настроите доступ к архиву геобазы.
1. [Назначьте роль](s3-access.md#configure-acl) `storage.viewer` сервисному аккаунту.
1. В ACL бакета [добавьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту.
1. [Получите ссылку](s3-access.md#get-link-to-object) на архив с геобазой.


## Подключить геобазу к кластеру ClickHouse® {#add}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**.
  1. В поле **Geobase uri** укажите ссылку на архив с геобазой в Yandex Object Storage.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы подключить геобазу:

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        yc managed-clickhouse cluster update-config --help
        ```

    1. Выполните команду, передав ссылку на архив с подключаемой геобазой в параметре `geobase_uri`:

        ```bash
        yc managed-clickhouse cluster update-config <имя_или_идентификатор_кластера> \
             --set geobase_uri="<ссылка_на_архив_с_геобазой_в_Object_Storage>"
        ```

        Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

    1. Добавьте в настройки кластера Managed Service for ClickHouse® параметр `geobase_uri` со ссылкой на архив с подключаемой геобазой в Yandex Object Storage:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          clickhouse = {
            config = {
              geobase_uri = "<ссылка_на_архив_с_геобазой_в_Object_Storage>"
              ...
            }
          ...
          }
          ...
        }
        ```

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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
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

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.config.geobaseUri",
                      "configSpec": {
                        "clickhouse": {
                          "config": {
                            "geobaseUri": "<ссылка>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `configSpec.clickhouse.config.geobaseUri`.

        * `configSpec.clickhouse.config.geobaseUri` — ссылка на архив с геобазой в Object Storage.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.config.geobase_uri"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "config": {
                        "geobase_uri": "<ссылка>"
                      }
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `config_spec.clickhouse.config.geobase_uri`.

        * `config_spec.clickhouse.config.geobase_uri` — ссылка на архив с геобазой в Object Storage.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отключить геобазу {#disconnect}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**.
    1. В поле **Geobase uri** удалите значение.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы отключить геобазу:

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        yc managed-clickhouse cluster update-config --help
        ```

    1. Выполните команду, передав пустое значение параметра `geobase_uri`:

        ```bash
        yc managed-clickhouse cluster update-config <имя_или_идентификатор_кластера> \
             --set geobase_uri=""
        ```

        Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.config.geobaseUri",
                      "configSpec": {
                        "clickhouse": {
                          "config": {
                            "geobaseUri": ""
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `configSpec.clickhouse.config.geobaseUri`.

        * `configSpec.clickhouse.config.geobaseUri` — ссылка на архив с геобазой в Object Storage. Укажите пустое значение в этом параметре.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.config.geobase_uri"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "config": {
                        "geobase_uri": ""
                      }
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `config_spec.clickhouse.config.geobase_uri`.

        * `config_spec.clickhouse.config.geobase_uri` — ссылка на архив с геобазой в Object Storage. Укажите пустое значение в этом параметре.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._