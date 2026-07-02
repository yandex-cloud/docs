[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Trino](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Обновление версии Trino

# Обновление версии Trino

Вы можете изменить версию Trino на любую из [поддерживаемых](#available-versions) в Managed Service for Trino. Версию можно как повысить, так и понизить.

Обновления и исправления внутри одной версии устанавливаются во время [технического обслуживания](../concepts/maintenance.md) автоматически.

## Получить список доступных версий {#available-versions}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Managed Service for&nbsp;Trino**.
    1. Выберите кластер и нажмите на панели сверху кнопку **Редактировать**. Откроется страница редактирования кластера.
      
        Список доступных версий можно посмотреть в поле **Версия**.

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://trino.io/docs/current/release.html) Trino, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию Trino на тестовом кластере.

## Обновить версию {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Managed Service for&nbsp;Trino**.
    1. Выберите кластер и нажмите на панели сверху кнопку **Редактировать**.
    1. В блоке **Базовые параметры** выберите версию Trino.
    1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить версию Trino:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-trino cluster update --help
        ```

    2. Измените версию, выполнив команду:

        ```bash
        yc managed-trino cluster update <имя_или_идентификатор_кластера> \
          --version <версия_Trino>
        ```

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).
        
    1. Измените в описании кластера значение параметра `version`:
      
        ```hcl
        resource "yandex_trino_cluster" "<имя_кластера>" {
          ...
          version = "<версия_Trino>"
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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "trino.version",
          "trino": {
            "version": "<версия_Trino>"
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `trino.version` — версия Trino.

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>'
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "trino.version"
            ]
          },
          "trino": {
            "version": "<версия_Trino>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера.
            
            Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

            {% note warning %}

            При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `version` — версия Trino.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          trino.api.cloud.yandex.net:443 \
          yandex.cloud.trino.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}