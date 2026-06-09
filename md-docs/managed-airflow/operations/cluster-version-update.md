# Обновление версии Apache Airflow™ и Python

Со списком поддерживаемых версий можно ознакомиться в разделе [Версионирование](../concepts/versions.md).

При обновлении версий в Managed Service for Apache Airflow™ вы можете изменить:

* Версию Python на любую поддерживаемую для текущей версии Apache Airflow™.
* Версию Apache Airflow™ на следующую поддерживаемую в рамках одной ветки — `2.X` или `3.X`.

    Обновление Apache Airflow™ версий `2.X` до `3.X` недоступно. Чтобы перейти на версию `3.X`, [создайте новый кластер](cluster-create.md) и подключите к нему хранилище DAG-файлов старого кластера.

В сервисе недоступно одновременное обновление версии Apache Airflow™ и Python, так как пользовательские зависимости могут перестать работать на более новых версиях Python.

Например, чтобы обновить кластер с Apache Airflow™ `2.8` и Python `3.8` до Apache Airflow™ `2.10` и Python `3.12`:

1. Обновите версию Python до `3.10` и проверьте работоспособность кластера с учетом используемых зависимостей.
1. Обновите версию Apache Airflow™ до `2.10` и проверьте работоспособность кластера после миграции БД.
1. Обновите версию Python до `3.12` и снова проверьте работоспособность используемых зависимостей.

Об обновлениях в рамках одной версии и обслуживании хостов читайте в разделе [Техническое обслуживание](../concepts/maintenance.md).

{% note alert %}

Перед обновлением убедитесь, что это не нарушит работу ваших приложений — изучите [историю изменений Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/release_notes.html) и [Python](https://www.python.org/downloads/).

После обновления версии Apache Airflow™ вернуть кластер к предыдущей версии невозможно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы обновить версию Apache Airflow™ или Python:

    1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
    1. В поле **Версия** выберите нужную версию Apache Airflow™ и Python.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы обновить версию Apache Airflow™ или Python:

    1. Получите список ваших кластеров Managed Service for Apache Airflow™:

        ```bash
        yc managed-airflow cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте версии в свойствах `config.airflow_version` и `config.python_version`:

        ```bash
        yc managed-airflow cluster get <имя_или_идентификатор_кластера>
        ```

    1. Чтобы обновить версию Apache Airflow™, выполните команду:

        ```bash
        yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
          --airflow-version=<номер_новой_версии>
        ```

    1. Чтобы обновить версию Python, выполните команду:

        ```bash
        yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
          --python-version=<номер_новой_версии>
        ```

- Terraform {#tf}

    Чтобы обновить версию Apache Airflow™ или Python:

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера параметр `airflow_version` или `python_version` или измените его значение, если он уже существует:

        ```hcl
        resource "yandex_airflow_cluster" "<имя_кластера>" {
          ...
          airflow_version = "<версия_Apache_Airflow™>"
          python_version  = "<версия_Python>"
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    Чтобы обновить версию Apache Airflow™ или Python:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/).

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        * Чтобы обновить версию Apache Airflow™, выполните запрос:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "airflowVersion",
                          "airflowVersion": "<версия_Apache_Airflow™>"
                        }'
            ```

           Где:

            * `updateMask` — перечень изменяемых параметров. Укажите только параметр `airflowVersion`.

            * `airflowVersion` — версия Apache Airflow™, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        * Чтобы обновить версию Python, выполните запрос:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "pythonVersion",
                          "pythonVersion": "<версия_Python>"
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров. Укажите только параметр `pythonVersion`.

            * `pythonVersion` — версия Python, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы обновить версию Apache Airflow™ или Python:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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

        * Чтобы обновить версию Apache Airflow™, выполните запрос:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "airflow_version"
                        ]
                      },
                      "airflow_version": "<версия_Apache_Airflow™>"
                    }' \
                airflow.api.cloud.yandex.net:443 \
                yandex.cloud.airflow.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров. Укажите только параметр `airflow_version`.

            * `airflow_version` — версия Apache Airflow™, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        * Чтобы обновить версию Python, выполните запрос:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "python_version"
                        ]
                      },
                      "python_version": "<версия_Python>"
                    }' \
                airflow.api.cloud.yandex.net:443 \
                yandex.cloud.airflow.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров. Укажите только параметр `python_version`.

            * `python_version` — версия Python, до которой нужно обновиться.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить версию Apache Airflow™ с `2.10` до `2.11`, а версию Python — с `3.10` до `3.12`.

{% list tabs group=instructions %}

- CLI {#cli}

    1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

        ```bash
        yc managed-airflow cluster list
        ```

        ```text
        +----------------------+------------+---------------------+--------+---------+
        |          ID          |    NAME    |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+------------+---------------------+--------+---------+
        | c9qqhh2u3r20******** | airflow411 | 2026-02-26 15:39:33 | ALIVE  | RUNNING |
        +----------------------+------------+---------------------+--------+---------+
        ```

    1. Чтобы получить информацию о кластере с именем `airflow411`, выполните команду:

        ```bash
        yc managed-airflow cluster get airflow411
        ```

        Результат:

        ```text
        id: c9qqhh2u3r20********
        ...
        config:
          ...
          airflow-version: "2.10"
          python-version: "3.10"
        ```

    1. Для обновления версии Apache Airflow™ до `2.11` выполните команду:

        ```bash
        yc managed-airflow cluster update airflow411 \
          --airflow-version=2.11
        ```

        Дождитесь завершения операции.

    1. Для обновления версии Python до `3.12` выполните команду:

        ```bash
        yc managed-airflow cluster update airflow411 \
          --python-version=3.12
        ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
    1. В описании кластера укажите в поле `airflow_version` значение `2.11`:

        ```hcl
        resource "yandex_airflow_cluster" "<имя_кластера>" {
          ...
          airflow_version = "2.11"
          ...
        }
        ```

    1. Примените изменения:

        ```bash
        terraform apply
        ```

    1. В поле `python_version` укажите значение `3.12`:

        ```hcl
        resource "yandex_airflow_cluster" "<имя_кластера>" {
          ...
          python_version = "3.12"
          ...
        }
        ```

    1. Примените изменения еще раз:

        ```bash
        terraform apply
        ```

{% endlist %}

#### См. также {#see-also}

* [Версионирование в Managed Service for Apache Airflow™](../concepts/versions.md)
* [Политика работы с версиями Apache Airflow™](../concepts/update-policy.md)