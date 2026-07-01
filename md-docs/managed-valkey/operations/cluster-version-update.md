# Обновление версии Valkey™

Вы можете обновить кластер Yandex Managed Service for Valkey™ до любой поддерживаемой версии.


## Поддерживаемые версии {#version-supported}

Каждая версия Valkey™, поддержка которой была включена в Yandex Managed Service for Valkey™, остается доступной, пока она поддерживается производителем. Как правило, это 24 месяца с даты выпуска версии. Подробнее читайте в [документации Valkey™](https://valkey.io/topics/releases/).


### Узнать доступные версии Valkey™ {#version-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    В [консоли управления](https://console.yandex.cloud) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) Yandex Managed Service for Valkey™. Список доступен в поле **Версия**.

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
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/versions'
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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/versions_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.VersionsService.List
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.redis.v1.ListVersionsResponse).

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://docs.redis.com/latest/rs/release-notes/) Valkey™, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть из резервной копии](cluster-backups.md#restore) основного кластера, если версия Valkey™ в резервной копии [поддерживается](#version-supported) в Yandex Managed Service for Valkey™.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением версии.

## Обновить кластер {#start-update}

{% note alert %}

* После обновления СУБД до выбранной версии вернуть кластер к предыдущей версии невозможно.
* Успешность обновления версии Valkey™ зависит от многих факторов, в том числе от настроек кластера и данных, хранящихся в базах. Рекомендуется сначала [обновить тестовый кластер](#before-update), который использует те же данные и настройки.

{% endnote %}

{% note info %}

Чтобы указать номер версии в CLI, Terraform и API, добавьте к нему постфикс `-valkey` (например, `8.1-valkey`).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с кластером, который нужно обновить.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Выберите нужный кластер в списке и нажмите кнопку **Редактировать**.
  1. В поле **Версия** выберите новую версию.
  1. Нажмите кнопку **Сохранить изменения**.

  После запуска обновления кластер переходит в статус **Updating**. Дождитесь окончания операции и проверьте версию кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список ваших кластеров Valkey™ командой:

     ```bash
     yc managed-redis cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию Valkey™, указанную в свойстве `config.version`:

     ```bash
     yc managed-redis cluster get <имя_или_идентификатор_кластера>
     ```

  1. Запустите обновление Valkey™:

     ```bash
     yc managed-redis cluster update <имя_или_идентификатор_кластера> \
       --redis-version <номер_новой_версии>
     ```

     После запуска обновления кластер переходит в статус **Updating**. Дождитесь окончания операции и проверьте версию кластера.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера](cluster-create.md).

    1. В блоке `config` измените параметр `version` на номер версии Valkey™, до которой хотите обновиться:

        ```hcl
        resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
          ...
          config = {
            version  = "<номер_новой_версии>"
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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_redis_cluster_v2.md).

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

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

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
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<версия_Valkey™>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `configSpec.version` — новая версия Valkey™.

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "config_spec.version" ]
                  },
                  "config_spec": {
                    "version": "<версия_Valkey™>"
                  } 
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `config_spec.version` — новая версия Valkey™.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 8.1 до версии 9.0.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы получить список кластеров и узнать их имена и идентификаторы, выполните команду:

      ```bash
      yc managed-redis cluster list
      ```

	  Результат:
	  
      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   redis406    | 2022-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере с именем `redis406`, выполните команду:

      ```bash
      yc managed-redis cluster get redis406
      ```

      Результат:

      ```text
      id: c9q8p8j2gaih********
      ...
      config:
        version: 8.1-valkey
        ...
      ```

   1. Для обновления кластера с именем `redis406` до версии `9.0`, выполните команду:

      ```bash
      yc managed-redis cluster update redis406 --redis-version 9.0-valkey
      ```

{% endlist %}