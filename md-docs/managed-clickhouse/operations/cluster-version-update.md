# Обновление версии ClickHouse®

Вы можете изменить версию ClickHouse®, которую использует кластер, на любую из [поддерживаемых Managed Service for ClickHouse® версий](../concepts/update-policy.md#versioning-policy).

Об обновлениях в рамках одной версии и обслуживании хостов в разделе [Техническое обслуживание](../concepts/maintenance.md).

## Список доступных версий

{% list tabs group=instructions %}

- Консоль управления {#console}

    В [консоли управления](https://console.yandex.cloud) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) Managed Service for ClickHouse®. Список доступен в поле **Версия**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить список доступных версий, выполните команду:

    ```bash
    yc managed-clickhouse version list
    ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Versions.List](../api-ref/Versions/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/versions'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Versions/list.md#responses).

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

    1. Воспользуйтесь вызовом [VersionsService.List](../api-ref/grpc/Versions/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/versions_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.VersionsService.List
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse).

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://clickhouse.com/docs/ru/category/changelog) ClickHouse®, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно развернуть из резервной копии основного кластера. В этом случае восстановятся только таблицы на движке MergeTree.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.

## Обновить версию {#start-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где нужно обновить версию ClickHouse®.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse** 
    1. В списке кластеров выберите тот, который нужно изменить.
    1. Нажмите кнопку **Редактировать**.
    1. В блоке **Базовые параметры** в поле **Версия** выберите нужную версию.
    1. Нажмите кнопку **Сохранить изменения**.

    После того как изменение версии запущено, кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Получите список ваших кластеров ClickHouse® и посмотрите их версии:

        ```bash
        yc managed-clickhouse cluster list

        +----------------------+------+-------------+---------+---------------------+--------+---------+
        |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        ```

    1. Обновите версию ClickHouse® для нужного кластера:

        ```bash
        yc managed-clickhouse cluster update --id <идентификатор_кластера> --version <версия_ClickHouse®>
        ```

        Укажите версию ClickHouse®: 25.8.24.21 LTS, 26.3.12.3 LTS, 26.4.4.38 и 26.5.2.39.

    После того как обновление запущено, кластер переходит в статус **UPDATING**. Дождитесь окончания операции и затем проверьте версию кластера.


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера Managed Service for ClickHouse® поле `version` или измените его значение, если оно уже существует:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          version = "<версия_ClickHouse®>"
        }
        ```

        Укажите версию ClickHouse®: 25.8.24.21 LTS, 26.3.12.3 LTS, 26.4.4.38 и 26.5.2.39.

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
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<версия_ClickHouse®>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `configSpec.version`.

        * `configSpec.version` — версия ClickHouse®, до которой нужно обновиться: 25.8.24.21 LTS, 26.3.12.3 LTS, 26.4.4.38 и 26.5.2.39.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

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
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "<версия_ClickHouse®>"
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `config_spec.version`.

        * `config_spec.version` — версия ClickHouse®, до которой нужно обновиться: 25.8.24.21 LTS, 26.3.12.3 LTS, 26.4.4.38 и 26.5.2.39.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._