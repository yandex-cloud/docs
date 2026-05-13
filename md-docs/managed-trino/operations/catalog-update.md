# Изменение каталога Trino

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу [каталога ресурсов](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Trino**.
    1. Нажмите на имя нужного кластера.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **Каталоги**.
    1. В строке с нужным каталогом Trino нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Редактировать**.
    1. Измените параметры каталога Trino и нажмите кнопку **Обновить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды CLI для изменения каталога Trino:

        ```bash
        yc managed-trino catalog update --help
        ```

    1. Посмотрите описание команды CLI для изменения каталога Trino c конкретным коннектором:

        ```bash
        yc managed-trino catalog update <тип_коннектора> --help
        ```

    1. Чтобы изменить каталог, выполните команду:

        ```bash
        yc managed-trino catalog update <тип_коннектора> <имя_каталога_Trino> \
            --new-name <новое_имя_каталога_Trino>
        ```

        Имя каталога Trino можно запросить со [списком каталогов Trino в кластере](catalog-list.md#list-catalogs.md).

        В команде также можно передать настройки каталога Trino, которые зависят от типа коннектора. [Подробнее о настройках для разных типов коннекторов](catalog-create.md#catalog-settings).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените настройки каталога Trino в блоке `yandex_trino_catalog`:

        ```hcl
        resource "yandex_trino_catalog" "<имя_каталога_Trino>" {
          ...
          <тип_коннектора> = {
            <настройки_каталога_Trino>
          }
        }
        ```

        [Подробнее о настройках каталога Trino](catalog-create.md#catalog-settings) для разных типов коннекторов.

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

    1. Воспользуйтесь методом [Catalog.Update](../api-ref/Catalog/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs/<идентификатор_каталога_Trino>' \
            --data '{
                      "updateMask": "catalog.name,catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_1>,catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_2>,...,catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_N>",
                      "catalog": {
                        "name": "<новое_имя_каталога_Trino>",
                        "connector": {
                          "<тип_коннектора>": {
                            <изменяемые_настройки_каталога_Trino>
                          }
                        }
                      }
                    }'
        ```

        Где `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        [Подробнее о настройках каталога Trino](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов Trino в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Catalog/update.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [CatalogService.Update](../api-ref/grpc/Catalog/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "catalog_id": "<идентификатор_каталога_Trino>",
                  "update_mask": {
                    "paths": [
                      "catalog.name",
                      "catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_1>",
                      "catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_2>",
                      ...
                      "catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_N>"
                    ]
                  },
                  "catalog": {
                    "name": "<новое_имя_каталога_Trino>",
                    "connector": {
                      "<тип_коннектора>": {
                        <изменяемые_настройки_каталога_Trino>
                      }
                    }
                  }
                }' \
            trino.api.cloud.yandex.net:443 \
            yandex.cloud.trino.v1.CatalogService.Update
        ```

        Где `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        [Подробнее о настройках каталога Trino](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов Trino в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Catalog/update.md#yandex.cloud.operation.Operation).

{% endlist %}