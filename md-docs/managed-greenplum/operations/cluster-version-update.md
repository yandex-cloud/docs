[Документация Yandex Cloud](../../index.md) > [Yandex MPP Analytics for PostgreSQL](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Обновление версии в Yandex MPP Analytics for PostgreSQL

# Обновление версии в Yandex MPP Analytics for PostgreSQL

Вы можете изменить версию базы данных, которую использует кластер в Yandex MPP Analytics for PostgreSQL.

{% note info %}

Поддерживается обновление версии Greenplum® с 6.28 до 6.29.

Не поддерживается:

* Обновление между patch-версиями Greenplum® вручную, например с 6.29.1 до 6.29.2. Такие обновления выполняются автоматически в рамках технического обслуживания.
* Обновление версии Apache Cloudberry™.
* Миграция между Greenplum® и Apache Cloudberry™.

{% endnote %}

Об обновлениях в рамках одной версии и обслуживании хостов в разделе [Техническое обслуживание](../concepts/maintenance.md).


## Узнать доступные версии {#versions-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления](https://console.yandex.cloud) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) Yandex MPP Analytics for PostgreSQL. Список доступен в поле **Версия**.

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
          --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/versions'
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
          -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/versions_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.greenplum.v1.VersionsService.List
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.greenplum.v1.ListVersionsResponse).

{% endlist %}


## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите, как обновления могут повлиять на работу ваших приложений:

    * [История изменений Greenplum®](https://github.com/open-gpdb/gpdb/releases).
    * [История изменений Apache Cloudberry™](https://cloudberry.apache.org/blog/announce-apache-cloudberry-2.1.0/).

1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть из резервной копии](cluster-backups.md#restore) основного кластера, если версия базы данных в резервной копии [поддерживается](#version-supported) в Yandex MPP Analytics for PostgreSQL.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением версии.


## Обновить кластер {#start-update}

{% note alert %}

После обновления версии базы данных вернуть кластер к предыдущей версии невозможно.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
  1. В строке с нужным кластером нажмите ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Редактировать**.
  1. В поле **Версия** выберите номер новой версии.
  1. Нажмите **Сохранить**.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      Как создать такой файл, описано в разделе [Создание кластера Yandex MPP Analytics for PostgreSQL](cluster-create.md).

  1. Добавьте в блок `config` нужного кластера Yandex MPP Analytics for PostgreSQL поле `version` (версия базы данных) или измените его значение, если оно уже существует:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
        ...
        version = "<версия>"
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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_greenplum_cluster.md).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          -url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "config.version",
                    "config": {
                      "version": "<версия>"
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае указан только один параметр: `config.version`.

      * `config.version` — версия базы данных, до которой нужно обновиться.

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

  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                    "config.version"
                  ]
                },
                "config": {
                  "version": "<версия>"
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.greenplum.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае указан только один параметр: `config.version`.

      * `config.version` — версия базы данных, до которой нужно обновиться.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}