# Обновление версии PostgreSQL

{% note warning %}

Начиная с 12 августа 2026 года, существующие кластеры PostgreSQL версии 14 будут автоматически обновляться до версии 15. Рекомендуем заранее обновиться самостоятельно.

{% endnote %}

Вы можете обновить версию PostgreSQL в кластере Managed Service for PostgreSQL до версии `18` или ниже. При этом обновление мажорной версии возможно только последовательно, по одной версии за раз.

Продолжительность обновления зависит от количества баз данных и количества объектов в каждой из них. Чем больше баз данных и объектов, тем дольше будет выполняться обновление.

Подробнее об обновлении версии в разделе [Обновление мажорной версии PostgreSQL в Managed Service for PostgreSQL](../concepts/upgrade.md).

Об обновлениях в рамках одной версии и обслуживании хостов в разделе [Техническое обслуживание](../concepts/maintenance.md).


## Узнать доступные версии {#versions-list}

{% note info %}

Обновление обычной версии до версий для «1С:Предприятие» (например, с версии `14` на версию `14-1с`) недоступно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    В [консоли управления](https://console.yandex.cloud) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) Managed Service for PostgreSQL. Список доступен в поле **Версия**.

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
            --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/versions'
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
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/versions_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.postgresql.v1.VersionsService.List
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.postgresql.v1.ListVersionsResponse).

{% endlist %}


## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://www.postgresql.org/docs/release/) PostgreSQL, как обновления могут повлиять на работу ваших приложений или установленных [расширений](extensions/cluster-extensions.md).
1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть](cluster-backups.md#restore) из резервной копии основного кластера.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением версии.

## Обновить версию PostgreSQL {#start-update}

{% note warning %}

Для обновления мажорной версии должно быть свободно:

* для дисков объемом не более 100 ГБ — не менее 10% объема хранилища;
* для дисков объемом более 100 ГБ — не менее 10 ГБ.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}  

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите нужный кластер в списке и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В поле **Версия** выберите номер новой версии.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы обновить кластер до версии PostgreSQL 15 или ниже:

  1. Получите список ваших кластеров PostgreSQL командой:

     ```bash
     yc managed-postgresql cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию PostgreSQL, указанную в свойстве `config.version`:

     ```bash
     yc managed-postgresql cluster get <имя_или_идентификатор_кластера>
     ```

  1. Запустите обновление PostgreSQL:

     ```bash
     yc managed-postgresql cluster update <имя_или_идентификатор_кластера> \
        --postgresql-version <номер_новой_версии>
     ```

- Terraform {#tf}    

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

       Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

       Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL вы найдете в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    1. Добавьте в блок `cluster_config` нужного кластера Managed Service for PostgreSQL поле `version` или измените его значение, если оно уже существует:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
         ...
         cluster_config {
           version = "<версия_PostgreSQL>"
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
         
         Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
         
         * создание, в том числе путем восстановления из резервной копии, — 30 минут;
         * изменение — 60 минут;
         * удаление — 15 минут.
         
         Операции, длящиеся дольше указанного времени, прерываются.
         
         {% cut "Как изменить эти ограничения?" %}
         
         Добавьте к описанию кластера блок `timeouts`, например:
         
         ```hcl
         resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.version",
                 "configSpec": {
                   "version": "<версия_PostgreSQL>"
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `configSpec.version` — новая версия PostgreSQL.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.version"
               ]
             },
             "config_spec": {
               "version": "<версия_PostgreSQL>"
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `config_spec.version` — новая версия PostgreSQL.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

После запуска обновления кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

Время обновления кластера зависит от размера базы данных.

{% note tip %}

Если с переходом на версию 18 возникнут проблемы, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

{% endnote %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 14 до версии 15.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

      ```bash
      yc managed-postgresql cluster list
      ```

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   postgre406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере с именем `postgre406`, выполните команду:

      ```bash
      yc managed-postgresql cluster get postgre406
      ```

      ```text
        id: c9q8p8j2gaih********
        ...
        config:
          version: "14"
          ...
      ```

   1. Для обновления кластера `postgre406` до версии 15, выполните команду:

      ```bash
      yc managed-postgresql cluster update postgre406 --postgresql-version 15
      ```

{% endlist %}