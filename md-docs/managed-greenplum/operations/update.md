# Изменение настроек кластера Yandex MPP Analytics for PostgreSQL


После создания кластера вы можете:

* [Изменить имя и описание кластера](#change-name-and-description).
* [Изменить настройку публичного доступа](#change-public-access).
* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Изменить настройки регламентных операций технического обслуживания](#change-background-settings).
* [Изменить настройки СУБД](#change-gp-settings).
* [Изменить настройки протокола PXF для оптимизации работы с внешними данными](pxf/settings.md).
* [Изменить настройки аутентификации в конфигурационном файле pg_hba.conf](user-auth-rules.md).
* [Изменить настройку сервисного аккаунта](#change-service-account)
* [Изменить настройки логирования](#change-logging)

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Выберите кластер и нажмите кнопку **Редактировать** в верхней части страницы.
    1. В блоке **Базовые параметры** задайте новые имя и описание кластера.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить имя и описание кластера Yandex MPP Analytics for PostgreSQL:

  1. Посмотрите текущие имя (`name`) и описание (`description`) кластера:

     ```bash
     yc managed-greenplum cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      yc managed-greenplum cluster update --help
      ```

  1. Задайте новое имя и описание кластера:

      ```bash
      yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
         --new-name <новое_имя_кластера> \
         --description <новое_описание_кластера>
      ```

- Terraform {#tf}

    {% note alert %}

    Не изменяйте имя кластера с помощью Terraform. Это приведет к удалению существующего кластера и созданию нового.

    {% endnote %}

    Чтобы изменить описание кластера:

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Yandex MPP Analytics for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

    1. Измените в описании кластера Yandex MPP Analytics for PostgreSQL значение атрибута `description`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          name        = "<имя_кластера>"
          description = "<новое_описание_кластера>"
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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
          ...
          timeouts {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "name,description",
                      "name": "<новое_имя_кластера>",
                      "description": "<новое_описание_кластера>"
                    }'
        ```

        Где `updateMask` — перечень изменяемых параметров в одну строку через запятую.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "name", "description" ]
                  },
                  "name": "<новое_имя_кластера>",
                  "description": "<новое_описание_кластера>" 
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить настройку публичного доступа {#change-public-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Выберите кластер и нажмите кнопку **Редактировать** в верхней части страницы.
    1. В блоке **Сетевые настройки** установите или отключите опцию **Публичный доступ**.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить настройку публичного доступа в кластере Yandex MPP Analytics for PostgreSQL:

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      yc managed-greenplum cluster update --help
      ```

  1. Задайте настройку публичного доступа в параметре `--assign-public-ip`:

      ```bash
      yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
         --assign-public-ip=<разрешить_публичный_доступ_к_кластеру>
      ```

      Где `assign-public-ip` — публичный доступ к кластеру: `true` или `false`.

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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "config.assignPublicIp",
                      "config": {
                        "assignPublicIp": <разрешить_публичный_доступ_к_хостам_кластера>
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `assignPublicIp` — публичный доступ к хостам кластера: `true` или `false`.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "config.assign_public_ip" ]
                  },
                  "config": {
                    "assign_public_ip": <разрешить_публичный_доступ_к_хостам_кластера> 
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `assign_public_ip` — публичный доступ к хостам кластера: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note tip %}

Если вы включили публичный доступ к кластеру, но подключение через интернет не срабатывает:

* Проверьте [настройки групп безопасности](connect/index.md#configuring-security-groups).
* Подождите некоторое время. Включение публичного доступа иногда вступает в силу не сразу.

{% endnote %}


## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. Измените дополнительные настройки кластера:

        * **Начало резервного копирования (UTC)** — промежуток времени, в течение которого начинается резервное копирование кластера. Время указывается по UTC в 24-часовом формате. По умолчанию — `22:00 - 23:00` UTC.
        * **Обслуживание** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **В любое время** (по умолчанию).
            * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **По расписанию** и укажите день недели и интервал времени по UTC. Например, можно выбрать время, когда кластер наименее загружен.
            
            Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.

        
        * **Доступ из DataLens** — опция разрешает анализировать данные из кластера в сервисе [Yandex DataLens](../../datalens/concepts/index.md).
        * **Доступ из Yandex Query** — опция разрешает выполнять YQL-запросы из сервиса [Yandex Query](../../query/concepts/index.md) к управляемой базе данных Yandex MPP Analytics for PostgreSQL.
        * **Доступ из WebSQL** — опция разрешает отправлять запросы к базам данных в кластере с помощью сервиса [Yandex WebSQL](../../websql/index.md).



        * **Защита от удаления** — управляет защитой кластера от непреднамеренного удаления.

            Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

        * **Гибридное хранилище** — включает [гибридное хранилище](../concepts/hybrid-storage.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            Когда гибридное хранилище включено, с помощью [расширения Yezzey](extensions/yezzey.md) можно переместить часть [таблиц AO и AOCO](../concepts/tables.md) из хранилища кластера в холодное хранилище и наоборот.
            
            Холодное хранилище удобно, если данные таблиц нужно хранить долго, а работать с ними планируется редко. Так хранение [будет дешевле](../pricing/index.md#rules-storage).

            
            {% note info %}
            
            Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.
            
            {% endnote %}


        * **Менеджер подключений** — режим работы и параметры [менеджера подключений](../concepts/pooling.md):

            * **Режим** — `SESSION` (сессионный) или `TRANSACTION` (транзакционный, по умолчанию).
            * **Размер** — количество клиентских соединений. По умолчанию — `0` (не ограничено).
            * **Тайм-аут ожидания клиента** — время неактивности клиентского соединения в секундах, после которого соединение разрывается. По умолчанию — `28800`.
            * **Тайм-аут простоя в транзакции** — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается. По умолчанию — `0` (не ограничено).

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-greenplum cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        
        ```bash
        yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
            --backup-window-start <время_начала_резервного_копирования> \
            --datalens-access=<разрешить_доступ_из_DataLens> \
            --yandexquery-access=<разрешить_доступ_из_Yandex_Query> \
            --maintenance-window type=<тип_технического_обслуживания>,`
                                `day=<день_недели>,`
                                `hour=<час_дня> \
            --websql-access=<разрешить_доступ_из_WebSQL> \
            --deletion-protection
        ```




    Вы можете изменить следующие настройки:

    * `--backup-window-start` — время начала резервного копирования кластера, задается по UTC в формате `HH:MM:SS`. Если время не задано, резервное копирование начнется в 22:00 UTC.

    
    * `--datalens-access` — доступ к кластеру из сервиса [Yandex DataLens](../../datalens/concepts/index.md): `true` или `false`.

    * `--yandexquery-access` — доступ к кластеру из сервиса [Yandex Query](../../query/concepts/index.md): `true` или `false`.

    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL. Значение по умолчанию — `false`.



    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
        
              > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

    * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Yandex MPP Analytics for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

    1. Измените в описании кластера Yandex MPP Analytics for PostgreSQL значения нужных дополнительных настроек:

        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          backup_window_start {
            hours = <начало_периода_резервного_копирования>
          }

          maintenance_window {
            type = "<тип_технического_обслуживания>"
            day  = "<день_недели>"
            hour = <час_дня>
          }

          access {
            data_lens    = <разрешить_доступ_из_DataLens>
            yandex_query = <разрешить_доступ_из_Yandex_Query>
          }

          deletion_protection = <защитить_кластер_от_удаления>

          cloud_storage {
            enable = <использовать_гибридное_хранилище>
          }

          pooler_config {
            pooling_mode                     = <режим_работы>
            pool_size                        = <размер>
            pool_client_idle_timeout         = <время_ожидания_клиента>
            pool_idle_in_transaction_timeout = <время_ожидания_клиента_в_транзакции>
          }
        }
        ```




        Вы можете изменить следующие настройки:

        * `backup_window_start.hours` — начало периода, в течение которого начинается [резервное копирование](../concepts/backup.md) кластера. Задается по UTC в формате `HH`: от `0` до `23`.

        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

            * `type` — тип технического обслуживания. Принимает значения:
                * `ANYTIME` — в любое время.
                * `WEEKLY` — по расписанию.
            * `day` — день недели для типа `WEEKLY` в формате `DDD`. Например, `MON`.
            * `hour` — час дня по UTC для типа `WEEKLY` в формате `HH`. Например, `21`.

        
        * `access.data_lens` — доступ к кластеру из сервиса [Yandex DataLens](../../datalens/concepts/index.md): `true` или `false`.

        * `access.yandex_query` — доступ к кластеру из сервиса [Yandex Query](../../query/concepts/index.md): `true` или `false`.



        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

        * `cloud_storage.enable` — использование [гибридного хранилища](../concepts/hybrid-storage.md).

            Установите значение `true`, чтобы включить гибридное хранилище. Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            Когда гибридное хранилище включено, с помощью [расширения Yezzey](extensions/yezzey.md) можно переместить часть [таблиц AO и AOCO](../concepts/tables.md) из хранилища кластера в холодное хранилище и наоборот.
            
            Холодное хранилище удобно, если данные таблиц нужно хранить долго, а работать с ними планируется редко. Так хранение [будет дешевле](../pricing/index.md#rules-storage).

            
            {% note info %}
            
            Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.
            
            {% endnote %}


        * `pooler_config` — настройки [менеджера подключений](../concepts/pooling.md):

            * `pooling_mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `pool_size` — количество клиентских соединений.
            * `pool_client_idle_timeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.
            * `pool_idle_in_transaction_timeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
          ...
          timeouts {
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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        
        ```json
        {
          "updateMask": "config.backupWindowStart,config.access.dataLens,config.access.yandexQuery,maintenanceWindow,deletionProtection,configSpec.pool.mode,configSpec.pool.size,configSpec.pool.clientIdleTimeout,configSpec.pool.idleInTransactionTimeout,cloudStorage",
          "config": {
            "backupWindowStart": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "access": {
              "dataLens": <разрешить_доступ_из_DataLens>,
              "yandexQuery": <разрешить_доступ_из_Yandex_Query>
            }
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "deletionProtection": <защитить_кластер_от_удаления>,
          "configSpec": {
            "pool": {
              "mode": "<режим_работы>",
              "size": "<количество_клиентских_соединений>",
              "clientIdleTimeout": "<время_ожидания_клиента>",
              "idleInTransactionTimeout": "<время_ожидания_клиента_в_транзакции>"
            }
          },
          "cloudStorage": {
            "enable": <использовать_гибридное_хранилище>
          }
        }
        ```




        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `config` — настройки кластера:

            * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

                В параметре укажите время, когда начинать резервное копирование:

                * `hours` — от `0` до `23` часов;
                * `minutes` — от `0` до `59` минут;
                * `seconds` — от `0` до `59` секунд;
                * `nanos` — от `0` до `999999999` наносекунд.

            
            * `access` — настройки доступа кластера к следующим сервисам Yandex Cloud:

                * `dataLens` — [Yandex DataLens](../../datalens/index.md): `true` или `false`.
                * `yandexQuery` — [Yandex Query](../../query/concepts/index.md): `true` или `false`.



        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

            * `anytime` — техническое обслуживание происходит в любое время.
            * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC от `1` до `24`.

        * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

        * `configSpec.pool` — настройки [менеджера подключений](../concepts/pooling.md):

            * `mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `size` — количество клиентских соединений.
            * `clientIdleTimeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.
            * `idleInTransactionTimeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

        * `cloudStorage.enable` — использование гибридного хранилища. Установите значение `true`, чтобы включить в кластере [расширение Yezzey](https://github.com/yezzey-gp/yezzey/) от Yandex Cloud. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера Yandex MPP Analytics for PostgreSQL в холодное хранилище Yandex Object Storage. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            
            {% note info %}
            
            Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.
            
            {% endnote %}


    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data "@body.json"
        ```

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

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

        
        ```json
        {
          "cluster_id": "<идентификатор_кластера>"
          "update_mask": {
            "paths": [
              "config.backup_window_start",
              "config.access.data_lens",
              "config.access.yandex_query",
              "maintenance_window",
              "deletion_protection",
              "config_spec.pool.mode",
              "config_spec.pool.size",
              "config_spec.pool.client_idle_timeout",
              "config_spec.pool.idle_in_transaction_timeout",
              "cloud_storage"
            ]
          },
          "config": {
            "backup_window_start": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "access": {
              "data_lens": <разрешить_доступ_из_DataLens>,
              "yandex_query": <разрешить_доступ_из_Yandex_Query>
            }
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "deletion_protection": <защитить_кластер_от_удаления>,
          "config_spec": {
            "pool": {
              "mode": "<режим_работы>",
              "size": "<количество_клиентских_соединений>",
              "client_idle_timeout": "<время_ожидания_клиента>",
              "idle_in_transaction_timeout": "<время_ожидания_клиента_в_транзакции>"
            }
          },
          "cloud_storage": {
            "enable": <использовать_гибридное_хранилище>
          }
        }
        ```




        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config` — настройки кластера:

            * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

                В параметре укажите время, когда начинать резервное копирование:

                * `hours` — от `0` до `23` часов;
                * `minutes` — от `0` до `59` минут;
                * `seconds` — от `0` до `59` секунд;
                * `nanos` — от `0` до `999999999` наносекунд.

            
            * `access` — настройки доступа кластера к следующим сервисам Yandex Cloud:

                * `data_lens` — [Yandex DataLens](../../datalens/index.md): `true` или `false`.
                * `yandex_query` — [Yandex Query](../../query/concepts/index.md): `true` или `false`.



        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

            * `anytime` — техническое обслуживание происходит в любое время.
            * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                * `hour` — час дня по UTC от `1` до `24`.

        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

        * `config_spec.pool` — настройки [менеджера подключений](../concepts/pooling.md):

            * `mode` — режим работы: `SESSION` или `TRANSACTION`.
            * `size` — количество клиентских соединений.
            * `client_idle_timeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.
            * `pool_idle_in_transaction_timeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

        * `cloud_storage.enable` — использование гибридного хранилища. Установите значение `true`, чтобы включить в кластере [расширение Yezzey](https://github.com/yezzey-gp/yezzey/) от Yandex Cloud. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера Yandex MPP Analytics for PostgreSQL в холодное хранилище Yandex Object Storage. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

            Гибридное хранилище нельзя отключить после сохранения настроек кластера.

            
            {% note info %}
            
            Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.
            
            {% endnote %}


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки регламентных операций технического обслуживания {#change-background-settings}

Вы можете изменить настройки [регламентных операций технического обслуживания](../concepts/maintenance.md#regular-ops) вашего кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Управление фоновыми процессами** измените параметры:

        * **Время старта (UTC)** — время, в которое начнется выполнение операции `VACUUM`. По умолчанию — `19:00 UTC`. После завершения операции `VACUUM` запустится операция `ANALYZE`.
        * **Таймаут VACUUM** — максимальная длительность выполнения операции `VACUUM`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `VACUUM` будет принудительно завершена.
        * **Таймаут ANALYZE** — максимальная длительность выполнения операции `ANALYZE`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `ANALYZE` будет принудительно завершена.
        
        Суммарная длительность операций `VACUUM` и `ANALYZE` не может превышать 24 часа.

    1. Нажмите кнопку **Сохранить**.

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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.backgroundActivities.analyzeAndVacuum.start,configSpec.backgroundActivities.analyzeAndVacuum.analyzeTimeout,configSpec.backgroundActivities.analyzeAndVacuum.vacuumTimeout",
                      "configSpec": {
                        "backgroundActivities": {
                          "analyzeAndVacuum": {
                            "start": {
                              "hours": "<час_начала_операции>",
                              "minutes": "<минута_начала_операции>"
                            },
                            "analyzeTimeout": "<длительность_выполнения_операции_ANALYZE>",
                            "vacuumTimeout": "<длительность_выполнения_операции_VACUUM>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `configSpec.backgroundActivities.analyzeAndVacuum` — настройки управления фоновыми процессами:

            * `start.hours` — час начала операции `VACUUM` по UTC. Возможные значения: от `0` до `23`, по умолчанию — `19`.
            * `start.minutes` — минута начала операции `VACUUM` по UTC. Возможные значения: от `0` до `59`, по умолчанию — `0`.
            * `analyzeTimeout` — максимальная длительность выполнения операции `ANALYZE`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `ANALYZE` будет принудительно завершена.
            * `vacuumTimeout` — максимальная длительность выполнения операции `VACUUM`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `VACUUM` будет принудительно завершена.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.background_activities.analyze_and_vacuum.start",
                      "config_spec.background_activities.analyze_and_vacuum.analyze_timeout",
                      "config_spec.background_activities.analyze_and_vacuum.vacuumTimeout"
                    ]
                  },
                  "config_spec": {
                    "background_activities": {
                      "analyze_and_vacuum": {
                        "start": {
                          "hours": "<час_начала_операции>",
                          "minutes": "<минута_начала_операции>"
                        },
                        "analyze_timeout": "<длительность_выполнения_операции_ANALYZE>",
                        "vacuum_timeout": "<длительность_выполнения_операции_VACUUM>"
                      }
                    }
                  } 
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.background_activities.analyze_and_vacuum` — настройки управления фоновыми процессами:

            * `start.hours` — час начала операции `VACUUM` по UTC. Возможные значения: от `0` до `23`, по умолчанию — `19`.
            * `start.minutes` — минута начала операции `VACUUM` по UTC. Возможные значения: от `0` до `59`, по умолчанию — `0`.
            * `analyze_timeout` — максимальная длительность выполнения операции `ANALYZE`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `ANALYZE` будет принудительно завершена.
            * `vacuum_timeout` — максимальная длительность выполнения операции `VACUUM`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `VACUUM` будет принудительно завершена.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки СУБД {#change-gp-settings}

Вы можете изменить [глобальные настройки СУБД](../concepts/settings-list.md) вашего кластера. Перечень доступных для изменения настроек см. в разделе [Настройки СУБД](../concepts/settings-list.md).

{% note info %}

Для изменения настроек на уровне пользователя, в том числе тех, которые не управляются сервисом Yandex MPP Analytics for PostgreSQL на уровне кластера, используйте команду:

```sql
ALTER ROLE <имя_роли> SET <настройка> = <значение>;
```

Для изменения настроек на уровне отдельной базы данных используйте команду:

```sql
ALTER DATABASE <имя_базы_данных> SET <настройка> = <значение>;
```

Полный список настроек см. в [документации Greenplum®](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Измените [настройки СУБД](../concepts/settings-list.md), нажав кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [настройки СУБД](../concepts/settings-list.md):

  1. Посмотрите полный список настроек, установленных для кластера:

     ```bash
     yc managed-greenplum cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      yc managed-greenplum cluster update-config --help
      ```

  1. Установите нужные значения параметров:

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `greenplumConfig_<версия_СУБД>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `maxConnections` из запроса к API преобразуется в `max_connections` для команды CLI:

      ```bash
      yc managed-greenplum cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра1>=<значение1>,<имя_параметра2>=<значение2>,...
      ```

      Yandex MPP Analytics for PostgreSQL запустит операцию по изменению настроек кластера.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Yandex MPP Analytics for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

    1. Измените в описании кластера [настройки СУБД](../concepts/settings-list.md) в блоке `greenplum_config`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          greenplum_config = {
            max_connections         = <максимальное_количество_соединений>
            gp_workfile_compression = <true_или_false>
            ...
          }
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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
          ...
          timeouts {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.greenplumConfig_<версия_СУБД>.<настройка_1>,...,configSpec.greenplumConfig_<версия_СУБД>.<настройка_N>",
                      "configSpec": {
                        "greenplumConfig_<версия_СУБД>": {
                          "<настройка_1>": "<значение_1>",
                          "<настройка_2>": "<значение_2>",
                          ...
                          "<настройка_N>": "<значение_N>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае перечислите все изменяемые настройки СУБД.

        * `configSpec.greenplumConfig_<версия_СУБД>` — набор настроек СУБД. Укажите каждую настройку на отдельной строке через запятую. Описание и возможные значения настроек см. в разделе [Настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

            Доступные версии СУБД: Greenplum® `6.28` и `6.29`, Apache Cloudberry™ `2.0-cb`.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.greenplum_config_<версия_СУБД>.<настройка_1>",
                      "config_spec.greenplum_config_<версия_СУБД>.<настройка_2>",
                      ...
                      "config_spec.greenplum_config_<версия_СУБД>.<настройка_N>"
                    ]
                  },
                  "config_spec": {
                    "greenplum_config_<версия_СУБД>": {
                      "<настройка_1>": "<значение_1>",
                      "<настройка_2>": "<значение_2>",
                      ...
                      "<настройка_N>": "<значение_N>"
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае перечислите все изменяемые настройки СУБД.

        * `config_spec.greenplum_config_<версия_СУБД>` — набор настроек СУБД. Укажите каждую настройку на отдельной строке через запятую. Описание и возможные значения настроек см. в разделе [Настройки СУБД](../concepts/settings-list.md).

            Доступные версии СУБД: Greenplum® `6.28` и `6.29`, Apache Cloudberry™ `2.0-cb`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить класс хостов {#change-resource-preset}

Вы можете изменить класс как хостов-мастеров, так и хостов-сегментов. При смене класса хостов:

* В кластере сменится первичный хост-мастер.
* Кластер с хранилищем на локальных SSD-дисках может быть недоступен длительное время, если потребуется миграция данных на другой физический сервер.
* Подключение по [особому FQDN](connect/fqdn.md#fqdn-master) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Изменение класса хостов-сегментов [влияет](../concepts/instance-types.md#select-class-segment-hosts) на максимальный объем памяти, выделенный на каждый серверный процесс Yandex MPP Analytics for PostgreSQL.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите [на страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
  1. В блоке **Класс хоста** выберите нужный класс для хостов-мастеров или хостов-сегментов Yandex MPP Analytics for PostgreSQL.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-greenplum cluster update --help
      ```

  1. Запросите список доступных классов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):
     * для хостов-мастеров:

        ```bash
        yc managed-greenplum resource-preset list master
        ```

     * для хостов-сегментов:

        ```bash
        yc managed-greenplum resource-preset list segment
        ```

     
     ```text
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     |     ID      |            ZONE IDS            |           DISK TYPES           | CORES |  MEMORY  | HOST COUNT DIVIDER | MAX SEGMENT IN HOST |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     | i2.2xlarge  | ru-central1-a, ru-central1-b   | local-ssd,                     |    16 | 128.0 GB |                  1 |                   0 |
     |             |                                | network-ssd-nonreplicated      |       |          |                    |                     |
     | ...                                                                                                                                         |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     ```


  1. Укажите нужные классы в команде изменения кластера:

      ```bash
      yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
          --master-config resource-id=<идентификатор_класса_хостов-мастеров> \
          --segment-config resource-id=<идентификатор_класса_хостов-сегментов>
      ```

      Yandex MPP Analytics for PostgreSQL запустит операцию изменения класса хостов для кластера.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера Yandex MPP Analytics for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

  1. Измените в описании кластера Yandex MPP Analytics for PostgreSQL значение атрибута `resource_preset_id` в блоке `master_subcluster.resources` или `segment_subcluster.resources`:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
        ...
        master_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
        segment_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
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

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
      
      Операции, длящиеся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию кластера блок `timeouts`, например:
      
      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
        ...
        timeouts {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "masterConfig.resources.resourcePresetId,segmentConfig.resources.resourcePresetId",
                      "masterConfig": {
                        "resources": {
                          "resourcePresetId": "<класс_хостов>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "resourcePresetId": "<класс_хостов>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `masterConfig.resources.resourcePresetId`, `segmentConfig.resources.resourcePresetId` — новый [класс хостов](../concepts/instance-types.md) для хостов-мастеров и хостов-сегментов.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.resource_preset_id",
                      "segment_config.resources.resource_preset_id"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "resource_preset_id": "<класс_хостов>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "resource_preset_id": "<класс_хостов>"
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `master_config.resources.resource_preset_id`, `segment_config.resources.resource_preset_id` — новый [класс хостов](../concepts/instance-types.md) для хостов-мастеров и хостов-сегментов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [Квоты](https://console.yandex.cloud/cloud?section=quotas) для облака и убедитесь, что в секции **Managed Databases** в строке **Объём HDD-хранилищ** или **Объём SSD-хранилищ** есть квота на объем хранилищ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
  1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **Редактировать**.
  1. В блоке **Хранилище**:

      * Выберите [тип диска](../concepts/storage.md).
      * Укажите нужный размер диска.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-greenplum cluster update --help
      ```

  1. Укажите нужный размер хранилища для хостов-мастеров или хостов-сегментов в команде изменения кластера (размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```bash
      yc managed-mysql cluster update <имя_или_идентификатор_кластера> \
         --master-config disk-size <размер_хранилища_в_гигабайтах> \
         --segment-config disk-size <размер_хранилища_в_гигабайтах>
      ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Yandex MPP Analytics for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

    1. Измените в описании кластера Yandex MPP Analytics for PostgreSQL значения атрибутов `disk_type_id` и `disk_size` в блоке `master_subcluster.resources` или `segment_subcluster.resources`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          master_subcluster {
            resources {
              disk_type_id = "<тип_диска>"
              disk_size    = <размер_хранилища_в_гигабайтах>
              ...
            }
          }
          segment_subcluster {
            resources {
              disk_type_id = "<тип_диска>"
              disk_size    = <размер_хранилища_в_гигабайтах>
              ...
            }
          }
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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
          ...
          timeouts {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "masterConfig.resources.diskTypeId,masterConfig.resources.diskSize,segmentConfig.resources.diskTypeId,segmentConfig.resources.diskSize",
                      "masterConfig": {
                        "resources": {
                          "diskTypeId": "<тип_диска>",
                          "diskSize": "<размер_хранилища_в_байтах>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "diskTypeId": "<тип_диска>",
                          "diskSize": "<размер_хранилища_в_байтах>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `masterConfig.resources`, `segmentConfig.resources` — параметры хранилища для хостов-мастеров и хостов-сегментов:

            * `diskTypeId` — [тип диска](../concepts/storage.md).
            * `diskSize` — новый размер хранилища в байтах.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.disk_type_id",
                      "master_config.resources.disk_size",
                      "segment_config.resources.disk_type_id",
                      "segment_config.resources.disk_size"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "disk_type_id": "<тип_диска>",
                      "disk_size": "<размер_хранилища_в_байтах>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "disk_type_id": "<тип_диска>",
                      "disk_size": "<размер_хранилища_в_байтах>"
                    }
                  }
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `master_config.resources`, `segment_config.resources` — параметры хранилища для хостов-мастеров и хостов-сегментов:

            * `disk_type_id` — [тип диска](../concepts/storage.md).
            * `disk_size` — новый размер хранилища в байтах.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить настройку сервисного аккаунта {#change-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Выберите нужный кластер.
    1. В верхней части страницы нажмите кнопку **Редактировать**.
    1. В поле **Сервисный аккаунт** выберите сервисный аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md).
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить идентификатор сервисного аккаунта кластера:

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        yc managed-greenplum cluster update --help
        ```

    1. Укажите идентификатор нужного сервисного аккаунта:

        ```bash
        yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
           --service-account <идентификатор_сервисного_аккаунта>
        ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Yandex MPP Analytics for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

    1. Измените в описании кластера Yandex MPP Analytics for PostgreSQL значение атрибута `service_account_id`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          service_account_id = "<идентификатор_сервисного_аккаунта>"
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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
          ...
          timeouts {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "serviceAccountId",
                      "serviceAccountId": "<идентификатор_сервисного_аккаунта>"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `serviceAccountId` — идентификатор сервисного аккаунта.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "service_account_id" ]
                  },
                  "service_account_id": "<идентификатор_сервисного_аккаунта>"
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `service_account_id` — идентификатор сервисного аккаунта.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки логирования {#change-logging}

Вы можете изменить настройки [передачи логов кластера в Yandex Cloud Logging](mgp-to-cloud-logging.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Выберите нужный кластер.
    1. В верхней части страницы нажмите кнопку **Редактировать**.
    1. В блоке **Дополнительные настройки** включите или выключите логирование с помощью опции **Запись логов**. Если вы включили логирование, настройте его параметры:

        * Укажите место записи логов:

          * **Каталог** — логи будут записываться в лог-группу по умолчанию выбранного каталога.
          * **Группа** — логи будут записываться в новую или выбранную из списка [лог-группу](../../logging/concepts/log-group.md).

        * Выберите, какие логи записывать:

          * **Логи командного центра** — опция включает запись логов [командного центра](../concepts/command-center.md).
          * **Логи Greenplum** — опция включает запись логов СУБД.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить настройки логирования:

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        yc managed-greenplum cluster update --help
        ```

    1. Укажите настройки логирования, которые вы хотите изменить, в команде изменения кластера:

        ```bash
        yc managed-greenplum cluster update <имя_или_идентификатор_кластера> \
           --log-enabled \
           --log-command-center-enabled \
           --log-greenplum-enabled \
           --log-pooler-enabled \
           --log-folder-id <идентификатор_каталога>
        ```

        Где:

        * `--log-enabled` — включает механизм передачи логов. Обязателен для работы других флагов, отвечающих за передачу конкретных логов, например, `--log-greenplum-enabled`.
        * `--log-command-center-enabled` — передача логов [командного центра](../concepts/command-center.md).
        * `--log-greenplum-enabled` — передача логов СУБД.
        * `--log-pooler-enabled` — передача логов [менеджера подключений](../concepts/pooling.md).
        * `--log-folder-id` — идентификатор каталога, лог-группу которого нужно использовать.
        * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.

            Укажите только одну из настроек: `--log-folder-id` либо `--log-group-id`.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Yandex MPP Analytics for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

    1. Измените в описании кластера Yandex MPP Analytics for PostgreSQL значения атрибутов в блоке `logging`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          logging {
            enabled                = <включить_передачу_логов>
            command_center_enabled = <передавать_логи_Yandex_Command_Center>
            greenplum_enabled      = <передавать_логи_СУБД>
            pooler_enabled         = <передавать_логи_менеджера_подключений>
            folder_id              = "<идентификатор_каталога>"
          }
        }
        ```

        Где:

        * `enabled` — управляет механизмом передачи логов: `true` или `false`. Для работы параметров, отвечающих за передачу конкретных логов, передайте значение `true`.
        * `command_center_enabled` — передача логов [командного центра](../concepts/command-center.md): `true` или `false`.
        * `greenplum_enabled` — передача логов СУБД: `true` или `false`.
        * `pooler_enabled` — передача логов [менеджера подключений](../concepts/pooling.md): `true` или `false`.
        * `folder_id` — идентификатор каталога, лог-группу которого нужно использовать.
        * `log_group_id` — идентификатор лог-группы, в которую будут записываться логи.

            Укажите только одну из настроек: `folder_id` либо `log_group_id`.

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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение всех операций с кластером Yandex MPP Analytics for PostgreSQL 120 минутами.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя кластера>" {
          ...
          timeouts {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "logging.enabled,logging.commandCenterEnabled,logging.greenplumEnabled,logging.poolerEnabled,logging.folderId",
                      "logging": {
                        "enabled": "<включить_передачу_логов>",
                        "commandCenterEnabled": "<передавать_логи_Yandex_Command_Center>",
                        "greenplumEnabled": "<передавать_логи_СУБД>",
                        "poolerEnabled": "<передавать_логи_менеджера_подключений>",
                        "folderId": "<идентификатор_каталога>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `logging` — настройки логирования:

            * `enabled` — управляет механизмом передачи логов: `true` или `false`. Для работы параметров, отвечающих за передачу конкретных логов, передайте значение `true`.
            * `commandCenterEnabled` — передача логов [командного центра](../concepts/command-center.md): `true` или `false`.
            * `greenplumEnabled` — передача логов СУБД: `true` или `false`.
            * `poolerEnabled` — передача логов [менеджера подключений](../concepts/pooling.md): `true` или `false`.
            * `folderId` — идентификатор каталога, лог-группу которого нужно использовать.
            * `logGroupId` — идентификатор лог-группы, в которую будут записываться логи.

                Укажите только одну из настроек: `folderId` либо `logGroupId`.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "logging.enabled",
                      "logging.command_center_enabled",
                      "logging.greenplum_enabled",
                      "logging.pooler_enabled",
                      "logging.folder_id"
                    ]
                  },
                  "logging": {
                    "enabled": "<включить_передачу_логов>",
                    "command_center_enabled": "<передавать_логи_Yandex_Command_Center>",
                    "greenplum_enabled": "<передавать_логи_СУБД>",
                    "pooler_enabled": "<передавать_логи_менеджера_подключений>",
                    "folder_id": "<идентификатор_каталога>"
                  } 
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `logging` — настройки логирования:

            * `enabled` — управляет механизмом передачи логов: `true` или `false`. Для работы параметров, отвечающих за передачу конкретных логов, передайте значение `true`.
            * `command_center_enabled` — передача логов [командного центра](../concepts/command-center.md): `true` или `false`.
            * `greenplum_enabled` — передача логов СУБД: `true` или `false`.
            * `pooler_enabled` — передача логов [менеджера подключений](../concepts/pooling.md): `true` или `false`.
            * `folder_id` — идентификатор каталога, лог-группу которого нужно использовать.
            * `log_group_id` — идентификатор лог-группы, в которую будут записываться логи.

                Укажите только одну из настроек: `folder_id` либо `log_group_id`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._